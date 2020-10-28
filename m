Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8800729D488
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgJ1VxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728304AbgJ1VwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFd1xBVZBrcTEe86W6I6gztLEyeIsJNJYqp24bAEW6k=;
        b=F/t6YXzULA2eD6IEm1ktR9+GFzZWp4q38mjq1BoUEyzLpoA1DFVO+s+V2KAlRfpLVMroqt
        +I/CMIwzHOrYFq7q31Ezz0B1y95E2qUA3dVdYeeOTHeMazxIYz3h6K7wRI3idoRWrtyQo8
        TFNaXwFMZ5bb3YyP48LjNI1yn9xC6Y4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-ZenA1IJaPbuOu18RGym41w-1; Wed, 28 Oct 2020 07:50:25 -0400
X-MC-Unique: ZenA1IJaPbuOu18RGym41w-1
Received: by mail-ej1-f69.google.com with SMTP id lf18so2053969ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 04:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFd1xBVZBrcTEe86W6I6gztLEyeIsJNJYqp24bAEW6k=;
        b=ed6ckVT1+9r/G566sNm+HA4rZBduCOp7cj5o10FQfwx1aqSTDATCkCpGHl4688md0J
         Xkz/ho+V3QOdB0Ucs4oJBz96cZFOwPVzdc0UBCVlBWCWdb4IrWMoLTm1iXzlfzi9M+f1
         t0kXHl8eYRjpR4QmJVn67kn59nP7M/x2bienR4YVOMGj71dxk0nsiym03srMa3dGNR52
         XQisIGkcrkfg3w8psfQ6QPEp4uL75Xbr2k2lZ66ppC/G7MlH75dBFq/alyBADC8/m1zj
         XwBAHHSrMZhbChszhDE3vXJog+pbrNn7+yA4uVmEP/SpZYQYCUHvgazB/oJChEd6Aqd4
         99qQ==
X-Gm-Message-State: AOAM531y8kd+yqovEbr21jMA9VaBF43cG8/4raK/SeP33V96Phjj3sO+
        pLu548oQMmF++TFrdwYyzYj/1uqm4WC6lD8UG/oGEiVhFKgmn/1OHGfEKFxpVZVhy1ccAq34J4T
        bzB4ESPBH4shoZPzxF6X0Pk7J
X-Received: by 2002:aa7:c7d9:: with SMTP id o25mr7561861eds.318.1603885824159;
        Wed, 28 Oct 2020 04:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE7whzMkRyv+Vnp+A1vD5fJ7fZXNV8z25eWb/pOx9qm4Faa+WW7Qa7N7Z8UOUoTjjIbD/ieg==
X-Received: by 2002:aa7:c7d9:: with SMTP id o25mr7561832eds.318.1603885823831;
        Wed, 28 Oct 2020 04:50:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id m20sm1521102edq.16.2020.10.28.04.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 04:50:23 -0700 (PDT)
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Add support for SW_TABLET_MODE
 on UX360
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201020220944.1075530-1-samuel@cavoj.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <635f6034-9ad8-ca97-9a63-6557ecbd565e@redhat.com>
Date:   Wed, 28 Oct 2020 12:50:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020220944.1075530-1-samuel@cavoj.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/21/20 12:09 AM, Samuel Čavoj wrote:
> The UX360CA has a WMI device id 0x00060062, which reports whether the
> lid is flipped in tablet mode (1) or in normal laptop mode (0).
> 
> Add a quirk (quirk_asus_use_lid_flip_devid) for devices on which this
> WMI device should be used to figure out the SW_TABLET_MODE state, as
> opposed to the quirk_asus_use_kbd_dock_devid.
> 
> Additionally, the device needs to be queried on resume and restore
> because the firmware does not generate an event if the laptop is put to
> sleep while in tablet mode, flipped to normal mode, and later awoken.
> 
> It is assumed other UX360* models have the same WMI device. As such, the
> quirk is applied to devices with DMI_MATCH(DMI_PRODUCT_NAME, "UX360").
> More devices with this feature need to be tested and added accordingly.
> 
> The reason for using an allowlist via the quirk mechanism is that the new
> WMI device (0x00060062) is also present on some models which do not have
> a 360 degree hinge (at least FX503VD and GL503VD from Hans' DSTS
> collection) and therefore its presence cannot be relied on.
> 
> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

As discussed I've fixed the whitespace issue; and I've also fixed
the following 2 checkpatch warnings:

ERROR: open brace '{' following function definitions go on the next line
#114: FILE: drivers/platform/x86/asus-wmi.c:414:
+static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus) {

WARNING: Missing a blank line after declarations
#116: FILE: drivers/platform/x86/asus-wmi.c:416:
+	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
+	if (result >= 0) {

Next time please consider doing:

git format-patch HEAD~
scripts/checkpatch.pl 0001-*.patch

Before sending out your patch.

Note it will show up in my review-hans branch once I've pushed my local
branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> changed v2 -> v3:
>     - added check on resume from sleep and restore
> ---
>  drivers/platform/x86/asus-nb-wmi.c         | 15 +++++++++
>  drivers/platform/x86/asus-wmi.c            | 38 ++++++++++++++++++++++
>  drivers/platform/x86/asus-wmi.h            |  1 +
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  4 files changed, 55 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 1d9fbabd02fb..d41d7ad14be0 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -119,6 +119,11 @@ static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>  	.use_kbd_dock_devid = true,
>  };
>  
> +static struct quirk_entry quirk_asus_use_lid_flip_devid = {
> +	.wmi_backlight_set_devstate = true,
> +	.use_lid_flip_devid = true,
> +};
> +
>  static int dmi_matched(const struct dmi_system_id *dmi)
>  {
>  	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -520,6 +525,16 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_use_kbd_dock_devid,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ZenBook Flip UX360",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			/* Match UX360* */
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UX360"),
> +		},
> +		.driver_data = &quirk_asus_use_lid_flip_devid,
> +	},
>  	{},
>  };
>  
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 39e1a6396e08..864c608ad569 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -63,6 +63,7 @@ MODULE_LICENSE("GPL");
>  #define NOTIFY_KBD_BRTTOGGLE		0xc7
>  #define NOTIFY_KBD_FBM			0x99
>  #define NOTIFY_KBD_TTP			0xae
> +#define NOTIFY_LID_FLIP			0xfa
>  
>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>  
> @@ -375,6 +376,20 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>  		}
>  	}
>  
> +	if (asus->driver->quirks->use_lid_flip_devid) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +        if (result < 0)
> +			asus->driver->quirks->use_lid_flip_devid = 0;
> +		if (result >= 0) {
> +			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +		} else if (result == -ENODEV) {
> +			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
> +		} else {
> +			pr_err("Error checking for lid-flip: %d\n", result);
> +		}
> +	}
> +
>  	err = input_register_device(asus->inputdev);
>  	if (err)
>  		goto err_free_dev;
> @@ -394,6 +409,16 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
>  	asus->inputdev = NULL;
>  }
>  
> +/* Tablet mode ****************************************************************/
> +
> +static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus) {
> +	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +	if (result >= 0) {
> +		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +		input_sync(asus->inputdev);
> +	}
> +}
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -2128,6 +2153,11 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  		return;
>  	}
>  
> +	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> +		lid_flip_tablet_mode_get_state(asus);
> +		return;
> +	}
> +
>  	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>  		fan_boost_mode_switch_next(asus);
>  		return;
> @@ -2719,6 +2749,10 @@ static int asus_hotk_resume(struct device *device)
>  
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);
> +
> +	if (asus->driver->quirks->use_lid_flip_devid)
> +		lid_flip_tablet_mode_get_state(asus);
> +
>  	return 0;
>  }
>  
> @@ -2757,6 +2791,10 @@ static int asus_hotk_restore(struct device *device)
>  
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);
> +
> +	if (asus->driver->quirks->use_lid_flip_devid)
> +		lid_flip_tablet_mode_get_state(asus);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index 1a95c172f94b..b302415bf1d9 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -34,6 +34,7 @@ struct quirk_entry {
>  	bool wmi_backlight_set_devstate;
>  	bool wmi_force_als_set;
>  	bool use_kbd_dock_devid;
> +	bool use_lid_flip_devid;
>  	int wapf;
>  	/*
>  	 * For machines with AMD graphic chips, it will send out WMI event
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 897b8332a39f..2f274cf52805 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -62,6 +62,7 @@
>  
>  /* Misc */
>  #define ASUS_WMI_DEVID_CAMERA		0x00060013
> +#define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 

