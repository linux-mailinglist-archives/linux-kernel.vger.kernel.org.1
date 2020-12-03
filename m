Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346F12CE2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgLCXqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:46:47 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:42462 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgLCXqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:46:46 -0500
Date:   Thu, 03 Dec 2020 23:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1607039121;
        bh=qmuWDzOsFI/zkFO7+hg/4oeX2zrEQVi6H5VQzyMJoG0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sRhaay1oZxiA6Hz7SyAMn3K7K0g66+jksKGe7XLs1uD+DSFoyV3oMPY9HcYoqExJC
         ZIKW3HkKFLBRj1t5+5kFkh0pXuC8v2bzLd1nmjuwU3tgohUCk+WyfWUkSXMmWSXjy1
         SoE5j8sjkRf1WR4yCk/qhFdcdUQY3Vg5hliyolUA=
To:     Elia Devito <eliadevito@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 2/2] intel-hid: add alternative method to enable switches
Message-ID: <u_tIRoW7nG4DQc7H_wcr9yn8oIc5rO9SsWKfOoJz4c9KKDJtUsYore_4tyNYxn3r0OpEOI5rsyrE__1Y2hbIc8lnS5cJKeeFmqyPdRjDVyU=@protonmail.com>
In-Reply-To: <20201203212148.36039-1-eliadevito@gmail.com>
References: <69f340f6-4301-6546-f14a-47d90208d44b@redhat.com> <20201203212148.36039-1-eliadevito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2020. december 3., cs=C3=BCt=C3=B6rt=C3=B6k 22:21 keltez=C3=A9ssel, Elia De=
vito =C3=ADrta:

> [...]
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/inte=
l-hid.c
> index 86261970bd8f..fed24d4f28b8 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -15,6 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
>
> +/* When NOT in tablet mode, VGBS returns with the flag 0x40 */
> +#define TABLET_MODE_FLAG 0x40

I think `BIT(6)` would be better (linux/bits.h).


> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alex Hung");
>
> @@ -89,9 +92,26 @@ static const struct dmi_system_id button_array_table[]=
 =3D {
>  =09{ }
>  };
> [...]
> +static void detect_tablet_mode(struct platform_device *device)

I believe `report_tablet_mode_state()` or something similar would be a more=
 apt name.


> +{
> +=09struct intel_hid_priv *priv =3D dev_get_drvdata(&device->dev);
> +=09acpi_handle handle =3D ACPI_HANDLE(&device->dev);
> +=09unsigned long long vgbs;
> +=09int m;
> +
> +=09if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_VGBS_FN, &vgbs))
> +=09=09return;
> +
> +=09m =3D !(vgbs & TABLET_MODE_FLAG);
> +=09input_report_switch(priv->switches, SW_TABLET_MODE, m);
> +=09input_sync(priv->switches);
> +}
> +
>  static void notify_handler(acpi_handle handle, u32 event, void *context)
>  {
>  =09struct platform_device *device =3D context;
> @@ -363,6 +415,13 @@ static void notify_handler(acpi_handle handle, u32 e=
vent, void *context)
>  =09=09if (event =3D=3D 0xce)
>  =09=09=09goto wakeup;
>
> +=09=09/*
> +=09=09 * Switch events will wake the device and report the new switch
> +=09=09 * position to the input subsystem.
> +=09=09 */
> +=09=09if (priv->switches && (event =3D=3D 0xcc || event =3D=3D 0xcd))
> +=09=09=09goto wakeup;
> +
>  =09=09/* Wake up on 5-button array events only. */
>  =09=09if (event =3D=3D 0xc0 || !priv->array)
>  =09=09=09return;
> @@ -374,6 +433,21 @@ static void notify_handler(acpi_handle handle, u32 e=
vent, void *context)
>
>  wakeup:
>  =09=09pm_wakeup_hard_event(&device->dev);
> +
> +=09=09if (priv->switches) {
> +=09=09=09if (event =3D=3D 0xcc) {
> +=09=09=09=09input_report_switch(priv->switches, SW_TABLET_MODE, 1);
> +=09=09=09=09input_sync(priv->switches);
> +=09=09=09=09return;
> +=09=09=09}
> +
> +=09=09=09if (event =3D=3D 0xcd) {
> +=09=09=09=09input_report_switch(priv->switches, SW_TABLET_MODE, 0);
> +=09=09=09=09input_sync(priv->switches);
> +=09=09=09=09return;
> +=09=09=09}
> +=09=09}
> +
>  =09=09return;
>  =09}
>
> @@ -398,6 +472,20 @@ static void notify_handler(acpi_handle handle, u32 e=
vent, void *context)
>  =09=09}
>  =09}
>
> +=09if (priv->switches) {
> +=09=09if (event =3D=3D 0xcc) {
> +=09=09=09input_report_switch(priv->switches, SW_TABLET_MODE, 1);
> +=09=09=09input_sync(priv->switches);
> +=09=09=09return;
> +=09=09}
> +
> +=09=09if (event =3D=3D 0xcd) {
> +=09=09=09input_report_switch(priv->switches, SW_TABLET_MODE, 0);
> +=09=09=09input_sync(priv->switches);
> +=09=09=09return;
> +=09=09}
> +=09}

Wouldn't be better to create a new function `bool report_tablet_mode_event(=
)`
which would basically contain the above `if` or better, a `switch`, and the=
n
you could use it here and in the wake-up path like the following:

```
if (report_tablet_mode_event(priv->switches, event))
  return;
```
(or similarly)


> +
>  =09/* 0xC0 is for HID events, other values are for 5 button array */
>  =09if (event !=3D 0xc0) {
>  =09=09if (!priv->array ||
> @@ -485,6 +573,16 @@ static int intel_hid_probe(struct platform_device *d=
evice)
>  =09=09=09pr_err("Failed to setup Intel 5 button array hotkeys\n");
>  =09}
>
> +=09/* Setup switches for devices that we know VGBS return correctly */
> +=09if (dmi_check_system(dmi_vgbs_allow_list)) {
> +=09=09dev_info(&device->dev, "platform supports switches\n");
> +=09=09err =3D intel_hid_switches_setup(device);
> +=09=09if (err)
> +=09=09=09pr_err("Failed to setup Intel HID switches\n");
> +=09=09else
> +=09=09=09detect_tablet_mode(device);
> +=09}
> +
>  =09status =3D acpi_install_notify_handler(handle,
>  =09=09=09=09=09     ACPI_DEVICE_NOTIFY,
>  =09=09=09=09=09     notify_handler,
> --
> 2.28.0


Regards,
Barnab=C3=A1s P=C5=91cze
