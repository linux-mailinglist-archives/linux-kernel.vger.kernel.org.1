Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665652E9D13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbhADSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:31:42 -0500
Received: from vern.gendns.com ([98.142.107.122]:38774 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbhADSbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oDfcvjDf7SJg3FG/ecf6b0KnLwiHt36+ZCw6OZhhnAA=; b=JbCeEfUDhwi+v51kylqnDgrs8P
        0spEItpSo98mL2zbfV+gjsgpBh6NNNlmQM3IBcJvjSVnhOSbZj5An5otTVZ7aiHCko7t+65wweGKh
        tANEqB5TltFIBrpAh4iLzdN4nTrcwyXC8u0QYwohx88GcHHOSY26Z9HADsnJPEOK3Sllsm7Qw+ZRo
        lqQ4ZdTbEry5NOUtWUSwgRu5Chs0D4zLTfqJMQqYYUoixgF9A6EGeE5/1jkoXS33Aj7T000aGTxgL
        VF6nnXvwqDGGLV78Loc8qvtIEKsljVXwLS5cEeG/8ca7duZd2Kq++7TDVvX7jNJrfWXoEfAjBKdId
        JhsxqTsw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51064 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kwUd2-0002rB-Pr; Mon, 04 Jan 2021 13:30:52 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: ti: pruss: add support for AM18XX/OMAP-L138 PRUSS
Date:   Mon,  4 Jan 2021 12:30:21 -0600
Message-Id: <20210104183021.330112-3-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104183021.330112-1-david@lechnology.com>
References: <20210104183021.330112-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the PRUSS found in AM18XX/OMAP-L138. This PRUSS
doesn't have a CFG register, so that is made optional as selected by
the device tree compatible string.

ARCH_DAVINCI is added in the Kconfig so that the driver can be selected
on that platform.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/soc/ti/Kconfig |  2 +-
 drivers/soc/ti/pruss.c | 76 ++++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 7e2fb1c16af1..7a692a21480a 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -85,7 +85,7 @@ config TI_K3_SOCINFO
 
 config TI_PRUSS
 	tristate "TI PRU-ICSS Subsystem Platform drivers"
-	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
 	select MFD_SYSCON
 	help
 	  TI PRU-ICSS Subsystem platform specific support.
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 5d6e7132a5c4..bfaf3ff74b01 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -24,10 +24,12 @@
  * struct pruss_private_data - PRUSS driver private data
  * @has_no_sharedram: flag to indicate the absence of PRUSS Shared Data RAM
  * @has_core_mux_clock: flag to indicate the presence of PRUSS core clock
+ * @has_cfg: flag to indicate the presence of PRUSS CFG registers
  */
 struct pruss_private_data {
 	bool has_no_sharedram;
 	bool has_core_mux_clock;
+	bool has_cfg;
 };
 
 static void pruss_of_free_clk_provider(void *data)
@@ -239,42 +241,44 @@ static int pruss_probe(struct platform_device *pdev)
 		goto rpm_disable;
 	}
 
-	child = of_get_child_by_name(np, "cfg");
-	if (!child) {
-		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
-		ret = -ENODEV;
-		goto rpm_put;
-	}
+	if (data->has_cfg) {
+		child = of_get_child_by_name(np, "cfg");
+		if (!child) {
+			dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
+			ret = -ENODEV;
+			goto rpm_put;
+		}
 
-	if (of_address_to_resource(child, 0, &res)) {
-		ret = -ENOMEM;
-		goto node_put;
-	}
+		if (of_address_to_resource(child, 0, &res)) {
+			ret = -ENOMEM;
+			goto node_put;
+		}
 
-	pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (!pruss->cfg_base) {
-		ret = -ENOMEM;
-		goto node_put;
-	}
+		pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
+		if (!pruss->cfg_base) {
+			ret = -ENOMEM;
+			goto node_put;
+		}
 
-	regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
-				     (u64)res.start);
-	regmap_conf.max_register = resource_size(&res) - 4;
-
-	pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
-						  &regmap_conf);
-	kfree(regmap_conf.name);
-	if (IS_ERR(pruss->cfg_regmap)) {
-		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
-			PTR_ERR(pruss->cfg_regmap));
-		ret = PTR_ERR(pruss->cfg_regmap);
-		goto node_put;
-	}
+		regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
+					     (u64)res.start);
+		regmap_conf.max_register = resource_size(&res) - 4;
+
+		pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
+							  &regmap_conf);
+		kfree(regmap_conf.name);
+		if (IS_ERR(pruss->cfg_regmap)) {
+			dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
+				PTR_ERR(pruss->cfg_regmap));
+			ret = PTR_ERR(pruss->cfg_regmap);
+			goto node_put;
+		}
 
-	ret = pruss_clk_init(pruss, child);
-	if (ret) {
-		dev_err(dev, "failed to setup coreclk-mux\n");
-		goto node_put;
+		ret = pruss_clk_init(pruss, child);
+		if (ret) {
+			dev_err(dev, "failed to setup coreclk-mux\n");
+			goto node_put;
+		}
 	}
 
 	ret = devm_of_platform_populate(dev);
@@ -309,19 +313,27 @@ static int pruss_remove(struct platform_device *pdev)
 }
 
 /* instance-specific driver private data */
+static const struct pruss_private_data am18xx_pruss_data = {
+	.has_no_sharedram = true,
+};
+
 static const struct pruss_private_data am437x_pruss1_data = {
 	.has_no_sharedram = false,
+	.has_cfg = true,
 };
 
 static const struct pruss_private_data am437x_pruss0_data = {
 	.has_no_sharedram = true,
+	.has_cfg = true,
 };
 
 static const struct pruss_private_data am65x_j721e_pruss_data = {
 	.has_core_mux_clock = true,
+	.has_cfg = true,
 };
 
 static const struct of_device_id pruss_of_match[] = {
+	{ .compatible = "ti,am1806-pruss", .data = &am18xx_pruss_data, },
 	{ .compatible = "ti,am3356-pruss" },
 	{ .compatible = "ti,am4376-pruss0", .data = &am437x_pruss0_data, },
 	{ .compatible = "ti,am4376-pruss1", .data = &am437x_pruss1_data, },
-- 
2.25.1

