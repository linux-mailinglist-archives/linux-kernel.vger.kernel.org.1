Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7438326DCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgIQNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbgIQNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600349444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7xLs3AwQL9gchhGe8X/siGmJaN0xNdUwcRcgWxQGUI=;
        b=YqjnYnebWo94wyB7okSId4BlUDkUu88KLdxl941bHXqiFgc6aLDxIaTLT6/KGH20GjZA5h
        QfKgYrXJHXZC+TR4Nt3LHKgD/OCwutgj+jkHGnMBhlqBZKNjgTy3VqD50ZGlxhOWqCmbQW
        kaHnYXmbdM02THkAeSYtvB502aQiFX8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-jIvBTtNePfC04Rfhh4DmQg-1; Thu, 17 Sep 2020 09:22:34 -0400
X-MC-Unique: jIvBTtNePfC04Rfhh4DmQg-1
Received: by mail-ej1-f70.google.com with SMTP id ce9so872692ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7xLs3AwQL9gchhGe8X/siGmJaN0xNdUwcRcgWxQGUI=;
        b=otAVrEKI4J0o4KsAXWT3zTf/Vk9TFtwuO2IvAwa/PVwD+i59hJrmLDCNM+khaMTucT
         yI+6S7oK2aIlqUGScti5OdS0mqM6+I+nPv5fgSE8Jmbef5b5nVFQ6MRkoZxDiPStWG27
         d7OP+OSHN2DdpsSTopjBIzfDrP9oMlM8uXSLMaAjrLdVgtDw1mFw26dEhRShO91Yor78
         apILbMJRioNmpOgyQPr8PZ57C3NmkwBQUJLwCZaXCx271nz0B3jZNUx0iFD36JXAt4FB
         /Gaowh1VqbvBCyRewgczPfcCG48JlOZXX/aGGQAn+a0oozBP4INApDD9jp4wPX7EgbjF
         c9vQ==
X-Gm-Message-State: AOAM5305crNwIOTToHaz+RgD9okTQ7cPDkBiq/t6FBMW32m9TtioyTAO
        nxJ/oCqObt+TsQ8WW/Pwm6tfPPnLQlULL5IRVMz5/KKyf9MqBuEeWmbkxkNNzP3G9G/kzNPCQa2
        z1PvoQ0aIxxvWESuTsPtfDBXi
X-Received: by 2002:a50:fa88:: with SMTP id w8mr33406664edr.179.1600348952575;
        Thu, 17 Sep 2020 06:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEMqB2lHfbnitZed1lbMaK1fz4o+jzKfDsZ6MDA+DSJYjr9unZW9Jvzi5b7xc8WQ7Z2K+EmQ==
X-Received: by 2002:a50:fa88:: with SMTP id w8mr33406638edr.179.1600348952296;
        Thu, 17 Sep 2020 06:22:32 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id t4sm14922580ejj.6.2020.09.17.06.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:22:31 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-wmi: Add support for SW_TABLET_MODE on
 UX360
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200916191232.1020318-1-samuel@cavoj.net>
 <206d51c4-401d-e73b-b81a-fc57346a47ee@redhat.com>
 <20200917131232.2t4aos75lrwtdvky@fastboi.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3bef4851-fe20-1515-9051-790c20fd8e0f@redhat.com>
Date:   Thu, 17 Sep 2020 15:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917131232.2t4aos75lrwtdvky@fastboi.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/20 3:12 PM, Samuel Čavoj wrote:
> Hi.
> 
> On 17.09.2020 14:23, Hans de Goede wrote:
>> Hi,
>>
>> On 9/16/20 9:12 PM, Samuel Čavoj wrote:
>>> The UX360CA has a WMI device id 0x00060062, which reports whether the
>>> lid is flipped in tablet mode (1) or in normal laptop mode (0).
>>>
>>> This commit adds a quirk (quirk_asus_use_lid_flip_devid) for devices on
>>> which this WMI device should be used to figure out the SW_TABLET_MODE
>>> state, as opposed to the quirk_asus_use_kbd_dock_devid.
>>>
>>> It is assumed other UX360* models have the same WMI device. As such, the
>>> quirk is applied to devices with DMI_MATCH(DMI_PRODUCT_NAME, "UX360").
>>> More devices with this feature need to be tested and added accordingly.
>>>
>>> The reason for using a whitelist via the quirk mechanism is that the new
>>> WMI device (0x00060062) is also present on some models which do not have
>>> a 360 degree hinge (at least FX503VD and GL503VD from Hans' DSTS
>>> collection) and therefore its presence cannot be relied on.
>>>
>>> This patch is a followup to "platform/x86: asus-wmi: Fix SW_TABLET_MODE
>>> always reporting 1 on many different models" by Hans de Goede.
>>>
>>> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>    drivers/platform/x86/asus-nb-wmi.c         | 14 +++++++++++++
>>>    drivers/platform/x86/asus-wmi.c            | 23 ++++++++++++++++++++++
>>>    drivers/platform/x86/asus-wmi.h            |  1 +
>>>    include/linux/platform_data/x86/asus-wmi.h |  1 +
>>>    4 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>>> index 345bd224494b..ae5501e07712 100644
>>> --- a/drivers/platform/x86/asus-nb-wmi.c
>>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>>> @@ -119,6 +119,10 @@ static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>>>    	.use_kbd_dock_devid = true,
>>>    };
>>> +static struct quirk_entry quirk_asus_use_lid_flip_devid = {
>>> +	.use_lid_flip_devid = true,
>>
>>
>> Note the default (quirk_asus_unknown) quirks set:
>>
>>          .wmi_backlight_set_devstate = true,
>>
>> So you're changing that to false for all devices using that
>> quirk now.  I did not set this quirk for the transformer devices,
>> since the quirk has to do with the handling of Fn + F7 (display off hotkey)
>> by the embedded-controller. Since on transformer devices the keyboard is
>> an USB device and not handled by the embedded-controller they do not need
>> the wmi_backlight_set_devstate quirk, so I left it out. Chances are that
>> your UX360 does need it. The purpose of the quirk is to make the embbedded
>> controller send a KEY_DISPLAY_OFF event on FN + F7 and have it not do anything
>> else (like turning off the backlight by itself).
>>
>> TL;DR: you should probably add:         .wmi_backlight_set_devstate = true,
>> to your new quirk_asus_use_lid_flip_devid quirk.
>>
> 
> Of course. I didn't notice that. Thank you.
> 
> Should I send a v2 right away, or do I wait for other potential
> comments?

Normally waiting for some other comments would be good, but this is a
pretty straight-forward patch so I don't expect much other comments.

As such I think submitting a v2 right away is fine.

Regards,

Hans



>>> +};
>>> +
>>>    static int dmi_matched(const struct dmi_system_id *dmi)
>>>    {
>>>    	pr_info("Identified laptop model '%s'\n", dmi->ident);
>>> @@ -520,6 +524,16 @@ static const struct dmi_system_id asus_quirks[] = {
>>>    		},
>>>    		.driver_data = &quirk_asus_use_kbd_dock_devid,
>>>    	},
>>> +	{
>>> +		.callback = dmi_matched,
>>> +		.ident = "ASUS ZenBook Flip UX360",
>>> +		.matches = {
>>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>> +			/* Match UX360* */
>>> +			DMI_MATCH(DMI_PRODUCT_NAME, "UX360"),
>>> +		},
>>> +		.driver_data = &quirk_asus_use_lid_flip_devid,
>>> +	},
>>>    	{},
>>>    };
>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>> index ae6289d37faf..a628a7d9e066 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -63,6 +63,7 @@ MODULE_LICENSE("GPL");
>>>    #define NOTIFY_KBD_BRTTOGGLE		0xc7
>>>    #define NOTIFY_KBD_FBM			0x99
>>>    #define NOTIFY_KBD_TTP			0xae
>>> +#define NOTIFY_LID_FLIP			0xfa
>>>    #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>>> @@ -375,6 +376,18 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>>>    		}
>>>    	}
>>> +	if (asus->driver->quirks->use_lid_flip_devid) {
>>> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>>> +		if (result >= 0) {
>>> +			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>>> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>> +		} else if (result == -ENODEV) {
>>> +			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
>>> +		} else {
>>> +			pr_err("Error checking for lid-flip: %d\n", result);
>>> +		}
>>> +	}
>>> +
>>>    	err = input_register_device(asus->inputdev);
>>>    	if (err)
>>>    		goto err_free_dev;
>>> @@ -2127,6 +2140,16 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>>>    		return;
>>>    	}
>>> +	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
>>> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>>> +
>>> +		if (result >= 0) {
>>> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>> +			input_sync(asus->inputdev);
>>> +		}
>>> +		return;
>>> +	}
>>> +
>>>    	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>>>    		fan_boost_mode_switch_next(asus);
>>>    		return;
>>> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
>>> index 1a95c172f94b..b302415bf1d9 100644
>>> --- a/drivers/platform/x86/asus-wmi.h
>>> +++ b/drivers/platform/x86/asus-wmi.h
>>> @@ -34,6 +34,7 @@ struct quirk_entry {
>>>    	bool wmi_backlight_set_devstate;
>>>    	bool wmi_force_als_set;
>>>    	bool use_kbd_dock_devid;
>>> +	bool use_lid_flip_devid;
>>>    	int wapf;
>>>    	/*
>>>    	 * For machines with AMD graphic chips, it will send out WMI event
>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>> index 897b8332a39f..2f274cf52805 100644
>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>> @@ -62,6 +62,7 @@
>>>    /* Misc */
>>>    #define ASUS_WMI_DEVID_CAMERA		0x00060013
>>> +#define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>>>    /* Storage */
>>>    #define ASUS_WMI_DEVID_CARDREADER	0x00080013
>>>
>>
>> Otherwise the patch looks good to me, thank you for the patch.
>>
>> Regards,
>>
>> Hans
>>
> 

