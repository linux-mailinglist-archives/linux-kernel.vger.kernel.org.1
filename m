Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73D2288ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgJIOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbgJIOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:25:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1BC0613D2;
        Fri,  9 Oct 2020 07:25:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w21so1773550plq.3;
        Fri, 09 Oct 2020 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7qE0GUuBpfv8UjMVWbZ0ncuDXglYrJh0hxvzENiZ/8=;
        b=JBBVCTAcdPeVOeY24OObzt1FQFK/0dbrwcz8o15piYCM9wKumNVa25e+K0WRk1e38l
         ldSw2BR8PbjpUuRJA2Bz36JvLnVrD7Vq7M1VCM+u8LrI4KpeenlEYs07H1+hecgnPaGz
         oNeuxVJXAu9t2auQq9G9byyqlxa/0cLVweaCDuXYvi1AeUQJdmpjRfArYEzilqd8AQxX
         t3kEw7+I1XyQ3SqSXCrb6yy2M290azWEdz1Qr2Il9Etl16bTsXMvxv35YJb8wDcNgNrK
         c4Y19lv4jWcQWSzQpv8IfvLn3pqf9h9NrHPkk4iyHuj6bi09kdCVJvOnIjSGPX8fRdv9
         K1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7qE0GUuBpfv8UjMVWbZ0ncuDXglYrJh0hxvzENiZ/8=;
        b=mG9+neVyh54J1Rw54bEivJCVg4lNToIlpB1I7svC92upJmQkEiBts6+e1mGW3EVaRQ
         +ruUbAXwmv51xhWbH3RinsA/59YxsIIf4HKr+ldYsZaAW3oWwJCRgYCoORNg+Zc5PWzN
         9aR1Qdd1LXHr8TNTX0H7pmAhDoIIixd55CQJyVwYH/QLa75IXWfWrws6qrPcFeykdLNz
         iaNfm7mcob4MBIHqFJ9zZA9sa+iy4/S9Gri4Yrv/H7u4h8UVTpkY9T6ySUxoFzqtl1s4
         emsvai3uwZwxCIPjyy6YggQH50t8ZyVhiC/KfBjV0J9JEjr8dYFHEhv3ZR5joXaJNkJ2
         CCtw==
X-Gm-Message-State: AOAM533LeG/St1bekbW9NGnTLk/AkW3bIbA+CZ1LYr5KBzi1CXO/WDLH
        JgcnWnN/M9SRmHk/ULbVOx3fpBLNYry6W73dx6M=
X-Google-Smtp-Source: ABdhPJyZg/PkK/hjqy/5vVWSOS1AXfLxmeEoMXE0Id1GSJWLrjE5E8Me834jLrcvXmHmwLx7Zy17XZG174r1FC4GYVw=
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id
 d10-20020a170902aa8ab02900d3c9dd77d1mr12650563plr.0.1602253512112; Fri, 09
 Oct 2020 07:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201009141128.683254-1-luzmaximilian@gmail.com> <20201009141128.683254-3-luzmaximilian@gmail.com>
In-Reply-To: <20201009141128.683254-3-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Oct 2020 17:26:01 +0300
Message-ID: <CAHp75VfJNrJs3PFuH4+Cw5wZ8MB+hoeuZc-+2s1YD2wHYzf8pg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 5:11 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Move the Surface 3 WMI driver from platform/x86 to the newly created
> platform/surface directory.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/platform/surface/Kconfig                 | 16 ++++++++++++++++
>  drivers/platform/surface/Makefile                |  2 ++
>  drivers/platform/{x86 => surface}/surface3-wmi.c |  0
>  drivers/platform/x86/Kconfig                     | 12 ------------
>  drivers/platform/x86/Makefile                    |  1 -
>  5 files changed, 18 insertions(+), 13 deletions(-)
>  rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
>
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index b67926ece95f..326f7bbf83d7 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -12,3 +12,19 @@ menuconfig SURFACE_PLATFORMS
>           kernel code.
>
>           If you say N, all options in this submenu will be skipped and disabled.
> +
> +if SURFACE_PLATFORMS
> +
> +config SURFACE3_WMI
> +       tristate "Surface 3 WMI Driver"
> +       depends on ACPI_WMI
> +       depends on DMI
> +       depends on INPUT
> +       depends on SPI
> +       help
> +         Say Y here if you have a Surface 3.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called surface3-wmi.
> +
> +endif # SURFACE_PLATFORMS
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> index 3700f9e84299..f889d521420f 100644
> --- a/drivers/platform/surface/Makefile
> +++ b/drivers/platform/surface/Makefile
> @@ -3,3 +3,5 @@
>  # Makefile for linux/drivers/platform/surface
>  # Microsoft Surface Platform-Specific Drivers
>  #
> +
> +obj-$(CONFIG_SURFACE3_WMI)             += surface3-wmi.o
> diff --git a/drivers/platform/x86/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
> similarity index 100%
> rename from drivers/platform/x86/surface3-wmi.c
> rename to drivers/platform/surface/surface3-wmi.c
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0d91d136bc3b..0759913c9846 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -870,18 +870,6 @@ config INTEL_VBTN
>           To compile this driver as a module, choose M here: the module will
>           be called intel_vbtn.
>
> -config SURFACE3_WMI
> -       tristate "Surface 3 WMI Driver"
> -       depends on ACPI_WMI
> -       depends on DMI
> -       depends on INPUT
> -       depends on SPI
> -       help
> -         Say Y here if you have a Surface 3.
> -
> -         To compile this driver as a module, choose M here: the module will
> -         be called surface3-wmi.
> -
>  config SURFACE_3_BUTTON
>         tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
>         depends on ACPI && KEYBOARD_GPIO && I2C
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5f823f7eff45..29563a32b3e3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -82,7 +82,6 @@ obj-$(CONFIG_INTEL_OAKTRAIL)          += intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)               += intel-vbtn.o
>
>  # Microsoft
> -obj-$(CONFIG_SURFACE3_WMI)             += surface3-wmi.o
>  obj-$(CONFIG_SURFACE_3_BUTTON)         += surface3_button.o
>  obj-$(CONFIG_SURFACE_3_POWER_OPREGION) += surface3_power.o
>  obj-$(CONFIG_SURFACE_PRO3_BUTTON)      += surfacepro3_button.o
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
