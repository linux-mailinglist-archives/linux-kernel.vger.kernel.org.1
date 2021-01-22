Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAB30011C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhAVLCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:02:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12422 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727346AbhAVKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:21 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAmJ8H002506;
        Fri, 22 Jan 2021 11:51:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=39WN3DQpy0hr431CJdHl6IkORZfZzk4urrp3DPI8aq4=;
 b=GGFSdr7UDacps690cKQJ9HFXFVI4ORjMjR02f449XCES68YZJ6wIa0fSWlTWHAXPofeE
 uISN4vc6tIc1NlgsyeVMZsQY/YUHAM3X85RqW8i4aWVQBR8F7lvMUzcS8qTTHesg7B8J
 bMTo+7M1P2T7gh34yf9a6UXhJhoR5pHo+iouh3lnNLYhb5i0hYnlBdFlUu3WXBWLKwh/
 Dv7jItSjpPvTx6qvHzThIGFRBniQfdVgt+eiuiQPS25k39raDNVbDag7FwYJE3bReROv
 sLmPbVV7VdxEzwJ4S20fYYvINK5MPIYQzTRHoDot5abDeBbxavvScWxH2qYy43TxxJOq ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pqhduh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECBE1100034;
        Fri, 22 Jan 2021 11:51:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCDEF22DBCA;
        Fri, 22 Jan 2021 11:51:21 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:21
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/14] clk: stm32mp1: convert to module driver
Date:   Fri, 22 Jan 2021 11:50:51 +0100
Message-ID: <20210122105101.27374-5-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Adds support for  probe deferral in way to prepare
integration of the security in RCC clock and reset
drivers.
Some kernel clocks will be provided by the SCMI drivers.
Since RCC clock driver create clocks which parents
are SCMI clocks, RCC clock driver probe can be deferred.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/clk-stm32mp1.c | 121 ++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index ee6968a2ad57..530babc4c4b6 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -10,8 +10,10 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -469,7 +471,7 @@ static const struct clk_ops mp1_gate_clk_ops = {
 	.is_enabled	= clk_gate_is_enabled,
 };
 
-static struct clk_hw *_get_stm32_mux(void __iomem *base,
+static struct clk_hw *_get_stm32_mux(struct device *dev, void __iomem *base,
 				     const struct stm32_mux_cfg *cfg,
 				     spinlock_t *lock)
 {
@@ -478,7 +480,7 @@ static struct clk_hw *_get_stm32_mux(void __iomem *base,
 	struct clk_hw *mux_hw;
 
 	if (cfg->mmux) {
-		mmux = kzalloc(sizeof(*mmux), GFP_KERNEL);
+		mmux = devm_kzalloc(dev, sizeof(*mmux), GFP_KERNEL);
 		if (!mmux)
 			return ERR_PTR(-ENOMEM);
 
@@ -493,7 +495,7 @@ static struct clk_hw *_get_stm32_mux(void __iomem *base,
 		cfg->mmux->hws[cfg->mmux->nbr_clk++] = mux_hw;
 
 	} else {
-		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 		if (!mux)
 			return ERR_PTR(-ENOMEM);
 
@@ -509,13 +511,13 @@ static struct clk_hw *_get_stm32_mux(void __iomem *base,
 	return mux_hw;
 }
 
-static struct clk_hw *_get_stm32_div(void __iomem *base,
+static struct clk_hw *_get_stm32_div(struct device *dev, void __iomem *base,
 				     const struct stm32_div_cfg *cfg,
 				     spinlock_t *lock)
 {
 	struct clk_divider *div;
 
-	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 
 	if (!div)
 		return ERR_PTR(-ENOMEM);
@@ -530,16 +532,16 @@ static struct clk_hw *_get_stm32_div(void __iomem *base,
 	return &div->hw;
 }
 
-static struct clk_hw *
-_get_stm32_gate(void __iomem *base,
-		const struct stm32_gate_cfg *cfg, spinlock_t *lock)
+static struct clk_hw *_get_stm32_gate(struct device *dev, void __iomem *base,
+				      const struct stm32_gate_cfg *cfg,
+				      spinlock_t *lock)
 {
 	struct stm32_clk_mgate *mgate;
 	struct clk_gate *gate;
 	struct clk_hw *gate_hw;
 
 	if (cfg->mgate) {
-		mgate = kzalloc(sizeof(*mgate), GFP_KERNEL);
+		mgate = devm_kzalloc(dev, sizeof(*mgate), GFP_KERNEL);
 		if (!mgate)
 			return ERR_PTR(-ENOMEM);
 
@@ -554,7 +556,7 @@ _get_stm32_gate(void __iomem *base,
 		gate_hw = &mgate->gate.hw;
 
 	} else {
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			return ERR_PTR(-ENOMEM);
 
@@ -592,7 +594,7 @@ clk_stm32_register_gate_ops(struct device *dev,
 	if (cfg->ops)
 		init.ops = cfg->ops;
 
-	hw = _get_stm32_gate(base, cfg, lock);
+	hw = _get_stm32_gate(dev, base, cfg, lock);
 	if (IS_ERR(hw))
 		return ERR_PTR(-ENOMEM);
 
@@ -623,7 +625,7 @@ clk_stm32_register_composite(struct device *dev,
 	gate_ops = NULL;
 
 	if (cfg->mux) {
-		mux_hw = _get_stm32_mux(base, cfg->mux, lock);
+		mux_hw = _get_stm32_mux(dev, base, cfg->mux, lock);
 
 		if (!IS_ERR(mux_hw)) {
 			mux_ops = &clk_mux_ops;
@@ -634,7 +636,7 @@ clk_stm32_register_composite(struct device *dev,
 	}
 
 	if (cfg->div) {
-		div_hw = _get_stm32_div(base, cfg->div, lock);
+		div_hw = _get_stm32_div(dev, base, cfg->div, lock);
 
 		if (!IS_ERR(div_hw)) {
 			div_ops = &clk_divider_ops;
@@ -645,7 +647,7 @@ clk_stm32_register_composite(struct device *dev,
 	}
 
 	if (cfg->gate) {
-		gate_hw = _get_stm32_gate(base, cfg->gate, lock);
+		gate_hw = _get_stm32_gate(dev, base, cfg->gate, lock);
 
 		if (!IS_ERR(gate_hw)) {
 			gate_ops = &clk_gate_ops;
@@ -890,7 +892,7 @@ static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
 	struct clk_hw *hw;
 	int err;
 
-	element = kzalloc(sizeof(*element), GFP_KERNEL);
+	element = devm_kzalloc(dev, sizeof(*element), GFP_KERNEL);
 	if (!element)
 		return ERR_PTR(-ENOMEM);
 
@@ -914,10 +916,8 @@ static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
 	hw = &element->hw;
 	err = clk_hw_register(dev, hw);
 
-	if (err) {
-		kfree(element);
+	if (err)
 		return ERR_PTR(err);
-	}
 
 	return hw;
 }
@@ -1028,7 +1028,7 @@ static struct clk_hw *clk_register_cktim(struct device *dev, const char *name,
 	struct clk_hw *hw;
 	int err;
 
-	tim_ker = kzalloc(sizeof(*tim_ker), GFP_KERNEL);
+	tim_ker = devm_kzalloc(dev, sizeof(*tim_ker), GFP_KERNEL);
 	if (!tim_ker)
 		return ERR_PTR(-ENOMEM);
 
@@ -1046,10 +1046,8 @@ static struct clk_hw *clk_register_cktim(struct device *dev, const char *name,
 	hw = &tim_ker->hw;
 	err = clk_hw_register(dev, hw);
 
-	if (err) {
-		kfree(tim_ker);
+	if (err)
 		return ERR_PTR(err);
-	}
 
 	return hw;
 }
@@ -2071,6 +2069,7 @@ static const struct of_device_id stm32mp1_match_data[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, stm32mp1_match_data);
 
 static int stm32_register_hw_clk(struct device *dev,
 				 struct clk_hw_onecell_data *clk_data,
@@ -2096,8 +2095,7 @@ static int stm32_register_hw_clk(struct device *dev,
 	return 0;
 }
 
-static int stm32_rcc_init(struct device_node *np,
-			  void __iomem *base,
+static int stm32_rcc_init(struct device *dev, void __iomem *base,
 			  const struct of_device_id *match_data)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -2106,9 +2104,9 @@ static int stm32_rcc_init(struct device_node *np,
 	const struct stm32_clock_match_data *data;
 	int err, n, max_binding;
 
-	match = of_match_node(match_data, np);
+	match = of_match_node(match_data, dev_of_node(dev));
 	if (!match) {
-		pr_err("%s: match data not found\n", __func__);
+		dev_err(dev, "match data not found\n");
 		return -ENODEV;
 	}
 
@@ -2116,8 +2114,8 @@ static int stm32_rcc_init(struct device_node *np,
 
 	max_binding =  data->maxbinding;
 
-	clk_data = kzalloc(struct_size(clk_data, hws, max_binding),
-			   GFP_KERNEL);
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, max_binding),
+				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
@@ -2129,36 +2127,73 @@ static int stm32_rcc_init(struct device_node *np,
 		hws[n] = ERR_PTR(-ENOENT);
 
 	for (n = 0; n < data->num; n++) {
-		err = stm32_register_hw_clk(NULL, clk_data, base, &rlock,
+		err = stm32_register_hw_clk(dev, clk_data, base, &rlock,
 					    &data->cfg[n]);
 		if (err) {
-			pr_err("%s: can't register  %s\n", __func__,
-			       data->cfg[n].name);
-
-			kfree(clk_data);
+			dev_err(dev, "Can't register clk %s: %d\n",
+				data->cfg[n].name, err);
 
 			return err;
 		}
 	}
 
-	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+	return of_clk_add_hw_provider(dev_of_node(dev), of_clk_hw_onecell_get, clk_data);
 }
 
-static void stm32mp1_rcc_init(struct device_node *np)
+static int stm32mp1_rcc_init(struct device *dev)
 {
 	void __iomem *base;
+	int ret;
 
-	base = of_iomap(np, 0);
+	base = of_iomap(dev_of_node(dev), 0);
 	if (!base) {
-		pr_err("%pOFn: unable to map resource", np);
-		of_node_put(np);
-		return;
+		pr_err("%pOFn: unable to map resource", dev_of_node(dev));
+		ret = -ENOMEM;
+		goto out;
 	}
 
-	if (stm32_rcc_init(np, base, stm32mp1_match_data)) {
-		iounmap(base);
-		of_node_put(np);
+	ret = stm32_rcc_init(dev, base, stm32mp1_match_data);
+
+out:
+	if (ret) {
+		if (base)
+			iounmap(base);
+
+		of_node_put(dev_of_node(dev));
 	}
+
+	return ret;
+}
+
+static int stm32mp1_rcc_clocks_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return stm32mp1_rcc_init(dev);
+}
+
+static int stm32mp1_rcc_clocks_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *child, *np = dev_of_node(dev);
+
+	for_each_available_child_of_node(np, child)
+		of_clk_del_provider(child);
+
+	return 0;
 }
 
-CLK_OF_DECLARE_DRIVER(stm32mp1_rcc, "st,stm32mp1-rcc", stm32mp1_rcc_init);
+static struct platform_driver stm32mp1_rcc_clocks_driver = {
+	.driver	= {
+		.name = "stm32mp1_rcc",
+		.of_match_table = stm32mp1_match_data,
+	},
+	.probe = stm32mp1_rcc_clocks_probe,
+	.remove = stm32mp1_rcc_clocks_remove,
+};
+
+static int __init stm32mp1_clocks_init(void)
+{
+	return platform_driver_register(&stm32mp1_rcc_clocks_driver);
+}
+core_initcall(stm32mp1_clocks_init);
-- 
2.17.1

