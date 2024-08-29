from django.db import models
class Service(models.Model):
    service_icons=models.CharField(max_length=50)
    service_title=models.CharField(max_length=50)
    service_des=models.TextField()
    
class billinfo(models.Model):
   user_id=models.IntegerField()
   month_frm=models.DateField()
   month_to=models.DateField()
   meter_id=models.IntegerField()
   prev_read=models.IntegerField()
   new_read=models.IntegerField()
   units=models.IntegerField()
   amount=models.IntegerField()
   status=models.IntegerField()

class paymentrecords(models.Model):
  user_id=models.IntegerField()
  date=models.DateField()
  time=models.TimeField()
  refid=models.CharField(max_length=12)
  remark=models.IntegerField()
  amount=models.IntegerField()
# Create your models here.
