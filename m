Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725422A7F62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgKENBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKENBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:01:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE02BC0613CF;
        Thu,  5 Nov 2020 05:01:51 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id b1so2141996lfp.11;
        Thu, 05 Nov 2020 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rte+RN1GlZT+o4zocXut02cNP7YGnRzgrklvV1qGkzE=;
        b=IqktlwYSaSyiiKHV7cf4qZCHEFS3k+iWPGg2cRWbzpkbEnXj8GUpJ8pNQByaWgLsSk
         14AldybKLtCznbuVJGBmAs1Qne0mUiaZ/sCfPJKiy0uWaxhNwMZs8UDqj17f5McIqNx2
         RSD5EuG9J998rEzfy9gycWRvqJ53whqlhzuagjkssV0sDXnqjr9+iXh7TGc6ZUuP3SNk
         Ox9HuaMuFXzYptTTeQpoHky9vl3liNdqLbEBDiMx4Q34xewFPmEQL+LYrv/G+s5QaGVn
         BOG5i1RO1Xe204VCZUHzBHm+n+dkuNEB2JB+0bVpEAaFsOtYgQQAR5Wgs32quBg8fTSL
         q6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rte+RN1GlZT+o4zocXut02cNP7YGnRzgrklvV1qGkzE=;
        b=mo/rasgRsojGkD8hP/vuRDm0haGlWTiH65sgQ0Y661BYI6Ur2BqfpvUfi0XciW0gmK
         ClOUfXzRydDIA4xa2IHSuLmS/nOGvtJ753cQFk7bpolK8CCOQEVFpup3Mywp/f5nXK7B
         Rat33ojvCGXl6rbfQ6YCKRCq/BMVmj/Oes5T1X44byWqSBTac1HGR015/W6uI9trZgxk
         rxxq5celC0BdbUe6HI3QOMM25eAwo0mnCPthWTqRmFOQcucK+g/1f/j++6y9i8+L92Cm
         0JEeZ+YqsjN6SvPFTfSXeFxXBZA9dJbslOF83Sfl/2CmsvzNOyiIIZcQMyp99daeZjS3
         vJuQ==
X-Gm-Message-State: AOAM53367CqMzjjxaLO/CLvEMN8RWln/XGRNwso1xA8tFgSZoSzqfhM8
        MD4h3fNZ8LzS2hD6rhreqpsGeh4Ejrsh6B9N+vA=
X-Google-Smtp-Source: ABdhPJxotpSij5A3nSWVUAW3LYc1Xx2PO1q6zcg8dwl4mYSge/mG1s9sQUtsk4Y+FeWxtCbyUWu6qtw5CyipNHOYjSM=
X-Received: by 2002:ac2:5a5d:: with SMTP id r29mr914185lfn.456.1604581310256;
 Thu, 05 Nov 2020 05:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20201104143717.GA92239@roeck-us.net>
In-Reply-To: <20201104143717.GA92239@roeck-us.net>
From:   Charles Hsu <hsu.yuegteng@gmail.com>
Date:   Thu, 5 Nov 2020 21:01:38 +0800
Message-ID: <CAJArhDYH4pXc4MHbxUNxHLmP4Haiv_WyaNDktAByWQdgtOTWLA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus) Add driver for STMicroelectronics PM6764
 Voltage Regulator
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yungteng Hsu <hsu.yungteng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 10:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Nov 04, 2020 at 03:09:23PM +0800, Yungteng Hsu wrote:
> > Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
> >
> > the output voltage use the MFR_READ_VOUT 0xD4
> > vout value returned is linear11
> >
> > Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
>
> Please use standard Linux kernel code formatting rules.
> Run checkpatch --strict on the patch and make sure it does not report
> any problems.
>
> total: 1 errors, 39 warnings, 3 checks, 96 lines checked
>
> is a bit much for a 74-line patch.
>

Okay, I got it.

> > ---
> >  drivers/hwmon/pmbus/Kconfig    |  8 ++++
> >  drivers/hwmon/pmbus/Makefile   |  1 +
> >  drivers/hwmon/pmbus/pm6764tr.c | 74 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+)
> >  create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
> >
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index a25faf69fce3..2b487c401a4e 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -220,6 +220,14 @@ config SENSORS_MP2975
> >    This driver can also be built as a module. If so, the module will
> >    be called mp2975.
> >
> > +config SENSORS_PM6764TR
> > + tristate "PM6764TR"
> > + help
> > +  If you say yes here you get hardware monitoring support for PM6764TR.
> > +
> > +  This driver can also be built as a module. If so, the module will
> > +  be called pm6764tr.
> > +
> >  config SENSORS_PXE1610
> >   tristate "Infineon PXE1610"
> >   help
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index 4c97ad0bd791..31ebdef5d4a6 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785) += max31785.o
> >  obj-$(CONFIG_SENSORS_MAX34440) += max34440.o
> >  obj-$(CONFIG_SENSORS_MAX8688) += max8688.o
> >  obj-$(CONFIG_SENSORS_MP2975) += mp2975.o
> > +obj-$(CONFIG_SENSORS_PM6764TR) += pm6764tr.o
> >  obj-$(CONFIG_SENSORS_PXE1610) += pxe1610.o
> >  obj-$(CONFIG_SENSORS_TPS40422) += tps40422.o
> >  obj-$(CONFIG_SENSORS_TPS53679) += tps53679.o
> > diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
> > new file mode 100644
> > index 000000000000..b125a1cbfea5
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/pm6764tr.c
> > @@ -0,0 +1,74 @@
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/mutex.h>
> > +#include <linux/i2c.h>
> > +#include <linux/pmbus.h>
>
> Alphabetic include file order, please.
>

update include file order in v2.

> > +#include "pmbus.h"
> > +
> > +#define PM6764TR_PMBUS_READ_VOUT 0xD4
>
> tab after PM6764TR_PMBUS_READ_VOUT, please.
>
> I see you don't use any tabs in the patch. Please do.
>
> > +
> > +static int pm6764tr_read_word_data(struct i2c_client *client, int
> > page, int reg)
>
> Corrupted ?
>
> That makes me wonder if the patch was corrupted by your e-mail system,
> and if that system replaced tabs with spaces. Is that possible ?
>

This is corrupted by e-mail system,
and tabs are replaced with spaces.
I'll check the e-mail system setting and updated in v2.

> > +{
> > + int ret;
> > +
> > + switch (reg) {
> > + case PMBUS_VIRT_READ_VMON:
> > + ret = pmbus_read_word_data(client, page,
> > +   PM6764TR_PMBUS_READ_VOUT);
>
> That can be one line (line limit is now 100 columns).
>

fix to one line in v2.

> > + break;
> > + default:
> > + ret = -ENODATA;
> > + break;
> > + }
> > + return ret;
> > +}
> > +
> > +static struct pmbus_driver_info pm6764tr_info = {
> > + .pages = 1,
> > + .format[PSC_VOLTAGE_IN] = linear,
> > + .format[PSC_VOLTAGE_OUT] = vid,
> > + .format[PSC_TEMPERATURE] = linear,
> > + .format[PSC_CURRENT_OUT] = linear,
> > + .format[PSC_POWER] = linear,
> > + .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
> > +    PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
> > + PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
> > + PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> > +    .read_word_data = pm6764tr_read_word_data,
> > +};
> > +
> > +static int pm6764tr_probe(struct i2c_client *client,
> > +  const struct i2c_device_id *id)
>
> Please use the new style probe function (probe_new).
>

Change form .probe to .probe_new in v2.

> > +{
> > + return pmbus_do_probe(client, id, &pm6764tr_info);
> > +}
> > +
> > +static const struct i2c_device_id pm6764tr_id[] = {
> > + {"pm6764tr", 0},
> > + {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
> > +
> > +static const struct of_device_id pm6764tr_of_match[] = {
> > + {.compatible = "pm6764tr"},
> > + {}
> > +};
> > +/* This is the driver that will be inserted */
> > +static struct i2c_driver pm6764tr_driver = {
> > + .driver = {
> > +   .name = "pm6764tr",
> > +   .of_match_table = of_match_ptr(pm6764tr_of_match),
> > +   },
> > + .probe = pm6764tr_probe,
> > + .remove = pmbus_do_remove,
>
> pmbus_do_remove no longer exists.
>

remove .remove = pmbus_do_remove in v2.

> > + .id_table = pm6764tr_id,
> > +};
> > +
> > +module_i2c_driver(pm6764tr_driver);
> > +
> > +MODULE_AUTHOR("Charles Hsu");
> > +MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
