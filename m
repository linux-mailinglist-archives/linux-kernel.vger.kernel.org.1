Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A9271F03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIUJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgIUJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600681096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMueE7TUp93oQ7tBGEmbtQUpxk5L9SeW1/QycLtgmXo=;
        b=IbiU2duyUCH/bL2ghf4JccqXzyekJB5w0D6LUpVPLpB87H9sdPBeLFgj+62t8MbMtZKWFY
        681PH0wdxZNDWPSQmkrZM/anvj1nDbgIqEl9eMZrT8PfGNZ9oLkORRverwHdODcSuuc6hs
        kv6Eb3xKUM88RU9s+X/gqZUmCRHOv+4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-dPph-hKFMf-zLoV9KTZEUA-1; Mon, 21 Sep 2020 05:38:14 -0400
X-MC-Unique: dPph-hKFMf-zLoV9KTZEUA-1
Received: by mail-ej1-f69.google.com with SMTP id d8so4647658ejt.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMueE7TUp93oQ7tBGEmbtQUpxk5L9SeW1/QycLtgmXo=;
        b=D4AamzQZW4MMiH8rjvQHCo6Wr9qOXau2KfwPZ+B4owqzO8LkIa8WKSRTuPOayHTVsN
         yxd6J6qVR+MY6TD1W38UrWAx395O9zXYdA1dHl9197ZUgetObdqQx0sZQ7N+GTJcKpfd
         DsFcgGtUjPap+jLuadGwvELiGTcFdjVp5vOUuzaU+c3eJmu8uopf92wtyJ+4zbpFNENO
         HjZGZ99NE8Uh9dzXfCaRdqXexPdujPZeVGIcOsBhSwAHC3odZsh9Vmq8UCeyKuwWCWjK
         LwE1S+5ktBafIbNHIRAjcbAPgDmoAWMvzx+j32PSIdGBbI/VuBLqc4CYyrwRb8Y4FbeA
         chUA==
X-Gm-Message-State: AOAM533RyYA3M/bBANxmZS5klrE/4OnwrkwWxHgaDJsYWX4jxJU8zrN3
        WqKo53UB4OSY9LgYWSYYaQvvrEMOOcEdwLWVI1ddjlNI2P9ASWnymXq8kS/kSWTn02p25Lk0svK
        2Ymuc6yAXVuScWbTVyVXBoOPv
X-Received: by 2002:a17:906:4e54:: with SMTP id g20mr50585146ejw.252.1600681092949;
        Mon, 21 Sep 2020 02:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJSZTXdBVWGqB2un9eeUK9ZWv92rLjbjiVwFl5amHpnBMSabLAay1iXxSoBq76KE4eSf8Hvw==
X-Received: by 2002:a17:906:4e54:: with SMTP id g20mr50585133ejw.252.1600681092754;
        Mon, 21 Sep 2020 02:38:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j15sm8509972ejs.5.2020.09.21.02.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:38:12 -0700 (PDT)
Subject: Re: [PATCH v2] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200904142846.5356-1-divya_bharathi@dell.com>
 <aaf3b072-a109-4f69-67dd-bea3dc5fb023@redhat.com>
 <DM6PR19MB2636829402BC67EC1048E15FFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
 <CY4PR19MB12544CE6AFD16E89E688ACCD85200@CY4PR19MB1254.namprd19.prod.outlook.com>
 <CY4PR19MB1254A26A233052B71ACC5ACA853E0@CY4PR19MB1254.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6dbd512-760a-bd01-28ab-7e82d18d03d8@redhat.com>
Date:   Mon, 21 Sep 2020 11:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CY4PR19MB1254A26A233052B71ACC5ACA853E0@CY4PR19MB1254.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/20 7:22 AM, Bharathi, Divya wrote:

<snip>

>>>>> +
>>>>> +/**
>>>>> + * exit_enum_attributes() - Clear all attribute data
>>>>> + * @kset: The kset to free
>>>>> + *
>>>>> + * Clears all data allocated for this group of attributes  **/ void
>>>>> +exit_enum_attributes(struct kset *kset) {
>>>>> +	struct kobject *pos, *next;
>>>>> +
>>>>> +	mutex_lock(&kset_mutex);
>>>>> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
>>>>> +		sysfs_remove_group(pos, &enumeration_attr_group);
>>>>> +	}
>>>>> +	mutex_unlock(&kset_mutex);
>>>>> +	mutex_lock(&enum_mutex);
>>>>> +	kfree(enumeration_data);
>>>>> +	mutex_unlock(&enum_mutex);
>>>>> +}
>>>>
>>>> Since there is now only 1 kset for the main dir, you are now calling
>>>> sysfs_remove_group 4 times (for all the different times) on each entry
>>>> in the attributes dir. I guess this may fail silently, but it still is
>>>> not good. So this needs to be fixed.
>>>>
>>>> The remarks to this file also apply to the:
>>>>
>>>> drivers/platform/x86/dell-wmi-int-attributes.c
>>>> drivers/platform/x86/dell-wmi-string-attributes.c
>>>>
>>>> files.
>>>>
> 
> Since we maintained 4 different attribute groups under 1 kset, each time
> respective attribute group will be removed. And once all groups are
> removed, kset is deleted.

sysfs_remove_group() just does a kernfs_remove_by_name() for each
attribute in the group.

Since the integer_, enumeration_ and string_ attr_group-s all
have e.g. a current_value attribute that means that current_value
will be removed 3 times and for the 2nd and 3th call
kernfs_remove_by_name() will fail with -ENOENT.

Currently neither kernfs_remove_by_name() nor sysfs_remove_group() print
an error message for this, but still it is not very clean.

Instead why not do this:

int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
                         struct kobject *attr_name_kobj)
{
         int retval = sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
         int i, next_obj;

         if (retval)
                 goto out;

         mutex_lock(&wmi_priv.mutex);
	enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
	/* ^^^^^^^^^^^^^^^^ This line is new ^^^^^^^^^^^^^^^^^^^^^^^^*/
	...


void exit_enum_attributes(void)
{
         int i;

         for (i = 0; i < enumeration_instances_count; i++) {
		if (enumeration_data[instance_id].attr_name_kobj)
                         sysfs_remove_group(enumeration_data[instance_id].attr_name_kobj, &enumeration_attr_group);
	}

         kfree(enumeration_data);
}


That makes the teardown mirror the setup much more closely and as such is
a cleaner solution IMHO.

Regards,

Hans

