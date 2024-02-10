# # voting/paillier/example.py
# from paillier import encrypt, decrypt
# from paillier_keys import read_paillier_keys_from_file



# def perform_encryption_and_decryption(bits=64):
#     # Baca kunci-kunci Paillier dari file
#     private_key, public_key = read_paillier_keys_from_file()

#     # Misalnya, hasil suara dari pemilih
#     vote_result = 42

#     # Gunakan kunci publik untuk mengenkripsi hasil suara
#     encrypted_vote = encrypt(public_key, vote_result)
#     print("Hasil encrypt:", encrypted_vote)

#     # Gunakan kunci privat untuk mendekripsi hasil suara yang dienkripsi
#     decrypted_vote = decrypt(private_key, public_key, encrypted_vote)
#     print("Hasil decrypt:", decrypted_vote)

# # Panggil fungsi
# perform_encryption_and_decryption(bits=64)


# voting/paillier/example.py
import pickle
from voting.paillier.paillier import encrypt, decrypt

# Baca kunci privat dari file
with open("private_key.pkl", "rb") as private_file:
    private_key = pickle.load(private_file)

# Baca kunci publik dari file
with open("public_key.pkl", "rb") as public_file:
    public_key = pickle.load(public_file)

# Misalnya, hasil suara dari pemilih
vote_result = 42

# Gunakan kunci publik untuk mengenkripsi hasil suara
encrypted_vote = encrypt(public_key, vote_result)
print("Hasil encrypt:", encrypted_vote)
# encrypted_vote = 33499192531448476849903756740017311248

# Gunakan kunci privat untuk mendekripsi hasil suara yang dienkripsi
decrypted_vote = decrypt(private_key, public_key, encrypted_vote)
print("Hasil decrypt:", decrypted_vote)



# import pickle
# from paillier import encrypt, decrypt

# pu = open("C:/xampp/htdocs/skripsi/e-voting-with-django/pu.pk", 'rb')
# pr = open("C:/xampp/htdocs/skripsi/e-voting-with-django/pri.pk", 'rb')
# public_key = pickle.load(pu)
# private_key = pickle.load(pr) 

# # Contoh ID kandidat
# candidate_id = 18

# # Enkripsi ID kandidat menggunakan kunci publik
# encrypted_candidate_id = encrypt(candidate_id, public_key)

# print("Encrypted Candidate ID:", encrypted_candidate_id)

# # Dekripsi kembali ID kandidat menggunakan kunci pribadi
# decrypted_candidate_id = decrypt(encrypted_candidate_id, private_key)

# print("Decrypted Candidate ID:", decrypted_candidate_id)
