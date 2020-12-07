Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54EE2D16D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLGQvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgLGQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607359786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F18kZUHIN/6D8y9hGrRPPu2lvrYaiB3si+HU6LdTgBM=;
        b=dnq9Iq5XaaBW83DnWeIUxwiT+TXVH5asBULnqbjYc244yakUF5+WPWfQD27qvajfWU9tYk
        jnZahLhSIusZbWerXRfbzyNL22wvVZ23zDFj6HG37Hn/euZPhYyoUKgZw6GKJtRZU1cYCA
        si+4v6YptU5DCInQng5tyv4vWxY8RQI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-zHt8ZWiEMPKg1wdQ5RQ-PA-1; Mon, 07 Dec 2020 11:49:45 -0500
X-MC-Unique: zHt8ZWiEMPKg1wdQ5RQ-PA-1
Received: by mail-ed1-f71.google.com with SMTP id u17so1259031edi.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F18kZUHIN/6D8y9hGrRPPu2lvrYaiB3si+HU6LdTgBM=;
        b=mOqrWEcknCCeJZBT3mHxmej+A5mVfJWa72fy2ax8f/agaSIRuctWfnOUblFlWHbNQg
         kFxklkRYaJ9pJF9SuW1PBqdsm1gnz94bcztvJQ9C/9kRxiPgcVmAWIavofVUzGfdT6vc
         fOdbVPI/d6kk4X3epe/qr50LDeaSJaVAv4uFs/SWu11cjlwuMQk68rE6whPooFn3fKin
         SO0thChUCyRgEttwF3u+XwmpzFm2l3nRYZCFYCG6E2LEIEduxVz4hJz1WYs5WCoJFLcY
         KVsXa5sBAQ7pgDNx1WCpuWzJ34XFblpdkRIr7dCKbZh7WliJIqhTL+djXgL0kOJ4Fd0m
         tkng==
X-Gm-Message-State: AOAM5332xQGpPLgSMrSkHdK6V9mzPJrOP64mq6pCTHxX3z3D86H1FskJ
        NJSdv0dHlNZGyhL63xBfEtxAWNXWEydcD57kTZBjAiXtqR1bl3IBINWH5T+iOam2xOYMrTtW2TX
        5PJ6BWp5KARedXx3eBlETEu8w/YpKLxYEChnoEFLBfrFisc27phNBSuINAw1VVnKHZ1tleu5Ndo
        hX
X-Received: by 2002:a17:906:af49:: with SMTP id ly9mr14444950ejb.38.1607359783696;
        Mon, 07 Dec 2020 08:49:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCchcipNe0d46G2C1oO6Xl83asvIKGdXgnI7IohzvMuTIzacZLiGcnNRW9Ri2fa6sCOMMPgQ==
X-Received: by 2002:a17:906:af49:: with SMTP id ly9mr14444930ejb.38.1607359783390;
        Mon, 07 Dec 2020 08:49:43 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u1sm14185378edf.65.2020.12.07.08.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 08:49:42 -0800 (PST)
Subject: Re: [PATCH v3 1/2] intel-hid: add support for SW_TABLET_MODE
To:     Elia Devito <eliadevito@gmail.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201203212000.35898-1-eliadevito@gmail.com>
 <20201204160121.36703-1-elia@xvalue.it>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a56f2ce-4971-5b33-1e96-414ebf4e06ec@redhat.com>
Date:   Mon, 7 Dec 2020 17:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204160121.36703-1-elia@xvalue.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/20 5:01 PM, Elia Devito wrote:
> From: Elia Devito <eliadevito@gmail.com>
> 
> Some convertible use the intel-hid ACPI interface to report SW_TABLET_MODE,
> implement this with DMI based allow-list to be sure to activate support
> only on models that effectively have it.
> 
> Signed-off-by: Elia Devito <eliadevito@gmail.com>

Thank you for your patch-series.

Note there is one special corner-case which you missed wrt the
dynamic creation of the device on receiving 0xcc/0xcd events
(so patch 2/2). I've prepared a follow-up patch fixing this,
which I will post right after sending this email. The commit
msg of that patch gives more details.

I've applied the series to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
> v2:
>  patch reworked according to received feedbacks
>   
> v3:
>  improved code according to received feedbacks
> 
>  drivers/platform/x86/intel-hid.c | 95 ++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index 86261970bd8f..d2f892665ec6 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -15,6 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
>  
> +/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
> +#define TABLET_MODE_FLAG BIT(6)
> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alex Hung");
>  
> @@ -89,9 +92,26 @@ static const struct dmi_system_id button_array_table[] = {
>  	{ }
>  };
>  
> +/*
> + * Some convertible use the intel-hid ACPI interface to report SW_TABLET_MODE,
> + * these need to be compared via a DMI based authorization list because some
> + * models have unreliable VGBS return which could cause incorrect
> + * SW_TABLET_MODE report.
> + */
> +static const struct dmi_system_id dmi_vgbs_allow_list[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x360 Convertible 15-df0xxx"),
> +		},
> +	},
> +	{ }
> +};
> +
>  struct intel_hid_priv {
>  	struct input_dev *input_dev;
>  	struct input_dev *array;
> +	struct input_dev *switches;
>  	bool wakeup_mode;
>  };
>  
> @@ -347,6 +367,57 @@ static int intel_button_array_input_setup(struct platform_device *device)
>  	return input_register_device(priv->array);
>  }
>  
> +static int intel_hid_switches_setup(struct platform_device *device)
> +{
> +	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
> +
> +	/* Setup input device for switches */
> +	priv->switches = devm_input_allocate_device(&device->dev);
> +	if (!priv->switches)
> +		return -ENOMEM;
> +
> +	__set_bit(EV_SW, priv->switches->evbit);
> +	__set_bit(SW_TABLET_MODE, priv->switches->swbit);
> +
> +	priv->switches->name = "Intel HID switches";
> +	priv->switches->id.bustype = BUS_HOST;
> +	return input_register_device(priv->switches);
> +}
> +
> +static void report_tablet_mode_state(struct platform_device *device)
> +{
> +	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
> +	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +	unsigned long long vgbs;
> +	int m;
> +
> +	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
> +		return;
> +
> +	m = !(vgbs & TABLET_MODE_FLAG);
> +	input_report_switch(priv->switches, SW_TABLET_MODE, m);
> +	input_sync(priv->switches);
> +}
> +
> +static bool report_tablet_mode_event(struct input_dev *input_dev, u32 event)
> +{
> +	if (!input_dev)
> +		return false;
> +
> +	switch (event) {
> +	case 0xcc:
> +		input_report_switch(input_dev, SW_TABLET_MODE, 1);
> +		input_sync(input_dev);
> +		return true;
> +	case 0xcd:
> +		input_report_switch(input_dev, SW_TABLET_MODE, 0);
> +		input_sync(input_dev);
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void notify_handler(acpi_handle handle, u32 event, void *context)
>  {
>  	struct platform_device *device = context;
> @@ -363,6 +434,13 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		if (event == 0xce)
>  			goto wakeup;
>  
> +		/*
> +		 * Switch events will wake the device and report the new switch
> +		 * position to the input subsystem.
> +		 */
> +		if (priv->switches && (event == 0xcc || event == 0xcd))
> +			goto wakeup;
> +
>  		/* Wake up on 5-button array events only. */
>  		if (event == 0xc0 || !priv->array)
>  			return;
> @@ -374,6 +452,10 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  
>  wakeup:
>  		pm_wakeup_hard_event(&device->dev);
> +
> +		if (report_tablet_mode_event(priv->switches, event))
> +			return;
> +
>  		return;
>  	}
>  
> @@ -398,6 +480,9 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		}
>  	}
>  
> +	if (report_tablet_mode_event(priv->switches, event))
> +		return;
> +
>  	/* 0xC0 is for HID events, other values are for 5 button array */
>  	if (event != 0xc0) {
>  		if (!priv->array ||
> @@ -485,6 +570,16 @@ static int intel_hid_probe(struct platform_device *device)
>  			pr_err("Failed to setup Intel 5 button array hotkeys\n");
>  	}
>  
> +	/* Setup switches for devices that we know VGBS return correctly */
> +	if (dmi_check_system(dmi_vgbs_allow_list)) {
> +		dev_info(&device->dev, "platform supports switches\n");
> +		err = intel_hid_switches_setup(device);
> +		if (err)
> +			pr_err("Failed to setup Intel HID switches\n");
> +		else
> +			report_tablet_mode_state(device);
> +	}
> +
>  	status = acpi_install_notify_handler(handle,
>  					     ACPI_DEVICE_NOTIFY,
>  					     notify_handler,
> 

