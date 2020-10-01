Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08F4280377
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgJAQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732773AbgJAQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:02:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B5C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:02:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7329729D769
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/12] soc: mediatek: pm-domains: Add subsystem clocks
Date:   Thu,  1 Oct 2020 18:01:50 +0200
Message-Id: <20201001160154.3587848-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001160154.3587848-1-enric.balletbo@collabora.com>
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

For the bus protection operations, some subsystem clocks need to be enabled
before releasing the protection. This patch identifies the subsystem clocks
by it's name.

Suggested-by: Weiyi Lu <weiyi.lu@mediatek.com>
[Adapted the patch to the mtk-pm-domains driver]
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Use dev_err_probe if getting clocks fails, so an error is not printed
  if is deferred.

 drivers/soc/mediatek/mtk-pm-domains.c | 89 ++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index e0a52d489fea..2075072f16da 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020 Collabora Ltd.
  */
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -81,6 +82,8 @@ struct scpsys_bus_prot_data {
 	bool bus_prot_reg_update;
 };
 
+#define MAX_SUBSYS_CLKS 10
+
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @sta_mask: The mask for power on/off status bit.
@@ -107,6 +110,8 @@ struct scpsys_domain {
 	struct scpsys *scpsys;
 	int num_clks;
 	struct clk_bulk_data *clks;
+	int num_subsys_clks;
+	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg;
 	struct regmap *smi;
 };
@@ -318,16 +323,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val |= PWR_RST_B_BIT;
 	regmap_write(scpsys->base, pd->data->ctl_offs, val);
 
+	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_pwr_ack;
+
 	ret = scpsys_sram_enable(pd);
 	if (ret < 0)
-		goto err_pwr_ack;
+		goto err_sram;
 
 	ret = scpsys_bus_protect_disable(pd);
 	if (ret < 0)
-		goto err_pwr_ack;
+		goto err_sram;
 
 	return 0;
 
+err_sram:
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable(pd->num_clks, pd->clks);
 	return ret;
@@ -348,6 +359,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+
 	/* subsys power off */
 	regmap_read(scpsys->base, pd->data->ctl_offs, &val);
 	val |= PWR_ISO_BIT;
@@ -380,8 +393,11 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	int i, ret;
+	int i, ret, num_clks;
 	u32 id;
+	int clk_ind = 0;
+	struct property *prop;
+	const char *clk_name;
 
 	ret = of_property_read_u32(node, "reg", &id);
 	if (ret) {
@@ -416,28 +432,63 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
 	if (IS_ERR(pd->smi))
 		pd->smi = NULL;
 
-	pd->num_clks = of_clk_get_parent_count(node);
-	if (pd->num_clks > 0) {
+	num_clks = of_clk_get_parent_count(node);
+	if (num_clks > 0) {
+		/* Calculate number of subsys_clks */
+		of_property_for_each_string(node, "clock-names", prop, clk_name) {
+			char *subsys;
+
+			subsys = strchr(clk_name, '-');
+			if (subsys)
+				pd->num_subsys_clks++;
+			else
+				pd->num_clks++;
+		}
+
 		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
 		if (!pd->clks)
 			return -ENOMEM;
-	} else {
-		pd->num_clks = 0;
+
+		pd->subsys_clks = devm_kcalloc(scpsys->dev, pd->num_subsys_clks,
+					       sizeof(*pd->subsys_clks), GFP_KERNEL);
+		if (!pd->subsys_clks)
+			return -ENOMEM;
 	}
 
 	for (i = 0; i < pd->num_clks; i++) {
-		pd->clks[i].clk = of_clk_get(node, i);
-		if (IS_ERR(pd->clks[i].clk)) {
-			ret = PTR_ERR(pd->clks[i].clk);
-			dev_err_probe(scpsys->dev, ret, "%pOFn: failed to get clk at index %d\n",
-				      node, i);
-			return ret;
+		struct clk *clk = of_clk_get(node, i);
+
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err_probe(scpsys->dev, PTR_ERR(clk),
+				      "%pOFn: failed to get clk at index %d\n", node, i);
+			goto err_put_clocks;
 		}
+
+		pd->clks[clk_ind++].clk = clk;
 	}
 
+	for (i = 0; i < pd->num_subsys_clks; i++) {
+		struct clk *clk = of_clk_get(node, i + clk_ind);
+
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err_probe(scpsys->dev, PTR_ERR(clk),
+				      "%pOFn: failed to get clk at index %d: %d\n",
+				      node, i + clk_ind, ret);
+			goto err_put_subsys_clocks;
+		}
+
+		pd->subsys_clks[i].clk = clk;
+	}
+
+	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_put_subsys_clocks;
+
 	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
 	if (ret)
-		goto err_put_clocks;
+		goto err_unprepare_subsys_clocks;
 
 	/*
 	 * Initially turn on all domains to make the domains usable
@@ -462,6 +513,12 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
 
 err_unprepare_clocks:
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
+err_unprepare_subsys_clocks:
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+err_put_subsys_clocks:
+	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
+	devm_kfree(scpsys->dev, pd->subsys_clks);
+	pd->num_subsys_clks = 0;
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
 	devm_kfree(scpsys->dev, pd->clks);
@@ -541,6 +598,10 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
 	pd->num_clks = 0;
+
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
+	pd->num_subsys_clks = 0;
 }
 
 static void scpsys_domain_cleanup(struct scpsys *scpsys)
-- 
2.28.0

