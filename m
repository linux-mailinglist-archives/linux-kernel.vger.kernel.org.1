Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF892A9977
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKFQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:29:42 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C8C0613CF;
        Fri,  6 Nov 2020 08:29:41 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so2768582lfc.4;
        Fri, 06 Nov 2020 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P8b0ddrz8ofjNdmskp0NCDq0PN2gdJlbu4hQYmcTJqQ=;
        b=cIwSjjtGWy5c+PAv3Gqo7sOybdLWRBYrkeah3GwACujEM/HlzxphToerOQDogfibJi
         JSqVvDjT8ZxCl40NpournQfrri7HFHjG6NmyLPKwsf/4MGLWAk9m1zOTtta4Ni1aeifb
         viVhNGe7FKQCHNEJ9M4HKZGKggflJNxvt3o1CAfYAKCj4sakzwmY3SUfzOBGTtcVxHS0
         V/sfR858VFzDs4kygy3olvNJOJLaMSYS9Q9kyl62qbfqexQ8ijeitgeF67Sgezf05hf2
         WCq6lRuRa3+JLDX+Byr7aal6ngzAatqXiIkXi9eu8y7NckjPaP+IGO+s8Rol40vnOwJ+
         RhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P8b0ddrz8ofjNdmskp0NCDq0PN2gdJlbu4hQYmcTJqQ=;
        b=ONNCX4+/DsBTeJAMOUexyCy9fWc7vhGAtLvM2RlZzEhh8p10ovLwuEMGQtX3uq1twc
         TAEAcU//anmxztY0g3mJp/HFKblh16tjBG6COPs3O4tr0ZIUN1nu0QyqI/SmxHPLis8S
         VXLHbwN47effd6DtK7QAC4wN48boI8Ns6gQW4I2d2ICFsZxbKb0t9hhStVQGyhC2EY/Z
         Jv6X3QutwgvunDxBI5Xi/vSdfOozoqED03ZD8+h+sGjb8Cmf7M9UN8ZuXuyODPfmhKQp
         XysuZ7xjLkgB6s3/tbTkKr0Xdz4jV/zQ0ibWwmdoSFnWP6/rKiwzVCNJMthJXXaM/1pS
         mtqw==
X-Gm-Message-State: AOAM532sZ8nXF88eCDsc5hpv6i4/lOJPDD2y9GjHrXFQ9SskVOTr/6ia
        cKPOmID0TAirUdTv96uUmRCOOFLwMwXjIxnDImM=
X-Google-Smtp-Source: ABdhPJxvb+gYGCD9fPi5OlEXiz7i4IeLXEqm8Z8t1/RxL5/MsNgYqsysWKhJnXi7Xift9pnoiuRSE4UMfYbar5yDhhQ=
X-Received: by 2002:a05:6512:612:: with SMTP id b18mr1291813lfe.209.1604680180322;
 Fri, 06 Nov 2020 08:29:40 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 7 Nov 2020 00:29:28 +0800
Message-ID: <CADiBU3_5D-_djEM-s=9F6TepJU-zY4KySN2pvOji0Z5JTWszDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD core
To:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org
Cc:     cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Lee:
    Any advice about this rt4831 mfd patch?

cy_huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=882=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Adds support Richtek RT4831 MFD core.
> RT4831 includes backlight and DSV part that can provode display panel
> for postive and negative voltage and WLED driving.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/mfd/Kconfig       |  11 +++++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/mfd/rt4831-core.c
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13..a22f002 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1088,6 +1088,17 @@ config MFD_RDC321X
>           southbridge which provides access to GPIOs and Watchdog using t=
he
>           southbridge PCI device configuration space.
>
> +config MFD_RT4831
> +       tristate "Richtek RT4831 WLED and DSV IC"
> +       depends on I2C
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       help
> +         This enables support for the Richtek RT4831.
> +         RT4831 includes WLED driver and DisplayBias voltage(+/-) regula=
tor.
> +         It's common used to provide the display power and to drive the
> +         display backlight WLED.
> +
>  config MFD_RT5033
>         tristate "Richtek RT5033 Power Management IC"
>         depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 1780019..4108141 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC) +=3D menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)  +=3D hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_HI655X_PMIC)   +=3D hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)         +=3D dln2.o
> +obj-$(CONFIG_MFD_RT4831)       +=3D rt4831-core.o
>  obj-$(CONFIG_MFD_RT5033)       +=3D rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)     +=3D sky81452.o
>
> diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> new file mode 100644
> index 00000000..5342959
> --- /dev/null
> +++ b/drivers/mfd/rt4831-core.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define RT4831_REG_REVISION    0x01
> +#define RT4831_REG_ENABLE      0x08
> +#define RT4831_REG_I2CPROT     0x15
> +
> +#define RICHTEK_VID            0x03
> +#define RT4831_VID_MASK                GENMASK(1, 0)
> +#define RT4831_RESET_MASK      BIT(7)
> +#define RT4831_I2CSAFETMR_MASK BIT(0)
> +
> +static const struct mfd_cell rt4831_subdevs[] =3D {
> +       OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831=
-backlight"),
> +       MFD_CELL_NAME("rt4831-regulator")
> +};
> +
> +static bool rt4831_is_accessible_reg(struct device *dev, unsigned int re=
g)
> +{
> +       if (reg >=3D RT4831_REG_REVISION && reg <=3D RT4831_REG_I2CPROT)
> +               return true;
> +       return false;
> +}
> +
> +static const struct regmap_config rt4831_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .max_register =3D RT4831_REG_I2CPROT,
> +
> +       .readable_reg =3D rt4831_is_accessible_reg,
> +       .writeable_reg =3D rt4831_is_accessible_reg,
> +};
> +
> +static int rt4831_probe(struct i2c_client *client)
> +{
> +       struct gpio_desc *enable;
> +       struct regmap *regmap;
> +       unsigned int val;
> +       int ret;
> +
> +       enable =3D devm_gpiod_get_optional(&client->dev, "enable", GPIOD_=
OUT_HIGH);
> +       if (IS_ERR(enable)) {
> +               dev_err(&client->dev, "Failed to get chip enable gpio\n")=
;
> +               return PTR_ERR(enable);
> +       }
> +
> +       regmap =3D devm_regmap_init_i2c(client, &rt4831_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Failed to init regmap\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       ret =3D regmap_read(regmap, RT4831_REG_REVISION, &val);
> +       if (ret) {
> +               dev_err(&client->dev, "Fail to get version id\n");
> +               return ret;
> +       }
> +
> +       if ((val & RT4831_VID_MASK) !=3D RICHTEK_VID) {
> +               dev_err(&client->dev, "VID not matched, val =3D 0x%02x\n"=
, val);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Used to prevent the abnormal shutdown.
> +        * If SCL/SDA both keep low for one second to reset HW.
> +        */
> +       ret =3D regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2C=
SAFETMR_MASK,
> +                                RT4831_I2CSAFETMR_MASK);
> +       if (ret) {
> +               dev_err(&client->dev, "Failed to enable I2C safety timer\=
n");
> +               return ret;
> +       }
> +
> +       return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt=
4831_subdevs,
> +                                   ARRAY_SIZE(rt4831_subdevs), NULL, 0, =
NULL);
> +}
> +
> +static int rt4831_remove(struct i2c_client *client)
> +{
> +       struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> +
> +       /* Make sure all off before module removal */
> +       return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET=
_MASK, RT4831_RESET_MASK);
> +}
> +
> +static void rt4831_shutdown(struct i2c_client *client)
> +{
> +       struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> +
> +       /* Make sure all off before machine shutdown */
> +       regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, =
RT4831_RESET_MASK);
> +}
> +
> +static const struct of_device_id __maybe_unused rt4831_of_match[] =3D {
> +       { .compatible =3D "richtek,rt4831", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> +
> +static struct i2c_driver rt4831_driver =3D {
> +       .driver =3D {
> +               .name =3D "rt4831",
> +               .of_match_table =3D of_match_ptr(rt4831_of_match),
> +       },
> +       .probe_new =3D rt4831_probe,
> +       .remove =3D rt4831_remove,
> +       .shutdown =3D rt4831_shutdown,
> +};
> +module_i2c_driver(rt4831_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
