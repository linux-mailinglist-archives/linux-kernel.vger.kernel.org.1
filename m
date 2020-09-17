Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F026DCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIQNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIQN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:29:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D12C061224
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:29:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so2093292wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55Fl8iRTWry8sClQedunMDBGG4ZcDw9WhyqWY+z9CDM=;
        b=SaVtwZvEUlCSrKLSB/jfZIitdreCGj+Ltia5Xq+RfwUITIXjmTZipSdjeKv2qSA8hM
         9m+oUjPEarkhjH0fdqZpHuylyxJkH1JatbCY/sFYvNZAnOe5Od9/BTOgfWfRcw2+wbSq
         HNVGHyXKzr6FjEtDo6kooTPpyZRf3F3sQP4I/+w8Jv8mbM3r516VnMFu4b4Tz1pc3bYa
         jf971i3CiAuuhi7d4RXMgmHbGmsoMVXre1PDLabRSkOaqTxPZeMAUR6ftxj/sh3WPul/
         EJNEUb41JMhSbZ+MQWSsHwdgLOF+juDG+V4ob/fCPGjartfkzRHYq/YUmFBsf2eFW5JE
         QvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55Fl8iRTWry8sClQedunMDBGG4ZcDw9WhyqWY+z9CDM=;
        b=HQlp+qUSWkc0zU2yizU40HL7uHpFg0LP+WZUDeAeC+A3bFLagzkxO2yKJZZLKdZ4DO
         CGkXIbiDkp1/26CWGRePzJHW9OW2xy2UGhMIxQCnqbLTQpJxyIt01XTp+4eZvILxlU0Q
         QZEl2ZcuA/aMbEhf6kBhuMVZV6KxNedEqdaBK4Qu931U7gRfpq2oE6H98TkDT8C1x6kG
         WvJbGW+Gnw4wnTxo7DGoNIyYgjy9olrMbo6T8o3zH/PrKVfLy5PP0xi78dJo+AUyLo3Q
         Na6Zr1suHECWcmkh0ZQAF9Mz9aLNW5WVVdHywQMf63nUBe3q+bEmd3mgui7PaKG7uDU7
         7NaQ==
X-Gm-Message-State: AOAM533xLIRq5ybN1ujkav/3Jif3sZsdhLHWpFNuGBKowNdyXyX2oyf6
        DyRf5UzYHhAngERZLkGUpsB/Pg==
X-Google-Smtp-Source: ABdhPJxXjTMt3U1zADgl3ZVp6/v2FO6MZgS1jdesv+YId1tuFMuQm3yZn4cYLO0pVVRZzbFerEJT2w==
X-Received: by 2002:a5d:470e:: with SMTP id y14mr32111551wrq.354.1600349340278;
        Thu, 17 Sep 2020 06:29:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n10sm11486910wmk.7.2020.09.17.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:28:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks
Date:   Thu, 17 Sep 2020 14:28:49 +0100
Message-Id: <20200917132850.7730-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
References: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFM Muxes in AUDIO_CC control clocks to LPASS WSA and RX Codec Macros.
This patch adds support to these muxes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/Kconfig            |   7 +
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/lpass-gfm-sm8250.c | 235 ++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 2eda63b7c46c..4e46fd339e62 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -494,4 +494,11 @@ config KRAITCC
 	  Support for the Krait CPU clocks on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling.
 
+config CLK_GFM_LPASS_SM8250
+	tristate "GFM LPASS Clocks"
+	depends on SND_SOC_QDSP6_COMMON
+	help
+	  Support for the GFM Glitch Free Mux LPASS clock. Say Y
+	  if you want to support GFM Clocks on LPASS for SM8250 SoC.
+
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 8eb395d02a32..c18e4ead6c9e 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -74,3 +74,4 @@ obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
 obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
 obj-$(CONFIG_KRAITCC) += krait-cc.o
+obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
diff --git a/drivers/clk/qcom/lpass-gfm-sm8250.c b/drivers/clk/qcom/lpass-gfm-sm8250.c
new file mode 100644
index 000000000000..2d5c41ae4969
--- /dev/null
+++ b/drivers/clk/qcom/lpass-gfm-sm8250.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/notifier.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
+
+struct lpass_gfm {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *core_vote;
+	struct clk *bus_clk;
+};
+
+struct clk_gfm {
+	unsigned int mux_reg;
+	unsigned int mux_mask;
+	struct clk_hw	hw;
+	struct lpass_gfm *priv;
+	void __iomem *gfm_mux;
+};
+
+#define GFM_MASK	BIT(1)
+#define to_clk_gfm(_hw) container_of(_hw, struct clk_gfm, hw)
+
+static u8 clk_gfm_get_parent(struct clk_hw *hw)
+{
+	struct clk_gfm *clk = to_clk_gfm(hw);
+
+	return readl(clk->gfm_mux) & GFM_MASK;
+}
+
+static int clk_gfm_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_gfm *clk = to_clk_gfm(hw);
+	unsigned int val;
+
+	val = readl(clk->gfm_mux);
+
+	if (index)
+		val |= GFM_MASK;
+	else
+		val &= ~GFM_MASK;
+
+	writel(val, clk->gfm_mux);
+
+	return 0;
+}
+
+static const struct clk_ops clk_gfm_ops = {
+	.get_parent = clk_gfm_get_parent,
+	.set_parent = clk_gfm_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk_gfm lpass_gfm_wsa_mclk = {
+	.mux_reg = 0x220d8,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "WSA_MCLK",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.parent_names = (const char *[]){
+			"LPASS_CLK_ID_TX_CORE_MCLK",
+			"LPASS_CLK_ID_WSA_CORE_MCLK",
+		},
+		.parent_data = (const struct clk_parent_data[]){
+				{ .index = 0 },
+				{ .index = 1 },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_gfm lpass_gfm_wsa_npl = {
+	.mux_reg = 0x220d8,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "WSA_NPL",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.parent_names = (const char *[]){
+			"LPASS_CLK_ID_TX_CORE_NPL_MCLK",
+			"LPASS_CLK_ID_WSA_CORE_NPL_MCLK",
+		},
+		.parent_data = (const struct clk_parent_data[]){
+				{ .index = 0 },
+				{ .index = 1 },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_gfm lpass_gfm_rx_mclk_mclk2 = {
+	.mux_reg = 0x240d8,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "RX_MCLK_MCLK2",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.parent_names = (const char *[]){
+			"LPASS_CLK_ID_TX_CORE_MCLK",
+			"LPASS_CLK_ID_RX_CORE_MCLK",
+		},
+		.parent_data = (const struct clk_parent_data[]){
+				{ .index = 0 },
+				{ .index = 1 },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_gfm lpass_gfm_rx_npl = {
+	.mux_reg = 0x240d8,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "RX_NPL",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.parent_names = (const char *[]){
+			"LPASS_CLK_ID_TX_CORE_NPL_MCLK",
+			"LPASS_CLK_ID_RX_CORE_NPL_MCLK",
+		},
+		.parent_data = (const struct clk_parent_data[]){
+				{ .index = 0 },
+				{ .index = 1 },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_gfm *audiocc_gfm_clks[] = {
+	[LPASS_CDC_WSA_NPL]		= &lpass_gfm_wsa_npl,
+	[LPASS_CDC_WSA_MCLK]		= &lpass_gfm_wsa_mclk,
+	[LPASS_CDC_RX_NPL]		= &lpass_gfm_rx_npl,
+	[LPASS_CDC_RX_MCLK_MCLK2]	= &lpass_gfm_rx_mclk_mclk2,
+};
+
+static struct clk_hw_onecell_data audiocc_hw_onecell_data = {
+	.hws = {
+		[LPASS_CDC_WSA_NPL]	= &lpass_gfm_wsa_npl.hw,
+		[LPASS_CDC_WSA_MCLK]	= &lpass_gfm_wsa_mclk.hw,
+		[LPASS_CDC_RX_NPL]	= &lpass_gfm_rx_npl.hw,
+		[LPASS_CDC_RX_MCLK_MCLK2] = &lpass_gfm_rx_mclk_mclk2.hw,
+	},
+	.num = ARRAY_SIZE(audiocc_gfm_clks),
+};
+
+struct lpass_gfm_data {
+	struct clk_hw_onecell_data *onecell_data;
+	struct clk_gfm **gfm_clks;
+};
+
+static struct lpass_gfm_data audiocc_data = {
+	.onecell_data = &audiocc_hw_onecell_data,
+	.gfm_clks = audiocc_gfm_clks,
+};
+
+static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
+{
+	const struct lpass_gfm_data *data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct clk_gfm *gfm;
+	struct lpass_gfm *cc;
+	int err, i;
+
+	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->core_vote = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(cc->core_vote)) {
+		dev_dbg(dev, "Failed to get lpass core clk\n");
+		return PTR_ERR(cc->core_vote);
+	}
+
+	data = of_device_get_match_data(dev);
+	cc->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(cc->bus_clk)) {
+		dev_dbg(dev, "Failed to get lpass bus clk\n");
+		return PTR_ERR(cc->bus_clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cc->base))
+		return PTR_ERR(cc->base);
+
+	clk_prepare_enable(cc->core_vote);
+	clk_prepare_enable(cc->bus_clk);
+
+	for (i = 0; i < data->onecell_data->num; i++) {
+		if (!data->gfm_clks[i])
+			continue;
+
+		gfm = data->gfm_clks[i];
+		gfm->priv = cc;
+		gfm->gfm_mux = cc->base;
+		gfm->gfm_mux = gfm->gfm_mux + data->gfm_clks[i]->mux_reg;
+
+		err = devm_clk_hw_register(dev, &data->gfm_clks[i]->hw);
+		if (err)
+			return err;
+
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   data->onecell_data);
+}
+
+static const struct of_device_id lpass_gfm_clk_match_table[] = {
+	{
+		.compatible = "qcom,sm8250-lpass-audiocc",
+		.data = &audiocc_data,
+	},
+	{ }
+};
+
+static struct platform_driver lpass_gfm_clk_driver = {
+	.probe		= lpass_gfm_clk_driver_probe,
+	.driver		= {
+		.name	= "lpass-gfm-clk",
+		.of_match_table = lpass_gfm_clk_match_table,
+	},
+};
+builtin_platform_driver(lpass_gfm_clk_driver);
-- 
2.21.0

