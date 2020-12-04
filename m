Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2C2CF0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgLDPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgLDPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:23:04 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C89C0613D1;
        Fri,  4 Dec 2020 07:22:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g25so4918052wmh.1;
        Fri, 04 Dec 2020 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2L4E4JEtOePK6yPQS0Wp/iPNaHfjX21E9yHOBlaREgI=;
        b=bYjT7SE18PsWAzANz5aR9lKwWkyIo4uWpi+0bVx7fe/+HDU8YIKCyPqRrM6majo9RH
         gNGcyp3teOLT5WazQUAHTCOxCyQcF/Vyk3BEGQsvW5/sNl5jJH8+nCLSX/THBDvBrtox
         WdP0z3aBeplOm7oscC6hEE6Ock7blLtqbPEj9gqyYrrHsjVeV2e0jiYnNHKF8mUtXQ0h
         uLprd7FNaFe3FM7ZGieBgAcbA1FtgdW1XzhTUHm7viQnw2ZEXKg9i8GOclip5zor5O81
         lW9Wj55zs74Wi648bWjYr9SPn0Bo0DDbjErjyi2KP7yixNRtJb/+jq2m6arjEaGw/nyN
         9KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2L4E4JEtOePK6yPQS0Wp/iPNaHfjX21E9yHOBlaREgI=;
        b=Q6TBqc+UL8BG9GnWbnI4P2sg4OCVGwoHidqpGKt6UR+x3vSPHx38+uyRN9RystTpaq
         4lPYPEwDkLgZ9Yiy7mS95gFjIi0K4hmiEsNc19SUNXFY1EUYhVfftF0O5pglBtjR9pFY
         bfzAnoSAqUzxZRnI8KhTGKvfmilZStRWpRml75707w3BTG62fkhoTn3XG98j/o9GJxr9
         dxxx0AXkn34Mq5RaQH/twpEIQ5VxYMv7uTW49iQWLoUnB1riD8PTdBH7z6gem61cfXye
         KtlcX/sfmKFsbJQkIA5pMVqiOV578sfANq4ZUXSshIly9iAVDZ2C/xIfnECxwUx79Y/R
         5iNw==
X-Gm-Message-State: AOAM533EBgAi8qKoezHAZfhff6pW+ohL4vbYCypozCN6GJdq8ZkP0sfm
        YQRoargFjXlxBetXBHoB7fA=
X-Google-Smtp-Source: ABdhPJwsOTPHrbwbor8/0xNE2TE1FP/kW3syTfxM2ifeeE9343cUjIHTiP56RdTapHVvsjJAahcN0A==
X-Received: by 2002:a1c:9e41:: with SMTP id h62mr4852541wme.51.1607095342063;
        Fri, 04 Dec 2020 07:22:22 -0800 (PST)
Received: from pce.localnet (host-79-13-10-171.retail.telecomitalia.it. [79.13.10.171])
        by smtp.gmail.com with ESMTPSA id k11sm3892364wrv.88.2020.12.04.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:22:21 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
To:     =?utf-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] intel-hid: add alternative method to enable switches
Date:   Fri, 04 Dec 2020 16:22:18 +0100
Message-ID: <2204197.ElGaqSPkdT@pce>
In-Reply-To: <u_tIRoW7nG4DQc7H_wcr9yn8oIc5rO9SsWKfOoJz4c9KKDJtUsYore_4tyNYxn3r0OpEOI5rsyrE__1Y2hbIc8lnS5cJKeeFmqyPdRjDVyU=@protonmail.com>
References: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com> <20201203212148.36039-1-eliadevito@gmail.com> <u_tIRoW7nG4DQc7H_wcr9yn8oIc5rO9SsWKfOoJz4c9KKDJtUsYore_4tyNYxn3r0OpEOI5rsyrE__1Y2hbIc8lnS5cJKeeFmqyPdRjDVyU=@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnab=C3=A1s

In data venerd=C3=AC 4 dicembre 2020 00:45:10 CET, Barnab=C3=A1s P=C5=91cze=
 ha scritto:
> Hi
>=20
> 2020. december 3., cs=C3=BCt=C3=B6rt=C3=B6k 22:21 keltez=C3=A9ssel, Elia =
Devito =C3=ADrta:
> > [...]
> > diff --git a/drivers/platform/x86/intel-hid.c
> > b/drivers/platform/x86/intel-hid.c index 86261970bd8f..fed24d4f28b8
> > 100644
> > --- a/drivers/platform/x86/intel-hid.c
> > +++ b/drivers/platform/x86/intel-hid.c
> > @@ -15,6 +15,9 @@
> >=20
> >  #include <linux/platform_device.h>
> >  #include <linux/suspend.h>
> >=20
> > +/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
> > +#define TABLET_MODE_FLAG 0x40
>=20
> I think `BIT(6)` would be better (linux/bits.h).
>=20
Okay,  I will change it

> > +
> >=20
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Alex Hung");
> >=20
> > @@ -89,9 +92,26 @@ static const struct dmi_system_id button_array_table=
[]
> > =3D {>=20
> >  	{ }
> > =20
> >  };
> >=20
> > [...]
> > +static void detect_tablet_mode(struct platform_device *device)
>=20
> I believe `report_tablet_mode_state()` or something similar would be a mo=
re
> apt name.
Sound good,  I will rename it.

> > +{
> > +	struct intel_hid_priv *priv =3D dev_get_drvdata(&device->dev);
> > +	acpi_handle handle =3D ACPI_HANDLE(&device->dev);
> > +	unsigned long long vgbs;
> > +	int m;
> > +
> > +	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN,=20
&vgbs))
> > +		return;
> > +
> > +	m =3D !(vgbs & TABLET_MODE_FLAG);
> > +	input_report_switch(priv->switches, SW_TABLET_MODE, m);
> > +	input_sync(priv->switches);
> > +}
> > +
> >=20
> >  static void notify_handler(acpi_handle handle, u32 event, void *contex=
t)
> >  {
> > =20
> >  	struct platform_device *device =3D context;
> >=20
> > @@ -363,6 +415,13 @@ static void notify_handler(acpi_handle handle, u32
> > event, void *context)>=20
> >  		if (event =3D=3D 0xce)
> >  	=09
> >  			goto wakeup;
> >=20
> > +		/*
> > +		 * Switch events will wake the device and report the=20
new switch
> > +		 * position to the input subsystem.
> > +		 */
> > +		if (priv->switches && (event =3D=3D 0xcc || event =3D=3D 0xcd))
> > +			goto wakeup;
> > +
> >=20
> >  		/* Wake up on 5-button array events only. */
> >  		if (event =3D=3D 0xc0 || !priv->array)
> >  	=09
> >  			return;
> >=20
> > @@ -374,6 +433,21 @@ static void notify_handler(acpi_handle handle, u32
> > event, void *context)>=20
> >  wakeup:
> >  		pm_wakeup_hard_event(&device->dev);
> >=20
> > +
> > +		if (priv->switches) {
> > +			if (event =3D=3D 0xcc) {
> > +				input_report_switch(priv-
>switches, SW_TABLET_MODE, 1);
> > +				input_sync(priv->switches);
> > +				return;
> > +			}
> > +
> > +			if (event =3D=3D 0xcd) {
> > +				input_report_switch(priv-
>switches, SW_TABLET_MODE, 0);
> > +				input_sync(priv->switches);
> > +				return;
> > +			}
> > +		}
> > +
> >=20
> >  		return;
> >  =09
> >  	}
> >=20
> > @@ -398,6 +472,20 @@ static void notify_handler(acpi_handle handle, u32
> > event, void *context)>=20
> >  		}
> >  =09
> >  	}
> >=20
> > +	if (priv->switches) {
> > +		if (event =3D=3D 0xcc) {
> > +			input_report_switch(priv->switches,=20
SW_TABLET_MODE, 1);
> > +			input_sync(priv->switches);
> > +			return;
> > +		}
> > +
> > +		if (event =3D=3D 0xcd) {
> > +			input_report_switch(priv->switches,=20
SW_TABLET_MODE, 0);
> > +			input_sync(priv->switches);
> > +			return;
> > +		}
> > +	}
>=20
> Wouldn't be better to create a new function `bool
> report_tablet_mode_event()` which would basically contain the above `if` =
or
> better, a `switch`, and then you could use it here and in the wake-up path
> like the following:
>=20
> ```
> if (report_tablet_mode_event(priv->switches, event))
>   return;
> ```
> (or similarly)
>=20
Looks more clean, I will do.

> > +
> >=20
> >  	/* 0xC0 is for HID events, other values are for 5 button array */
> >  	if (event !=3D 0xc0) {
> >  =09
> >  		if (!priv->array ||
> >=20
> > @@ -485,6 +573,16 @@ static int intel_hid_probe(struct platform_device
> > *device)>=20
> >  			pr_err("Failed to setup Intel 5 button array=20
hotkeys\n");
> >  =09
> >  	}
> >=20
> > +	/* Setup switches for devices that we know VGBS return correctly=20
*/
> > +	if (dmi_check_system(dmi_vgbs_allow_list)) {
> > +		dev_info(&device->dev, "platform supports switches\n");
> > +		err =3D intel_hid_switches_setup(device);
> > +		if (err)
> > +			pr_err("Failed to setup Intel HID=20
switches\n");
> > +		else
> > +			detect_tablet_mode(device);
> > +	}
> > +
> >=20
> >  	status =3D acpi_install_notify_handler(handle,
> >  =09
> >  					    =20
ACPI_DEVICE_NOTIFY,
> >  					     notify_handler,
> >=20
> > --
> > 2.28.0
>=20
> Regards,
> Barnab=C3=A1s P=C5=91cze

Thank you for the review

Regards
Elia



