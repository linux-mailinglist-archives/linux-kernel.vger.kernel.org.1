Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163BE2DF140
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgLSTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgLSTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:15:54 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F60C061282
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:15:05 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id f132so6807803oib.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cvg0mMj3/9iAeAXAFseY1rufUcEGU4I4FlJPpr/ziaQ=;
        b=O6O8HayU6qcp39t0RkxnUqAFXQWwffNedWehI2s+6LznXlcp7w92O/Tnx9pblvo11N
         8r+F2OS9aB/sK/Q4De7Bnd/baWQ1WwEJsGyICNRGrBD2f6YByuapdVWn7SY/AKEQhxIm
         RcrljaielMhQuBOUnbQdedXMuATNdIh2F96lTfd2820KVLwG4fDRohdj7o51DDVGk3/l
         00XBog7Vz9rrUGUzxctruYIykGvtZFteE+2c9wz+lsIIypLyPF3rl3ejvtZ3YvfZ5O6f
         DWkdTK/jcQUzrfTQZktcDn/nWMNTT0I1BbUENM/f6I9vMXuqmDiXXXhcAZc4mLUKWrJ7
         3Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cvg0mMj3/9iAeAXAFseY1rufUcEGU4I4FlJPpr/ziaQ=;
        b=t9Pi3Tw5P2lvtQT8vcBaDV3Ga6ci5kRuysDZedtaCqShG1kml3Ia4J3UtGMKgrymxl
         MBf9kXP8LZENn/RFByXoBkD8Fb4xRoKKADffGerA+85+cg+g+41ZHRqBZB8EPtF3Dr6x
         X/s3zecP6Q7Cu++5NKE9kXD7OxeqOO13sGlF5LnkzUkGh8FIqq22YR3f9UAS9Q6/u86k
         +XESVR+5KQo5CK5Cp3TU6XJcjuRGKzTlnFMH/Xe7kFOGZlZ8/cH2synsjbkzqXS4X8Uz
         G8abKeqDBiMjn6RhGaac8F9AXU4RgL8AC/eoqbJDlBXL9eCOBPvz3Hr4TYIE2IaHfNGQ
         qD2A==
X-Gm-Message-State: AOAM531EAItiv7xvaNcndGuIbFeUUJavEhPouBLsPgXlr7fvDQJ5lluD
        lDnQDHDpCa6JkgBXxUSYCn1WwL+M3It/LcSFz7sbMw==
X-Google-Smtp-Source: ABdhPJzXsvRFkrBUiWRyzBJrbEAD5IQQM8CcX/hmvFzsHIdc2MVX+AYWl3cGSLinoNoh5ylUZurwMbx5NR+P/kbGRfs=
X-Received: by 2002:aca:75cc:: with SMTP id q195mr6669734oic.173.1608405305318;
 Sat, 19 Dec 2020 11:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20201218130329.258254-1-robert.marko@sartura.hr>
 <20201218130329.258254-2-robert.marko@sartura.hr> <9dd93c41-aa11-ebfb-7f72-0ee188268976@roeck-us.net>
In-Reply-To: <9dd93c41-aa11-ebfb-7f72-0ee188268976@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Sat, 19 Dec 2020 20:14:54 +0100
Message-ID: <CA+HBbNGjTD+DYeKEix5D4EfudW8-C-r4uft2hy+OBykN7eXfeg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: add Texas Instruments TPS23861 driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 3:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/18/20 5:03 AM, Robert Marko wrote:
> > Add basic monitoring support as well as port on/off control for Texas
> > Instruments TPS23861 PoE PSE IC.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> >  drivers/hwmon/Kconfig    |  11 ++
> >  drivers/hwmon/Makefile   |   1 +
> >  drivers/hwmon/tps23861.c | 398 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 410 insertions(+)
> >  create mode 100644 drivers/hwmon/tps23861.c
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index a850e4f0e0bd..3368ecfa7a9c 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1102,6 +1102,17 @@ config SENSORS_TC654
> >         This driver can also be built as a module. If so, the module
> >         will be called tc654.
> >
> > +config SENSORS_TPS23861
> > +     tristate "Texas Instruments TPS23861 PoE PSE"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       If you say yes here you get support for Texas Instruments
> > +       TPS23861 802.3at PoE PSE chips.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called tps23861.
> > +
> >  config SENSORS_MENF21BMC_HWMON
> >       tristate "MEN 14F021P00 BMC Hardware Monitoring"
> >       depends on MFD_MENF21BMC
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 9db2903b61e5..7493e9d5dc43 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX31790)    += max31790.o
> >  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> >  obj-$(CONFIG_SENSORS_MCP3021)        += mcp3021.o
> >  obj-$(CONFIG_SENSORS_TC654)  += tc654.o
> > +obj-$(CONFIG_SENSORS_TPS23861)       += tps23861.o
> >  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
> >  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
> >  obj-$(CONFIG_SENSORS_MR75203)        += mr75203.o
> > diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> > new file mode 100644
> > index 000000000000..e8b614267084
> > --- /dev/null
> > +++ b/drivers/hwmon/tps23861.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for the TI TPS23861 PoE PSE.
> > + *
> > + * Author: Robert Marko <robert.marko@sartura.hr>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
>
> Alphabetic include file order, please.

Done in v2.
>
> [ ... ]
>
> > +     hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> > +                                                        data, tps23861_groups);
>
> Please rework to use devm_hwmon_device_register_with_info().

Done in v2.

Thanks for the remarks.

Regards,
Robert
>
> Thanks,
> Guenter
