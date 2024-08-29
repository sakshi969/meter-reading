from django.contrib import admin
from .models import Service
from .models import billinfo
from .models import paymentrecords


class ServiceAdmin(admin.ModelAdmin):
    list_display=('service_icons','service_title','service_des')

class billsinfo(admin.ModelAdmin):
    list_display=('user_id','month_frm','month_to','meter_id','prev_read', 'new_read', 'units', 'amount', 'status')

class paymentrecord(admin.ModelAdmin):
    list_display=('user_id','date','time','refid','remark','amount')
        
admin.site.register(Service,ServiceAdmin)
admin.site.register(billinfo,billsinfo)
admin.site.register(paymentrecords,paymentrecord)
# Register your models here.
