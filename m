Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A52BA19B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKTFCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:02:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7957 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKTFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:02:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcktD0vzszhZRH;
        Fri, 20 Nov 2020 13:01:56 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Nov 2020
 13:02:04 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <Markus.Elfring@web.de>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <haojian.zhuang@linaro.org>,
        <mturquette@linaro.org>, <zhangfei.gao@linaro.org>,
        <arnd@arndb.de>, <jh80.chung@samsung.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] clk: hisilicon: refine hi3620_mmc_clk_init() and fix memory leak issues
Date:   Fri, 20 Nov 2020 13:26:34 +0000
Message-ID: <20201120132634.47779-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine hi3620_mmc_clk_init() to use of_clk_add_hw_provider()
instead of of_clk_add_provider(), the called function hisi_register_clk_mmc()
returns 'clk_hw *' to adapt to this change.  Also free memory mapping and
free hw_data if clock initialization is failed.

Fix the memory leak issues in hisi_clk_init().

Fixes: 75af25f581b1 ("clk: hisi: remove static variable")
Fixes: 62ac983b6141 ("clk: hisilicon: add hi3620_mmc_clks")
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
v3->v4:
1. omit a blank in hisi_register_clk_mmc()
2. Further need to do:
    consider adjust also such a function call for the of_clk_add_provider()

v2->v3:
1. Refind hi3620_mmc_clk_init() and hisi_register_clk_mmc() in order to use
   of_clk_add_hw_provider().
2. Fix the issue that incorrectly free data even clock is initialized
   successfully.
---
 drivers/clk/hisilicon/clk-hi3620.c | 43 ++++++++++++++++++------------
 drivers/clk/hisilicon/clk.c        | 11 ++++----
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..af4587245c72 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -408,12 +408,13 @@ static const struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
+static struct clk_hw *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 			void __iomem *base, struct device_node *np)
 {
 	struct clk_mmc *mclk;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int err;
 
 	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
 	if (!mclk)
@@ -439,17 +440,21 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 	mclk->sam_off = mmc_clk->sam_off;
 	mclk->sam_bits = mmc_clk->sam_bits;
 
-	clk = clk_register(NULL, &mclk->hw);
-	if (WARN_ON(IS_ERR(clk)))
+	hw = &mclk->hw;
+	err = clk_hw_register(NULL, hw);
+	if (err) {
 		kfree(mclk);
-	return clk;
+		return ERR_PTR(err);
+	}
+
+	return hw;
 }
 
 static void __init hi3620_mmc_clk_init(struct device_node *node)
 {
 	void __iomem *base;
-	int i, num = ARRAY_SIZE(hi3620_mmc_clks);
-	struct clk_onecell_data *clk_data;
+	int i, ret, num = ARRAY_SIZE(hi3620_mmc_clks);
+	struct clk_hw_onecell_data *hw_data;
 
 	if (!node) {
 		pr_err("failed to find pctrl node in DTS\n");
@@ -462,22 +467,26 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (WARN_ON(!clk_data))
-		return;
-
-	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		return;
+	hw_data = kzalloc(struct_size(hw_data, hws, num), GFP_KERNEL);
+	if (WARN_ON(!hw_data))
+		goto unmap_io;
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-		clk_data->clks[mmc_clk->id] =
+		hw_data->hws[mmc_clk->id] =
 			hisi_register_clk_mmc(mmc_clk, base, node);
 	}
 
-	clk_data->clk_num = num;
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	hw_data->num = num;
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, hw_data);
+	if (ret < 0)
+		goto free_hw_data;
+	return;
+
+free_hw_data:
+	kfree(hw_data);
+unmap_io:
+	iounmap(base);
 }
 
 CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..da655683710f 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -65,25 +65,26 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		goto err;
+		return NULL;
 	}
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
-		goto err;
+		goto unmap_io;
 
 	clk_data->base = base;
 	clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
 	if (!clk_table)
-		goto err_data;
+		goto free_clk_data;
 
 	clk_data->clk_data.clks = clk_table;
 	clk_data->clk_data.clk_num = nr_clks;
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
 	return clk_data;
-err_data:
+free_clk_data:
 	kfree(clk_data);
-err:
+unmap_io:
+	iounmap(base);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
-- 
2.17.1

