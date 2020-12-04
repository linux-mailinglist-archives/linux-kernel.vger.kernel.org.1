Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601892CF1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbgLDQOM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Dec 2020 11:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbgLDQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:14:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D135AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:13:31 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1klDi5-0005zx-Ng; Fri, 04 Dec 2020 17:13:29 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1klDi4-0004bn-Iz; Fri, 04 Dec 2020 17:13:28 +0100
Message-ID: <f620c4aa8ca3ed10701c5fe050a2bed04ff759db.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: bcm4908-usb: add driver for BCM4908 USB
 reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Date:   Fri, 04 Dec 2020 17:13:28 +0100
In-Reply-To: <20201204093704.11359-2-zajec5@gmail.com>
References: <20201204093704.11359-1-zajec5@gmail.com>
         <20201204093704.11359-2-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

On Fri, 2020-12-04 at 10:37 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This controller is responsible for OHCI, EHCI, XHCI and PHYs setup that
> has to be handled in the proper order.
> 
> One unusual thing about this controller is that is provides access to
> the MDIO bus. There are two registers (in the middle of block space)
> responsible for that. For that reason this driver initializes regmap so
> a proper MDIO driver can use them.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

This doesn't look like a reset controller to me, but rather like
something that belongs in drivers/usb.

regards
Philipp

> ---
>  drivers/reset/Kconfig             |   8 +
>  drivers/reset/Makefile            |   1 +
>  drivers/reset/reset-bcm4908-usb.c | 250 ++++++++++++++++++++++++++++++
>  3 files changed, 259 insertions(+)
>  create mode 100644 drivers/reset/reset-bcm4908-usb.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index f393f7e17e33..bb4d2bea9e95 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -35,6 +35,14 @@ config RESET_AXS10X
>  	help
>  	  This enables the reset controller driver for AXS10x.
>  
> +config RESET_BCM4908_USB
> +	tristate "Broadcom BCM4908 USB controller"
> +	depends on ARM64 || COMPILE_TEST
> +	default ARCH_BCM4908
> +	help
> +	  This enables driver for the Broadcom BCM4908 USB controller
> +	  responsible for initializing OHCI, EHCI, XHCI and PHYs.
> +
>  config RESET_BERLIN
>  	bool "Berlin Reset Driver" if COMPILE_TEST
>  	default ARCH_BERLIN
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 0dd5d42050dc..f2627bbc7ad4 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
> +obj-$(CONFIG_RESET_BCM4908_USB) += reset-bcm4908-usb.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCM_PMB) += reset-brcm-pmb.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
> diff --git a/drivers/reset/reset-bcm4908-usb.c b/drivers/reset/reset-bcm4908-usb.c
> new file mode 100644
> index 000000000000..e9b7d369c894
> --- /dev/null
> +++ b/drivers/reset/reset-bcm4908-usb.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2013 Broadcom
> + * Copyright (C) 2020 Rafał Miłecki <rafal@milecki.pl>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reset.h>
> +
> +#define BCM4908_USB_RESET_SETUP						0x0000
> +#define  BCM4908_USBH_IPP						(1<<5)
> +#define  BCM4908_USBH_IOC						(1<<4)
> +#define  BCM4908_USB2_OC_DISABLE_PORT0					(1<<28)
> +#define  BCM4908_USB2_OC_DISABLE_PORT1					(1<<29)
> +#define  BCM4908_USB3_OC_DISABLE_PORT0					(1<<30)
> +#define  BCM4908_USB3_OC_DISABLE_PORT1					(1<<31)
> +#define BCM4908_USB_RESET_PLL_CTL					0x0004
> +#define BCM4908_USB_RESET_FLADJ_VALUE					0x0008
> +#define BCM4908_USB_RESET_BRIDGE_CTL					0x000c
> +#define BCM4908_USB_RESET_SPARE1					0x0010
> +#define BCM4908_USB_RESET_MDIO						0x0014
> +#define BCM4908_USB_RESET_MDIO2						0x0018
> +#define BCM4908_USB_RESET_TEST_PORT_CONTROL				0x001c
> +#define BCM4908_USB_RESET_USB_SIMCTL					0x0020
> +#define  BCM4908_USBH_OHCI_MEM_REQ_DIS					(1<<1)
> +#define BCM4908_USB_RESET_USB_TESTCTL					0x0024
> +#define BCM4908_USB_RESET_USB_TESTMON					0x0028
> +#define BCM4908_USB_RESET_UTMI_CTL_1					0x002c
> +#define BCM4908_USB_RESET_SPARE2					0x0030
> +#define BCM4908_USB_RESET_USB_PM					0x0034
> +#define  BCM4908_XHC_SOFT_RESETB					(1<<22)
> +#define  BCM4908_USB_PWRDWN						(1<<31)
> +#define BCM4908_USB_RESET_USB_PM_STATUS					0x0038
> +#define BCM4908_USB_RESET_SPARE3					0x003c
> +#define BCM4908_USB_RESET_PLL_LDO_CTL					0x0040
> +#define BCM4908_USB_RESET_PLL_LDO_PLLBIAS				0x0044
> +#define BCM4908_USB_RESET_PLL_AFE_BG_CNTL				0x0048
> +#define BCM4908_USB_RESET_AFE_USBIO_TST					0x004c
> +#define BCM4908_USB_RESET_PLL_NDIV_FRAC					0x0050
> +#define BCM4908_USB_RESET_TP_DIAG					0x0054
> +#define BCM4908_USB_RESET_AHB_CAPTURE_FIFO				0x0058
> +#define BCM4908_USB_RESET_SPARE4					0x005c
> +#define BCM4908_USB_RESET_USB30_CTL1					0x0060
> +#define  BCM4908_PHY3_PLL_SEQ_START					(1<<4)
> +#define BCM4908_USB_RESET_USB30_CTL2					0x0064
> +#define BCM4908_USB_RESET_USB30_CTL3					0x0068
> +#define BCM4908_USB_RESET_USB30_CTL4					0x006c
> +#define BCM4908_USB_RESET_USB30_PCTL					0x0070
> +#define BCM4908_USB_RESET_USB30_CTL5					0x0074
> +#define BCM4908_USB_RESET_SPARE5					0x0078
> +#define BCM4908_USB_RESET_SPARE6					0x007c
> +#define BCM4908_USB_RESET_SPARE7					0x0080
> +#define BCM4908_USB_RESET_USB_DEVICE_CTL1				0x0090
> +#define BCM4908_USB_RESET_USB_DEVICE_CTL2				0x0094
> +#define BCM4908_USB_RESET_USB20_ID					0x0150
> +#define BCM4908_USB_RESET_USB30_ID					0x0154
> +#define BCM4908_USB_RESET_BDC_COREID					0x0158
> +#define BCM4908_USB_RESET_USB_REVID					0x015c
> +
> +struct bcm4908usb {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +	struct phy *usb2_phy;
> +	struct phy *usb3_phy;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static const struct regmap_config bcm4908_usb_reset_regmap_config = {
> +	.reg_bits =	32,
> +	.reg_stride =	4,
> +	.val_bits =	32,
> +	.fast_io =	true,
> +};
> +
> +static u32 bcm4908_usb_reset_read(struct bcm4908usb *usb, u32 reg)
> +{
> +	return readl(usb->base + reg);
> +}
> +
> +static void bcm4908_usb_reset_write(struct bcm4908usb *usb, u32 reg, u32 value)
> +{
> +	writel(value, usb->base + reg);
> +}
> +
> +static void bcm4908_usb_reset_update_bits(struct bcm4908usb *usb, u32 reg, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	WARN_ON(val & ~mask);
> +
> +	tmp = readl(usb->base + reg);
> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +	writel(tmp, usb->base + reg);
> +}
> +
> +static int bcm4908_usb_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct bcm4908usb *usb = container_of(rcdev, struct bcm4908usb, rcdev);
> +	struct device *dev = usb->dev;
> +	u32 val;
> +	int err;
> +
> +	err = reset_control_deassert(usb->reset);
> +	if (err) {
> +		dev_err(dev, "failed to deassert");
> +		return err;
> +	}
> +
> +	mdelay(1);
> +
> +	/* adjust over current & port power polarity */
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_SETUP,
> +				      BCM4908_USBH_IOC, BCM4908_USBH_IOC);
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_SETUP,
> +				      BCM4908_USBH_IPP, BCM4908_USBH_IPP);
> +
> +	/* enable USB PHYs */
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_USB_PM,
> +				      BCM4908_USB_PWRDWN, 0);
> +	mdelay(1);
> +
> +	err = phy_init(usb->usb3_phy);
> +	if (err) {
> +		dev_err(usb->dev, "failed to init USB 3.0 PHY: %d\n", err);
> +		return err;
> +	}
> +	mdelay(300);
> +
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_USB30_CTL1,
> +				      BCM4908_PHY3_PLL_SEQ_START, BCM4908_PHY3_PLL_SEQ_START);
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_USB_PM,
> +				      BCM4908_XHC_SOFT_RESETB, BCM4908_XHC_SOFT_RESETB);
> +
> +	err = phy_init(usb->usb2_phy);
> +	if (err) {
> +		dev_err(usb->dev, "failed to init USB 2.0 PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	/* no swap for data & descriptors */
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_BRIDGE_CTL, 0xf, 0);
> +
> +	/* reset host controllers for possible fake overcurrent indications */
> +	val = bcm4908_usb_reset_read(usb, BCM4908_USB_RESET_USB_PM);
> +	bcm4908_usb_reset_write(usb, BCM4908_USB_RESET_USB_PM, 0);
> +	bcm4908_usb_reset_write(usb, BCM4908_USB_RESET_USB_PM, val);
> +	mdelay(1);
> +
> +	/* TODO: erdy nump bypass */
> +
> +	/* Reduce accesses to DDR during USB idle time when Self-Refresh feature is compiled in */
> +	bcm4908_usb_reset_update_bits(usb, BCM4908_USB_RESET_USB_SIMCTL,
> +				      BCM4908_USBH_OHCI_MEM_REQ_DIS, BCM4908_USBH_OHCI_MEM_REQ_DIS);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops bcm4908_usb_reset_control_ops = {
> +	.deassert = bcm4908_usb_deassert,
> +};
> +
> +static int bcm4908_usb_reset_xlate(struct reset_controller_dev *rcdev,
> +				   const struct of_phandle_args *reset_spec)
> +{
> +	if (WARN_ON(reset_spec->args_count))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bcm4908_usb_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm4908usb *usb;
> +	int err;
> +
> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
> +	if (!usb)
> +		return -ENOMEM;
> +
> +	usb->dev = dev;
> +
> +	usb->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(usb->base))
> +		return PTR_ERR(usb->base);
> +
> +	usb->regmap = devm_regmap_init_mmio(dev, usb->base, &bcm4908_usb_reset_regmap_config);
> +	if (IS_ERR(usb->regmap)) {
> +		err = PTR_ERR(usb->regmap);
> +		dev_err(dev, "failed to init regmap: %d\n", err);
> +		return err;
> +	}
> +
> +	usb->reset = of_reset_control_array_get_optional_exclusive(usb->dev->of_node);
> +	if (IS_ERR(usb->reset)) {
> +		err = PTR_ERR(usb->reset);
> +		return err;
> +	}
> +
> +	usb->usb2_phy = devm_phy_get(dev, "usb2");
> +	if (IS_ERR(usb->usb2_phy)) {
> +		err = PTR_ERR(usb->usb2_phy);
> +		dev_err(dev, "Failed to get USB 2.0 PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	usb->usb3_phy = devm_phy_get(dev, "usb3");
> +	if (IS_ERR(usb->usb3_phy)) {
> +		err = PTR_ERR(usb->usb3_phy);
> +		dev_err(dev, "Failed to get USB 2.0 PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	usb->rcdev.ops = &bcm4908_usb_reset_control_ops;
> +	usb->rcdev.owner = THIS_MODULE;
> +	usb->rcdev.of_node = dev->of_node;
> +	usb->rcdev.of_reset_n_cells = 0;
> +	usb->rcdev.of_xlate = bcm4908_usb_reset_xlate;
> +
> +	return devm_reset_controller_register(dev, &usb->rcdev);
> +}
> +
> +static const struct of_device_id bcm4908_usb_reset_of_match[] = {
> +	{ .compatible = "brcm,bcm4908-usb-reset" },
> +	{ },
> +};
> +
> +static struct platform_driver bcm4908_usb_reset_driver = {
> +	.probe = bcm4908_usb_reset_probe,
> +	.driver = {
> +		.name	= "bcm4908-usb-reset",
> +		.of_match_table	= bcm4908_usb_reset_of_match,
> +	}
> +};
> +module_platform_driver(bcm4908_usb_reset_driver);
> +
> +MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, bcm4908_usb_reset_of_match);
