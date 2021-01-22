Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565F92FFDE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAVIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbhAVIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:09:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737BC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:08:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l2rUt-00024o-NG; Fri, 22 Jan 2021 09:08:47 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1l2rUs-0006Nv-MA; Fri, 22 Jan 2021 09:08:46 +0100
Date:   Fri, 22 Jan 2021 09:08:46 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, git@xilinx.com,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <20210122080846.GI12316@pengutronix.de>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <20210118134223.GE12316@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:03:50 up 50 days, 20:30, 78 users,  load average: 0.40, 0.51,
 0.28
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, Jan 18, 2021 at 02:42:24PM +0100, Michael Grzeschik wrote:
>Hi!
>
>On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
>>Add a new driver for supporting Xilinx platforms. This driver is used
>>for some sequence of operations required for Xilinx USB controllers.
>>This driver is also used to choose between PIPE clock coming from SerDes
>>and the Suspend Clock. Before the controller is out of reset, the clock
>>selection should be changed to PIPE clock in order to make the USB
>>controller work. There is a register added in Xilinx USB controller
>>register space for the same.
>
>I tried out this driver with the vanilla kernel on an zynqmp. Without
>this patch the USB-Gadget is already acting buggy. In the gadget mode,
>some iterations of plug/unplug results to an stalled gadget which will
>never come back without a reboot.
>
>With the corresponding code of this driver (reset assert, clk modify,
>reset deassert) in the downstream kernels phy driver we found out it is
>totaly stable. But using this exact glue driver which should do the same
>as the downstream code, the gadget still was buggy the way described
>above.
>
>I suspect the difference lays in the different order of operations.
>While the downstream code is runing the resets inside the phy driver
>which is powered and initialized in the dwc3-core itself. With this glue
>layser approach of this patch the whole phy init is done before even
>touching dwc3-core in any way. It seems not to have the same effect,
>though.
>
>If really the order of operations is limiting us, we probably need
>another solution than this glue layer. Any Ideas?

I found out what the difference between the Downstream and this
Glue is. When using vanilla with this Glue code we may not set
the following bit:

https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-re=
gisters.html#usb3_regs___fpd_power_prsnt.html

>>+	/* Set PIPE Power Present signal in FPD Power Present Register*/
>>+	writel(PIPE_POWER_ON, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);

When I comment this out, the link stays stable. This is different in
the Downstream Xilinx Kernel, where the bit is also set but has no
negativ effect.

Manish, can you give me a pointer what to look for?
So setting this will also work with mainline?

Regards,
Michael

>>
>>Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>>---
>>drivers/usb/dwc3/Kconfig          |   9 +
>>drivers/usb/dwc3/Makefile         |   1 +
>>drivers/usb/dwc3/dwc3-of-simple.c |   1 -
>>drivers/usb/dwc3/dwc3-xilinx.c    | 334 ++++++++++++++++++++++++++++++
>>4 files changed, 344 insertions(+), 1 deletion(-)
>>create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
>>
>>diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>>index 7a2304565a73..0e00e6dfccd8 100644
>>--- a/drivers/usb/dwc3/Kconfig
>>+++ b/drivers/usb/dwc3/Kconfig
>>@@ -139,4 +139,13 @@ config USB_DWC3_QCOM
>>	  for peripheral mode support.
>>	  Say 'Y' or 'M' if you have one such device.
>>
>>+config USB_DWC3_XILINX
>>+	tristate "Xilinx Platforms"
>>+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
>>+	default USB_DWC3
>>+	help
>>+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
>>+	  This driver handles both ZynqMP and Versal SoC operations.
>>+	  Say 'Y' or 'M' if you have one such device.
>>+
>>endif
>>diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
>>index ae86da0dc5bd..add567578b1f 100644
>>--- a/drivers/usb/dwc3/Makefile
>>+++ b/drivers/usb/dwc3/Makefile
>>@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+=3D dwc3-meson-g12a.o
>>obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
>>obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
>>obj-$(CONFIG_USB_DWC3_QCOM)		+=3D dwc3-qcom.o
>>+obj-$(CONFIG_USB_DWC3_XILINX)		+=3D dwc3-xilinx.o
>>diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of=
-simple.c
>>index e62ecd22b3ed..71fd620c5161 100644
>>--- a/drivers/usb/dwc3/dwc3-of-simple.c
>>+++ b/drivers/usb/dwc3/dwc3-of-simple.c
>>@@ -172,7 +172,6 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_=
ops =3D {
>>
>>static const struct of_device_id of_dwc3_simple_match[] =3D {
>>	{ .compatible =3D "rockchip,rk3399-dwc3" },
>>-	{ .compatible =3D "xlnx,zynqmp-dwc3" },
>>	{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
>>	{ .compatible =3D "sprd,sc9860-dwc3" },
>>	{ .compatible =3D "allwinner,sun50i-h6-dwc3" },
>>diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilin=
x.c
>>new file mode 100644
>>index 000000000000..7e485951d2f7
>>--- /dev/null
>>+++ b/drivers/usb/dwc3/dwc3-xilinx.c
>>@@ -0,0 +1,334 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/**
>>+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
>>+ *
>>+ * Authors: Manish Narani <manish.narani@xilinx.com>
>>+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>+ */
>>+
>>+#include <linux/module.h>
>>+#include <linux/kernel.h>
>>+#include <linux/slab.h>
>>+#include <linux/clk.h>
>>+#include <linux/of.h>
>>+#include <linux/platform_device.h>
>>+#include <linux/dma-mapping.h>
>>+#include <linux/of_platform.h>
>>+#include <linux/pm_runtime.h>
>>+#include <linux/reset.h>
>>+#include <linux/of_address.h>
>>+#include <linux/delay.h>
>>+#include <linux/firmware/xlnx-zynqmp.h>
>>+#include <linux/io.h>
>>+
>>+#include <linux/phy/phy.h>
>>+
>>+/* USB phy reset mask register */
>>+#define XLNX_USB_PHY_RST_EN			0x001C
>>+#define XLNX_PHY_RST_MASK			0x1
>>+
>>+/* Xilinx USB 3.0 IP Register */
>>+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
>>+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
>>+
>>+/* Versal USB Reset ID */
>>+#define VERSAL_USB_RESET_ID			0xC104036
>>+
>>+#define XLNX_USB_FPD_PIPE_CLK			0x7c
>>+#define PIPE_CLK_DESELECT			1
>>+#define PIPE_CLK_SELECT				0
>>+#define XLNX_USB_FPD_POWER_PRSNT		0x80
>>+#define PIPE_POWER_ON				1
>>+#define PIPE_POWER_OFF				0
>>+
>>+struct dwc3_xlnx {
>>+	int				num_clocks;
>>+	struct clk_bulk_data		*clks;
>>+	struct device			*dev;
>>+	void __iomem			*regs;
>>+	int				(*pltfm_init)(struct dwc3_xlnx *data);
>>+};
>>+
>>+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mas=
k)
>>+{
>>+	u32 reg;
>>+
>>+	/*
>>+	 * Enable or disable ULPI PHY reset from USB Controller.
>>+	 * This does not actually reset the phy, but just controls
>>+	 * whether USB controller can or cannot reset ULPI PHY.
>>+	 */
>>+	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
>>+
>>+	if (mask)
>>+		reg &=3D ~XLNX_PHY_RST_MASK;
>>+	else
>>+		reg |=3D XLNX_PHY_RST_MASK;
>>+
>>+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
>>+}
>>+
>>+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
>>+{
>>+	struct device		*dev =3D priv_data->dev;
>>+	int			ret;
>>+
>>+	dwc3_xlnx_mask_phy_rst(priv_data, false);
>>+
>>+	/* Assert and De-assert reset */
>>+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
>>+				     PM_RESET_ACTION_ASSERT);
>>+	if (ret < 0) {
>>+		dev_err_probe(dev, ret, "failed to assert Reset\n");
>>+		return ret;
>>+	}
>>+
>>+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
>>+				     PM_RESET_ACTION_RELEASE);
>>+	if (ret < 0) {
>>+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
>>+		return ret;
>>+	}
>>+
>>+	dwc3_xlnx_mask_phy_rst(priv_data, true);
>>+
>>+	return 0;
>>+}
>>+
>>+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>+{
>>+	struct device		*dev =3D priv_data->dev;
>>+	struct reset_control	*crst, *hibrst, *apbrst;
>>+	struct phy		*usb3_phy;
>>+	int			ret;
>>+	u32			reg;
>>+
>>+	crst =3D devm_reset_control_get_exclusive(dev, "usb_crst");
>>+	if (IS_ERR(crst)) {
>>+		ret =3D PTR_ERR(crst);
>>+		dev_err_probe(dev, ret,
>>+			      "failed to get core reset signal\n");
>>+		goto err;
>>+	}
>>+
>>+	hibrst =3D devm_reset_control_get_exclusive(dev, "usb_hibrst");
>>+	if (IS_ERR(hibrst)) {
>>+		ret =3D PTR_ERR(hibrst);
>>+		dev_err_probe(dev, ret,
>>+			      "failed to get hibernation reset signal\n");
>>+		goto err;
>>+	}
>>+
>>+	apbrst =3D devm_reset_control_get_exclusive(dev, "usb_apbrst");
>>+	if (IS_ERR(apbrst)) {
>>+		ret =3D PTR_ERR(apbrst);
>>+		dev_err_probe(dev, ret,
>>+			      "failed to get APB reset signal\n");
>>+		goto err;
>>+	}
>>+
>>+	ret =3D reset_control_assert(crst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to assert core reset\n");
>>+		goto err;
>>+	}
>>+
>>+	ret =3D reset_control_assert(hibrst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to assert hibernation reset\n");
>>+		goto err;
>>+	}
>>+
>>+	ret =3D reset_control_assert(apbrst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to assert APB reset\n");
>>+		goto err;
>>+	}
>>+
>>+	usb3_phy =3D devm_phy_get(dev, "usb3-phy");
>>+
>>+	ret =3D phy_init(usb3_phy);
>>+	if (ret < 0) {
>>+		phy_exit(usb3_phy);
>>+		goto err;
>>+	}
>>+
>>+	ret =3D reset_control_deassert(apbrst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to release APB reset\n");
>>+		goto err;
>>+	}
>>+
>>+	/* Set PIPE Power Present signal in FPD Power Present Register*/
>>+	writel(PIPE_POWER_ON, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);

This is somehow leading to an unstable link when using vanilla.

>>+
>>+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
>>+	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
>>+
>>+	ret =3D reset_control_deassert(crst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to release core reset\n");
>>+		goto err;
>>+	}
>>+
>>+	ret =3D reset_control_deassert(hibrst);
>>+	if (ret < 0) {
>>+		dev_err(dev, "Failed to release hibernation reset\n");
>>+		goto err;
>>+	}
>>+
>>+	ret =3D phy_power_on(usb3_phy);
>>+	if (ret < 0) {
>>+		phy_exit(usb3_phy);
>>+		goto err;
>>+	}
>>+
>>+	/*
>>+	 * This routes the USB DMA traffic to go through FPD path instead
>>+	 * of reaching DDR directly. This traffic routing is needed to
>>+	 * make SMMU and CCI work with USB DMA.
>>+	 */
>>+	if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
>>+		reg =3D readl(priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
>>+		reg |=3D XLNX_USB_TRAFFIC_ROUTE_FPD;
>>+		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
>>+	}
>>+
>>+err:
>>+	return ret;
>>+}
>>+
>>+static const struct of_device_id dwc3_xlnx_of_match[] =3D {
>>+	{
>>+		.compatible =3D "xlnx,zynqmp-dwc3",
>>+		.data =3D &dwc3_xlnx_init_zynqmp,
>>+	},
>>+	{
>>+		.compatible =3D "xlnx,versal-dwc3",
>>+		.data =3D &dwc3_xlnx_init_versal,
>>+	},
>>+	{ /* Sentinel */ }
>>+};
>>+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
>>+
>>+static int dwc3_xlnx_probe(struct platform_device *pdev)
>>+{
>>+	struct dwc3_xlnx		*priv_data;
>>+	struct device			*dev =3D &pdev->dev;
>>+	struct device_node		*np =3D dev->of_node;
>>+	const struct of_device_id	*match;
>>+	void __iomem			*regs;
>>+	int				ret;
>>+
>>+	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
>>+	if (!priv_data)
>>+		return -ENOMEM;
>>+
>>+	regs =3D devm_platform_ioremap_resource(pdev, 0);
>>+	if (IS_ERR(regs)) {
>>+		ret =3D PTR_ERR(regs);
>>+		dev_err_probe(dev, ret, "failed to map registers\n");
>>+		return ret;
>>+	}
>>+
>>+	match =3D of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
>>+
>>+	priv_data->pltfm_init =3D match->data;
>>+	priv_data->regs =3D regs;
>>+	priv_data->dev =3D dev;
>>+
>>+	platform_set_drvdata(pdev, priv_data);
>>+
>>+	ret =3D devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
>>+	if (ret < 0)
>>+		return ret;
>>+
>>+	priv_data->num_clocks =3D ret;
>>+
>>+	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
>>+	if (ret)
>>+		return ret;
>>+
>>+	ret =3D priv_data->pltfm_init(priv_data);
>>+	if (ret)
>>+		goto err_clk_put;
>>+
>>+	ret =3D of_platform_populate(np, NULL, NULL, dev);
>>+	if (ret)
>>+		goto err_clk_put;
>>+
>>+	pm_runtime_set_active(dev);
>>+	pm_runtime_enable(dev);
>>+	pm_suspend_ignore_children(dev, false);
>>+	pm_runtime_get_sync(dev);
>>+
>>+	return 0;
>>+
>>+err_clk_put:
>>+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
>>+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
>>+
>>+	return ret;
>>+}
>>+
>>+static int dwc3_xlnx_remove(struct platform_device *pdev)
>>+{
>>+	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
>>+	struct device		*dev =3D &pdev->dev;
>>+
>>+	of_platform_depopulate(dev);
>>+
>>+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
>>+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
>>+	priv_data->num_clocks =3D 0;
>>+
>>+	pm_runtime_disable(dev);
>>+	pm_runtime_put_noidle(dev);
>>+	pm_runtime_set_suspended(dev);
>>+
>>+	return 0;
>>+}
>>+
>>+static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
>>+{
>>+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
>>+
>>+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
>>+
>>+	return 0;
>>+}
>>+
>>+static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
>>+{
>>+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
>>+
>>+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
>>+}
>>+
>>+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
>>+{
>>+	pm_runtime_mark_last_busy(dev);
>>+	pm_runtime_autosuspend(dev);
>>+
>>+	return 0;
>>+}
>>+
>>+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_comm=
on,
>>+			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
>>+
>>+static struct platform_driver dwc3_xlnx_driver =3D {
>>+	.probe		=3D dwc3_xlnx_probe,
>>+	.remove		=3D dwc3_xlnx_remove,
>>+	.driver		=3D {
>>+		.name		=3D "dwc3-xilinx",
>>+		.of_match_table	=3D dwc3_xlnx_of_match,
>>+		.pm		=3D &dwc3_xlnx_dev_pm_ops,
>>+	},
>>+};
>>+
>>+module_platform_driver(dwc3_xlnx_driver);
>>+
>>+MODULE_LICENSE("GPL v2");
>>+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
>>+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
>>+MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
>>--=20
>>2.17.1
>>
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>--=20
>Pengutronix e.K.                           |                             |
>Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmAKiAsACgkQC+njFXoe
LGQ/CA/9FPPfJxU3RV3pXZWQ87v5+EIATxcE16QRsW47jIMIhfNZU66e82b8SADK
5Y6pyuUty80P7u0alDqDxC6z3zD93Mf9D3vKkeOBR2MkQEtGGjhuzpbqAX8c2Bfd
dmd1IIggTk5w1V2dRk+XmFbmni+VddQmXqx0BSLabB0HojxFLNCEoJs+XGL19Kx7
GL6Mjx1I5ECSE/+WIcH0xaUsMdzjHOvOEppBhDUEyQ6pL3TrPmq/XSBRdku6ZmmE
F1D8YOcFtvjF3bGJChxD75VcO0i9gIUs3hTSpH2+ZNs77FQ4tnOkFivLj1k0CpI3
npeOBRlMDc8gWkBRreQAiCi4mHO7TXYw854LD8lNeHzLrZOZ8EGN2/fJ0XPb+l1c
bLIFswS/y5U2nRyfX2aqTqHLdDdygL0u0pcC840sQfgxqZoCUQcd9z/PeFyW8fTH
QLG4vSD8fxI8KFY4rXQ3f2eV4zEPBgm6KZbTEsEkLLdhqWOo3Kk3xvtm8sH+yNNn
Xfj+USC3h+b7jfxJ1ywJOi8ZpJy9aS55TaYTlHPcgYETsHxy7gi3llJQfhvJm+t1
VfcG0HaQ6yRnS0C9TF4Q7ydyaww0t58tFnLV91N8OU/KvJ/CFa0T4243tWjpFndD
GjHz4CxMbSPugNsrlyK7CxprVm4m0sDuLkU2eodrIUK4pakiVZM=
=eWqi
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
