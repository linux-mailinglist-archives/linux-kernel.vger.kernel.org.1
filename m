Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A32916D3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJRJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgJRJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 05:56:47 -0400
X-Greylist: delayed 37384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Oct 2020 02:56:46 PDT
Received: from lithium.sammserver.com (lithium.sammserver.com [IPv6:2a01:4f8:c2c:b7df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3FC061755;
        Sun, 18 Oct 2020 02:56:46 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 51890312B5AC;
        Sun, 18 Oct 2020 11:56:45 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 109991123FBC; Sun, 18 Oct 2020 11:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603015005; bh=/Y8S0iNnABP3lTvPIoWQLs96TfGgH1L1OBxrFRTYpWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkGBiXUUC08SKSJhgmIn7ZZi5EtTsCCXxiB3xT8CJcjnzmk1fimdGGsOBxBx52ufu
         fDWYhtW944Ax283QSuS3BiHvqKrJHOjX9wSquKvQZO4oUXK4tmM3fR5p3+V+Dw1Mft
         czkzT3Bep1nRVoNzXyx3sDE4tP+EH/sUbG9yQqhQ=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 9D45A1123FB9;
        Sun, 18 Oct 2020 11:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1603015005; bh=/Y8S0iNnABP3lTvPIoWQLs96TfGgH1L1OBxrFRTYpWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkGBiXUUC08SKSJhgmIn7ZZi5EtTsCCXxiB3xT8CJcjnzmk1fimdGGsOBxBx52ufu
         fDWYhtW944Ax283QSuS3BiHvqKrJHOjX9wSquKvQZO4oUXK4tmM3fR5p3+V+Dw1Mft
         czkzT3Bep1nRVoNzXyx3sDE4tP+EH/sUbG9yQqhQ=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 8CE071420A90; Sun, 18 Oct 2020 11:56:44 +0200 (CEST)
Date:   Sun, 18 Oct 2020 11:56:44 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add support for
 SW_TABLET_MODE on UX360
Message-ID: <20201018095644.wmvgkoomwf7yh5dy@fastboi.localdomain>
References: <20200917133425.168310-1-samuel@cavoj.net>
 <20201017233339.v4th6wyej3a25ved@fastboi.localdomain>
 <be5ea0b1-1a29-609e-d1a1-933344653f76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be5ea0b1-1a29-609e-d1a1-933344653f76@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS autolearn=no autolearn_force=no
        version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on sammserver.tu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.10.2020 11:26, Hans de Goede wrote:
> Hi,
> 
> On 10/18/20 1:33 AM, Samuel Čavoj wrote:
> > Hello everyone.
> > 
> > On 17.09.2020 15:34, Samuel Čavoj wrote:
> >> The UX360CA has a WMI device id 0x00060062, which reports whether the
> >> lid is flipped in tablet mode (1) or in normal laptop mode (0).
> >>
> >> This commit adds a quirk (quirk_asus_use_lid_flip_devid) for devices on
> >> which this WMI device should be used to figure out the SW_TABLET_MODE
> >> state, as opposed to the quirk_asus_use_kbd_dock_devid.
> >>
> >> It is assumed other UX360* models have the same WMI device. As such, the
> >> quirk is applied to devices with DMI_MATCH(DMI_PRODUCT_NAME, "UX360").
> >> More devices with this feature need to be tested and added accordingly.
> >>
> >> The reason for using a whitelist via the quirk mechanism is that the new
> >> WMI device (0x00060062) is also present on some models which do not have
> >> a 360 degree hinge (at least FX503VD and GL503VD from Hans' DSTS
> >> collection) and therefore its presence cannot be relied on.
> >>
> >> This patch is a followup to "platform/x86: asus-wmi: Fix SW_TABLET_MODE
> >> always reporting 1 on many different models" by Hans de Goede.
> >>
> >> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> >> Cc: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>
> >> v1 -> v2:
> >>   - inherit wmi_backlight_set_devstate from default quirk
> > 
> > I have realised that one shortcoming still remains: If the laptop is
> > suspended while in tablet mode, flipped to normal mode during sleep and
> > then awoken, no event is generated by the firmware. The SW_TABLET_MODE
> > switch then stays enabled, with inputs not working until the user tries
> > flipping it once again.
> > 
> > I suppose a simple check on resume would suffice. However, I am not sure
> > if this is worth implementing as an update to this patch (i would like
> > it to make the 5.10 merge window after all) or as a separate patch, if
> > at all.
> 
> First, in case you did not know I've taken over PDx86 maintainership
> from Andy starting this merge-window.

Oh, I didn't catch that. I'm not really in the loop about things like
this. And I somehow missed the [GIT PULL] when I went searching the
lists for what the status is.

> I'm afraid that it is too late for 5.10 anyways as the merge window for
> that is already open and I already sent out the pull-req. I'm sorry
> that your patch did not make it, but even though I knew the handover

That's alright, it's not that important to me, I don't really use the
tablet mode at all. I'm glad your patch made it to 5.9 and -stable, as
that's what fixed the issue in this case.

> from Andy to me was coming I still ended up having not a whole lot
> of time to deal with the merge window, so some patches did not make it.
> 
> > Opinions?
> 
> Since this is not going to make 5.10 anyways it would be nice if
> you can post a new version which fixes the issue which you have
> found, so that we can get this supported (without the issue) in 5.11.
> As you point out yourself the correct thing to do here
> obviously is to re-check the state on resume.

Yeah, I will see what I can do.

Regards,
Sam

> 
> Regards,
> 
> Hans
> 
> 
> >> ---
> >>  drivers/platform/x86/asus-nb-wmi.c         | 15 +++++++++++++++
> >>  drivers/platform/x86/asus-wmi.c            | 22 ++++++++++++++++++++++
> >>  drivers/platform/x86/asus-wmi.h            |  1 +
> >>  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >>  4 files changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> >> index 345bd224494b..5019b03b2c95 100644
> >> --- a/drivers/platform/x86/asus-nb-wmi.c
> >> +++ b/drivers/platform/x86/asus-nb-wmi.c
> >> @@ -119,6 +119,11 @@ static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
> >>  	.use_kbd_dock_devid = true,
> >>  };
> >>  
> >> +static struct quirk_entry quirk_asus_use_lid_flip_devid = {
> >> +	.wmi_backlight_set_devstate = true,
> >> +	.use_lid_flip_devid = true,
> >> +};
> >> +
> >>  static int dmi_matched(const struct dmi_system_id *dmi)
> >>  {
> >>  	pr_info("Identified laptop model '%s'\n", dmi->ident);
> >> @@ -520,6 +525,16 @@ static const struct dmi_system_id asus_quirks[] = {
> >>  		},
> >>  		.driver_data = &quirk_asus_use_kbd_dock_devid,
> >>  	},
> >> +	{
> >> +		.callback = dmi_matched,
> >> +		.ident = "ASUS ZenBook Flip UX360",
> >> +		.matches = {
> >> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> >> +			/* Match UX360* */
> >> +			DMI_MATCH(DMI_PRODUCT_NAME, "UX360"),
> >> +		},
> >> +		.driver_data = &quirk_asus_use_lid_flip_devid,
> >> +	},
> >>  	{},
> >>  };
> >>  
> >> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> >> index ae6289d37faf..e5066248e83a 100644
> >> --- a/drivers/platform/x86/asus-wmi.c
> >> +++ b/drivers/platform/x86/asus-wmi.c
> >> @@ -63,6 +63,7 @@ MODULE_LICENSE("GPL");
> >>  #define NOTIFY_KBD_BRTTOGGLE		0xc7
> >>  #define NOTIFY_KBD_FBM			0x99
> >>  #define NOTIFY_KBD_TTP			0xae
> >> +#define NOTIFY_LID_FLIP			0xfa
> >>  
> >>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
> >>  
> >> @@ -375,6 +376,18 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
> >>  		}
> >>  	}
> >>  
> >> +	if (asus->driver->quirks->use_lid_flip_devid) {
> >> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> >> +		if (result >= 0) {
> >> +			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
> >> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> >> +		} else if (result == -ENODEV) {
> >> +			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
> >> +		} else {
> >> +			pr_err("Error checking for lid-flip: %d\n", result);
> >> +		}
> >> +	}
> >> +
> >>  	err = input_register_device(asus->inputdev);
> >>  	if (err)
> >>  		goto err_free_dev;
> >> @@ -2127,6 +2140,15 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
> >>  		return;
> >>  	}
> >>  
> >> +	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
> >> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
> >> +		if (result >= 0) {
> >> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
> >> +			input_sync(asus->inputdev);
> >> +		}
> >> +		return;
> >> +	}
> >> +
> >>  	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
> >>  		fan_boost_mode_switch_next(asus);
> >>  		return;
> >> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> >> index 1a95c172f94b..b302415bf1d9 100644
> >> --- a/drivers/platform/x86/asus-wmi.h
> >> +++ b/drivers/platform/x86/asus-wmi.h
> >> @@ -34,6 +34,7 @@ struct quirk_entry {
> >>  	bool wmi_backlight_set_devstate;
> >>  	bool wmi_force_als_set;
> >>  	bool use_kbd_dock_devid;
> >> +	bool use_lid_flip_devid;
> >>  	int wapf;
> >>  	/*
> >>  	 * For machines with AMD graphic chips, it will send out WMI event
> >> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> >> index 897b8332a39f..2f274cf52805 100644
> >> --- a/include/linux/platform_data/x86/asus-wmi.h
> >> +++ b/include/linux/platform_data/x86/asus-wmi.h
> >> @@ -62,6 +62,7 @@
> >>  
> >>  /* Misc */
> >>  #define ASUS_WMI_DEVID_CAMERA		0x00060013
> >> +#define ASUS_WMI_DEVID_LID_FLIP		0x00060062
> >>  
> >>  /* Storage */
> >>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> >> -- 
> >> 2.28.0
> >>
> > 
> 
