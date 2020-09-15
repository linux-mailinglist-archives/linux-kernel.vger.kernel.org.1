Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FEF26B276
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgIOWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:47:54 -0400
Received: from crapouillou.net ([89.234.176.41]:36744 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbgIOWrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600210042; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcPZUp1rmQlm3fzizVqUWLPbm7rhwndoJTQbSjOD3rc=;
        b=T2ezz5HdvioBFHXkPyQ1b6AJ7YuCiIdZauOfsih7z5Nc1nsMjqrvG3vXKo5VwsTdiodAq2
        0NSM/Q03iCO4JZERPY9qOavBdGHM+7MuKDVybYlPmg2LFRbcO5jcKd2kDoBZZUFmeA2rG4
        xb9XjwPWxOtVWLegSuO/7VnSt03QNJs=
Date:   Wed, 16 Sep 2020 00:47:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] USB: PHY: JZ4770: Use the generic PHY framework.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <EY1QGQ.TFKG10DQWSQP@crapouillou.net>
In-Reply-To: <20200913063430.9622-3-zhouyanjie@wanyeetech.com>
References: <20200913063430.9622-1-zhouyanjie@wanyeetech.com>
        <20200913063430.9622-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le dim. 13 sept. 2020 =C3=A0 14:34, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanji=
e)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Used the generic PHY framework API to create the PHY,
> and move the driver to driver/phy/ingenic. And adjust
> the position of some codes to make it consistent with
> the style of other USB PHY drivers.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingen=
ic.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v1->v2:
>     Fix bug, ".of_match_table =3D=20
> of_match_ptr(ingenic_usb_phy_of_matches)" is wrong
>     and should be replaced with ".of_match_table =3D=20
> ingenic_usb_phy_of_matches".
>=20
>     v2->v3:
>     1.Change "depends on (MACH_INGENIC && MIPS) || COMPILE_TEST" to
>       "depends on MIPS || COMPILE_TEST".
>     2.Keep the adjustments of "ingenic_usb_phy_init()" and=20
> "ingenic_usb_phu_exit()"
>       positions in v2 to make them consistent with the order in=20
> "ingenic_usb_phy_ops",
>       keep the adjustments to the positions of=20
> "ingenic_usb_phy_of_matches[]" in v2
>       to keep them consistent with the styles of other USB PHY=20
> drivers. And remove
>       some unnecessary changes to reduce the diff size, from the=20
> original 256 lines
>       change to the current 209 lines.
>=20
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/ingenic/Kconfig                        |  12 ++
>  drivers/phy/ingenic/Makefile                       |   2 +
>  .../phy-jz4770.c =3D> phy/ingenic/phy-ingenic-usb.c} | 209=20
> +++++++++++----------
>  drivers/usb/phy/Kconfig                            |   8 -
>  drivers/usb/phy/Makefile                           |   1 -
>  7 files changed, 128 insertions(+), 106 deletions(-)
>  create mode 100644 drivers/phy/ingenic/Kconfig
>  create mode 100644 drivers/phy/ingenic/Makefile
>  rename drivers/{usb/phy/phy-jz4770.c =3D>=20
> phy/ingenic/phy-ingenic-usb.c} (71%)
>=20
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index de9362c25c07..0534b0fdd057 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/freescale/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
> +source "drivers/phy/ingenic/Kconfig"
>  source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
>  source "drivers/phy/mediatek/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index c27408e4daae..ab24f0d20763 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -14,6 +14,7 @@ obj-y					+=3D allwinner/	\
>  					   cadence/	\
>  					   freescale/	\
>  					   hisilicon/	\
> +					   ingenic/	\
>  					   intel/	\
>  					   lantiq/	\
>  					   marvell/	\
> diff --git a/drivers/phy/ingenic/Kconfig b/drivers/phy/ingenic/Kconfig
> new file mode 100644
> index 000000000000..912b14e512cb
> --- /dev/null
> +++ b/drivers/phy/ingenic/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Phy drivers for Ingenic platforms
> +#
> +config PHY_INGENIC_USB
> +	tristate "Ingenic SoCs USB PHY Driver"
> +	depends on MIPS || COMPILE_TEST
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	help
> +	  This driver provides USB PHY support for the USB controller found
> +	  on the JZ-series and X-series SoCs from Ingenic.
> diff --git a/drivers/phy/ingenic/Makefile=20
> b/drivers/phy/ingenic/Makefile
> new file mode 100644
> index 000000000000..65d5ea00fc9d
> --- /dev/null
> +++ b/drivers/phy/ingenic/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y		+=3D phy-ingenic-usb.o
> diff --git a/drivers/usb/phy/phy-jz4770.c=20
> b/drivers/phy/ingenic/phy-ingenic-usb.c
> similarity index 71%
> rename from drivers/usb/phy/phy-jz4770.c
> rename to drivers/phy/ingenic/phy-ingenic-usb.c
> index 4025da20b3fd..1f2e811c9125 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
> @@ -7,12 +7,12 @@
>   */
>=20
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/usb/otg.h>
> -#include <linux/usb/phy.h>
> +#include <linux/phy/phy.h>
>=20
>  /* OTGPHY register offsets */
>  #define REG_USBPCR_OFFSET			0x00
> @@ -97,68 +97,56 @@ enum ingenic_usb_phy_version {
>  struct ingenic_soc_info {
>  	enum ingenic_usb_phy_version version;
>=20
> -	void (*usb_phy_init)(struct usb_phy *phy);
> +	void (*usb_phy_init)(struct phy *phy);
>  };
>=20
> -struct jz4770_phy {
> +struct ingenic_usb_phy {
>  	const struct ingenic_soc_info *soc_info;
>=20
> -	struct usb_phy phy;
> -	struct usb_otg otg;
> +	struct phy *phy;
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk *clk;
>  	struct regulator *vcc_supply;
>  };
>=20
> -static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg=20
> *otg)
> +static int ingenic_usb_phy_init(struct phy *phy)
>  {
> -	return container_of(otg, struct jz4770_phy, otg);
> -}
> -
> -static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy=20
> *phy)
> -{
> -	return container_of(phy, struct jz4770_phy, phy);
> -}
> -
> -static int ingenic_usb_phy_set_peripheral(struct usb_otg *otg,
> -				     struct usb_gadget *gadget)
> -{
> -	struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
> +	int err;
>  	u32 reg;
>=20
> -	if (priv->soc_info->version >=3D ID_X1000) {
> -		reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
> -		reg |=3D USBPCR1_BVLD_REG;
> -		writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +	err =3D clk_prepare_enable(priv->clk);
> +	if (err) {
> +		dev_err(priv->dev, "Unable to start clock: %d\n", err);
> +		return err;
>  	}
>=20
> +	priv->soc_info->usb_phy_init(phy);
> +
> +	/* Wait for PHY to reset */
> +	usleep_range(30, 300);
>  	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> -	reg &=3D ~USBPCR_USB_MODE;
> -	reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> +	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
> +	usleep_range(300, 1000);
>=20
>  	return 0;
>  }
>=20
> -static int ingenic_usb_phy_set_host(struct usb_otg *otg, struct=20
> usb_bus *host)
> +static int ingenic_usb_phy_exit(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D otg_to_jz4770_phy(otg);
> -	u32 reg;
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>=20
> -	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> -	reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE);
> -	reg |=3D USBPCR_USB_MODE;
> -	writel(reg, priv->base + REG_USBPCR_OFFSET);
> +	clk_disable_unprepare(priv->clk);
> +	regulator_disable(priv->vcc_supply);
>=20
>  	return 0;
>  }

That part is still messy. You remove ingenic_usb_phy_set_peripheral()=20
and ingenic_usb_phy_set_host(), then add ingenic_usb_phy_init() and=20
ingenic_usb_phy_exit(). Why were the two first functions removed? Just=20
keep these around, and call them from ingenic_usb_phy_set_mode(). That=20
will automatically make the diff much smaller.

And by making the diff smaller, we can spot the actual differences.=20
Like how support for PHY_MODE_USB_OTG was added, without any notice.

>=20
> -static int ingenic_usb_phy_init(struct usb_phy *phy)
> +static int ingenic_usb_phy_power_on(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	int err;
> -	u32 reg;
>=20
>  	err =3D regulator_enable(priv->vcc_supply);
>  	if (err) {
> @@ -166,39 +154,71 @@ static int ingenic_usb_phy_init(struct usb_phy=20
> *phy)
>  		return err;
>  	}
>=20
> -	err =3D clk_prepare_enable(priv->clk);
> -	if (err) {
> -		dev_err(priv->dev, "Unable to start clock: %d\n", err);
> -		return err;
> -	}
> -
> -	priv->soc_info->usb_phy_init(phy);
> -
> -	/* Wait for PHY to reset */
> -	usleep_range(30, 300);
> -	reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> -	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
> -	usleep_range(300, 1000);
> -
>  	return 0;
>  }
>=20
> -static void ingenic_usb_phy_shutdown(struct usb_phy *phy)
> +static int ingenic_usb_phy_power_off(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>=20
> -	clk_disable_unprepare(priv->clk);
>  	regulator_disable(priv->vcc_supply);
> +
> +	return 0;
>  }
>=20
> -static void ingenic_usb_phy_remove(void *phy)
> +static int ingenic_usb_phy_set_mode(struct phy *phy,
> +				  enum phy_mode mode, int submode)
>  {
> -	usb_remove_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE);
> +		reg |=3D USBPCR_USB_MODE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	case PHY_MODE_USB_DEVICE:
> +		if (priv->soc_info->version >=3D ID_X1000) {
> +			reg =3D readl(priv->base + REG_USBPCR1_OFFSET);
> +			reg |=3D USBPCR1_BVLD_REG;
> +			writel(reg, priv->base + REG_USBPCR1_OFFSET);
> +		}
> +
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~USBPCR_USB_MODE;
> +		reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL |=20
> USBPCR_OTG_DISABLE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		reg =3D readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &=3D ~USBPCR_OTG_DISABLE;
> +		reg |=3D USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_USB_MODE;
> +		writel(reg, priv->base + REG_USBPCR_OFFSET);
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>=20
> -static void jz4770_usb_phy_init(struct usb_phy *phy)
> +static const struct phy_ops ingenic_usb_phy_ops =3D {
> +	.init		=3D ingenic_usb_phy_init,
> +	.exit		=3D ingenic_usb_phy_exit,
> +	.power_on	=3D ingenic_usb_phy_power_on,
> +	.power_off	=3D ingenic_usb_phy_power_off,
> +	.set_mode	=3D ingenic_usb_phy_set_mode,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static void jz4770_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
> @@ -208,9 +228,9 @@ static void jz4770_usb_phy_init(struct usb_phy=20
> *phy)
>  	writel(reg, priv->base + REG_USBPCR_OFFSET);
>  }
>=20
> -static void jz4780_usb_phy_init(struct usb_phy *phy)
> +static void jz4780_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
> @@ -221,9 +241,9 @@ static void jz4780_usb_phy_init(struct usb_phy=20
> *phy)
>  	writel(reg, priv->base + REG_USBPCR_OFFSET);
>  }
>=20
> -static void x1000_usb_phy_init(struct usb_phy *phy)
> +static void x1000_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	reg =3D readl(priv->base + REG_USBPCR1_OFFSET) |=20
> USBPCR1_WORD_IF_16BIT;
> @@ -235,9 +255,9 @@ static void x1000_usb_phy_init(struct usb_phy=20
> *phy)
>  	writel(reg, priv->base + REG_USBPCR_OFFSET);
>  }
>=20
> -static void x1830_usb_phy_init(struct usb_phy *phy)
> +static void x1830_usb_phy_init(struct phy *phy)
>  {
> -	struct jz4770_phy *priv =3D phy_to_jz4770_phy(phy);
> +	struct ingenic_usb_phy *priv =3D phy_get_drvdata(phy);
>  	u32 reg;
>=20
>  	/* rdt */
> @@ -276,43 +296,25 @@ static const struct ingenic_soc_info=20
> x1830_soc_info =3D {
>  	.usb_phy_init =3D x1830_usb_phy_init,
>  };
>=20
> -static const struct of_device_id ingenic_usb_phy_of_matches[] =3D {
> -	{ .compatible =3D "ingenic,jz4770-phy", .data =3D &jz4770_soc_info },
> -	{ .compatible =3D "ingenic,jz4780-phy", .data =3D &jz4780_soc_info },
> -	{ .compatible =3D "ingenic,x1000-phy", .data =3D &x1000_soc_info },
> -	{ .compatible =3D "ingenic,x1830-phy", .data =3D &x1830_soc_info },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);

Why move that array?

> -
> -static int jz4770_phy_probe(struct platform_device *pdev)
> +static int ingenic_usb_phy_probe(struct platform_device *pdev)
>  {
> +	struct ingenic_usb_phy *priv;
> +	struct phy_provider *provider;
>  	struct device *dev =3D &pdev->dev;
> -	struct jz4770_phy *priv;
>  	int err;
>=20
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>=20
> -	priv->soc_info =3D device_get_match_data(&pdev->dev);
> +	priv->soc_info =3D device_get_match_data(dev);
>  	if (!priv->soc_info) {
> -		dev_err(&pdev->dev, "Error: No device match found\n");
> +		dev_err(dev, "Error: No device match found\n");
>  		return -ENODEV;
>  	}
>=20
>  	platform_set_drvdata(pdev, priv);
>  	priv->dev =3D dev;
> -	priv->phy.dev =3D dev;
> -	priv->phy.otg =3D &priv->otg;
> -	priv->phy.label =3D "ingenic-usb-phy";
> -	priv->phy.init =3D ingenic_usb_phy_init;
> -	priv->phy.shutdown =3D ingenic_usb_phy_shutdown;
> -
> -	priv->otg.state =3D OTG_STATE_UNDEFINED;
> -	priv->otg.usb_phy =3D &priv->phy;
> -	priv->otg.set_host =3D ingenic_usb_phy_set_host;
> -	priv->otg.set_peripheral =3D ingenic_usb_phy_set_peripheral;
>=20
>  	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base)) {
> @@ -336,27 +338,40 @@ static int jz4770_phy_probe(struct=20
> platform_device *pdev)
>  		return err;
>  	}
>=20
> -	err =3D usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
> -	if (err) {
> -		if (err !=3D -EPROBE_DEFER)
> -			dev_err(dev, "Unable to register PHY\n");
> -		return err;
> -	}
> +	priv->phy =3D devm_phy_create(priv->dev, NULL, &ingenic_usb_phy_ops);

You can use 'dev' directly.

> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	phy_set_drvdata(priv->phy, priv);
>=20
> -	return devm_add_action_or_reset(dev, ingenic_usb_phy_remove,=20
> &priv->phy);
> +	provider =3D devm_of_phy_provider_register(priv->dev,=20
> of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	return 0;

return demv_of_phy_provider_register(dev, ...)

>  }
>=20
> -static struct platform_driver ingenic_phy_driver =3D {
> -	.probe		=3D jz4770_phy_probe,
> +static const struct of_device_id ingenic_usb_phy_of_matches[] =3D {
> +	{ .compatible =3D "ingenic,jz4770-phy", .data =3D &jz4770_soc_info },
> +	{ .compatible =3D "ingenic,jz4780-phy", .data =3D &jz4780_soc_info },
> +	{ .compatible =3D "ingenic,x1000-phy", .data =3D &x1000_soc_info },
> +	{ .compatible =3D "ingenic,x1830-phy", .data =3D &x1830_soc_info },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
> +
> +static struct platform_driver ingenic_usb_phy_driver =3D {
> +	.probe		=3D ingenic_usb_phy_probe,
>  	.driver		=3D {
> -		.name	=3D "jz4770-phy",
> +		.name	=3D "ingenic-usb-phy",
>  		.of_match_table =3D ingenic_usb_phy_of_matches,
>  	},
>  };
> -module_platform_driver(ingenic_phy_driver);
> +module_platform_driver(ingenic_usb_phy_driver);
>=20
>  MODULE_AUTHOR("=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wan=
yeetech.com>");
>  MODULE_AUTHOR("=E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@inge=
nic.com>");
>  MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>  MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
> +MODULE_ALIAS("jz4770-phy");

So I first thought this generic PHY driver would be a drop-in=20
replacement for the old jz4770-phy driver, that's why I suggested to=20
add the jz4770-phy alias. But it turns out that it's a completely=20
different framework, so we can drop the alias.

That also means that this patch, without any change to the JZ4740 MUSB=20
driver, breaks USB on all Ingenic SoCs I can test with.

So unless you have a patch to the jz4740-musb driver in this series,=20
you can't remove the old jz4770-phy driver yet. Just modify this patch=20
so that the new generic-PHY driver is added, without removing the old=20
one. It will be much easier to review (one new driver vs lots of +/-=20
lines) and you can move the code around if you want to. Then when the=20
jz4740-musb driver is modified to use the generic PHY framework, the=20
old jz4770-phy driver can be "retired".

Cheers,
-Paul

>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index ef4787cd3d37..ff24fca0a2d9 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -184,12 +184,4 @@ config USB_ULPI_VIEWPORT
>  	  Provides read/write operations to the ULPI phy register set for
>  	  controllers with a viewport register (e.g. Chipidea/ARC=20
> controllers).
>=20
> -config JZ4770_PHY
> -	tristate "Ingenic SoCs Transceiver Driver"
> -	depends on MIPS || COMPILE_TEST
> -	select USB_PHY
> -	help
> -	  This driver provides PHY support for the USB controller found
> -	  on the JZ-series and X-series SoCs from Ingenic.
> -
>  endmenu
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index b352bdbe8712..df1d99010079 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -24,4 +24,3 @@ obj-$(CONFIG_USB_MXS_PHY)		+=3D phy-mxs-usb.o
>  obj-$(CONFIG_USB_ULPI)			+=3D phy-ulpi.o
>  obj-$(CONFIG_USB_ULPI_VIEWPORT)		+=3D phy-ulpi-viewport.o
>  obj-$(CONFIG_KEYSTONE_USB_PHY)		+=3D phy-keystone.o
> -obj-$(CONFIG_JZ4770_PHY)		+=3D phy-jz4770.o
> --
> 2.11.0
>=20


