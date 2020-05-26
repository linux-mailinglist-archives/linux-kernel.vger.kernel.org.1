Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDB1A1801
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDGWYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 18:24:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16080 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgDGWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586298248; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Y2jGsjW4Cat61j7texOeQJst/+4CaG9+N7miSMcfB4E=; b=GBEDHsxNNLPwiovQruPePp7hpYm5h2427EvwYtivNYyroYPjaeYByRc0kA1Dd/L3w9md5My7
 JBg4HhYi+B0Ruwlae2vQstbYa36GKI35PClOxYXeSJxGeBjNRbihsdDX9ho5P2EUXwZcNTle
 +hnptQeBFWERcYP9Vr3d4ePdpuw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8cfd6c.7f2ed0874458-smtp-out-n01;
 Tue, 07 Apr 2020 22:23:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3853CC433BA; Tue,  7 Apr 2020 22:23:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB4E6C433F2;
        Tue,  7 Apr 2020 22:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB4E6C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 2/4] phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
Date:   Tue,  7 Apr 2020 15:23:27 -0700
Message-Id: <1586298209-4589-3-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586298209-4589-1-git-send-email-wcheng@codeaurora.org>
References: <1586298209-4589-1-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the SNPS FemtoPHY driver used in QCOM SOCs.  There
are potentially multiple instances of this UTMI PHY on the
SOC, all which can utilize this driver.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reviewed-by: Philipp Zabel <pza@pengutronix.de>
---
 drivers/phy/qualcomm/Kconfig             |  10 ++
 drivers/phy/qualcomm/Makefile            |   1 +
 drivers/phy/qualcomm/phy-qcom-snps-7nm.c | 294 +++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-7nm.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index e46824d..3158c14 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -85,6 +85,16 @@ config PHY_QCOM_USB_HS
 	  Support for the USB high-speed ULPI compliant phy on Qualcomm
 	  chipsets.
 
+config PHY_QCOM_USB_SNPS_HS_7NM
+	tristate "Qualcomm 7nm USB HS PHY module"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable support for the USB high-speed SNPS phy on Qualcomm 7nm
+	  chipsets.  This PHY has differences in the register map compared
+	  to the 28nm variant.  The PHY is paired with a Synopsys DWC3 USB
+	  controller on MSM SOCs.
+
 config PHY_QCOM_USB_HSIC
 	tristate "Qualcomm USB HSIC ULPI PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index 283251d..06bdb40 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
 obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
+obj-$(CONFIG_PHY_QCOM_USB_SNPS_HS_7NM)		+= phy-qcom-snps-7nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-7nm.c b/drivers/phy/qualcomm/phy-qcom-snps-7nm.c
new file mode 100644
index 0000000..00a46cd
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-snps-7nm.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL0		(0x3c)
+#define OPMODE_MASK					GENMASK(4, 3)
+#define OPMODE_NORMAL				(0x00)
+#define OPMODE_NONDRIVING			BIT(3)
+#define SLEEPM						BIT(0)
+#define TERMSEL						BIT(5)
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL1		(0x40)
+#define XCVRSEL						BIT(0)
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL5		(0x50)
+#define POR							BIT(1)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
+#define RETENABLEN							BIT(3)
+#define FSEL_MASK							GENMASK(7, 5)
+#define FSEL_DEFAULT						(0x3 << 4)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1	(0x58)
+#define VBUSVLDEXTSEL0						BIT(4)
+#define PLLBTUNE							BIT(5)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2	(0x5c)
+#define VREGBYPASS							BIT(0)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL1	(0x60)
+#define VBUSVLDEXT0					BIT(0)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL2	(0x64)
+#define USB2_AUTO_RESUME			BIT(0)
+#define USB2_SUSPEND_N				BIT(2)
+#define USB2_SUSPEND_N_SEL			BIT(3)
+
+#define USB2_PHY_USB_PHY_CFG0					(0x94)
+#define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
+#define UTMI_PHY_CMN_CTRL_OVERRIDE_EN		BIT(1)
+
+#define USB2_PHY_USB_PHY_REFCLK_CTRL	(0xa0)
+#define REFCLK_SEL_MASK				GENMASK(1, 0)
+#define REFCLK_SEL_DEFAULT			(0x2 << 0)
+
+static const char * const qcom_snps_hsphy_vreg_names[] = {
+	"vdda-pll", "vdda33", "vdda18",
+};
+
+#define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
+
+/**
+ * struct qcom_snps_hsphy - structure holding snps hs phy attributes
+ *
+ * @phy: generic phy
+ * @base: iomapped memory space for qubs2 phy
+ *
+ * @cfg_ahb_clk: AHB2PHY interface clock
+ * @ref_clk: phy reference clock
+ * @iface_clk: phy interface clock
+ * @phy_reset: phy reset control
+ * @vregs: regulator supplies bulk data
+
+ * @phy_initialized: if PHY has been initialized correctly
+ *
+ */
+struct qcom_snps_hsphy {
+	struct phy *phy;
+	void __iomem *base;
+
+	struct clk *cfg_ahb_clk;
+	struct clk *ref_clk;
+	struct reset_control *phy_reset;
+	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
+
+	bool phy_initialized;
+};
+
+static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
+				    u32 mask, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static int qcom_snps_hsphy_init(struct phy *phy)
+{
+	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
+	int ret;
+
+	dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
+
+	/* turn on regulator supplies */
+	ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
+	if (ret)
+		return ret;
+
+	/* enable ahb interface clock to program phy */
+	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		goto poweroff_phy;
+	}
+
+	/* Perform phy reset */
+	ret = reset_control_assert(hsphy->phy_reset);
+	if (ret) {
+		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
+		goto disable_ahb_clk;
+	}
+
+	/* 100 us delay to keep PHY in reset mode */
+	usleep_range(100, 150);
+
+	ret = reset_control_deassert(hsphy->phy_reset);
+	if (ret) {
+		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
+		goto disable_ahb_clk;
+	}
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
+							UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
+							UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_UTMI_CTRL5,
+							POR, POR);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
+							FSEL_MASK, 0);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+					PLLBTUNE, PLLBTUNE);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
+					REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+					VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
+					VBUSVLDEXT0, VBUSVLDEXT0);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
+					VREGBYPASS, VREGBYPASS);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+					USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
+					USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_UTMI_CTRL0,
+					SLEEPM, SLEEPM);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_UTMI_CTRL5,
+					POR, 0);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+					USB2_SUSPEND_N_SEL, 0);
+
+	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
+					UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
+
+	hsphy->phy_initialized = true;
+
+	return 0;
+
+disable_ahb_clk:
+	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+poweroff_phy:
+	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
+
+	return ret;
+}
+
+static int qcom_snps_hsphy_exit(struct phy *phy)
+{
+	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
+
+	reset_control_assert(hsphy->phy_reset);
+	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
+	hsphy->phy_initialized = false;
+
+	return 0;
+}
+
+static const struct phy_ops qcom_snps_hsphy_gen_ops = {
+	.init		= qcom_snps_hsphy_init,
+	.exit		= qcom_snps_hsphy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id qcom_snps_hsphy_of_match_table[] = {
+	{
+		.compatible	= "qcom,sm8150-usb-hs-phy",
+	},
+	{
+		.compatible	= "qcom,usb-snps-hs-7nm-phy",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_snps_hsphy_of_match_table);
+
+static int qcom_snps_hsphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_snps_hsphy *hsphy;
+	struct phy_provider *phy_provider;
+	struct phy *generic_phy;
+	struct resource *res;
+	int ret, i;
+	int num;
+
+	hsphy = devm_kzalloc(dev, sizeof(*hsphy), GFP_KERNEL);
+	if (!hsphy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hsphy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hsphy->base))
+		return PTR_ERR(hsphy->base);
+
+	hsphy->ref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(hsphy->ref_clk)) {
+		ret = PTR_ERR(hsphy->ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get ref clk, %d\n", ret);
+		return ret;
+	}
+
+	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(hsphy->phy_reset)) {
+		dev_err(dev, "failed to get phy core reset\n");
+		return PTR_ERR(hsphy->phy_reset);
+	}
+
+	num = ARRAY_SIZE(hsphy->vregs);
+	for (i = 0; i < num; i++)
+		hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
+
+	ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get regulator supplies: %d\n",
+				ret);
+		return ret;
+	}
+
+	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_hsphy_gen_ops);
+	if (IS_ERR(generic_phy)) {
+		ret = PTR_ERR(generic_phy);
+		dev_err(dev, "failed to create phy, %d\n", ret);
+		return ret;
+	}
+	hsphy->phy = generic_phy;
+
+	dev_set_drvdata(dev, hsphy);
+	phy_set_drvdata(generic_phy, hsphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (!IS_ERR(phy_provider))
+		dev_info(dev, "Registered Qcom-SNPS HS phy\n");
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver qcom_snps_hsphy_driver = {
+	.probe		= qcom_snps_hsphy_probe,
+	.driver = {
+		.name	= "qcom-snps-hs-7nm-phy",
+		.of_match_table = qcom_snps_hsphy_of_match_table,
+	},
+};
+
+module_platform_driver(qcom_snps_hsphy_driver);
+
+MODULE_DESCRIPTION("Qualcomm 7nm USB HS PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
