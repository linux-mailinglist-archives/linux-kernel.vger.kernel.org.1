Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D42944FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438924AbgJTWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393479AbgJTWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:14:32 -0400
Received: from lithium.sammserver.com (lithium.sammserver.com [IPv6:2a01:4f8:c2c:b7df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5EC0613CE;
        Tue, 20 Oct 2020 15:14:32 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 41287312B5A9;
        Wed, 21 Oct 2020 00:14:31 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id EB5341131AAB; Wed, 21 Oct 2020 00:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603232070; bh=v/ZGegMCpfIqK9hc7W7g/y0ica5pe8op1LXwWpEESqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkDRnI/odaXlKa0WLtCJwF1IOLc6I5T8Cz8ftzEETXEoQ8Uv2WJEK/kKxsnrL3J7M
         b7a0IUfoXhH7w8869+yDJKGupbSeFh3V8SOxs2OM33NL3NA2uA6negTD3IHjjAbVOt
         cmDSIKbDMLMV74PD44IbqIRxiInViNnmK7fBJoYE=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 9C7421131AA8;
        Wed, 21 Oct 2020 00:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603232070; bh=v/ZGegMCpfIqK9hc7W7g/y0ica5pe8op1LXwWpEESqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkDRnI/odaXlKa0WLtCJwF1IOLc6I5T8Cz8ftzEETXEoQ8Uv2WJEK/kKxsnrL3J7M
         b7a0IUfoXhH7w8869+yDJKGupbSeFh3V8SOxs2OM33NL3NA2uA6negTD3IHjjAbVOt
         cmDSIKbDMLMV74PD44IbqIRxiInViNnmK7fBJoYE=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 83F5C14209CF; Wed, 21 Oct 2020 00:14:30 +0200 (CEST)
Date:   Wed, 21 Oct 2020 00:14:30 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Add support for
 SW_TABLET_MODE on UX360
Message-ID: <20201020221430.5hn33tax7nz42vgl@fastboi.localdomain>
References: <20201020220944.1075530-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020220944.1075530-1-samuel@cavoj.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS autolearn=no autolearn_force=no
        version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on sammserver.tu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.10.2020 00:09, Samuel Čavoj wrote:
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

I had the idea of doing this, not sure if it is actually a good idea
though. The idea is that it would prevent querying the device later
during runtime, if the first get_devstate fails. Also I assume doing a
input_report_switch without a corresponding input_set_capability is not
great either, this would prevent that, if for some reason the
get_devstate fails in the beginning but later fixes itself.

However, I can also imagine that writing to the quirks structure is
frowned upon, please tell if that is the case. Thanks.

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

Is the function name reasonable?

Regards, 
Sam

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
> -- 
> 2.29.0
> 
