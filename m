Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBA2E938F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhADKpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:45:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33223 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726396AbhADKpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:45:43 -0500
X-UUID: 419299f87d4b4152abf484f9d78f3d7f-20210104
X-UUID: 419299f87d4b4152abf484f9d78f3d7f-20210104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1837513500; Mon, 04 Jan 2021 18:44:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Jan 2021 18:44:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 18:44:58 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 1/2] soc: mediatek: Add regulator control for MT8192 MFG power domain
Date:   Mon, 4 Jan 2021 18:44:52 +0800
Message-ID: <1609757093-30618-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com>
References: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator control support and specific power domain name of
MT8192 MFG power domain for regulator lookup.
Also power domain name can fix the debugfs warning.
(e.g. debugfs: Directory 'power-domain' with parent 'pm_genpd'
already present!)
However, not every domain with name need to get the regulator,
if we just want to fix the debugfs warning log by adding names to
power domains. Considering this case, lookup regulator by
regulator_get_optional() instead of getting a dummy regulator from
regulator_get() to operate.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mt8192-pm-domains.h |  1 +
 drivers/soc/mediatek/mtk-pm-domains.c    | 42 ++++++++++++++++++++++++++++++--
 drivers/soc/mediatek/mtk-pm-domains.h    |  2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index 0fdf6dc..7db0ad3 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -49,6 +49,7 @@
 		.ctl_offs = 0x0308,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.name = "mfg",
 	},
 	[MT8192_POWER_DOMAIN_MFG1] = {
 		.sta_mask = BIT(3),
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index fb70cb3..a160800 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
 #include "mt8173-pm-domains.h"
@@ -40,6 +41,7 @@ struct scpsys_domain {
 	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg;
 	struct regmap *smi;
+	struct regulator *supply;
 };
 
 struct scpsys {
@@ -187,6 +189,22 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
 }
 
+static int scpsys_regulator_enable(struct scpsys_domain *pd)
+{
+	if (!pd->supply)
+		return 0;
+
+	return regulator_enable(pd->supply);
+}
+
+static int scpsys_regulator_disable(struct scpsys_domain *pd)
+{
+	if (!pd->supply)
+		return 0;
+
+	return regulator_disable(pd->supply);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
@@ -194,9 +212,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	ret = scpsys_regulator_enable(pd);
+	if (ret < 0)
+		return ret;
+
 	ret = clk_bulk_enable(pd->num_clks, pd->clks);
 	if (ret)
-		return ret;
+		goto err_disable_regulator;
 
 	/* subsys power on */
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
@@ -232,6 +254,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
 	clk_bulk_disable(pd->num_clks, pd->clks);
+err_disable_regulator:
+	scpsys_regulator_disable(pd);
 	return ret;
 }
 
@@ -267,6 +291,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	clk_bulk_disable(pd->num_clks, pd->clks);
 
+	ret = scpsys_regulator_disable(pd);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -315,6 +343,16 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->smi))
 		return ERR_CAST(pd->smi);
 
+	if (pd->data->name) {
+		pd->supply = devm_regulator_get_optional(scpsys->dev, pd->data->name);
+		if (IS_ERR(pd->supply)) {
+			if (PTR_ERR(pd->supply) == -ENODEV)
+				pd->supply = NULL;
+			else
+				return ERR_CAST(pd->supply);
+		}
+	}
+
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
 		/* Calculate number of subsys_clks */
@@ -397,7 +435,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		goto err_unprepare_subsys_clocks;
 	}
 
-	pd->genpd.name = node->name;
+	pd->genpd.name = pd->data->name ?: node->name;
 	pd->genpd.power_off = scpsys_power_off;
 	pd->genpd.power_on = scpsys_power_on;
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index a2f4d8f..58d72fb 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -81,6 +81,7 @@ struct scpsys_bus_prot_data {
  * @caps: The flag for active wake-up action.
  * @bp_infracfg: bus protection for infracfg subsystem
  * @bp_smi: bus protection for smi subsystem
+ * @name: specific power domain name for regulator lookup and debugfs
  */
 struct scpsys_domain_data {
 	u32 sta_mask;
@@ -90,6 +91,7 @@ struct scpsys_domain_data {
 	u8 caps;
 	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
 	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
+	char *name;
 };
 
 struct scpsys_soc_data {
-- 
1.8.1.1.dirty

