from django.db import models
from account.models import CustomUser
# Create your models here.


class Voter(models.Model):
    admin = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    phone = models.CharField(max_length=11, unique=True)  # Used for OTP
    otp = models.CharField(max_length=10, null=True)
    verified = models.BooleanField(default=False)
    voted = models.BooleanField(default=False)
    otp_sent = models.IntegerField(default=0)  # Control how many OTPs are sent

    # New columns
    # photo_V = models.ImageField(upload_to="voting_voter")
    # validation_status = models.CharField(
    #     max_length=20, choices=[('pending', 'Pending'), ('approved', 'Approved'), ('rejected', 'Rejected')],
    #     default='pending'
    # )
    
    def __str__(self):
        return self.admin.last_name + ", " + self.admin.first_name


class Position(models.Model):
    name = models.CharField(max_length=50, unique=True)
    max_vote = models.IntegerField()
    priority = models.IntegerField()

    def __str__(self):
        return self.name


class Candidate(models.Model):
    fullname = models.CharField(max_length=50)
    photo = models.ImageField(upload_to="candidates")
    bio = models.TextField()
    position = models.ForeignKey(Position, on_delete=models.CASCADE)
    skorenk = models.CharField(max_length=500, default='0')  # Skor untuk data terenkripsi
    skordek = models.CharField(max_length=500, default='0')  # Skor untuk data terdekripsi

    def __str__(self):
        return self.fullname


class Votes(models.Model):
    voter = models.ForeignKey(Voter, on_delete=models.CASCADE)
    position = models.ForeignKey(Position, on_delete=models.CASCADE)
    candidate = models.ForeignKey(Candidate, on_delete=models.CASCADE)


class Votes_encrypt(models.Model):
    voter = models.ForeignKey(Voter, on_delete=models.CASCADE)
    position = models.ForeignKey(Position, on_delete=models.CASCADE)
    # candidate_encrypt = models.ForeignKey(Candidate, on_delete=models.CASCADE)
    candidate_encrypt_id = models.CharField(max_length=500)  # Adjust the max_length as needed

    def __str__(self):
        return f"{self.voter} - {self.position} - {self.candidate_encrypt}"


# class party(models.Model):
#     party_a = models.CharField(db_column='Candidate_1', max_length=512)  # Field name made lowercase.
#     party_b = models.CharField(db_column='Candidate_2', max_length=512)  # Field name made lowercase.
#     party_c = models.CharField(db_column='Candidate_3', max_length=512)  # Field name made lowercase.

#     class Meta:
#         ##managed = False
#         db_table = 'party'
 