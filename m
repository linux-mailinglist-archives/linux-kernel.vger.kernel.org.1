Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B508303B89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392403AbhAZLYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:24:22 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41610 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390857AbhAZJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:28 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8tfZi000604;
        Tue, 26 Jan 2021 10:04:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Q06f/KAD9XiJFMzy4zCgRAg32NGIrZOP5jBj4gOdWrA=;
 b=yqFRdUlEqm38LwHz0rR1VxsDxjp6GQ12A4pnb+GHUS858o1LXnnGf8zDjDxWkrlygonu
 gmjd0cHa47xtsnlstehbbOdXqWSrPZ1hyCSIcmEJ5lmVLF1TjDCmekoYd1o4PGhJ+/TS
 OVLUYDbl2svvgXn4+CIiBcI5UagWy07XW3yRXeUiEMxiYqQ/MTZ+zWKsYk4v14jXddH6
 f0UI2ggD6oszlBWMkXjXhyDQDo8NqRVCs6B50J+vdvuVHNZP/paWPFcne2d/9Eftd25y
 IiRZcNiVWeWrHzhI8GGEkzMpGL4RN5eeKApM7u317ViiaUg8NWt0gKewtkuyukpMqDa0 Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368c15qghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A32C0100034;
        Tue, 26 Jan 2021 10:04:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92E7A22A4A4;
        Tue, 26 Jan 2021 10:04:31 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:31
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/14] clk: stm32mp1: move RCC reset controller into RCC clock driver
Date:   Tue, 26 Jan 2021 10:01:11 +0100
Message-ID: <20210126090120.19900-6-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

RCC clock and reset controller shared same memory mapping.
As RCC clock driver is now a module, the best way to register clock
and reset controller is to do it in same driver.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/clk-stm32mp1.c | 157 ++++++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 530babc4c4b6..25e3f272344c 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -2050,16 +2051,18 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 		  _DIV(RCC_DBGCFGR, 0, 3, 0, ck_trace_div_table)),
 };
 
-struct stm32_clock_match_data {
+struct stm32_rcc_match_data {
 	const struct clock_config *cfg;
 	unsigned int num;
 	unsigned int maxbinding;
+	u32 clear_offset;
 };
 
-static struct stm32_clock_match_data stm32mp1_data = {
+static struct stm32_rcc_match_data stm32mp1_data = {
 	.cfg		= stm32mp1_clock_cfg,
 	.num		= ARRAY_SIZE(stm32mp1_clock_cfg),
 	.maxbinding	= STM32MP1_LAST_CLK,
+	.clear_offset	= RCC_CLR,
 };
 
 static const struct of_device_id stm32mp1_match_data[] = {
@@ -2095,23 +2098,122 @@ static int stm32_register_hw_clk(struct device *dev,
 	return 0;
 }
 
-static int stm32_rcc_init(struct device *dev, void __iomem *base,
-			  const struct of_device_id *match_data)
+#define STM32_RESET_ID_MASK GENMASK(15, 0)
+
+struct stm32_reset_data {
+	/* reset lock */
+	spinlock_t			lock;
+	struct reset_controller_dev	rcdev;
+	void __iomem			*membase;
+	u32				clear_offset;
+};
+
+static inline struct stm32_reset_data *
+to_stm32_reset_data(struct reset_controller_dev *rcdev)
 {
-	struct clk_hw_onecell_data *clk_data;
-	struct clk_hw **hws;
-	const struct of_device_id *match;
-	const struct stm32_clock_match_data *data;
-	int err, n, max_binding;
+	return container_of(rcdev, struct stm32_reset_data, rcdev);
+}
 
-	match = of_match_node(match_data, dev_of_node(dev));
-	if (!match) {
-		dev_err(dev, "match data not found\n");
-		return -ENODEV;
+static int stm32_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+
+	if (data->clear_offset) {
+		void __iomem *addr;
+
+		addr = data->membase + (bank * reg_width);
+		if (!assert)
+			addr += data->clear_offset;
+
+		writel(BIT(offset), addr);
+
+	} else {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&data->lock, flags);
+
+		reg = readl(data->membase + (bank * reg_width));
+
+		if (assert)
+			reg |= BIT(offset);
+		else
+			reg &= ~BIT(offset);
+
+		writel(reg, data->membase + (bank * reg_width));
+
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
+	return 0;
+}
+
+static int stm32_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, true);
+}
+
+static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, false);
+}
+
+static int stm32_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+
+	reg = readl(data->membase + (bank * reg_width));
+
+	return !!(reg & BIT(offset));
+}
+
+static const struct reset_control_ops stm32_reset_ops = {
+	.assert		= stm32_reset_assert,
+	.deassert	= stm32_reset_deassert,
+	.status		= stm32_reset_status,
+};
+
+static int stm32_rcc_reset_init(struct device *dev, void __iomem *base,
+				const struct of_device_id *match)
+{
+	const struct stm32_rcc_match_data *data = match->data;
+	struct stm32_reset_data *reset_data = NULL;
+
 	data = match->data;
 
+	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
+	if (!reset_data)
+		return -ENOMEM;
+
+	reset_data->membase = base;
+	reset_data->rcdev.owner = THIS_MODULE;
+	reset_data->rcdev.ops = &stm32_reset_ops;
+	reset_data->rcdev.of_node = dev_of_node(dev);
+	reset_data->rcdev.nr_resets = STM32_RESET_ID_MASK;
+	reset_data->clear_offset = data->clear_offset;
+
+	return reset_controller_register(&reset_data->rcdev);
+}
+
+static int stm32_rcc_clock_init(struct device *dev, void __iomem *base,
+				const struct of_device_id *match)
+{
+	const struct stm32_rcc_match_data *data = match->data;
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **hws;
+	int err, n, max_binding;
+
 	max_binding =  data->maxbinding;
 
 	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, max_binding),
@@ -2140,6 +2242,35 @@ static int stm32_rcc_init(struct device *dev, void __iomem *base,
 	return of_clk_add_hw_provider(dev_of_node(dev), of_clk_hw_onecell_get, clk_data);
 }
 
+static int stm32_rcc_init(struct device *dev, void __iomem *base,
+			  const struct of_device_id *match_data)
+{
+	const struct of_device_id *match;
+	int err;
+
+	match = of_match_node(match_data, dev_of_node(dev));
+	if (!match) {
+		dev_err(dev, "match data not found\n");
+		return -ENODEV;
+	}
+
+	/* RCC Reset Configuration */
+	err = stm32_rcc_reset_init(dev, base, match);
+	if (err) {
+		pr_err("stm32mp1 reset failed to initialize\n");
+		return err;
+	}
+
+	/* RCC Clock Configuration */
+	err = stm32_rcc_clock_init(dev, base, match);
+	if (err) {
+		pr_err("stm32mp1 clock failed to initialize\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int stm32mp1_rcc_init(struct device *dev)
 {
 	void __iomem *base;
-- 
2.17.1

