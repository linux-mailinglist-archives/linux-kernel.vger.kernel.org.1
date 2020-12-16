Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30D62DC275
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgLPOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgLPOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:50:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E4C061794;
        Wed, 16 Dec 2020 06:49:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a12so48994906lfl.6;
        Wed, 16 Dec 2020 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bE4UNwoir30PuHh6XkuL3M6MwBTU+ktUaaMgwLq3cYk=;
        b=lYrsvw4Q3ad32TyynkseRONGKgzozoK9apMLPHSQi/0MNmFar8mvghx06jWou8F4WD
         ircDAVPpA0h8sU3eUK/4SMRiSi4joZW7Tyf1gjJ+fWtiev/eW95V6PZVaeFV1wnZJbCi
         HujlUdMpShyQaiU8MlEMhHu5b1us6lNEfFh5P+uAp7o+gDFk7GJ4yvL5D0WG1qnpvWqI
         OVIA1hmazjdM+STYGNhPFLH026ZPxPS6BQcqBxgkhwkzatKoNdXGX6htg85uXAiG1wuu
         wdSLtOpnyPtqG6gW7riRGBJ8yeS5CtPPqTWTVc/C1q9/D6xcRE48wrytAxG7iFZr8ZHK
         sQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bE4UNwoir30PuHh6XkuL3M6MwBTU+ktUaaMgwLq3cYk=;
        b=GvGjOJpecolHcqlgytFuUGzXdcg8N8RozXRQXOYIPABh3wmlxyu6g28jrvjmOOla5F
         XDQRgvGoC3xicXVa6tLGmgNnwzJG67bsZWj/WlpKROb0V2bP+SQfa7dYLYn+hPffG4A3
         fgLe0U0c9V25beswd+cox1DFaE9epMUwy9VtrUr5LCWdSI5OArE3BYuvBxYQ6o8SPILY
         MgA9hR5AacuZWkA6qFoeF/dl39dRErnBliOrk2nx44qF5n1AxXP2hxVGzG00M9NGxpIC
         z2luUhGj8GMnhRjXJks/zLzvRYJAVtQwzQb5RzRJwCCXtD+Gw/qeng8dYpktXqnv7alQ
         FOaA==
X-Gm-Message-State: AOAM530FwQy6ZBgb0pyHNCJ0R04OFukOgE2UA/JBch8BTBjkxBqVwnSh
        ylyyBt23Q9sQ0yFeY0doV7CZy3br68SrHtSF3k4p81Lx
X-Google-Smtp-Source: ABdhPJzQUIIt3oVexVe9RclrI3fBqFWeQwktyjhcNFHuBUa4OVaoODtiLfYvB1yb6AUGofzerl08dxt4xtyumj9H0jg=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr6225178ljn.342.1608130162586;
 Wed, 16 Dec 2020 06:49:22 -0800 (PST)
MIME-Version: 1.0
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com> <20201216141213.GE207743@dell>
In-Reply-To: <20201216141213.GE207743@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 16 Dec 2020 22:49:11 +0800
Message-ID: <CADiBU3_o6uyS7GsPcWHVUkat2cHk0armDz4FC_TB6XaHfU-rEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mfd: rt4831: Adds support for Richtek RT4831 MFD core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=8816=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, 12 Dec 2020, cy_huang wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This adds support Richtek RT4831 MFD core. It includes four channel WLE=
D driver
>
> Drop mentions of MFD.  Just core driver will do.
>
> > and Display Bias Voltage outputs.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > since v2
> > - Refine Kconfig descriptions.
> > - Add copyright.
> > - Refine error logs in probe.
> > - Refine comment lines in remove and shutdown.
> > ---
> >  drivers/mfd/Kconfig       |  10 ++++
> >  drivers/mfd/Makefile      |   1 +
> >  drivers/mfd/rt4831-core.c | 124 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 135 insertions(+)
> >  create mode 100644 drivers/mfd/rt4831-core.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8b99a13..dfb2640 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1088,6 +1088,16 @@ config MFD_RDC321X
> >         southbridge which provides access to GPIOs and Watchdog using t=
he
> >         southbridge PCI device configuration space.
> >
> > +config MFD_RT4831
> > +     tristate "Richtek RT4831 four channel WLED and Display Bias Volta=
ge"
> > +     depends on I2C
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     help
> > +       This enables support for the Richtek RT4831 that includes 4 cha=
nnel
> > +       WLED driving and Display Bias Voltage. It's commonly used to pr=
ovide
> > +       power to the LCD display and LCD backlight.
> > +
> >  config MFD_RT5033
> >       tristate "Richtek RT5033 Power Management IC"
> >       depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 1780019..4108141 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)       +=3D menf21bmc.o
> >  obj-$(CONFIG_MFD_HI6421_PMIC)        +=3D hi6421-pmic-core.o
> >  obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.o
> >  obj-$(CONFIG_MFD_DLN2)               +=3D dln2.o
> > +obj-$(CONFIG_MFD_RT4831)     +=3D rt4831-core.o
>
> Why is this called -core ...
>
> >  obj-$(CONFIG_MFD_RT5033)     +=3D rt5033.o
>
> ... and this isn't?
>

Ok, I'm rename the mfd file to rt4831 only.
Due to this mfd is the parent of all sub device, to use 'core' is
trying to distinguish from rt4831-regulator  or rt4831-backlight.
My original thought is not to let the user confused.
If to add the postfix '-core' in the file name is bad, I think it can
be removed.

> >  obj-$(CONFIG_MFD_SKY81452)   +=3D sky81452.o
> >
> > diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> > new file mode 100644
> > index 00000000..f837c06
> > --- /dev/null
> > +++ b/drivers/mfd/rt4831-core.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2020 Richtek Technology Corp.
> > + *
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > + */
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#define RT4831_REG_REVISION  0x01
> > +#define RT4831_REG_ENABLE    0x08
> > +#define RT4831_REG_I2CPROT   0x15
> > +
> > +#define RICHTEK_VID          0x03
> > +#define RT4831_VID_MASK              GENMASK(1, 0)
> > +#define RT4831_RESET_MASK    BIT(7)
> > +#define RT4831_I2CSAFETMR_MASK       BIT(0)
> > +
> > +static const struct mfd_cell rt4831_subdevs[] =3D {
> > +     OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831=
-backlight"),
> > +     MFD_CELL_NAME("rt4831-regulator")
> > +};
>
> Just a little note about these helpers.  I'm planning on unifying the
> names pretty soon.  So if you have to rebase, please watch out for the
> rename.
>
> Essentially OF_MFD_CELL() will soon become MFD_CELL_OF().
>
Yes, I'll check this change. BTW, is it possible to get this patch
that I can integrate it into my codebase in advance.
> > +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int =
reg)
> > +{
> > +     if (reg >=3D RT4831_REG_REVISION && reg <=3D RT4831_REG_I2CPROT)
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static const struct regmap_config rt4831_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D RT4831_REG_I2CPROT,
> > +
> > +     .readable_reg =3D rt4831_is_accessible_reg,
> > +     .writeable_reg =3D rt4831_is_accessible_reg,
> > +};
> > +
> > +static int rt4831_probe(struct i2c_client *client)
> > +{
> > +     struct gpio_desc *enable;
>
> My preference would be "enable_gpio" to ensure it's easily
> identifiable further on.
>
Yes, it make sense.
> > +     struct regmap *regmap;
> > +     unsigned int val;
>
> 'val' is not a great name for a variable that is used for a specific
> purpose.  How about 'revision'?
>
Actually, this is just for the vendor id check.
Maybe to named 'vendor_id' is more suitable.
This register can be divided into two parts, bit[7:4] is the fixed
vendor identifier, only bit[3:0] is for the chip revision.
> > +     int ret;
> > +
> > +     enable =3D devm_gpiod_get_optional(&client->dev, "enable", GPIOD_=
OUT_HIGH);
> > +     if (IS_ERR(enable)) {
> > +             dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> > +             return PTR_ERR(enable);
> > +     }
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Failed to initialize regmap\n");
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     ret =3D regmap_read(regmap, RT4831_REG_REVISION, &val);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Failed to get H/W revision\n");
> > +             return ret;
> > +     }
> > +
> > +     if ((val & RT4831_VID_MASK) !=3D RICHTEK_VID) {
>
> What does VID stand for here?
>
> The fact that I have to ask probably means it should be changed.
>
> Variant ID perhaps?  If so, call the define 'VARIANT_ID'.
>
Like as the the above explaination.
'RICHTEK_VID' may not be good. So it make you confused.
I'll rename it to 'RICHTEK_VENDOR_ID'. How about this naming?

> > +             dev_err(&client->dev, "VID not matched, val =3D 0x%02x\n"=
, val);
>
> Using variable names means nothing to the user.
>
> "revision:  0x%02x" ?
>
How about this one "CHIP ID: 0x%02x"?
May I use 'chip_id to replace this variable 'val' naming?
> > +             return -ENODEV;
> > +     }
> > +
> > +     /*
> > +      * Used to prevent the abnormal shutdown.
> > +      * If SCL/SDA both keep low for one second to reset HW.
> > +      */
> > +     ret =3D regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2C=
SAFETMR_MASK,
> > +                              RT4831_I2CSAFETMR_MASK);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Failed to enable I2C safety timer\=
n");
> > +             return ret;
> > +     }
> > +
> > +     return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt=
4831_subdevs,
> > +                                 ARRAY_SIZE(rt4831_subdevs), NULL, 0, =
NULL);
> > +}
> > +
> > +static int rt4831_remove(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > +
> > +     /* Disable WLED and DSV outputs */
> > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET=
_MASK, RT4831_RESET_MASK);
> > +}
> > +
> > +static void rt4831_shutdown(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > +
> > +     /* Disable WLED and DSV outputs */
> > +     regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, =
RT4831_RESET_MASK);
> > +}
> > +
> > +static const struct of_device_id __maybe_unused rt4831_of_match[] =3D =
{
> > +     { .compatible =3D "richtek,rt4831", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> > +
> > +static struct i2c_driver rt4831_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rt4831",
> > +             .of_match_table =3D of_match_ptr(rt4831_of_match),
>
> The trend is to not use of_match_ptr() anymore, as these devices can
> not be instantiated using ACPI.
>
OK, I'll remove 'of_match_ptr'.
> > +     },
> > +     .probe_new =3D rt4831_probe,
> > +     .remove =3D rt4831_remove,
> > +     .shutdown =3D rt4831_shutdown,
> > +};
> > +module_i2c_driver(rt4831_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_LICENSE("GPL v2");
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
