Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5729271E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgIUJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:08:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726387AbgIUJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600679317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXgGkXf1ns6wj3iCmrCbcIG5/mx3epd2YbhN5mp9GGs=;
        b=benbJNWkIa5fvOmzioYPUCiKNjId6KwVWT479Tl/McN77DaJIrskfSU918LZpUZr2iIrqK
        EFm2UU9gkCKb1OkFoTVvdvw9J1rD19s+h2MFgIFNWFh8AOW2Qd5fC/7KARwVNikxTexY/k
        jRHTY6UJtPUYUU0/CWCxemE3Qwd7e8Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-bQCSBEeLN-Knq6HXehfAXw-1; Mon, 21 Sep 2020 05:08:35 -0400
X-MC-Unique: bQCSBEeLN-Knq6HXehfAXw-1
Received: by mail-ed1-f72.google.com with SMTP id b12so4398656edw.15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXgGkXf1ns6wj3iCmrCbcIG5/mx3epd2YbhN5mp9GGs=;
        b=dLjXJxwnXzBincxuHvADY+W33bbBSXftHTjS7BOr8bun6/t6mrq1d+VzWkXGKMP47X
         EymNoFuqtU1i0tAYxOK7svTpG+NU7/H00pERBu+VjqZZJoTjjSfoPe0jgtyRqK7OuPW6
         BhM+AdCB+hzVCJfmBguT21IoBxUTzVXDbw5OT/ECCu0cReaYlApRFCscPhzAweL/gO3n
         jMQcRFPPDgMBM893Lb/wXM59QkkPYPuRccBkynA2uOlaobhJMxRVj/9vGPjpdsVC2Q6r
         6/PzkvzUi/o83NH3ninvfcWXr+DOFj3HitNm5U7GaqvN2HUS7MyAHlLxxsCgvEe2pREl
         zNlQ==
X-Gm-Message-State: AOAM531CC7ZYCVS8Agg8WyQFvyywlFAuzJZMgq/7406KzIX+0gEZpBjs
        LVlEv85BTswMD572/X3mJMMBXkGJK/brJ7d8tlgGKNwQm1l2zBw3J1deVjUVATsFzIqKoew6S5u
        Hc9n0ujCJCfXHe4u4yvqG0E9I
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr49749938eds.191.1600679313912;
        Mon, 21 Sep 2020 02:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQMwpVU6q7jmrxdGnqjACR03MWiJpQ5UuG7Wb+IYnEnF0x1N/HMomAc7DmL2N5piR0Nu43uA==
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr49749927eds.191.1600679313689;
        Mon, 21 Sep 2020 02:08:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k6sm8434681ejr.104.2020.09.21.02.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:08:33 -0700 (PDT)
Subject: Re: [PATCH v2] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200904142846.5356-1-divya_bharathi@dell.com>
 <aaf3b072-a109-4f69-67dd-bea3dc5fb023@redhat.com>
 <DM6PR19MB2636829402BC67EC1048E15FFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4d8f9ab8-ec5e-d8ec-65fe-afcd32f4e9d0@redhat.com>
Date:   Mon, 21 Sep 2020 11:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636829402BC67EC1048E15FFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 7:12 PM, Limonciello, Mario wrote:

<snip>

>>> +static int call_biosattributes_interface(struct wmi_device *wdev, char
>> *in_args, size_t size,
>>> +					int method_id)
>>> +{
>>> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
>>> +	struct acpi_buffer input;
>>> +	union acpi_object *obj;
>>> +	acpi_status status;
>>> +	int ret = -EIO;
>>> +
>>> +	input.length =  (acpi_size) size;
>>> +	input.pointer = in_args;
>>> +	status = wmidev_evaluate_method(wdev, 0, method_id, &input, &output);
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EIO;
>>> +	obj = (union acpi_object *)output.pointer;
>>> +	if (obj->type == ACPI_TYPE_INTEGER)
>>> +		ret = obj->integer.value;
>>> +
>>> +	kfree(output.pointer);
>>> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
>>
>> Why are you generating an uevent here? I think this needs a comment (or it
>> should be removed).
> 
> It's there so that userspace can know that a setting has been changed and doesn't
> need to poll the attribute indicating a reboot is pending.
> 
> We can certainly add a comment to this effect.

uevents are somewhat expensive they get processed by udevd, causing it
to evaluate all loaded udev rules and send out events to any userspace
processes listening for udev events.

The generic sysfs ABI allows polling using the poll() system-call
(so event driven) on sysfs attributes. IMHO it would be much better to
use this mechanism. Userspace can then poll() (watching for POLL_PRI)
on the pending_reboot sysfs attribute.

This could then be combined with a little helper for setting the
pending_changes bool, which checks if it is actually transitioning
from false to true and in that case does something like this:

kn = sysfs_get_dirent(..., "pending_reboot");
if (kn) {
	sysfs_notify_dirent(kn);
	sysfs_put(kn);
}

Note something like this really ought to be part of the sysfs ABI
documentation.


>>> +	return map_wmi_error(ret);
>>> +}
>>> +
>>> +/**
>>> + * set_attribute() - Update an attribute value
>>> + * @a_name: The attribute name
>>> + * @a_value: The attribute value
>>> + *
>>> + * Sets an attribute to new value
>>> + **/
>>> +int set_attribute(const char *a_name, const char *a_value)
>>> +{
>>> +	size_t security_area_size, string_area_size, buffer_size;
>>> +	char *attribute_name, *attribute_value;
>>> +	u8 *name_len, *value_len;
>>> +	char *buffer;
>>> +	int ret;
>>> +
>>> +	/* build/calculate buffer */
>>> +	security_area_size = calculate_security_buffer();
>>> +	string_area_size = (strlen(a_name) + strlen(a_value))*2;
>>> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
>>> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
>>> +	if (!buffer)
>>> +		return -ENOMEM;
>>> +
>>> +	/* build security area */
>>> +	if (strlen(wmi_priv.current_admin_password) > 0)
>>> +		populate_security_buffer(buffer, wmi_priv.current_admin_password);
>>> +
>>> +	/* build variables to set */
>>> +	name_len = buffer + security_area_size;
>>> +	attribute_name = name_len + sizeof(u16);
>>> +	*name_len = utf8s_to_utf16s(a_name, strlen(a_name), UTF16_HOST_ENDIAN,
>>> +				    (wchar_t *) attribute_name, MAX_BUFF) * 2;
>>> +	if (*name_len < 0) {
>>> +		ret = -EINVAL;
>>> +		pr_err("UTF16 conversion failed");
>>> +		goto out_set_attribute;
>>> +	}
>>> +
>>> +	value_len = (u8 *) attribute_name + *name_len;
>>> +	attribute_value = value_len + sizeof(u16);
>>> +	*value_len = utf8s_to_utf16s(a_value, strlen(a_value),
>> UTF16_HOST_ENDIAN,
>>> +				    (wchar_t *) attribute_value, MAX_BUFF) * 2;
>>> +	if (*value_len < 0) {
>>> +		ret = -EINVAL;
>>> +		pr_err("UTF16 conversion failed");
>>> +		goto out_set_attribute;
>>> +	}
>>> +
>>> +	mutex_lock(&call_mutex);
>>> +	if (!wmi_priv.bios_attr_wdev) {
>>> +		ret = -ENODEV;
>>> +		pr_err("no WMI backend bound");
>>> +		goto out_set_attribute;
>>> +	}
>>
>> It is probably better to move this to the top, as I mentioned in my reply
>> to Mario, you could add something like this to the top of each function,
>> even before allocating the buffer and filling it.
> 
> The placement was intentional to avoid taking the mutex until data was validated.
> Is it preferable to make it specifically on entry into functions then?

See below.

>>
>>       mutex_lock(&wmi_priv.mutex);
>>
>>       if (!wmi_priv.bios_attr_wdev || !wmi_priv.password_attr_wdev) {
>>           ret = -ENODEV;
>>           goto out_set_attribute;
>>       }
>>
>> Note this requires that you initialize the buf pointer to NULL
>> when declaring it.
>>
>> Having this at the top of each function establishes a pattern where
>> it easy for a reader of the code to:
>>
>> a) See that the check is present when checking that the driver being
>> unbound is checked everywhere
>>
>> b) Ignore the check as "boilerplate" when looking at other parts of
>> the code
> 
> I guess this argument makes sense - setting up a pattern is a good way
> to spot the function that stands out when a coding mistake occurs.

Right.

Regards,

Hans

