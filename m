Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA82CA857
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgLAQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLAQgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:36:11 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0589BC0613CF;
        Tue,  1 Dec 2020 08:35:24 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so5373827lfe.11;
        Tue, 01 Dec 2020 08:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/JmDiej85wrGWSfQ3GjLEa75NHZA8Mf8kh4AeeifPA=;
        b=jqDMS4E9j+o8eb3vgEduE1EA5iWwtjEXXZTXP5ijaXR9gWz/iBHRjXxSmnXQBvW1Jt
         F2Frbk+kPI4v39OLDdjeckNqwZQz/DJg5VE7YEUtA/FLG5ozzTQleHLzzo/bT0D76oVc
         XvNzQHHJNsJzpZcsZ0WGmarIJPQBuomTO/GhIawvgtG85ETk3+XsRlnCaZrzYR/yTd3F
         kGNOW6wPoPtGqwGMvaHqEFMycfFTuOoJ5xos7CUB/2ftRhnwOX+KmZXEW3aEnSwb6rPz
         uZGP02r0Z59jKqpgRjG2tqr8MdZ688wMbS764V2K1WKg8OI6G1ykXo8EMBrNe7RiC/oN
         ZO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/JmDiej85wrGWSfQ3GjLEa75NHZA8Mf8kh4AeeifPA=;
        b=Ks1HaiFVAf02aDY+Bsq8Lm/PrSvk8AmTnM47Y+Dfjx0UzmUFZnzxQMUsRhCDYFOorR
         FJ0nYrJuXAhtRLaX91zyjQOEkawrfgLwyBQ98325A1Inz4eqgiTSgFFkd7H6oJH2jcVe
         OUf9Z0KKjVHzvQRNXvXfMCc4sL76iMF0Rn0OT+IkQbZRLwuCJFbXzFnpb4o2a7DpbZnh
         3MgsRDntYoohsVWXBOdXdN/0ARFAnLL1PAbFbKJRzdqoeUfiqUbAHcpeCK18+1ul+plH
         arRa0uImjDbmt5dgIOcPPKpNFvDDf0666xZBIe9xEKvTnz7eDFdBJ98qmjc9zni/Td8O
         CUaQ==
X-Gm-Message-State: AOAM530T+piOy4Y7YHqZQt3dN5HgN0Bdm4Yc5kLNnzJNDew9j73CrZzI
        G0wJuD2nxYlhOPArNM7ARg33z9AhJv3LEZuLTtRtCexInOE=
X-Google-Smtp-Source: ABdhPJxEHLFJwIPECJ2ENE3Ak/v9VSqQ6FUO5vC0yVLQ7vVjs+2ddOgmlF/gT4tQK+hu7xhfQFYzI6wOlN2wZEoOe5k=
X-Received: by 2002:a19:6a1a:: with SMTP id u26mr1610848lfu.209.1606840523173;
 Tue, 01 Dec 2020 08:35:23 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com> <20201125164207.GD4716@dell>
In-Reply-To: <20201125164207.GD4716@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 2 Dec 2020 00:35:11 +0800
Message-ID: <CADiBU3_bgx-K_zxzKCSL8w=meZu3cA3uWoC-3QVsBAuNJW1uiw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD core
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 02 Nov 2020, cy_huang wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds support Richtek RT4831 MFD core.
> > RT4831 includes backlight and DSV part that can provode display panel
> > for postive and negative voltage and WLED driving.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/mfd/Kconfig       |  11 +++++
> >  drivers/mfd/Makefile      |   1 +
> >  drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 drivers/mfd/rt4831-core.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8b99a13..a22f002 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1088,6 +1088,17 @@ config MFD_RDC321X
> >         southbridge which provides access to GPIOs and Watchdog using t=
he
> >         southbridge PCI device configuration space.
> >
> > +config MFD_RT4831
> > +     tristate "Richtek RT4831 WLED and DSV IC"
>
> Please expand on WLED and DSV.
>
> This is documentation and should leave nothing to the imagination.
>
Rewrite to "Richtek RT4831 four channel WLED and display bias
voltage", is it okay?
> > +     depends on I2C
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     help
> > +       This enables support for the Richtek RT4831.
> > +       RT4831 includes WLED driver and DisplayBias voltage(+/-) regula=
tor.
> > +       It's common used to provide the display power and to drive the
> > +       display backlight WLED.
>
> Please don't line-wrap unnecessarily.
>
> Please re-work the last sentence, as it doesn't quite make sense.
>
Rewrite the whole sentence like as below
"This enables support for the Richtek RT4831. It includes 4 channel
WLED driving and Display Bias voltage output. It's commonly used to
provide the LCD power and to drive LCD backlight."

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
> >  obj-$(CONFIG_MFD_RT5033)     +=3D rt5033.o
> >  obj-$(CONFIG_MFD_SKY81452)   +=3D sky81452.o
> >
> > diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> > new file mode 100644
> > index 00000000..5342959
> > --- /dev/null
> > +++ b/drivers/mfd/rt4831-core.c
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>
> No copyright?
>
Yes, I'll add the copyright like as below
/*
 * Copyright (c) 2020 Richtek Inc.
 *
 * Author: ChiYuan Huang <cy_huang@richtek.com>
 */
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
> > +
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
> > +     struct regmap *regmap;
> > +     unsigned int val;
> > +     int ret;
> > +
> > +     enable =3D devm_gpiod_get_optional(&client->dev, "enable", GPIOD_=
OUT_HIGH);
> > +     if (IS_ERR(enable)) {
> > +             dev_err(&client->dev, "Failed to get chip enable gpio\n")=
;
>
> "Failed to get 'enable' GPIO chip"
>
May I remove "chip" word? It seems redundant.
"Failed to get 'enable' GPIO" is better.
Because 'enable' is a physical input pin for RT4831.
> > +             return PTR_ERR(enable);
> > +     }
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Failed to init regmap\n");
>
> "initialise"
>
Change to verb "initialize"
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     ret =3D regmap_read(regmap, RT4831_REG_REVISION, &val);
> > +     if (ret) {
> > +             dev_err(&client->dev, "Fail to get version id\n");
>
> "Failed to get H/W revision"
>
Ack
> > +             return ret;
> > +     }
> > +
> > +     if ((val & RT4831_VID_MASK) !=3D RICHTEK_VID) {
> > +             dev_err(&client->dev, "VID not matched, val =3D 0x%02x\n"=
, val);
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
> > +     /* Make sure all off before module removal */
>
> "Disable all <thing your disabling> are disabled before ..."
>
May I rewrite it to "Configure WLED driving and DSV output all to be
disabled before MFD module removal"?
> > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET=
_MASK, RT4831_RESET_MASK);
> > +}
> > +
> > +static void rt4831_shutdown(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > +
> > +     /* Make sure all off before machine shutdown */
>
> As above.
>
like as above ".... before 'machine shutdown'
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
