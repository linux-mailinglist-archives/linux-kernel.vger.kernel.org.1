Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971632928A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgJSN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728810AbgJSN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603115763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGq0Dog2vrrUmRlbaOcpmdszZESC52i7xq+KjLSKB7s=;
        b=Ux/RkuZPhHgvY8jZWe8Ua8qMGaUNJl5RjtmhcXfnWMZgxeIwRI6ARDsE/nTK15tXGCQA6V
        +FKYEdSbhIaVxboHTS8816idHlVu1V2Pga+SHwvHh8ZoiHzdAozrYU3BE+z8tC746Fk2IZ
        7ITCFCYbWZjfxqY70Q2jWbW+9cx1Qxk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-6239m3o6OvixwEaip3W_SA-1; Mon, 19 Oct 2020 09:56:00 -0400
X-MC-Unique: 6239m3o6OvixwEaip3W_SA-1
Received: by mail-qk1-f198.google.com with SMTP id n125so7269802qke.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IGq0Dog2vrrUmRlbaOcpmdszZESC52i7xq+KjLSKB7s=;
        b=NkK36BLB8Sb/WeNBpejugJPHLXlHyWPnRycqgBNDGZ01PktGiujPj6eyPdmhRb5taP
         ufEMxt7Ey1CHa/cPT0H2syqo4dHvkw6bf+SEOPsNbgt7x5rf9fs5yMOQ3rdmumLHq8Is
         uE0UOtFA+PDvLog6ZPKg9o5cP91+DE4YQ9mSsDzUXAzcSFpxWrcniFYlQy7wUXoTeAtT
         2rCf/2KxnDjNm798W+4JygTRhzMps+0XZFtVfdhtTExW+Qcx/JG6DIvDKTtW9f+unQJ3
         amip8r7uGuBMvTuq76RQm5XERR6DcfBb4SvvAPpTUo6GDHuWlRZVPNrhPJjn6EieZtpy
         9UyA==
X-Gm-Message-State: AOAM532h+ilacc+oazvuaRlCsZL3mhuZZu1mIQuxAB/n6z9nlFS9lH2+
        B0uWbUUBNe1q+tkNpva+f4z1jPo6uPxZIwKYVfSl0JMoV79heZECOC7pbhPZLt8JlZk6ujc4bKI
        4d+aRcO1uXa8tjljjZSUfHAIq
X-Received: by 2002:a37:a55:: with SMTP id 82mr16832673qkk.142.1603115760242;
        Mon, 19 Oct 2020 06:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+64Ve7DkDi/Vqp196h0/x90+KcEHV+dh5A7unchwt3kwGcN6aMdk8yekZmzkbhBTq1AGOtA==
X-Received: by 2002:a37:a55:: with SMTP id 82mr16832647qkk.142.1603115759898;
        Mon, 19 Oct 2020 06:55:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l125sm52560qke.23.2020.10.19.06.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 06:55:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
Date:   Mon, 19 Oct 2020 06:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019040612.GA16172@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/20 9:06 PM, Xu Yilun wrote:
> On Fri, Oct 16, 2020 at 09:21:50AM -0700, Tom Rix wrote:
>> On 10/15/20 11:02 PM, Xu Yilun wrote:
>>> Add support for overriding the default matching of a dfl device to a dfl
>>> driver. It follows the same way that can be used for PCI and platform
>>> devices. This patch adds the 'driver_override' sysfs file.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
>>>  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++++++++++++++-
>>>  include/linux/dfl.h                     |  2 ++
>>>  3 files changed, 79 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
>>> index 23543be..db7e8d3 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-dfl
>>> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
>>> @@ -1,15 +1,35 @@
>>>  What:		/sys/bus/dfl/devices/dfl_dev.X/type
>>> -Date:		Aug 2020
>>> -KernelVersion:	5.10
>>> +Date:		Oct 2020
>>> +KernelVersion:	5.11
>>>  Contact:	Xu Yilun <yilun.xu@intel.com>
>>>  Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
>>>  		supports 2 FIU types, 0 for FME, 1 for PORT.
>>>  		Format: 0x%x
>>>  
>>>  What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
>>> -Date:		Aug 2020
>>> -KernelVersion:	5.10
>>> +Date:		Oct 2020
>>> +KernelVersion:	5.11
>>>  Contact:	Xu Yilun <yilun.xu@intel.com>
>>>  Description:	Read-only. It returns feature identifier local to its DFL FIU
>>>  		type.
>>>  		Format: 0x%x
>> These updates, do not match the comment.
>>
>> Consider splitting this out.
> I'm sorry it's a typo. The above code should not be changed.
>
>>> +
>>> +What:           /sys/bus/dfl/devices/.../driver_override
>>> +Date:           Oct 2020
>>> +KernelVersion:  5.11
>>> +Contact:        Xu Yilun <yilun.xu@intel.com>
>> I am looking at description and trying to make it consistent with sysfs-bus-pci
>>> +Description:    This file allows the driver for a device to be specified.
>> 'to be specified which will override the standard dfl bus feature id to driver mapping.'
> Yes, it could be improved.
>
> Actually now it is the "type" and "feature id" matching, the 2 fields
> are defined for dfl_driver.id_table. In future for dfl v1, it may be
> GUID matching, which will be added to id_table. So how about we make it
> more generic:
>
> 'to be specified which will override the standard ID table matching.'
yes, this is good.
>
>>
>>>  When
>>> +                specified, only a driver with a name matching the value written
>>> +                to driver_override will have an opportunity to bind to the
>>> +                device. The override is specified by writing a string to the
>>> +                driver_override file (echo dfl-uio-pdev > driver_override) and
>>> +                may be cleared with an empty string (echo > driver_override).
>>> +                This returns the device to standard matching rules binding.
>>> +                Writing to driver_override does not automatically unbind the
>>> +                device from its current driver or make any attempt to
>>> +                automatically load the specified driver.  If no driver with a
>>> +                matching name is currently loaded in the kernel, the device
>>> +                will not bind to any driver.  This also allows devices to
>>> +                opt-out of driver binding using a driver_override name such as
>>> +                "none".  Only a single driver may be specified in the override,
>>> +                there is no support for parsing delimiters.
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>> index 511b20f..bc35750 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>>>  	struct dfl_driver *ddrv = to_dfl_drv(drv);
>>>  	const struct dfl_device_id *id_entry;
>>>  
>>> +	/* When driver_override is set, only bind to the matching driver */
>>> +	if (ddev->driver_override)
>>> +		return !strcmp(ddev->driver_override, drv->name);
>>> +
>>>  	id_entry = ddrv->id_table;
>>>  	if (id_entry) {
>>>  		while (id_entry->feature_id) {
>>> @@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>  			      ddev->type, ddev->feature_id);
>>>  }
>>>  
>> I am looking at other implementations of driver_override* and looking for consistency.
>>
>>> +static ssize_t driver_override_show(struct device *dev,
>>> +				    struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct dfl_device *ddev = to_dfl_dev(dev);
>>> +	ssize_t len;
>>> +
>>> +	device_lock(dev);
>>> +	len = sprintf(buf, "%s\n", ddev->driver_override);
>> len = snprintf(buf, PAGE_SIZE ...
> It is good to me.
>
> Some bus drivers use snprintf, some use sprintf.
>
> I think it is reasonable snprintf is used here, unlike %d, %u ... it is
> uncertain for the output size of %s.

I am not sure if you are agreeing to do this change.

I was looking at the other driver_override_show() functions.

Generally the 'n' variants of string functions should be used.

>
>>> +	device_unlock(dev);
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t driver_override_store(struct device *dev,
>>> +				     struct device_attribute *attr,
>>> +				     const char *buf, size_t count)
>>> +{
>>> +	struct dfl_device *ddev = to_dfl_dev(dev);
>>> +	char *driver_override, *old, *cp;
>>> +
>>> +	/* We need to keep extra room for a newline */
>>> +	if (count >= (PAGE_SIZE - 1))
>>> +		return -EINVAL;
>>> +
>>> +	driver_override = kstrndup(buf, count, GFP_KERNEL);
>>> +	if (!driver_override)
>>> +		return -ENOMEM;
>>> +
>>> +	cp = strchr(driver_override, '\n');
>>> +	if (cp)
>>> +		*cp = '\0';
>>> +
>>> +	device_lock(dev);
>>> +	old = ddev->driver_override;
>>> +	if (strlen(driver_override)) {
>>> +		ddev->driver_override = driver_override;
>>> +	} else {
>>> +		kfree(driver_override);
>>> +		ddev->driver_override = NULL;
>>> +	}
>>> +	device_unlock(dev);
>>> +
>>> +	kfree(old);
>>> +
>>> +	return count;
>>> +}
>>> +static DEVICE_ATTR_RW(driver_override);
>>> +
>>>  static ssize_t
>>>  type_show(struct device *dev, struct device_attribute *attr, char *buf)
>>>  {
>>> @@ -324,6 +375,7 @@ static DEVICE_ATTR_RO(feature_id);
>>>  static struct attribute *dfl_dev_attrs[] = {
>>>  	&dev_attr_type.attr,
>>>  	&dev_attr_feature_id.attr,
>>> +	&dev_attr_driver_override.attr,
>>>  	NULL,
>>>  };
>>>  ATTRIBUTE_GROUPS(dfl_dev);
>>> @@ -469,7 +521,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
>>>  
>>>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>>>  {
>>> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
>>> +	if (!dfl_drv || !dfl_drv->probe)
>> id_table is still needed for the normal case.
>>
>> Instead of removing this check, could you add something like
>>
>> || (!dfl_drv->is_override && !dfl_drv->id_table)
> I don't think it is needed. Seems is_override and !id_table are duplicated
> conditions for this implementation. And it may make confusing, e.g. could
> a driver been force matched when is_override is not set?
>
> I think we could make it simple, if the dfl driver didn't provide the
> id_table, normally it could not match any device. I think it could be
> easily understood by dfl driver developers.
>
Then an ASSERT should be added in dfl_bus_match() for id_entry.

Tom

> Thanks,
> Yilun
>
>> Tom
>>
>>>  		return -EINVAL;
>>>  
>>>  	dfl_drv->drv.owner = owner;
>>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>>> index 7affba2f..e1b2471 100644
>>> --- a/include/linux/dfl.h
>>> +++ b/include/linux/dfl.h
>>> @@ -32,6 +32,7 @@ enum dfl_id_type {
>>>   * @num_irqs: number of IRQs supported by this dfl device.
>>>   * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
>>>   * @id_entry: matched id entry in dfl driver's id table.
>>> + * @driver_override: driver name to force a match
>>>   */
>>>  struct dfl_device {
>>>  	struct device dev;
>>> @@ -43,6 +44,7 @@ struct dfl_device {
>>>  	unsigned int num_irqs;
>>>  	struct dfl_fpga_cdev *cdev;
>>>  	const struct dfl_device_id *id_entry;
>>> +	char *driver_override;
>>>  };
>>>  
>>>  /**

