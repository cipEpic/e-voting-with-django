# # voting/paillier/paillier_keys.py
# import os
# from paillier import generate_keypair

# bits = 64  # Sesuaikan dengan kebutuhan
# key_file = "paillier_keys.txt"

# # Jika file paillier_keys.txt belum ada, generate kunci baru dan simpan ke file
# if not os.path.exists(key_file):
#     private_key, public_key = generate_keypair(bits)
    
#     # Simpan kunci-kunci ke dalam file
#     with open(key_file, "w") as file:
#         file.write(f"Private Key: {private_key}\n")
#         file.write(f"Public Key: {public_key}")
# else:
#     # Baca kunci-kunci dari file jika sudah ada
#     with open(key_file, "r") as file:
#         lines = file.readlines()
#         private_key = lines[0].split(": ")[1].strip()
#         public_key = lines[1].split(": ")[1].strip()

# # Variabel global untuk menyimpan kunci-kunci
# # GLOBAL_PRIVATE_KEY = private_key
# # GLOBAL_PUBLIC_KEY = public_key

# # Cetak hasil kunci privat dan publik
# print("Private Key:", private_key)
# print("Public Key:", public_key)

# def read_paillier_keys_from_file(file_path="paillier_keys.txt"):
#     with open(file_path, "r") as file:
#         lines = file.readlines()
#         private_key_str = lines[0].split(": ")[1].strip()
#         public_key_str = lines[1].split(": ")[1].strip()

#     # Ubah string kunci menjadi objek kunci menggunakan evaluasi literal
#     private_key = eval(private_key_str)
#     public_key = eval(public_key_str)

#     return private_key, public_key

# voting/paillier/paillier_keys.py
# from paillier import generate_keypair

# bits = 64  # Sesuaikan dengan kebutuhan
# private_key, public_key = generate_keypair(bits)

# # Variabel global untuk menyimpan kunci-kunci
# GLOBAL_PRIVATE_KEY = private_key
# GLOBAL_PUBLIC_KEY = public_key

# # Cetak hasil kunci privat dan publik
# print("Private Key:", private_key)
# print("Public Key:", public_key)


# import pickle
# from paillier import generate_keypair

# # Fungsi untuk menyimpan kunci ke dalam file
# def save_key_to_file(key, filename):
#     with open(filename, 'wb') as key_file:
#         pickle.dump(key, key_file)

# # Fungsi untuk membaca kunci dari file
# def load_key_from_file(filename):
#     with open(filename, 'rb') as key_file:
#         key = pickle.load(key_file)
#     return key

# # Generate kunci baru
# bits = 64  # Sesuaikan dengan kebutuhan
# private_key, public_key = generate_keypair(bits)

# # Simpan kunci pribadi ke dalam file 'pri.pk'
# save_key_to_file(private_key, 'pri.pk')

# # Simpan kunci publik ke dalam file 'pu.pk'
# save_key_to_file(public_key, 'pu.pk')

# # Cetak hasil kunci privat dan publik
# print("Private Key:", private_key)
# print("Public Key:", public_key)

# # Baca kunci pribadi dari file 'pri.pk'
# loaded_private_key = load_key_from_file('pri.pk')
# print("Loaded Private Key:", loaded_private_key)

# # Baca kunci publik dari file 'pu.pk'
# loaded_public_key = load_key_from_file('pu.pk')
# print("Loaded Public Key:", loaded_public_key)

# voting/paillier/keys.py
import pickle
from paillier import generate_keypair

bits = 64  # Sesuaikan dengan kebutuhan
private_key, public_key = generate_keypair(bits)

with open("private_key.pkl", "wb") as private_file:
    pickle.dump(private_key, private_file)

with open("public_key.pkl", "wb") as public_file:
    pickle.dump(public_key, public_file)


# Cetak hasil kunci privat dan publik
print("Private Key:", private_key)
print("Public Key:", public_key)