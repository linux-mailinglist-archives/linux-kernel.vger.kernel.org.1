Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770BC2C7147
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391299AbgK1Vzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387691AbgK1UW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:22:58 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4BC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:22:18 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id a19so7636280ilm.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2lRh+IOaq0DXmCLmFuJNZmSPxG3tfxDU4bnGVc5t20=;
        b=XSr5+wGZbRyWdaBTfGlXKMRdIFI/AcCdsiJ2CvRnLyQdD1ODRLOIFK061B/dqZKzCK
         WjDPOpzPkAf1WQeYW3TEf/1RJHZ0p4sdrPilWtX5rR4/Y0gEK+mKj34dCsQDJbBkCUD9
         Wri5Wo6n/Xf09ZbE0ZqluQGMIFOuxo09z+R16TqiLVwm5fQ+v79IS9CEnSKnCzG7SkqA
         OyZ9x6LOk28f+Kt7WpU+o/+qW6hd8iPFlwCXL9W2/oyw9wLLmjgxIx3uXNUu9t46Is0h
         hebCtOwSTtl+Q2rKSmD4vQ6QeeOdBeDLuEZz0rnmuqS7DfN8MaVetqrb6De2jZ8NPNXX
         hNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2lRh+IOaq0DXmCLmFuJNZmSPxG3tfxDU4bnGVc5t20=;
        b=asRCcI/LjEGxA7DILJnrWLN/jjgKwSfTGa2p4/93Lr9zR+Bx7hz3ZZveyy3snH2Qwd
         IhsuvSpjfKrvTMjkg1445/BrBhhHALn6objuiYAaixPbthPMR0oPY6ctjkZIyCoaj+B5
         gV/HjZzufmgezwmyo5UfJV8UF1MZPgAZ/YnFYDa/i0TJ+wiomu8YABsSKqU6yuyoLtbz
         Fv2w7SX/OKd75c97zDmM35QxOnP475NfKGQt8msTZQEl2xjO5Ht2VDLbrKW1r8ymfzG9
         +YagRfBuEN+Dzo5jX9IN2oqiW9Gup7ytS/uasLiY9tHnU9LYvVeolDyLO7cLCrEJEsWK
         yzXA==
X-Gm-Message-State: AOAM533rdjItPZ1PFEqHxtfy+Vh3niVTiaMqkvCyx2IQDcRim5oYVe+/
        pLAq4xd2Ty0RqeUJJC33vcfP+2rzWsV+vZ/Sfvsepw==
X-Google-Smtp-Source: ABdhPJxNtK5osVl9FXuwwZCMgM82qN89mycGZTsV2BU/cvmQyfwnAF1QEcqdtn8JWZTk4TMCHzs3RqMI/VlrSpGVMgE=
X-Received: by 2002:a92:c052:: with SMTP id o18mr11908639ilf.245.1606594937356;
 Sat, 28 Nov 2020 12:22:17 -0800 (PST)
MIME-Version: 1.0
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local> <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
 <20201128113524.24f4f56f@monster.powergraphx.local>
In-Reply-To: <20201128113524.24f4f56f@monster.powergraphx.local>
From:   Jonas Malaco <jonas@protocubo.io>
Date:   Sat, 28 Nov 2020 17:21:40 -0300
Message-ID: <CANS_-EPK75zrVRtBKxO-00RZD-XWrixJD8DH1_d=80rbazXQng@mail.gmail.com>
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 7:35 AM Wilken Gottwalt
<wilken.gottwalt@posteo.net> wrote:
>
> On Sat, 28 Nov 2020 02:37:38 -0300
> Jonas Malaco <jonas@protocubo.io> wrote:
>
> > On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
> > <wilken.gottwalt@posteo.net> wrote:
> > >
> > > Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
> > > AX1500i and AX1600i. The first 3 power supplies are supported through
> > > the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> > > converter especially made for the COM ports of these power supplies.
> > > There are 3 known revisions of these adapters. The AX1500i power supply
> > > has revision 3 built into the case and AX1600i is the only one in that
> > > series, which has an unique usb hid id like the RM/RX series.
> >
> > Can I ask what AXi power supplies were tested?
> >
> > I ask because, based on the user-space implementations I am aware of,
> > the AXi dongle protocol appears to be different from the RMi/HXi series.
>
> I was not able to test this against the AX power supplies, they are really
> hard to find (and are far to expensive). But I went through all these tools
> and stuck to the most common commands, which all 3 series support. Not every
> series supports all commands (there also seem to be different firmwares in
> the micro-conrollers). But this is fine, some sensors will show up as N/A.
> Even my HX850i does not support all commands covered in this driver.

I think the similarities come from all using wrappers over the PMBus
interface to the voltage controller.  But I am not sure the wrapping
protocols are identical.

For example, cpsumon shows significantly more things going on during a
read than what is needed for the RMi/HXi series.[1]

[1] https://github.com/ka87/cpsumon/blob/fd639684d7f9/libcpsumon/src/cpsumon.c#L213-L231


>
> > AXi dongle:
> >  - https://github.com/ka87/cpsumon
>
> This tool made me to consider including the AX series, because it uses some
> of the same commands on the AX760i, AX860i, AX1200i and AX1500i. But it is
> a usb-serial tool only. But it was nice to know, that the commands are mostly
> the same. I left out all the commands for configuring, PCIe power rails,
> efficiency and others which do not really belong into hwmon.
>
> > RMi/HXi:
> >  - https://github.com/jonasmalacofilho/liquidctl
> >  - https://github.com/audiohacked/OpenCorsairLink
>
> This tool made me include the AX series, because it uses the rmi protocol
> component for the rmi driver (RM/HX series) and the corsair dongles.

The corsairlink_driver_dongle has no implementations for reading sensor
data (compare that with the corsairlink_driver_rmi).[2][3]  There is
also no code that actually tries to read (write) from (to) the device
using that dongle driver.[4]

I also looked at a few of the issues, and all of the ones I read
mentioned AXi support being under development, and the hypothesis of the
AXi series being compatible with the RMi/HXi code still remaining to be
confirmed.

[2] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/drivers/dongle.c#L33-L39
[3] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/drivers/rmi.c#L33-L57
[4] https://github.com/audiohacked/OpenCorsairLink/blob/61d336a61b85/main.c#L106


>
> >  - https://github.com/notaz/corsairmi
>
> This one covers only some HX/RM PSUs, but is uses the rawhid access which
> made me looking up the actual usb chips/bridges Corsair uses.
>
> >
> > One additional concern is that the non-HID AXi dongles may only have bulk
> > USB endpoints, and this is a HID driver.[1]
>
> You are right, in the case of the dongles it could be different. But I did
> some research on Corsair usb driven devices and they really like to stick to
> the cp210x, which is an usb hid bridge. The commit
> b9326057a3d8447f5d2e74a7b521ccf21add2ec0 actually covers two Corsair USB
> dongles as a cp210x device. So it is very likely that all Corsair PSUs with
> such an interface/dongle use usb hid. But I'm completely open to get proven
> wrong. Actually I really would like to see this tested by people who have
> access to the more rare devices.

I could be wrong (and I am sorry for the noise if that is the case), but
as far as I can see the cp210x does not create a HID device.

Thanks again,
Jonas


>
> > Thanks,
> > Jonas
> >
> > [1] https://github.com/ka87/cpsumon/issues/4
>
> Yes ... that one. The last revision of the dongle could indeed be a problem.
> But I'm not really sure what is described here. The last commenter is actually
> the one who provided the cp210x patch mentioned up there. The problem here is,
> the AX1500i has both connectors, USB and that other one. I call it the other
> one because it is the only PSU where it is labeled I2C COMM instead of COMM
> only. But at the same time this tools uses the same commands for this PSU.
>
> So, only some real hardware tests will show.
>
> Greetings,
> Wilken
>
> > >
> > > The patch also changes the usb hid ids to use upper case letters to be
> > > consistent with the rest of the hex numbers in the driver and updates
> > > the hwmon documentation.
> > >
> > > This patch adds:
> > > - hwmon/corsair-psu documentation update
> > > - corsair-psu driver update
> > >
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > ---
> > >  Documentation/hwmon/corsair-psu.rst | 10 +++++++++
> > >  drivers/hwmon/Kconfig               |  7 +++---
> > >  drivers/hwmon/corsair-psu.c         | 33 +++++++++++++++++++----------
> > >  3 files changed, 36 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> > > index 396b95c9a76a..6227e9046d73 100644
> > > --- a/Documentation/hwmon/corsair-psu.rst
> > > +++ b/Documentation/hwmon/corsair-psu.rst
> > > @@ -7,6 +7,16 @@ Supported devices:
> > >
> > >  * Corsair Power Supplies
> > >
> > > +  Corsair AX760i (by Corsair Link USB Dongle)
> > > +
> > > +  Corsair AX860i (by Corsair Link USB Dongle)
> > > +
> > > +  Corsair AX1200i (by Corsair Link USB Dongle)
> > > +
> > > +  Corsair AX1500i (by builtin Corsair Link USB Dongle)
> > > +
> > > +  Corsair AX1600i
> > > +
> > >    Corsair HX550i
> > >
> > >    Corsair HX650i
> > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > index 716df51edc87..3c059fc23cd6 100644
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -453,11 +453,12 @@ config SENSORS_CORSAIR_PSU
> > >         tristate "Corsair PSU HID controller"
> > >         depends on HID
> > >         help
> > > -         If you say yes here you get support for Corsair PSUs with a HID
> > > +         If you say yes here you get support for Corsair PSUs with an USB HID
> > >           interface.
> > >           Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
> > > -         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
> > > -         by Corsair.
> > > +         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i, HX1200i and AX1600i power
> > > +         supplies by Corsair. The AX760i, AX860i, AX1200i and AX1500i
> > > +         power supplies are supported through the Corsair Link USB Dongle.
> > >
> > >           This driver can also be built as a module. If so, the module
> > >           will be called corsair-psu.
> > > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > > index 99494056f4bd..0146dda3e2c3 100644
> > > --- a/drivers/hwmon/corsair-psu.c
> > > +++ b/drivers/hwmon/corsair-psu.c
> > > @@ -571,17 +571,28 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct
> > > hid_report *repo }
> > >
> > >  static const struct hid_device_id corsairpsu_idtable[] = {
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> > > -       { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> > > +       /*
> > > +        * The Corsair USB/COM Dongles appear in at least 3 different revisions, where rev 1
> > > and 2
> > > +        * are commonly used with the AX760i, AX860i and AX1200i, while rev3 is rarely seen with
> > > +        * these PSUs. Rev3 is also build into the AX1500i, while the AX1600i is the first PSU
> > > of
> > > +        * this series which has an unique usb hid id. Though, the actual device name is part of
> > > +        * the HID message protocol, so it doesn't matter which dongle is connected.
> > > +        */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair Link USB/COM Dongle rev1 */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C01) }, /* Corsair Link USB/COM Dongle rev2 */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair Link USB/COM Dongle rev3 (AX1500i) */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C03) }, /* Corsair HX550i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C04) }, /* Corsair HX650i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C05) }, /* Corsair HX750i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C06) }, /* Corsair HX850i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C07) }, /* Corsair HX1000i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C08) }, /* Corsair HX1200i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C09) }, /* Corsair RM550i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0A) }, /* Corsair RM650i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0B) }, /* Corsair RM750i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0C) }, /* Corsair RM850i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C0D) }, /* Corsair RM1000i */
> > > +       { HID_USB_DEVICE(0x1B1C, 0x1C11) }, /* Corsair AX1600i */
> > >         { },
> > >  };
> > >  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
> > > --
> > > 2.29.2
> > >
>
