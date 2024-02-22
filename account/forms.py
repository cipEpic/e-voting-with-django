from django import forms
from .models import *


class FormSettings(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(FormSettings, self).__init__(*args, **kwargs)
        # Here make some changes such as:
        for field in self.visible_fields():
            field.field.widget.attrs['class'] = 'form-control'


class CustomUserForm(FormSettings):
    email = forms.EmailField(required=True)
    # email = forms.EmailField(required=True)
    password = forms.CharField(widget=forms.PasswordInput)
    user_photo = forms.ImageField( required=True)  # Add this line for user_photo
    # exclude = ['validation_status']
    ni = forms.CharField(max_length=16, required=True)  # Add 'ni' field
    widget = {
        'password': forms.PasswordInput(),
    }

    def __init__(self, *args, **kwargs):
        super(CustomUserForm, self).__init__(*args, **kwargs)
        if kwargs.get('instance'):
            instance = kwargs.get('instance').__dict__
            self.fields['password'].required = False
            for field in CustomUserForm.Meta.fields:
                self.fields[field].initial = instance.get(field)
            if self.instance.pk is not None:
                self.fields['password'].widget.attrs['placeholder'] = "Fill this only if you wish to update password"
        else:
            self.fields['first_name'].required = True
            self.fields['last_name'].required = True

    def clean_email(self, *args, **kwargs):
        formEmail = self.cleaned_data['email'].lower()
        if self.instance.pk is None:  # Insert
            if CustomUser.objects.filter(email=formEmail).exists():
                raise forms.ValidationError(
                    "The given email is already registered")
        else:  # Update
            dbEmail = self.Meta.model.objects.get(
                id=self.instance.pk).email.lower()
            if dbEmail != formEmail:  # There has been changes
                if CustomUser.objects.filter(email=formEmail).exists():
                    raise forms.ValidationError(
                        "The given email is already registered")
        return formEmail
    
    def clean_user_photo(self):
        user_photo = self.cleaned_data.get('user_photo')
        if not user_photo:
            raise forms.ValidationError("User photo is required.")
        return user_photo
    
    # def clean_ni(self, *args, **kwargs):
    #     formNi = self.cleaned_data['ni'].lower()
    #     if self.instance.pk is None:  # Insert
    #         if CustomUser.objects.filter(email=formNi).exists():
    #             raise forms.ValidationError(
    #                 "The given nomor identitas is already registered")
    #     else:  # Update
    #         dbNi = self.Meta.model.objects.get(
    #             id=self.instance.pk).ni.lower()
    #         if dbNi != formNi:  # There has been changes
    #             if CustomUser.objects.filter(email=formNi).exists():
    #                 raise forms.ValidationError(
    #                     "The given nomor identitas is already registered")
    #     return formNi

    def clean_password(self):
        password = self.cleaned_data.get("password", None)
        if self.instance.pk is not None:
            if not password:
                # return None
                return self.instance.password

        return make_password(password)

    class Meta:
        model = CustomUser
        fields = ['last_name', 'first_name', 'email', 'password', 'user_photo', 'ni',]
