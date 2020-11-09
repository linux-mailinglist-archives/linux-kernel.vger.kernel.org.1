Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AE2AB3DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKIJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:44:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7196 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:44:53 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CV5gY2jVjzkf6M;
        Mon,  9 Nov 2020 17:44:41 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:44:44 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gengdongjiu@huawei.com>
Subject: [PATCH V2] clk: hisilicon: Free clk_data and unmap region obtained by of_iomap
Date:   Mon, 9 Nov 2020 18:09:20 +0000
Message-ID: <20201109180920.43193-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free memory mapping and free clk_data, if clock initialization
is not successful.

Fixes: 75af25f581b1 ("clk: hisi: remove static variable")
Fixes: 62ac983b6141 ("clk: hisilicon: add hi3620_mmc_clks")
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/clk/hisilicon/clk-hi3620.c |  8 ++++++--
 drivers/clk/hisilicon/clk.c        | 11 ++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..864d2ddfc73c 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -464,11 +464,11 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (WARN_ON(!clk_data))
-		return;
+		goto unmap_io;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
 	if (!clk_data->clks)
-		return;
+		goto free_clk_data;
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
@@ -478,6 +478,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 
 	clk_data->clk_num = num;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+free_clk_data:
+	kfree(clk_data);
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

