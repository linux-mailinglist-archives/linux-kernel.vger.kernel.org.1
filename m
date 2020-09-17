Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1248026DD29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIQNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgIQNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600350610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Pl6kBxyoMwzDaq0S/ivfq9aCIP2AtYV9CxpcUHjvws=;
        b=cXfhSaVBxrRV3TbffSxUDZnSR0tY9pTrGYwjTslBjbl22+JZrmlKwS4JTU/tafVoJGuM6m
        KqAp5MJd98KyoQOjAmUVBa6NRzx3thoEcN/PU/wBZRESiQ0dmEMrJTRi9mhi2QMpy2AtHu
        Av0QswqJaBC21hS1cZxCbt18sNYH9ug=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-dl3dVB7xPpGMoV8EkKHWzQ-1; Thu, 17 Sep 2020 09:42:02 -0400
X-MC-Unique: dl3dVB7xPpGMoV8EkKHWzQ-1
Received: by mail-ed1-f71.google.com with SMTP id n19so919100eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Pl6kBxyoMwzDaq0S/ivfq9aCIP2AtYV9CxpcUHjvws=;
        b=Th0D47ai8sgpI6hliJYaH5H0niOYuJl4mj7peW2vlNgQnwkEViWai/6anXVM/DyIEa
         +Xr/e/9DCWxsQcWfSOgjd/Wx1E2g/TkeR/yzjWUdrspjEcHj1bYdxnJyvCU7PApBprjH
         pPkvcTeVGk5maCGyH3LHEpTUWe7EZMWz4yiuPdHMbjq55lf3VgT6PlXrhTN8bawCTvkR
         lgswtrzm4u7grMsC3VeR0WzxkCYzFXkpsChMv7YNL04CWqWOBs7au07CkVO9QExzH0BN
         zMVDtpYk15vuYMtzzAYNDnc28R2B4nCxCHZoQbddc1m6kTxiP2Wacx9RdJ/wpYyEeCcv
         h5oA==
X-Gm-Message-State: AOAM530ZvERLqFp31tPEZFsTCgveXQK7+Ok4kGpXRkKRm8FDzPtiZM2A
        6hx5avfo5dRRhBjodqc3McxsTJlomaQvdpGDg3e+JR3CstOHiTf4ELPX8ylC/14NSydTVQQt1Cq
        pkM7DVq3NpfkpNQepokFeawm3
X-Received: by 2002:aa7:d747:: with SMTP id a7mr32008580eds.304.1600350121066;
        Thu, 17 Sep 2020 06:42:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6jZA9VBVyOJ5XFNPFrh8J7tTcIY2YVfxCUPLoEL+DwDpwId6k7p7gyppotJrZLuviXC1aPw==
X-Received: by 2002:aa7:d747:: with SMTP id a7mr32008560eds.304.1600350120833;
        Thu, 17 Sep 2020 06:42:00 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id mb16sm14976727ejb.45.2020.09.17.06.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:42:00 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add support for SW_TABLET_MODE
 on UX360
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200917133425.168310-1-samuel@cavoj.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <285534ba-117a-d0a6-d4ae-34d29245d409@redhat.com>
Date:   Thu, 17 Sep 2020 15:41:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917133425.168310-1-samuel@cavoj.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/20 3:34 PM, Samuel Čavoj wrote:
> The UX360CA has a WMI device id 0x00060062, which reports whether the
> lid is flipped in tablet mode (1) or in normal laptop mode (0).
> 
> This commit adds a quirk (quirk_asus_use_lid_flip_devid) for devices on
> which this WMI device should be used to figure out the SW_TABLET_MODE
> state, as opposed to the quirk_asus_use_kbd_dock_devid.
> 
> It is assumed other UX360* models have the same WMI device. As such, the
> quirk is applied to devices with DMI_MATCH(DMI_PRODUCT_NAME, "UX360").
> More devices with this feature need to be tested and added accordingly.
> 
> The reason for using a whitelist via the quirk mechanism is that the new
> WMI device (0x00060062) is also present on some models which do not have
> a 360 degree hinge (at least FX503VD and GL503VD from Hans' DSTS
> collection) and therefore its presence cannot be relied on.
> 
> This patch is a followup to "platform/x86: asus-wmi: Fix SW_TABLET_MODE
> always reporting 1 on many different models" by Hans de Goede.
> 
> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> v1 -> v2:
>    - inherit wmi_backlight_set_devstate from default quirk

v2 looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> ---
>   drivers/platform/x86/asus-nb-wmi.c         | 15 +++++++++++++++
>   drivers/platform/x86/asus-wmi.c            | 22 ++++++++++++++++++++++
>   drivers/platform/x86/asus-wmi.h            |  1 +
>   include/linux/platform_data/x86/asus-wmi.h |  1 +
>   4 files changed, 39 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 345bd224494b..5019b03b2c95 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -119,6 +119,11 @@ static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>   	.use_kbd_dock_devid = true,
>   };
>   
> +static struct quirk_entry quirk_asus_use_lid_flip_devid = {
> +	.wmi_backlight_set_devstate = true,
> +	.use_lid_flip_devid = true,
> +};
> +
>   static int dmi_matched(const struct dmi_system_id *dmi)
>   {
>   	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -520,6 +525,16 @@ static const struct dmi_system_id asus_quirks[] = {
>   		},
>   		.driver_data = &quirk_asus_use_kbd_dock_devid,
>   	},
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
>   	{},
>   };
>   
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ae6289d37faf..e5066248e83a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -63,6 +63,7 @@ MODULE_LICENSE("GPL");
>   #define NOTIFY_KBD_BRTTOGGLE		0xc7
>   #define NOTIFY_KBD_FBM			0x99
>   #define NOTIFY_KBD_TTP			0xae
> +#define NOTIFY_LID_FLIP			0xfa
>   
>   #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>   
> @@ -375,6 +376,18 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>   		}
>   	}
>   
> +	if (asus->driver->quirks->use_lid_flip_devid) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
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
>   	err = input_register_device(asus->inputdev);
>   	if (err)
>   		goto err_free_dev;
> @@ -2127,6 +2140,15 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>   		return;
>   	}
>   
> +	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +		if (result >= 0) {
> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +			input_sync(asus->inputdev);
> +		}
> +		return;
> +	}
> +
>   	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>   		fan_boost_mode_switch_next(asus);
>   		return;
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index 1a95c172f94b..b302415bf1d9 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -34,6 +34,7 @@ struct quirk_entry {
>   	bool wmi_backlight_set_devstate;
>   	bool wmi_force_als_set;
>   	bool use_kbd_dock_devid;
> +	bool use_lid_flip_devid;
>   	int wapf;
>   	/*
>   	 * For machines with AMD graphic chips, it will send out WMI event
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 897b8332a39f..2f274cf52805 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -62,6 +62,7 @@
>   
>   /* Misc */
>   #define ASUS_WMI_DEVID_CAMERA		0x00060013
> +#define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>   
>   /* Storage */
>   #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 

