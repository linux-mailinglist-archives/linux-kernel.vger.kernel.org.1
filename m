Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439322DFF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLUSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgLUSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:06:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAEC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:06:09 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1krPZK-0008S6-TX; Mon, 21 Dec 2020 19:06:02 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1krPZH-0006Ar-4o; Mon, 21 Dec 2020 19:05:59 +0100
Date:   Mon, 21 Dec 2020 19:05:59 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <20201221180559.GA24909@pengutronix.de>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:49:09 up 19 days,  5:16, 60 users,  load average: 1.04, 0.49,
 0.23
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 12:24:51 +0530, Manish Narani wrote:
> Add a new driver for supporting Xilinx platforms. This driver is used
> for some sequence of operations required for Xilinx USB controllers.
> This driver is also used to choose between PIPE clock coming from SerDes
> and the Suspend Clock. Before the controller is out of reset, the clock
> selection should be changed to PIPE clock in order to make the USB
> controller work. There is a register added in Xilinx USB controller
> register space for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/dwc3/Kconfig          |   9 +
>  drivers/usb/dwc3/Makefile         |   1 +
>  drivers/usb/dwc3/dwc3-of-simple.c |   1 -
>  drivers/usb/dwc3/dwc3-xilinx.c    | 334 ++++++++++++++++++++++++++++++
>  4 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 7a2304565a73..0e00e6dfccd8 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -139,4 +139,13 @@ config USB_DWC3_QCOM
>  	  for peripheral mode support.
>  	  Say 'Y' or 'M' if you have one such device.
>  
> +config USB_DWC3_XILINX
> +	tristate "Xilinx Platforms"
> +	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> +	default USB_DWC3
> +	help
> +	  Support Xilinx SoCs with DesignWare Core USB3 IP.
> +	  This driver handles both ZynqMP and Versal SoC operations.
> +	  Say 'Y' or 'M' if you have one such device.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index ae86da0dc5bd..add567578b1f 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
>  obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
> +obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e62ecd22b3ed..71fd620c5161 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -172,7 +172,6 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
>  
>  static const struct of_device_id of_dwc3_simple_match[] = {
>  	{ .compatible = "rockchip,rk3399-dwc3" },
> -	{ .compatible = "xlnx,zynqmp-dwc3" },
>  	{ .compatible = "cavium,octeon-7130-usb-uctl" },
>  	{ .compatible = "sprd,sc9860-dwc3" },
>  	{ .compatible = "allwinner,sun50i-h6-dwc3" },
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> new file mode 100644
> index 000000000000..7e485951d2f7
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> + *
> + * Authors: Manish Narani <manish.narani@xilinx.com>
> + *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/of_address.h>
> +#include <linux/delay.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/io.h>
> +
> +#include <linux/phy/phy.h>
> +
> +/* USB phy reset mask register */
> +#define XLNX_USB_PHY_RST_EN			0x001C
> +#define XLNX_PHY_RST_MASK			0x1
> +
> +/* Xilinx USB 3.0 IP Register */
> +#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
> +#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
> +
> +/* Versal USB Reset ID */
> +#define VERSAL_USB_RESET_ID			0xC104036
> +
> +#define XLNX_USB_FPD_PIPE_CLK			0x7c
> +#define PIPE_CLK_DESELECT			1
> +#define PIPE_CLK_SELECT				0
> +#define XLNX_USB_FPD_POWER_PRSNT		0x80
> +#define PIPE_POWER_ON				1
> +#define PIPE_POWER_OFF				0

Don't use values for the defines, but rather define the bit. Its name in the
register reference is "option". Therefore, define it as

	#define FPD_POWER_PRSNT_OPTION			BIT(0)

and set/unset the bit in the code. The same for the other registers/bits.

> +
> +struct dwc3_xlnx {
> +	int				num_clocks;
> +	struct clk_bulk_data		*clks;
> +	struct device			*dev;
> +	void __iomem			*regs;
> +	int				(*pltfm_init)(struct dwc3_xlnx *data);
> +};
> +
> +static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable ULPI PHY reset from USB Controller.
> +	 * This does not actually reset the phy, but just controls
> +	 * whether USB controller can or cannot reset ULPI PHY.
> +	 */
> +	reg = readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
> +
> +	if (mask)
> +		reg &= ~XLNX_PHY_RST_MASK;
> +	else
> +		reg |= XLNX_PHY_RST_MASK;
> +
> +	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
> +}
> +
> +static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> +{
> +	struct device		*dev = priv_data->dev;
> +	int			ret;
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, false);
> +
> +	/* Assert and De-assert reset */
> +	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_ASSERT);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to assert Reset\n");
> +		return ret;
> +	}
> +
> +	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_RELEASE);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
> +		return ret;
> +	}
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, true);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> +{
> +	struct device		*dev = priv_data->dev;
> +	struct reset_control	*crst, *hibrst, *apbrst;
> +	struct phy		*usb3_phy;
> +	int			ret;
> +	u32			reg;
> +
> +	crst = devm_reset_control_get_exclusive(dev, "usb_crst");

The resets and reset-names are not documented in the dt-binding.

> +	if (IS_ERR(crst)) {
> +		ret = PTR_ERR(crst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get core reset signal\n");
> +		goto err;
> +	}
> +
> +	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
> +	if (IS_ERR(hibrst)) {
> +		ret = PTR_ERR(hibrst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get hibernation reset signal\n");
> +		goto err;
> +	}
> +
> +	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
> +	if (IS_ERR(apbrst)) {
> +		ret = PTR_ERR(apbrst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get APB reset signal\n");
> +		goto err;
> +	}
> +
> +	ret = reset_control_assert(crst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert core reset\n");
> +		goto err;
> +	}
> +
> +	ret = reset_control_assert(hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert hibernation reset\n");
> +		goto err;
> +	}
> +
> +	ret = reset_control_assert(apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert APB reset\n");
> +		goto err;
> +	}
> +
> +	usb3_phy = devm_phy_get(dev, "usb3-phy");

Error handling is missing.

The "usb3-phy" phy binding in not documented in the dt-binding.

Thanks,

Michael

> +
> +	ret = phy_init(usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(usb3_phy);
> +		goto err;
> +	}
> +
> +	ret = reset_control_deassert(apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release APB reset\n");
> +		goto err;
> +	}
> +
> +	/* Set PIPE Power Present signal in FPD Power Present Register*/
> +	writel(PIPE_POWER_ON, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
> +
> +	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
> +	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
> +
> +	ret = reset_control_deassert(crst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release core reset\n");
> +		goto err;
> +	}
> +
> +	ret = reset_control_deassert(hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release hibernation reset\n");
> +		goto err;
> +	}
> +
> +	ret = phy_power_on(usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(usb3_phy);
> +		goto err;
> +	}
> +
> +	/*
> +	 * This routes the USB DMA traffic to go through FPD path instead
> +	 * of reaching DDR directly. This traffic routing is needed to
> +	 * make SMMU and CCI work with USB DMA.
> +	 */
> +	if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
> +		reg = readl(priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> +		reg |= XLNX_USB_TRAFFIC_ROUTE_FPD;
> +		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> +	}
> +
> +err:
> +	return ret;
> +}
> +
> +static const struct of_device_id dwc3_xlnx_of_match[] = {
> +	{
> +		.compatible = "xlnx,zynqmp-dwc3",
> +		.data = &dwc3_xlnx_init_zynqmp,
> +	},
> +	{
> +		.compatible = "xlnx,versal-dwc3",
> +		.data = &dwc3_xlnx_init_versal,
> +	},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
> +
> +static int dwc3_xlnx_probe(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx		*priv_data;
> +	struct device			*dev = &pdev->dev;
> +	struct device_node		*np = dev->of_node;
> +	const struct of_device_id	*match;
> +	void __iomem			*regs;
> +	int				ret;
> +
> +	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs)) {
> +		ret = PTR_ERR(regs);
> +		dev_err_probe(dev, ret, "failed to map registers\n");
> +		return ret;
> +	}
> +
> +	match = of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
> +
> +	priv_data->pltfm_init = match->data;
> +	priv_data->regs = regs;
> +	priv_data->dev = dev;
> +
> +	platform_set_drvdata(pdev, priv_data);
> +
> +	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv_data->num_clocks = ret;
> +
> +	ret = clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = priv_data->pltfm_init(priv_data);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	ret = of_platform_populate(np, NULL, NULL, dev);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_suspend_ignore_children(dev, false);
> +	pm_runtime_get_sync(dev);
> +
> +	return 0;
> +
> +err_clk_put:
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +
> +	return ret;
> +}
> +
> +static int dwc3_xlnx_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
> +	struct device		*dev = &pdev->dev;
> +
> +	of_platform_depopulate(dev);
> +
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +	priv_data->num_clocks = 0;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
> +{
> +	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
> +{
> +	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> +}
> +
> +static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_common,
> +			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
> +
> +static struct platform_driver dwc3_xlnx_driver = {
> +	.probe		= dwc3_xlnx_probe,
> +	.remove		= dwc3_xlnx_remove,
> +	.driver		= {
> +		.name		= "dwc3-xilinx",
> +		.of_match_table	= dwc3_xlnx_of_match,
> +		.pm		= &dwc3_xlnx_dev_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(dwc3_xlnx_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
> +MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
> +MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Michael Tretter             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
