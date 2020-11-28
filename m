Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6E2C7180
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbgK1VwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgK1S73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:29 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD0C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 21:38:15 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x15so6413108ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 21:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pF+WanDM3+n5VS7vO2na0YoqHjiGdR7Nzt5UHYS4/7w=;
        b=DMUyzeznkOiL3SXvEQmp+v3efBNMN44KDRXUVwKdDMAm0P2nNYkARiH6yf6CZUp17c
         U89lzgR9bUOWcflTQZ1ZfrIIs8ZHMkuuMI+5o1CFlOheVX98NYhThNweZJG27BVQVtMY
         txowg/yxq3sYmhbEyIkMMx5l2+o4dDNL0yeF+pQ4cNAwwVYXAOhhBe0+Za7+3+MCVrVq
         /JzylqqzwAaO8+NGfZyAGzwCBo8bqT4s/eo5wkd+S3dKxmnUN6RBszvtMigpjYLEGOTa
         eRumsGNcYzPApEOVb4t6loGegu8OKxhhetd6MmFtMRUAh1iUXPfcBVZEWRw6XK1mMvTO
         Z7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pF+WanDM3+n5VS7vO2na0YoqHjiGdR7Nzt5UHYS4/7w=;
        b=s50BgljcJZwmavChvBDxwv5XFVYO7/NsRgCic1HZwEp4DfcCRPHVB5q2gJ0JrtUpAP
         pWPdk9is+t2j9fYlNxxPQTp5IKQiAra7LoEEHEZ6zlkcohhXVn064k49ccGCs58Xu21S
         qevCtJYmBioqaD55OPLUXt/DMw+AiAUlYnyMUxxZjuVf9+aWzrksyyK/2ganlHYgw/1V
         JHx2LH4A8MR7PhhRuI77rQ/uo3FhfNg7jZJlHCTWM5lue0A5SHmZqnQWwI3XaH445RDe
         EEF1iTFQPCOZYxpoffbwwN2U30Doo+w5hjDnIxmE37pyhDEcFsqP1j5PDMClITH74G2/
         IlNA==
X-Gm-Message-State: AOAM530YR6kffNDvswDN0NW8h7WHglfPvvQuLNq/9AUo/YqKQ3IL6U5D
        Lnb4KBCuvAsO496AB7YcjLgKT1xKNGPqck+2U4xpFw==
X-Google-Smtp-Source: ABdhPJx4WQS1Qjj+g5p2TJZkeNaN4v/ySdPNfqA+ov5oQ2g+E+ySfBfLgllAq3/F3aSMRZ522oVvuvWZ2Nf55vqqdHc=
X-Received: by 2002:a92:d68d:: with SMTP id p13mr9440062iln.27.1606541894358;
 Fri, 27 Nov 2020 21:38:14 -0800 (PST)
MIME-Version: 1.0
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
In-Reply-To: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
From:   Jonas Malaco <jonas@protocubo.io>
Date:   Sat, 28 Nov 2020 02:37:38 -0300
Message-ID: <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
<wilken.gottwalt@posteo.net> wrote:
>
> Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
> AX1500i and AX1600i. The first 3 power supplies are supported through
> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> converter especially made for the COM ports of these power supplies.
> There are 3 known revisions of these adapters. The AX1500i power supply
> has revision 3 built into the case and AX1600i is the only one in that
> series, which has an unique usb hid id like the RM/RX series.

Can I ask what AXi power supplies were tested?

I ask because, based on the user-space implementations I am aware of,
the AXi dongle protocol appears to be different from the RMi/HXi series.

AXi dongle:
 - https://github.com/ka87/cpsumon

RMi/HXi:
 - https://github.com/jonasmalacofilho/liquidctl
 - https://github.com/audiohacked/OpenCorsairLink
 - https://github.com/notaz/corsairmi

One additional concern is that the non-HID AXi dongles may only have bulk
USB endpoints, and this is a HID driver.[1]

Thanks,
Jonas

[1] https://github.com/ka87/cpsumon/issues/4


>
> The patch also changes the usb hid ids to use upper case letters to be
> consistent with the rest of the hex numbers in the driver and updates
> the hwmon documentation.
>
> This patch adds:
> - hwmon/corsair-psu documentation update
> - corsair-psu driver update
>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  Documentation/hwmon/corsair-psu.rst | 10 +++++++++
>  drivers/hwmon/Kconfig               |  7 +++---
>  drivers/hwmon/corsair-psu.c         | 33 +++++++++++++++++++----------
>  3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 396b95c9a76a..6227e9046d73 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -7,6 +7,16 @@ Supported devices:
>
>  * Corsair Power Supplies
>
> +  Corsair AX760i (by Corsair Link USB Dongle)
> +
> +  Corsair AX860i (by Corsair Link USB Dongle)
> +
> +  Corsair AX1200i (by Corsair Link USB Dongle)
> +
> +  Corsair AX1500i (by builtin Corsair Link USB Dongle)
> +
> +  Corsair AX1600i
> +
>    Corsair HX550i
>
>    Corsair HX650i
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 716df51edc87..3c059fc23cd6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -453,11 +453,12 @@ config SENSORS_CORSAIR_PSU
>         tristate "Corsair PSU HID controller"
>         depends on HID
>         help
> -         If you say yes here you get support for Corsair PSUs with a HID
> +         If you say yes here you get support for Corsair PSUs with an USB HID
>           interface.
>           Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
> -         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
> -         by Corsair.
> +         (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i, HX1200i and AX1600i power
> +         supplies by Corsair. The AX760i, AX860i, AX1200i and AX1500i
> +         power supplies are supported through the Corsair Link USB Dongle.
>
>           This driver can also be built as a module. If so, the module
>           will be called corsair-psu.
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 99494056f4bd..0146dda3e2c3 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -571,17 +571,28 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
>  }
>
>  static const struct hid_device_id corsairpsu_idtable[] = {
> -       { HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> +       /*
> +        * The Corsair USB/COM Dongles appear in at least 3 different revisions, where rev 1 and 2
> +        * are commonly used with the AX760i, AX860i and AX1200i, while rev3 is rarely seen with
> +        * these PSUs. Rev3 is also build into the AX1500i, while the AX1600i is the first PSU of
> +        * this series which has an unique usb hid id. Though, the actual device name is part of
> +        * the HID message protocol, so it doesn't matter which dongle is connected.
> +        */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair Link USB/COM Dongle rev1 */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C01) }, /* Corsair Link USB/COM Dongle rev2 */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair Link USB/COM Dongle rev3 (AX1500i) */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C03) }, /* Corsair HX550i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C04) }, /* Corsair HX650i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C05) }, /* Corsair HX750i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C06) }, /* Corsair HX850i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C07) }, /* Corsair HX1000i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C08) }, /* Corsair HX1200i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C09) }, /* Corsair RM550i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C0A) }, /* Corsair RM650i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C0B) }, /* Corsair RM750i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C0C) }, /* Corsair RM850i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C0D) }, /* Corsair RM1000i */
> +       { HID_USB_DEVICE(0x1B1C, 0x1C11) }, /* Corsair AX1600i */
>         { },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
> --
> 2.29.2
>
