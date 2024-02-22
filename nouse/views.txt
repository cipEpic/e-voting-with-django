from django.shortcuts import render, redirect, reverse
from account.views import account_login
from .models import Position, Candidate, Voter, Votes, Votes_encrypt
from account.models import CustomUser
from django.http import JsonResponse
from django.utils.text import slugify
from django.contrib import messages
from django.conf import settings
from django.http import JsonResponse
from django.db import transaction
# import requests
import json
# Create your views here.

#paillier
import sys
sys.path.append('C:/xampp/htdocs/skripsi/e-voting-with-django/voting/paillier')
from paillier import encrypt, decrypt, read_keys, e_add_const
from django.db import transaction
public_key, private_key = read_keys()

def index(request):
    if not request.user.is_authenticated:
        return account_login(request)
    context = {}
    # return render(request, "voting/login.html", context)


def generate_ballot(display_controls=False):
    positions = Position.objects.order_by('priority').all()
    output = ""
    candidates_data = ""
    num = 1
    # return None
    for position in positions:
        name = position.name
        position_name = slugify(name)
        candidates = Candidate.objects.filter(position=position)
        for candidate in candidates:
            if position.max_vote > 1:
                instruction = "You may select up to " + \
                    str(position.max_vote) + " candidates"
                input_box = '<input type="checkbox" value="'+str(candidate.id)+'" class="flat-red ' + \
                    position_name+'" name="' + \
                    position_name+"[]" + '">'
            else:
                instruction = "Select only one candidate"
                input_box = '<input value="'+str(candidate.id)+'" type="radio" class="flat-red ' + \
                    position_name+'" name="'+position_name+'">'
            image = "/media/" + str(candidate.photo)
            candidates_data = candidates_data + '<li>' + input_box + '<button type="button" class="btn btn-primary btn-sm btn-flat clist platform" data-fullname="'+candidate.fullname+'" data-bio="'+candidate.bio+'"><i class="fa fa-search"></i> Platform</button><img src="' + \
                image+'" height="100px" width="100px" class="clist"><span class="cname clist">' + \
                candidate.fullname+'</span></li>'
        up = ''
        if position.priority == 1:
            up = 'disabled'
        down = ''
        if position.priority == positions.count():
            down = 'disabled'
        output = output + f"""<div class="row">	<div class="col-xs-12"><div class="box box-solid" id="{position.id}">
             <div class="box-header with-border">
            <h3 class="box-title"><b>{name}</b></h3>"""

        if display_controls:
            output = output + f""" <div class="pull-right box-tools">
        <button type="button" class="btn btn-default btn-sm moveup" data-id="{position.id}" {up}><i class="fa fa-arrow-up"></i> </button>
        <button type="button" class="btn btn-default btn-sm movedown" data-id="{position.id}" {down}><i class="fa fa-arrow-down"></i></button>
        </div>"""

        output = output + f"""</div>
        <div class="box-body">
        <p>{instruction}
        <span class="pull-right">
        <button type="button" class="btn btn-success btn-sm btn-flat reset" data-desc="{position_name}"><i class="fa fa-refresh"></i> Reset</button>
        </span>
        </p>
        <div id="candidate_list">
        <ul>
        {candidates_data}
        </ul>
        </div>
        </div>
        </div>
        </div>
        </div>
        """
        position.priority = num
        position.save()
        num = num + 1
        candidates_data = ''
    return output


def fetch_ballot(request):
    output = generate_ballot(display_controls=True)
    return JsonResponse(output, safe=False)


def generate_otp():
    """Link to this function
    https://www.codespeedy.com/otp-generation-using-random-module-in-python/
    """
    import random as r
    otp = ""
    for i in range(r.randint(5, 8)):
        otp += str(r.randint(1, 9))
    return otp


def dashboard(request):
    user = request.user
    # * Check if this voter has been verified
    if user.voter.otp is None or user.voter.verified == False:
        if not settings.SEND_OTP:
            # Bypass
            msg = bypass_otp()
            messages.success(request, msg)
            return redirect(reverse('show_ballot'))
        else:
            return redirect(reverse('voterVerify'))
    else:
        if user.voter.voted:  # * User has voted
            # To display election result or candidates I voted for ?
            context = {
                'my_votes': Votes.objects.filter(voter=user.voter),
            }
            return render(request, "voting/voter/result.html", context)
        else:
            return redirect(reverse('show_ballot'))

def result(request):
    user = request.user
    positions = Position.objects.all().order_by('priority')
    candidates = Candidate.objects.all()
    voters = Voter.objects.all()
    voted_voters = Voter.objects.filter(voted=1)
    list_of_candidates = []
    votes_count = []
    chart_data = {}
    # * Check if this voter has been verified
    if user.voter.otp is None or user.voter.verified == False:
        if not settings.SEND_OTP:
            # Bypass
            msg = bypass_otp()
            messages.success(request, msg)
            return redirect(reverse('show_ballot'))
        else:
            return redirect(reverse('voterVerify'))
    else:
        if user.voter.voted:  # * User has voted
            for position in positions:
                list_of_candidates = []
                votes_count = []
                for candidate in Candidate.objects.filter(position=position):
                    list_of_candidates.append(candidate.fullname)
                    votes = Votes.objects.filter(candidate=candidate).count()
                    votes_count.append(votes)
                chart_data[position] = {
                    'candidates': list_of_candidates,
                    'votes': votes_count,
                    'pos_id': position.id
                }
            # To display election result or candidates I voted for ?
            context = {
                'my_votes': Votes.objects.filter(voter=user.voter),
                'position_count': positions.count(),
                'candidate_count': candidates.count(),
                'voters_count': voters.count(),
                'voted_voters_count': voted_voters.count(),
                'positions': positions,
                'chart_data': chart_data,
                'page_title': "Result"
            }
            return render(request, "voting/voter/tally.html", context)
        else:
            # Add a message for users who haven't voted yet
            messages.info(request, "Please vote first to preview the result.")
            return redirect(reverse('show_ballot'))


def encrypt_result(request):
    positions = Position.objects.all().order_by('priority')
    chart_data = {}

    for position in positions:
        list_of_candidates = []
        votes_count = []

        # Fetch the candidates for the current position
        candidates_for_position = Candidate.objects.filter(position=position)

        for candidate in candidates_for_position:
            list_of_candidates.append(candidate.fullname)

            # Get the skordek for the candidate
            skordek = candidate.skordek

            # Append the skordek to the votes_count
            votes_count.append(candidate.skordek)

        chart_data[position] = {
            'candidates': list_of_candidates,
            'votes': votes_count,
            'pos_id': position.id
        }

    # To display election result or candidates I voted for ?
    context = {
        'positions': positions,
        'chart_data': chart_data,
        'page_title': "Result"
    }

    return render(request, "voting/voter/tally.html", context)

        

def verify(request):
    context = {
        'page_title': 'OTP Verification'
    }
    return render(request, "voting/voter/verify.html", context)


def resend_otp(request):
    """API For SMS
    I used https://www.multitexter.com/ API to send SMS
    You might not want to use this or this service might not be available in your Country
    For quick and easy access, Toggle the SEND_OTP from True to False in settings.py
    """
    user = request.user
    voter = user.voter
    error = False
    if settings.SEND_OTP:
        if voter.otp_sent >= 3:
            error = True
            response = "You have requested OTP three times. You cannot do this again! Please enter previously sent OTP"
        else:
            phone = voter.phone
            # Now, check if an OTP has been generated previously for this voter
            otp = voter.otp
            if otp is None:
                # Generate new OTP
                otp = generate_otp()
                voter.otp = otp
                voter.save()
            try:
                msg = "Dear " + str(user) + ", kindly use " + \
                    str(otp) + " as your OTP"
                message_is_sent = send_sms(phone, msg)
                if message_is_sent:  # * OTP was sent successfully
                    # Update how many OTP has been sent to this voter
                    # Limited to Three so voters don't exhaust OTP balance
                    voter.otp_sent = voter.otp_sent + 1
                    voter.save()

                    response = "OTP has been sent to your phone number. Please provide it in the box provided below"
                else:
                    error = True
                    response = "OTP not sent. Please try again"
            except Exception as e:
                # response = "OTP could not be sent." + str(e)
                response = "OTP has been created, please contacted admin" + str(e)

                # * Send OTP
    else:
        #! Update all Voters record and set OTP to 0000
        #! Bypass OTP verification by updating verified to 1
        #! Redirect voters to ballot page
        response = bypass_otp()
    return JsonResponse({"data": response, "error": error})


def bypass_otp():
    Voter.objects.all().filter(otp=None, verified=False).update(otp="0000", verified=True)
    response = "Kindly cast your vote"
    return response


def send_sms(phone_number, msg):
    """Read More
    https://www.multitexter.com/developers
    """
    import requests
    import os
    import json
    response = ""
    email = os.environ.get('SMS_EMAIL')
    password = os.environ.get('SMS_PASSWORD')
    if email is None or password is None:
        # raise Exception("Email/Password cannot be Null")
        raise Exception("")
    url = "https://app.multitexter.com/v2/app/sms"
    data = {"email": email, "password": password, "message": msg,
            "sender_name": "OTP", "recipients": phone_number, "forcednd": 1}
    headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
    r = requests.post(url, data=json.dumps(data), headers=headers)
    response = r.json()
    status = response.get('status', 0)
    if str(status) == '1':
        return True
    else:
        return False


def verify_otp(request):
    error = True
    if request.method != 'POST':
        messages.error(request, "Access Denied")
    else:
        otp = request.POST.get('otp')
        if otp is None:
            messages.error(request, "Please provide valid OTP")
        else:
            # Get User OTP
            voter = request.user.voter
            db_otp = voter.otp
            if db_otp != otp:
                messages.error(request, "Provided OTP is not valid")
            else:
                messages.success(
                    request, "You are now verified. Please cast your vote")
                voter.verified = True
                voter.save()
                error = False
    if error:
        return redirect(reverse('voterVerify'))
    return redirect(reverse('show_ballot'))


def show_ballot(request):
    if request.user.voter.voted:
        messages.error(request, "You have voted already")
        return redirect(reverse('voterDashboard'))
    ballot = generate_ballot(display_controls=False)
    context = {
        'ballot': ballot
    }
    return render(request, "voting/voter/ballot.html", context)


def preview_vote(request):
    if request.method != 'POST':
        error = True
        response = "Please browse the system properly"
    else:
        output = ""
        form = dict(request.POST)
        # We don't need to loop over CSRF token
        form.pop('csrfmiddlewaretoken', None)
        error = False
        data = []
        positions = Position.objects.all()
        for position in positions:
            max_vote = position.max_vote
            pos = slugify(position.name)
            pos_id = position.id
            if position.max_vote > 1:
                this_key = pos + "[]"
                form_position = form.get(this_key)
                if form_position is None:
                    continue
                if len(form_position) > max_vote:
                    error = True
                    response = "You can only choose " + \
                        str(max_vote) + " candidates for " + position.name
                else:
                    # for key, value in form.items():
                    start_tag = f"""
                       <div class='row votelist' style='padding-bottom: 2px'>
		                      	<span class='col-sm-4'><span class='pull-right'><b>{position.name} :</b></span></span>
		                      	<span class='col-sm-8'>
                                <ul style='list-style-type:none; margin-left:-40px'>
                                
                    
                    """
                    end_tag = "</ul></span></div><hr/>"
                    data = ""
                    for form_candidate_id in form_position:
                        try:
                            candidate = Candidate.objects.get(
                                id=form_candidate_id, position=position)
                            data += f"""
		                      	<li><i class="fa fa-check-square-o"></i> {candidate.fullname}</li>
                            """
                        except:
                            error = True
                            response = "Please, browse the system properly"
                    output += start_tag + data + end_tag
            else:
                this_key = pos
                form_position = form.get(this_key)
                if form_position is None:
                    continue
                # Max Vote == 1
                try:
                    form_position = form_position[0]
                    candidate = Candidate.objects.get(
                        position=position, id=form_position)
                    output += f"""
                            <div class='row votelist' style='padding-bottom: 2px'>
		                      	<span class='col-sm-4'><span class='pull-right'><b>{position.name} :</b></span></span>
		                      	<span class='col-sm-8'><i class="fa fa-check-circle-o"></i> {candidate.fullname}</span>
		                    </div>
                      <hr/>
                    """
                except Exception as e:
                    error = True
                    response = "Please, browse the system properly"
    context = {
        'error': error,
        'list': output
    }
    return JsonResponse(context, safe=False)


# def submit_ballot(request):
#     if request.method != 'POST':
#         messages.error(request, "Please, browse the system properly")
#         return redirect(reverse('show_ballot'))
    
    
#     # Verify if the voter has voted or not
#     # voter = request.user.voter
#     # if voter.voted:
#     #     messages.error(request, "You have voted already")
#     #     return redirect(reverse('voterDashboard'))
#     voter = request.user.voter
#     custom_user = CustomUser.objects.get(id=voter.admin.id)

#     # Check validation status
#     if custom_user.validation_status == 'pending':
#         messages.error(request, "Your voter status is still pending. You cannot vote at the moment. Please Contacted admin")
#         return redirect(reverse('voterDashboard'))
#     elif custom_user.validation_status == 'rejected':
#         messages.error(request, "Your voter status has been rejected. You cannot vote.")
#         return redirect(reverse('voterDashboard'))


#     if voter.voted:
#         messages.error(request, "You have voted already")
#         return redirect(reverse('voterDashboard'))

#     form = dict(request.POST)
#     form.pop('csrfmiddlewaretoken', None)  # Pop CSRF Token
#     form.pop('submit_vote', None)  # Pop Submit Button

#     # Ensure at least one vote is selected
#     if len(form.keys()) < 1:
#         messages.error(request, "Please select at least one candidate")
#         return redirect(reverse('show_ballot'))
#     positions = Position.objects.all()
#     form_count = 0
#     for position in positions:
#         max_vote = position.max_vote
#         pos = slugify(position.name)
#         pos_id = position.id
#         if position.max_vote > 1:
#             this_key = pos + "[]"
#             form_position = form.get(this_key)
#             if form_position is None:
#                 continue
#             if len(form_position) > max_vote:
#                 messages.error(request, "You can only choose " +
#                                str(max_vote) + " candidates for " + position.name)
#                 return redirect(reverse('show_ballot'))
#             else:
#                 for form_candidate_id in form_position:
#                     form_count += 1
#                     try:
#                         candidate = Candidate.objects.get(
#                             id=form_candidate_id, position=position)
#                         vote = Votes()
#                         vote.candidate = candidate
#                         vote.voter = voter
#                         vote.position = position
#                         vote.save()
#                     except Exception as e:
#                         messages.error(
#                             request, "Please, browse the system properly " + str(e))
#                         return redirect(reverse('show_ballot'))
#         else:
#             this_key = pos
#             form_position = form.get(this_key)
#             if form_position is None:
#                 continue
#             # Max Vote == 1
#             form_count += 1
#             try:
#                 form_position = form_position[0]
#                 candidate = Candidate.objects.get(
#                     position=position, id=form_position)
#                 vote = Votes()
#                 vote.candidate = candidate
#                 vote.voter = voter
#                 vote.position = position
#                 vote.save()
#             except Exception as e:
#                 messages.error(
#                     request, "Please, browse the system properly " + str(e))
#                 return redirect(reverse('show_ballot'))
#     # Count total number of records inserted
#     # Check it viz-a-viz form_count
#     inserted_votes = Votes.objects.filter(voter=voter)
#     if (inserted_votes.count() != form_count):
#         # Delete
#         inserted_votes.delete()
#         messages.error(request, "Please try voting again!")
#         return redirect(reverse('show_ballot'))
#     else:
#         # Update Voter profile to voted
#         voter.voted = True
#         voter.save()
#         messages.success(request, "Thanks for voting")
#         return redirect(reverse('voterDashboard'))


    # Credits to
# mikeivanov
# https://github.com/mikeivanov/paillier/

# import random
# import sys


# def ipow(a, b, n):
#     """calculates (a**b) % n via binary exponentiation, yielding itermediate
#        results as Rabin-Miller requires"""
#     A = a = (a % n)
#     yield A
#     t = 1
#     while t <= b:
#         t <<= 1

#     # t = 2**k, and t > b
#     t >>= 2

#     while t:
#         A = (A * A) % n
#         if t & b:
#             A = (A * a) % n
#         yield A
#         t >>= 1


# def rabin_miller_witness(test, possible):
#     """Using Rabin-Miller witness test, will return True if possible is
#        definitely not prime (composite), False if it may be prime."""
#     return 1 not in ipow(test, possible - 1, possible)


# smallprimes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
#                47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)


# def default_k(bits):
#     return max(40, 2 * bits)


# def is_probably_prime(possible, k=None):
#     if possible == 1:
#         return True
#     if k is None:
#         k = default_k(possible.bit_length())
#     for i in smallprimes:
#         if possible == i:
#             return True
#         if possible % i == 0:
#             return False
#     for i in range(int(k)):
#         test = random.randrange(2, possible - 1) | 1
#         if rabin_miller_witness(test, possible):
#             return False
#     return True


# def generate_prime(bits, k=None):
#     """Will generate an integer of b bits that is probably prime
#        (after k trials). Reasonably fast on current hardware for
#        values of up to around 512 bits."""
#     assert bits >= 8

#     if k is None:
#         k = default_k(bits)

#     while True:
#         possible = random.randrange(2 ** (bits - 1) + 1, 2 ** bits) | 1
#         if is_probably_prime(possible, k):
#             return possible
        

# import math

# def egcd(a, b):
#     """
#     Euclidean Extendted Algorithm for GCD

#     Code based on: https://en.wikibooks.org/wiki/Algorithm_Implementation/Mathematics/Extended_Euclidean_algorithm
#     """
#     if a == 0:
#         return (b, 0, 1)
#     else:
#         g, y, x = egcd(b % a, a)
#         return (g, x - (b // a) * y, y)

# def modinv(a, m):
#     """The multiplicitive inverse of a in the integers modulo p:
#              a * b == 1 mod p
#            Returns b.
#     """
#     g, x, y = egcd(a, m)
#     if g != 1:
#         raise Exception('modular inverse does not exist')
#     else:
#         return x % m

# class PrivateKey(object):

#     def __init__(self, p, q, n):
#         self.l = (p-1) * (q-1)
#         self.m = modinv(self.l, n)
#         self.p = p
#         self.q = q

#     def __repr__(self):
#         return '<PrivateKey: %s %s %s %s>' % (self.p, self.q, self.l, self.m)
    
#     #tambahan
#     # def to_dict(self):
#     #     return {"p": self.p, "q": self.q, "l": self.l, "m": self.m}

#     # @classmethod
#     # def from_dict(cls, data):
#     #     return cls(data["p"], data["q"], data["l"])

# class PublicKey(object):

#     @classmethod
#     def from_n(cls, n):
#         return cls(n)

#     def __init__(self, n):
#         self.n = n
#         self.n_sq = n * n
#         self.g = n + 1

#     def __repr__(self):
#         return '<PublicKey: %s %s %s>' % (self.n, self.g, self.n_sq)
    
#     #tambahan
#     # def to_dict(self):
#     #     return {"n": self.n, "g": self.g, "n_sq": self.n_sq}

#     # @classmethod
#     # def from_dict(cls, data):
#     #     return cls(data["n"])
    
    
# def generate_keypair(bits):
#     p = generate_prime(bits / 2)
#     q = generate_prime(bits / 2)
#     n = p * q
#     return PrivateKey(p, q, n), PublicKey(n)

# def encrypt(pub, plain):
#     r = get_r_in_z_n_star(pub)
#     return encrypt_with_r(pub, r, plain)

# def get_r_in_z_n_star(pub):
#     while True:
#         r = generate_prime(int(round(math.log(pub.n, 2))))
#         # r is in $$Z_{n}^{*}$$ i.e. Z-n-star (it has to be have a multiplicative inverse in Zn)
#         if r > 0 and r < pub.n and math.gcd(pub.n, r) == 1:
#             break
#     return r

# def encrypt_with_r(pub, r, plain):
#     x = pow(r, pub.n, pub.n_sq)
#     cipher = (pow(pub.g, plain, pub.n_sq) * x) % pub.n_sq
#     return cipher

# def e_add(pub, a, b):
#     """Add one encrypted integer to another"""
#     return a * b % pub.n_sq

# def e_add_const(pub, a, n):
#     """Add constant n to an encrypted integer"""
#     return a * pow(pub.g, n, pub.n_sq) % pub.n_sq

# def e_mul_const(pub, a, n):
#     """Multiplies an ancrypted integer by a constant"""
#     return pow(a, n, pub.n_sq)

# def decrypt(priv, pub, cipher):
#     x = pow(cipher, priv.l, pub.n_sq) - 1
#     plain = ((x // pub.n) * priv.m) % pub.n
#     return plain





# def submit_ballot(request):
#     if request.method != 'POST':
#         messages.error(request, "Please, browse the system properly")
#         return redirect(reverse('show_ballot'))
    
    
#     # Verify if the voter has voted or not
#     # voter = request.user.voter
#     # if voter.voted:
#     #     messages.error(request, "You have voted already")
#     #     return redirect(reverse('voterDashboard'))
#     voter = request.user.voter
#     custom_user = CustomUser.objects.get(id=voter.admin.id)

#     # Check validation status
#     if custom_user.validation_status == 'pending':
#         messages.error(request, "Your voter status is still pending. You cannot vote at the moment. Please Contacted admin")
#         return redirect(reverse('voterDashboard'))
#     elif custom_user.validation_status == 'rejected':
#         messages.error(request, "Your voter status has been rejected. You cannot vote.")
#         return redirect(reverse('voterDashboard'))


#     if voter.voted:
#         messages.error(request, "You have voted already")
#         return redirect(reverse('voterDashboard'))

#     form = dict(request.POST)
#     form.pop('csrfmiddlewaretoken', None)  # Pop CSRF Token
#     form.pop('submit_vote', None)  # Pop Submit Button

#     # Ensure at least one vote is selected
#     if len(form.keys()) < 1:
#         messages.error(request, "Please select at least one candidate")
#         return redirect(reverse('show_ballot'))
#     positions = Position.objects.all()
#     form_count = 0
#     for position in positions:
#         max_vote = position.max_vote
#         pos = slugify(position.name)
#         pos_id = position.id
#         if position.max_vote > 1:
#             this_key = pos + "[]"
#             form_position = form.get(this_key)
#             if form_position is None:
#                 continue
#             if len(form_position) > max_vote:
#                 messages.error(request, "You can only choose " +
#                                str(max_vote) + " candidates for " + position.name)
#                 return redirect(reverse('show_ballot'))
#             else:
#                 for form_candidate_id in form_position:
#                     form_count += 1
#                     try:
#                         candidate = Candidate.objects.get(
#                             id=form_candidate_id, position=position)
#                         vote = Votes()
#                         vote.candidate = candidate
#                         vote.voter = voter
#                         vote.position = position
#                         vote.save()
#                     except Exception as e:
#                         messages.error(
#                             request, "Please, browse the system properly " + str(e))
#                         return redirect(reverse('show_ballot'))
#         else:
#             this_key = pos
#             form_position = form.get(this_key)
#             if form_position is None:
#                 continue
#             # Max Vote == 1
#             form_count += 1
#             try:
#                 form_position = form_position[0]
#                 candidate = Candidate.objects.get(position=position, id=form_position)
#                 candidate_id = candidate.id  # Ambil ID candidate
#                 encrypted_candidate_id = encrypt(public_key, candidate_id)
#                 vote_encrypt = Votes_encrypt()
#                 vote_encrypt.voter = voter
#                 vote_encrypt.position = position
#                 vote_encrypt.candidate_encrypt_id = str(encrypted_candidate_id)
#                 vote_encrypt.save()
#                 vote = Votes()
#                 vote.candidate = candidate
#                 vote.voter = voter
#                 vote.position = position
#                 vote.save()
#             except Exception as e:
#                 messages.error(
#                     request, "Please, browse the system properly " + str(e))
#                 return redirect(reverse('show_ballot'))
#     # Count total number of records inserted
#     # Check it viz-a-viz form_count
#     inserted_votes = Votes.objects.filter(voter=voter)
#     if (inserted_votes.count() != form_count):
#         # Delete
#         inserted_votes.delete()
#         messages.error(request, "Please try voting again!")
#         return redirect(reverse('show_ballot'))
#     else:
#         # Update Voter profile to voted
#         voter.voted = True
#         voter.save()
#         messages.success(request, "Thanks for voting")
#         return redirect(reverse('voterDashboard'))

def submit_ballot(request):
    if request.method != 'POST':
        messages.error(request, "Please, browse the system properly")
        return redirect(reverse('show_ballot'))
    
    # Verify if the voter has voted or not
    voter = request.user.voter
    custom_user = voter.admin

    # Check validation status
    if custom_user.validation_status == 'pending':
        messages.error(request, "Your voter status is still pending. You cannot vote at the moment. Please contact admin.")
        return redirect(reverse('voterDashboard'))
    elif custom_user.validation_status == 'rejected':
        messages.error(request, "Your voter status has been rejected. You cannot vote.")
        return redirect(reverse('voterDashboard'))

    if voter.voted:
        messages.error(request, "You have voted already")
        return redirect(reverse('voterDashboard'))

    # Initialize skorenk for candidates if still 0
    candidates = Candidate.objects.all()
    for candidate in candidates:
        if candidate.skorenk == '0':
            encrypted_zero = encrypt(public_key, 0)
            candidate.skorenk = str(encrypted_zero)
            candidate.save()

    form = dict(request.POST)
    form.pop('csrfmiddlewaretoken', None)  # Pop CSRF Token
    form.pop('submit_vote', None)  # Pop Submit Button

    # Ensure at least one vote is selected
    if len(form.keys()) < 1:
        messages.error(request, "Please select at least one candidate")
        return redirect(reverse('show_ballot'))

    positions = Position.objects.all()
    form_count = 0

    # Initialize a dictionary to store the encrypted scores for each candidate
    encrypted_scores = {}

    for position in positions:
        max_vote = position.max_vote
        pos = slugify(position.name)
        pos_id = position.id

        if position.max_vote > 1:
            this_key = pos + "[]"
            form_position = form.get(this_key)
            if form_position is None:
                continue

            if len(form_position) > max_vote:
                messages.error(request, "You can only choose " +
                               str(max_vote) + " candidates for " + position.name)
                return redirect(reverse('show_ballot'))
            else:
                for form_candidate_id in form_position:
                    form_count += 1
                    try:
                        candidate = Candidate.objects.get(
                            id=form_candidate_id, position=position)

                        # Increment the encrypted score for the candidate
                        if candidate.id not in encrypted_scores:
                            encrypted_scores[candidate.id] = 0
                        encrypted_scores[candidate.id] += 1

                        vote = Votes()
                        vote.candidate = candidate
                        vote.voter = voter
                        vote.position = position
                        vote.save()
                    except Exception as e:
                        messages.error(
                            request, "Please, browse the system properly " + str(e))
                        return redirect(reverse('show_ballot'))
        else:
            this_key = pos
            form_position = form.get(this_key)
            if form_position is None:
                continue

            # Max Vote == 1
            form_count += 1
            try:
                form_position = form_position[0]
                candidate = Candidate.objects.get(
                    position=position, id=form_position)
                candidate_id = candidate.id  # Ambil ID candidate
                encrypted_candidate_id = encrypt(public_key, candidate_id)

                # Increment the encrypted score for the candidate
                if candidate_id not in encrypted_scores:
                    encrypted_scores[candidate_id] = 0
                encrypted_scores[candidate_id] += 1

                vote_encrypt = Votes_encrypt()
                vote_encrypt.voter = voter
                vote_encrypt.position = position
                vote_encrypt.candidate_encrypt_id = str(encrypted_candidate_id)
                vote_encrypt.save()

                vote = Votes()
                vote.candidate = candidate
                vote.voter = voter
                vote.position = position
                vote.save()
            except Exception as e:
                messages.error(
                    request, "Please, browse the system properly " + str(e))
                return redirect(reverse('show_ballot'))

    # Count total number of records inserted
    # Check it viz-a-viz form_count
    inserted_votes = Votes.objects.filter(voter=voter)

    if inserted_votes.count() != form_count:
        # Delete
        inserted_votes.delete()
        messages.error(request, "Please try voting again!")
        return redirect(reverse('show_ballot'))
    else:
        # Update Voter profile to voted
        voter.voted = True
        voter.save()

        # Update encrypted scores for each candidate
        with transaction.atomic():
            for candidate_id, encrypted_score in encrypted_scores.items():
                candidate = Candidate.objects.get(id=candidate_id)
                candidate.skorenk = e_add_const(public_key, int(candidate.skorenk), encrypted_score)
                candidate.skordek = decrypt(private_key, public_key,candidate.skorenk)
                
                candidate.save()

        messages.success(request, "Thanks for voting")
        return redirect(reverse('voterDashboard'))