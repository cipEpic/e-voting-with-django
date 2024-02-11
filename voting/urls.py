from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name="voterDashboard"),
    path('ballot/fetch/', views.fetch_ballot, name='fetch_ballot'),
    path('dashboard/', views.dashboard, name='voterDashboard'),
    path('result/', views.result, name='voterResult'),
    path('encrypt/result/', views.encrypt_result, name='voterEncryptResult'),
    path('verify/', views.verify, name='voterVerify'),
    path('verify/otp', views.verify_otp, name='verify_otp'),
    path('otp/resend/', views.resend_otp, name='resend_otp'),
    path('ballot/vote', views.show_ballot, name='show_ballot'),
    path('ballot/vote/preview', views.preview_vote, name='preview_vote'),
    path('ballot/vote/submit', views.submit_ballot, name='submit_ballot'),
    # path('ballot/vote/submit/encrypt', views.submit_ballot_encrypt, name='submit_ballot_encrypt'),
]
