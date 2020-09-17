Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18DF26E7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:56:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:49328 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:56:12 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 17:56:11 EDT
IronPort-SDR: WwPScWonaLgKGmxM9gRW/cN61jTv6L1rjtUE5nO4Sz3Bc4Q3ak4AiuJq4GUD95VRfG/a6Z/TKM
 p2NnRJQlk7gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244632725"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="244632725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:56:11 -0700
IronPort-SDR: Co/zZH+cQfIwRGb94dd423vvuTV87AYeydUAiFIQKGLAScVVdv9QoZJwVWSlKxlOq5/azjUMbM
 CoTVXNYPBj+Q==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="287740829"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:56:10 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id C431A6369;
        Thu, 17 Sep 2020 14:56:06 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:56:06 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add support for SW_TABLET_MODE
 on UX360
Message-ID: <20200917215606.GF29136@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200916191232.1020318-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916191232.1020318-1-samuel@cavoj.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:12:33PM +0200, Samuel Čavoj wrote:
> The UX360CA has a WMI device id 0x00060062, which reports whether the
> lid is flipped in tablet mode (1) or in normal laptop mode (0).
> 
> This commit adds a quirk (quirk_asus_use_lid_flip_devid) for devices on
> which this WMI device should be used to figure out the SW_TABLET_MODE
> state, as opposed to the quirk_asus_use_kbd_dock_devid.
see Documentation/process/submitting-patches.rst
section2  the bit about "imperative mood".

--mark
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
>  drivers/platform/x86/asus-nb-wmi.c         | 14 +++++++++++++
>  drivers/platform/x86/asus-wmi.c            | 23 ++++++++++++++++++++++
>  drivers/platform/x86/asus-wmi.h            |  1 +
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  4 files changed, 39 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 345bd224494b..ae5501e07712 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -119,6 +119,10 @@ static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
>  	.use_kbd_dock_devid = true,
>  };
>  
> +static struct quirk_entry quirk_asus_use_lid_flip_devid = {
> +	.use_lid_flip_devid = true,
> +};
> +
>  static int dmi_matched(const struct dmi_system_id *dmi)
>  {
>  	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -520,6 +524,16 @@ static const struct dmi_system_id asus_quirks[] = {
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
> index ae6289d37faf..a628a7d9e066 100644
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
> @@ -375,6 +376,18 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>  		}
>  	}
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
>  	err = input_register_device(asus->inputdev);
>  	if (err)
>  		goto err_free_dev;
> @@ -2127,6 +2140,16 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  		return;
>  	}
>  
> +	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> +
> +		if (result >= 0) {
> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> +			input_sync(asus->inputdev);
> +		}
> +		return;
> +	}
> +
>  	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
>  		fan_boost_mode_switch_next(asus);
>  		return;
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
> 2.28.0
> 
