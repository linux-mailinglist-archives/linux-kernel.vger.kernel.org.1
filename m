Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F352A0449
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgJ3Lgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59034 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgJ3Lgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B12021F45EBE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 08/16] soc: mediatek: pm-domains: Add subsystem clocks
Date:   Fri, 30 Oct 2020 12:36:14 +0100
Message-Id: <20201030113622.201188-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
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

Changes in v4: None
Changes in v3:
- Prepare the basic clocks before we prepare the subsystem clocks.

Changes in v2:
- Use dev_err_probe if getting clocks fails, so an error is not printed
  if is deferred.

 drivers/soc/mediatek/mtk-pm-domains.c | 81 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  2 +
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index a6f25933dbf0..88dec58aedd9 100644
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
@@ -33,6 +34,8 @@ struct scpsys_domain {
 	struct scpsys *scpsys;
 	int num_clks;
 	struct clk_bulk_data *clks;
+	int num_subsys_clks;
+	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg;
 	struct regmap *smi;
 };
@@ -204,9 +207,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
+	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_pwr_ack;
+
 	ret = scpsys_sram_enable(pd);
 	if (ret < 0)
-		goto err_pwr_ack;
+		goto err_disable_subsys_clks;
 
 	ret = scpsys_bus_protect_disable(pd);
 	if (ret < 0)
@@ -216,6 +223,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 
 err_disable_sram:
 	scpsys_sram_disable(pd);
+err_disable_subsys_clks:
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable(pd->num_clks, pd->clks);
 	return ret;
@@ -236,6 +245,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+
 	/* subsys power off */
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
@@ -259,7 +270,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	int i, ret;
+	struct property *prop;
+	const char *clk_name;
+	int i, ret, num_clks;
+	struct clk *clk;
+	int clk_ind = 0;
 	u32 id;
 
 	ret = of_property_read_u32(node, "reg", &id);
@@ -295,25 +310,62 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->smi))
 		return ERR_CAST(pd->smi);
 
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
 			return ERR_PTR(-ENOMEM);
+
+		pd->subsys_clks = devm_kcalloc(scpsys->dev, pd->num_subsys_clks,
+					       sizeof(*pd->subsys_clks), GFP_KERNEL);
+		if (!pd->subsys_clks)
+			return ERR_PTR(-ENOMEM);
+
 	}
 
 	for (i = 0; i < pd->num_clks; i++) {
-		pd->clks[i].clk = of_clk_get(node, i);
-		if (IS_ERR(pd->clks[i].clk)) {
-			dev_err(scpsys->dev, "%pOF: failed to get clk at index %d\n",
-				node, i);
-			return ERR_PTR(-EINVAL);
+		clk = of_clk_get(node, i);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err_probe(scpsys->dev, ret,
+				      "%pOF: failed to get clk at index %d: %d\n", node, i, ret);
+			goto err_put_clocks;
 		}
+
+		pd->clks[clk_ind++].clk = clk;
+	}
+
+	for (i = 0; i < pd->num_subsys_clks; i++) {
+		clk = of_clk_get(node, i + clk_ind);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err_probe(scpsys->dev, ret,
+				      "%pOF: failed to get clk at index %d: %d\n", node,
+				      i + clk_ind, ret);
+			goto err_put_subsys_clocks;
+		}
+
+		pd->subsys_clks[i].clk = clk;
 	}
 
 	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
 	if (ret)
-		goto err_put_clocks;
+		goto err_put_subsys_clocks;
+
+	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_unprepare_clocks;
 
 	/*
 	 * Initially turn on all domains to make the domains usable
@@ -331,7 +383,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = -EINVAL;
 		dev_err(scpsys->dev,
 			"power domain with id %d already exists, check your device-tree\n", id);
-		goto err_unprepare_clocks;
+		goto err_unprepare_subsys_clocks;
 	}
 
 	pd->genpd.name = node->name;
@@ -343,8 +395,12 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	return scpsys->pd_data.domains[id];
 
+err_unprepare_subsys_clocks:
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 err_unprepare_clocks:
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
+err_put_subsys_clocks:
+	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
 	return ERR_PTR(ret);
@@ -421,6 +477,9 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
 
 static void scpsys_domain_cleanup(struct scpsys *scpsys)
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index f190a0d9e592..20df5689739b 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -63,6 +63,8 @@ struct scpsys_bus_prot_data {
 	bool bus_prot_reg_update;
 };
 
+#define MAX_SUBSYS_CLKS 10
+
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @sta_mask: The mask for power on/off status bit.
-- 
2.28.0

