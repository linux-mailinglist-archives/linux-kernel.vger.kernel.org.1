Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28626D9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIQLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgIQLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:11:52 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:11:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600341061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYEGJhzeoqDcgOjK7MIlvVJV5vz2e5dMbqaD+VDMfm0=;
        b=LChsvQtsurpocEKNQB2Mi0N1gRvWT0K+w7EtFSitqsWTkn8KpHRbo85g8yaGdHNkZcUObA
        x1PcgOOXBO9G6sX8mayVRQ1gILkDJuBo1Fn8jE23xvQIFJJZ9bQmg8WenLfaxKonMovhV2
        hRN9x7YThoJK0p34q6w/Xnk47vIcZHs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-nd9XSoDKP72ODy_eeaRqsg-1; Thu, 17 Sep 2020 07:03:25 -0400
X-MC-Unique: nd9XSoDKP72ODy_eeaRqsg-1
Received: by mail-ed1-f70.google.com with SMTP id d27so739787edj.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYEGJhzeoqDcgOjK7MIlvVJV5vz2e5dMbqaD+VDMfm0=;
        b=ttwvQCLhKzhUZjh2xeORlLU5h3XPMqcHXuF3D0t6/YWcRJgxOqE96Ja3JP6AuuBkQs
         4QbKa7xfmp7tqXcMdMIbXnqznpntGFyb9g/pgLcOhxYEzWLuiBBrgmdgDika7bqB2Dj2
         uasK/VlIqhRfEsD2KpHmiZXjJ8G7FtkYsJVLMOE+YZi/fhMC+RyiOatUYVj3JGTz1BmZ
         FL13OqbZ3XM84KtdMXSAGMDPbRisVElxWB513+6lpUWNCJzSTqyMiFEhKY3r5A4DMZ0V
         WSdVKNNVKQiHCnN/28Xm/yIRRgVW9wU42yOhRAEEdOeFx4KQaSnEJBUWcXwDAVd+LMxf
         PMAg==
X-Gm-Message-State: AOAM530Q5cZN3TV1p9Y8b9qJe+3CkoYUl/shaPBwwQ2XX+emToORbIPk
        hokOvOo6dhP4wl0GhBrDRUbaMJyOCFqOO0zMApPAW+f/CkvUEumuR8KWNEdc7+4bAe/7OIIthKI
        knHH+mqRD/gwTFRofs7wphntX
X-Received: by 2002:a17:906:f150:: with SMTP id gw16mr28576285ejb.528.1600340603836;
        Thu, 17 Sep 2020 04:03:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJlAz9qSJ0pbsd/pSrMQTAcclkfIvPi7Tvj4g1N6WP8g5FRAt/PwKTXQGSBILyExKL+qLlOw==
X-Received: by 2002:a17:906:f150:: with SMTP id gw16mr28576261ejb.528.1600340603528;
        Thu, 17 Sep 2020 04:03:23 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id b6sm16369626eds.46.2020.09.17.04.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 04:03:22 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: hp-wmi: add support for thermal policy
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200914170252.41125-1-eliadevito@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <af8ccfbf-8a6f-8667-aee6-d196e8e7c845@redhat.com>
Date:   Thu, 17 Sep 2020 13:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914170252.41125-1-eliadevito@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 7:02 PM, Elia Devito wrote:
> HP Spectre notebooks (and probabily other model as well)
> support at least 3 thermal policy:
>   - Default
>   - Performance
>   - Cool
> 
> the correct thermal policy configuration make the firmware to correctly
> set OEM variables for Intel DPTF and optimize fan management to reach
> the best performance.

You mention DPTF, have you tested this patch together with Matthew Garret's
modified thermald which supports dynamic DPTF profiles ? :

https://mjg59.dreamwidth.org/54923.html

And if you have, have you alsoe tested it without this ?


> 
> Signed-off-by: Elia Devito <eliadevito@gmail.com>
> ---
>   drivers/platform/x86/hp-wmi.c | 80 +++++++++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 1762f335bac9..14ee176f5588 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -81,6 +81,7 @@ enum hp_wmi_commandtype {
>   	HPWMI_FEATURE2_QUERY		= 0x0d,
>   	HPWMI_WIRELESS2_QUERY		= 0x1b,
>   	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
> +	HPWMI_THERMAL_POLICY_QUERY	= 0x4c
>   };
>   
>   enum hp_wmi_command {
> @@ -114,6 +115,12 @@ enum hp_wireless2_bits {
>   	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>   };
>   
> +enum hp_thermal_policy {
> +	HP_THERMAL_POLICY_PERFORMANCE	= 0x00,
> +	HP_THERMAL_POLICY_DEFAULT		= 0x01,
> +	HP_THERMAL_POLICY_COOL			= 0x02
> +};
> +
>   #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
>   #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
>   
> @@ -458,6 +465,28 @@ static ssize_t postcode_show(struct device *dev, struct device_attribute *attr,
>   	return sprintf(buf, "0x%x\n", value);
>   }
>   
> +static ssize_t thermal_policy_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	int value;
> +
> +	/* Get the current thermal policy */
> +	value = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
> +	if (value < 0)
> +		return value;
> +
> +	switch (value) {
> +	case HP_THERMAL_POLICY_PERFORMANCE:
> +		return sprintf(buf, "Performance (%x)\n", value);
> +	case HP_THERMAL_POLICY_DEFAULT:
> +		return sprintf(buf, "Default (%x)\n", value);
> +	case HP_THERMAL_POLICY_COOL:
> +		return sprintf(buf, "Cool (%x)\n", value);
> +	default:
> +		return sprintf(buf, "Unknown (%x)\n", value);
> +	}
> +}
> +

So your showing it as a string here.


>   static ssize_t als_store(struct device *dev, struct device_attribute *attr,
>   			 const char *buf, size_t count)
>   {
> @@ -499,12 +528,35 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>   	return count;
>   }
>   
> +static ssize_t thermal_policy_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	u32 tmp;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &tmp);
> +	if (ret)
> +		return ret;


But then taking an integer value here. That is not really a good userspace interface IMHO.

What you can do is put the strings in an array of strings and then loop
over the array in show, adding [] around the selected option, so that
showing it will e.g. output:

Performance [Default] Cool

or:

[Performance] Default Cool

(and in the unknown case none of the 3 would have [] around it)

And then in the store callback also loop over the array,
comparing the user provided string with the 3 strings and
then selecting the value based on that; or return -EINVAL
if non of the strings match. Note I'm open to other
suggestions, but this is more or less how we usually deal with
exporting enums in sysfs now a days.

Note please use sysfs_match_string for the store function,
this will do things like ignoring the '\n' which echo
adds for you without needing to code all this out.



> +
> +	if (tmp < HP_THERMAL_POLICY_PERFORMANCE || tmp > HP_THERMAL_POLICY_COOL)
> +		return -EINVAL;
> +
> +	/* Set thermal policy */
> +	ret = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tmp,
> +				       sizeof(tmp), sizeof(tmp));
> +	if (ret)
> +		return ret < 0 ? ret : -EINVAL;
> +
> +	return count;
> +}
> +
>   static DEVICE_ATTR_RO(display);
>   static DEVICE_ATTR_RO(hddtemp);
>   static DEVICE_ATTR_RW(als);
>   static DEVICE_ATTR_RO(dock);
>   static DEVICE_ATTR_RO(tablet);
>   static DEVICE_ATTR_RW(postcode);
> +static DEVICE_ATTR_RW(thermal_policy);
>   
>   static struct attribute *hp_wmi_attrs[] = {
>   	&dev_attr_display.attr,
> @@ -861,6 +913,30 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
>   	return err;
>   }
>   
> +static int thermal_policy_setup(struct platform_device *device)
> +{
> +	int err, tp;
> +
> +	tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
> +	if (tp < 0)
> +		return tp;
> +
> +	/*
> +	 * set thermal policy to ensure that the firmware correctly
> +	 * sets the OEM variables for the DPTF
> +	 */
> +	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
> +							   sizeof(tp), 0);
> +	if (err)
> +		return err;
> +
> +	err = device_create_file(&device->dev, &dev_attr_thermal_policy);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>   static int __init hp_wmi_bios_setup(struct platform_device *device)
>   {
>   	/* clear detected rfkill devices */
> @@ -872,6 +948,8 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>   	if (hp_wmi_rfkill_setup(device))
>   		hp_wmi_rfkill2_setup(device);
>   
> +	thermal_policy_setup(device);
> +
>   	return 0;
>   }
>   
> @@ -879,6 +957,8 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
>   {
>   	int i;
>   
> +	device_remove_file(&device->dev, &dev_attr_thermal_policy);
> +
>   	for (i = 0; i < rfkill2_count; i++) {
>   		rfkill_unregister(rfkill2[i].rfkill);
>   		rfkill_destroy(rfkill2[i].rfkill);
> 

Otherwise this looks good to me.

Regsrds,

Hans

