Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCEB2DA855
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgLOG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:58:07 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:55210
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgLOG4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwm4yNbDhSnKCjYgEK73o+9UsWefhoPlYd4FuZCai0648lJxLLOFHo9ZIumCOld8anusj6oV0we8b4+FVFZBWWs9Nx7BggKe8G359T1pO3iyBrxXFyFKXSwiY/6dlGHGKOgERqfFeJgISNascy+WA/hMBv75AAAASzrhdMWk64IQW5eREL6yRbFZW/9oas2pGvBEbu46ExTrgT09qElLZ1TBjxM42UqdP0Tg/A/nRqGBHdshxnLZQiNWMyDZKcAC4qjDCc3MdTTK6WSrtscELUF9CYbgo8KyIewwY2IYFyU5/kvJuKx6d6WGBepJe+9/AfghqX/UaZnFml7Thy/A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pa9OkRjqkYr9t0+3B8TynpOYrDRdr0YOTzoudfWp1E=;
 b=SvnB4LY66OK+E5QWNTjhllidagzJmWqzDv52MaF0B+h/WQ2S4mK/Npb30fbgHkyYYGtph7sQFBqzXe3B5RM2n+UIJDsJgmmHG21rb51rJZwGbgqBDFPYj/JPEcIvdO+v7H75DK0ldqWu5zr1RZDKO7BYcx2O04y+O/D2kbunuBFtmG18C1cww7Hi0Z/neygmrx00duKm3TTTQQ89YYuEpw2R3WhL9rJBabqBffRXiUb2/sIyIyHjormgsni7lxnLnNuyf+GTSxUTm76wxZ2ZX0/4f3ErNrRtY3LZTBh1zud32H++a07r2ssl3PmyBrwksZR/4eDV+2n2sQPKklgeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pa9OkRjqkYr9t0+3B8TynpOYrDRdr0YOTzoudfWp1E=;
 b=qL19+Pvqkxr2iRNZ5Sc3R1AyT8ian9ZFtLtBP4MWGNoAaI5MjMylv93rchhFGoguYsufbQ7nY4Pjq3mFbFCP185EvoLMcR/TgaexZkc7Gffpc5hsh7L2BtibvPReeSzS53Zru7Nakfn0+ZSlwEIyeGeq9ICsx8t9epQB2yy/68c=
Received: from CY1PR03CA0039.namprd03.prod.outlook.com (2603:10b6:600::49) by
 BYAPR02MB4662.namprd02.prod.outlook.com (2603:10b6:a03:44::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Tue, 15 Dec 2020 06:55:40 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::c1) by CY1PR03CA0039.outlook.office365.com
 (2603:10b6:600::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 15 Dec 2020 06:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 06:55:40 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 14 Dec 2020 22:55:21 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 14 Dec 2020 22:55:21 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=59607 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kp4Ey-0006Id-Dv; Mon, 14 Dec 2020 22:55:21 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4A03C1222C5; Tue, 15 Dec 2020 12:24:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Date:   Tue, 15 Dec 2020 12:24:51 +0530
Message-ID: <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc3dfc09-c6b1-47e0-a3a3-08d8a0c66f21
X-MS-TrafficTypeDiagnostic: BYAPR02MB4662:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4662E50EC69A45631E60E62EC1C60@BYAPR02MB4662.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxoRTm3gtiVsQf5u1Ffbq6CEAFccdEt3de5T14gGP0eJHTJx66LDMnk38exRHUdzykQlyfBe8IQC18cnBqT6Z9cJs9fDn4UR1rukYXNQx1fZWFy4a3HtGhJsM/MfBoHy92HFK6sx5VlRFfwX5f3b586W+1uG+UAbRzPB+8YOlHt1iw/ei/n4YvPy7cuY5WXlGfnXuBN7O3s8QG6V301i99HPUTvKdi/iCOTelrYJivvSfS/WDaP5OORgl414JMKFTp4/fF/HtkOd1r80ybWtfnHDj/VFH0S3+CHlVGLgIU3N5ptw3kSDp7G7TuAyuNfaCULN8sTuZz3bu94Y28GAkJiSnvirJ2I3lga3kOkGiUCXdtimHl1vCGgu+w3VfRyoOurYBmKdkfhEk3ijCKcZ9rdNRN8vQvqjZHtxkNQoTQo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(46966005)(6266002)(426003)(36756003)(8936002)(186003)(30864003)(70586007)(336012)(8676002)(70206006)(4326008)(2616005)(47076004)(36906005)(508600001)(7636003)(44832011)(2906002)(5660300002)(356005)(110136005)(26005)(42186006)(54906003)(107886003)(82310400003)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 06:55:40.0749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3dfc09-c6b1-47e0-a3a3-08d8a0c66f21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4662
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for supporting Xilinx platforms. This driver is used
for some sequence of operations required for Xilinx USB controllers.
This driver is also used to choose between PIPE clock coming from SerDes
and the Suspend Clock. Before the controller is out of reset, the clock
selection should be changed to PIPE clock in order to make the USB
controller work. There is a register added in Xilinx USB controller
register space for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/dwc3/Kconfig          |   9 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c    | 334 ++++++++++++++++++++++++++++++
 4 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 7a2304565a73..0e00e6dfccd8 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -139,4 +139,13 @@ config USB_DWC3_QCOM
 	  for peripheral mode support.
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_XILINX
+	tristate "Xilinx Platforms"
+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+	default USB_DWC3
+	help
+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
+	  This driver handles both ZynqMP and Versal SoC operations.
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index ae86da0dc5bd..add567578b1f 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
+obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b3ed..71fd620c5161 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -172,7 +172,6 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 
 static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "rockchip,rk3399-dwc3" },
-	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
new file mode 100644
index 000000000000..7e485951d2f7
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
+ *
+ * Authors: Manish Narani <manish.narani@xilinx.com>
+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/io.h>
+
+#include <linux/phy/phy.h>
+
+/* USB phy reset mask register */
+#define XLNX_USB_PHY_RST_EN			0x001C
+#define XLNX_PHY_RST_MASK			0x1
+
+/* Xilinx USB 3.0 IP Register */
+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
+
+/* Versal USB Reset ID */
+#define VERSAL_USB_RESET_ID			0xC104036
+
+#define XLNX_USB_FPD_PIPE_CLK			0x7c
+#define PIPE_CLK_DESELECT			1
+#define PIPE_CLK_SELECT				0
+#define XLNX_USB_FPD_POWER_PRSNT		0x80
+#define PIPE_POWER_ON				1
+#define PIPE_POWER_OFF				0
+
+struct dwc3_xlnx {
+	int				num_clocks;
+	struct clk_bulk_data		*clks;
+	struct device			*dev;
+	void __iomem			*regs;
+	int				(*pltfm_init)(struct dwc3_xlnx *data);
+};
+
+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
+{
+	u32 reg;
+
+	/*
+	 * Enable or disable ULPI PHY reset from USB Controller.
+	 * This does not actually reset the phy, but just controls
+	 * whether USB controller can or cannot reset ULPI PHY.
+	 */
+	reg = readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
+
+	if (mask)
+		reg &= ~XLNX_PHY_RST_MASK;
+	else
+		reg |= XLNX_PHY_RST_MASK;
+
+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
+}
+
+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
+{
+	struct device		*dev = priv_data->dev;
+	int			ret;
+
+	dwc3_xlnx_mask_phy_rst(priv_data, false);
+
+	/* Assert and De-assert reset */
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_ASSERT);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to assert Reset\n");
+		return ret;
+	}
+
+	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
+				     PM_RESET_ACTION_RELEASE);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
+		return ret;
+	}
+
+	dwc3_xlnx_mask_phy_rst(priv_data, true);
+
+	return 0;
+}
+
+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
+{
+	struct device		*dev = priv_data->dev;
+	struct reset_control	*crst, *hibrst, *apbrst;
+	struct phy		*usb3_phy;
+	int			ret;
+	u32			reg;
+
+	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
+	if (IS_ERR(crst)) {
+		ret = PTR_ERR(crst);
+		dev_err_probe(dev, ret,
+			      "failed to get core reset signal\n");
+		goto err;
+	}
+
+	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
+	if (IS_ERR(hibrst)) {
+		ret = PTR_ERR(hibrst);
+		dev_err_probe(dev, ret,
+			      "failed to get hibernation reset signal\n");
+		goto err;
+	}
+
+	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
+	if (IS_ERR(apbrst)) {
+		ret = PTR_ERR(apbrst);
+		dev_err_probe(dev, ret,
+			      "failed to get APB reset signal\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert hibernation reset\n");
+		goto err;
+	}
+
+	ret = reset_control_assert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert APB reset\n");
+		goto err;
+	}
+
+	usb3_phy = devm_phy_get(dev, "usb3-phy");
+
+	ret = phy_init(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	ret = reset_control_deassert(apbrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release APB reset\n");
+		goto err;
+	}
+
+	/* Set PIPE Power Present signal in FPD Power Present Register*/
+	writel(PIPE_POWER_ON, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
+
+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
+	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+
+	ret = reset_control_deassert(crst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release core reset\n");
+		goto err;
+	}
+
+	ret = reset_control_deassert(hibrst);
+	if (ret < 0) {
+		dev_err(dev, "Failed to release hibernation reset\n");
+		goto err;
+	}
+
+	ret = phy_power_on(usb3_phy);
+	if (ret < 0) {
+		phy_exit(usb3_phy);
+		goto err;
+	}
+
+	/*
+	 * This routes the USB DMA traffic to go through FPD path instead
+	 * of reaching DDR directly. This traffic routing is needed to
+	 * make SMMU and CCI work with USB DMA.
+	 */
+	if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
+		reg = readl(priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+		reg |= XLNX_USB_TRAFFIC_ROUTE_FPD;
+		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+	}
+
+err:
+	return ret;
+}
+
+static const struct of_device_id dwc3_xlnx_of_match[] = {
+	{
+		.compatible = "xlnx,zynqmp-dwc3",
+		.data = &dwc3_xlnx_init_zynqmp,
+	},
+	{
+		.compatible = "xlnx,versal-dwc3",
+		.data = &dwc3_xlnx_init_versal,
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
+
+static int dwc3_xlnx_probe(struct platform_device *pdev)
+{
+	struct dwc3_xlnx		*priv_data;
+	struct device			*dev = &pdev->dev;
+	struct device_node		*np = dev->of_node;
+	const struct of_device_id	*match;
+	void __iomem			*regs;
+	int				ret;
+
+	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		dev_err_probe(dev, ret, "failed to map registers\n");
+		return ret;
+	}
+
+	match = of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
+
+	priv_data->pltfm_init = match->data;
+	priv_data->regs = regs;
+	priv_data->dev = dev;
+
+	platform_set_drvdata(pdev, priv_data);
+
+	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
+	if (ret < 0)
+		return ret;
+
+	priv_data->num_clocks = ret;
+
+	ret = clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
+	if (ret)
+		return ret;
+
+	ret = priv_data->pltfm_init(priv_data);
+	if (ret)
+		goto err_clk_put;
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		goto err_clk_put;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_suspend_ignore_children(dev, false);
+	pm_runtime_get_sync(dev);
+
+	return 0;
+
+err_clk_put:
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+
+	return ret;
+}
+
+static int dwc3_xlnx_remove(struct platform_device *pdev)
+{
+	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
+	struct device		*dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+
+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
+	priv_data->num_clocks = 0;
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+}
+
+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_common,
+			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
+
+static struct platform_driver dwc3_xlnx_driver = {
+	.probe		= dwc3_xlnx_probe,
+	.remove		= dwc3_xlnx_remove,
+	.driver		= {
+		.name		= "dwc3-xilinx",
+		.of_match_table	= dwc3_xlnx_of_match,
+		.pm		= &dwc3_xlnx_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_xlnx_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
+MODULE_AUTHOR("Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>");
-- 
2.17.1

