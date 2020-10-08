Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01C2874E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgJHNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:07:42 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:42817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730322AbgJHNHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+Ky+5ni9uAcNhtKXWtVq/tYQRomqIYVXunS7p+Otasj1cHOgzj/jNEqicgzjruACHq8ckDCQM0aA9uoIa0pNpd3EKHzrukELGOOrFuS/O2SzsmBoW7w83GryxUEF1Gviv+47I2TV/7N4gzztsO+KsUhmrpEUDv9L7bTXQlR31Q6YXQW05N0PfmVyNUnjfeZW8/CRiXET0rbC1xbBpfX8SX6mm9S8sWWFWwo8LwGm7k/8/2RblqVJXHovV3PyfPPdzgPG+Qsq02BROqjPBJIUBodI9tReprJHBuIYbU/QV+gH47JIPjF0X14e+SoKveizDS9nDkCeaxLvTUFCirTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WYPMeu4SXiMDUBFH0jpPYq+vQ6/ocF8+/zIOJ/+eCU=;
 b=L/t/X28YJA+X58XtyJUQsGYAsWl+uOVnHSO7xx86jfafIaOc9gBcwlHkBO/UbuP2qFi0GUXh0oCwEWhwvnZc+Ct1mqRG+/QCv5Z6zQjZyxkJO8ePgDTpm+ZzCxkX/9CJyO2qjks908CUWG71+FiunbVvfWCtb4h549o5elnmBh5e5BebMkyXDh/XaYHY7cuHtsyY94llZJ1koehVaNS2Vfo4ZGpvRzIpOqYN5caykWHPFKcOHlGsBotGdRke4p0cxWZwOGJ0j/tlGYav4ZtNcv9F98VTgIPmUoqMoibOsq1L/9sEdR7HPdJ+HkZ5TrJFbURDlMF7fT55+ePUaD6Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WYPMeu4SXiMDUBFH0jpPYq+vQ6/ocF8+/zIOJ/+eCU=;
 b=D1u2aC5LeGQAmYRlyYXKX1y2q/IXbxca+ftPWg4RRFDCJxeijU17eko4bhaRoGABXAvsr717r4cxUYm/28l1xGxU8SYqAYFyzAlHOdHzNwKuWlJ0AvXhqTa5pqz0SptJZAZC5nnJ6knu56nkEUHPTZOC1N3h90WUQiSbtE7a3e4=
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by DM6PR02MB5596.namprd02.prod.outlook.com (2603:10b6:5:7b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 8 Oct
 2020 13:07:36 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bd:cafe::fa) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend
 Transport; Thu, 8 Oct 2020 13:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Thu, 8 Oct 2020 13:07:36
 +0000
Received: from [149.199.38.66] (port=53705 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVdK-0007Qv-LL; Thu, 08 Oct 2020 06:06:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVdw-0005ya-4w; Thu, 08 Oct 2020 06:07:36 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 098D7VKf009754;
        Thu, 8 Oct 2020 06:07:31 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kQVdq-0005wr-Jv; Thu, 08 Oct 2020 06:07:31 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C6A0112118B; Thu,  8 Oct 2020 18:37:05 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Date:   Thu,  8 Oct 2020 18:36:56 +0530
Message-Id: <1602162416-28058-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
References: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cd2de6e0-1118-47e0-4ee9-08d86b8b20a7
X-MS-TrafficTypeDiagnostic: DM6PR02MB5596:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5596A3E36AE88701EBC71A3FC10B0@DM6PR02MB5596.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0C4vO3bHj33OyBj5Mc0KC6Sr14bNNR+zfigUdyhawvM7w9anH35/PMeA3JtHY3VpxYXyWylSYhBJc6WfO/Le99XRuXCb1/VfG5im0SpHnCa9tOG3AtyewCaGhr2JRfHtpqb3msyXdJDxJ4Qj13yC/kg0h+jgtfboYFgASLy4tslNumv9DoRh4+s9EZkX5hdYqyaAgrEHkDaerwYYLl/NoGqt7HW6UziP8yjtdpkPqv8L+EN7T+0ZsqoGQClNxyZB4jk/imjzQPFpprMhmt1li0xT3WIwj5Pau6k8uCJpJ40w/E2E/d7PkF91CrPmmgUYW8uPIWoBci3up8O4o8uu5DRqOJQXOCNBBRM2AR1yrSgaKwPidz5rcsDc2RrO1oaPonQkBsMOKu+wTjbJXt6bQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(46966005)(2906002)(82740400003)(8936002)(8676002)(36756003)(83380400001)(2616005)(336012)(426003)(81166007)(478600001)(4326008)(70206006)(70586007)(5660300002)(42186006)(47076004)(107886003)(44832011)(356005)(186003)(26005)(6666004)(6266002)(30864003)(316002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 13:07:36.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2de6e0-1118-47e0-4ee9-08d86b8b20a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5596
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
index 7df115012935..e3a485b76818 100644
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

