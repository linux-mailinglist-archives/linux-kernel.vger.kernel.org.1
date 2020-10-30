Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79B42A045E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3Lhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJ3Lgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A660C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:36:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DE2961F45EBD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 06/16] soc: mediatek: pm-domains: Add SMI block as bus protection block
Date:   Fri, 30 Oct 2020 12:36:12 +0100
Message-Id: <20201030113622.201188-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Apart from the infracfg block, the SMI block is used to enable the bus
protection for some power domains. Add support for this block.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4:
- Use the new syscon_regmap_lookup_by_phandle_optional() wrapper.

Changes in v3:
- Do not reuse bpd for 2 different things.
- Disable pd->smi first and after that pd->infracfg.
- Rename BUT_PROT_UPDATE_MT8173 to BUS_PROT_UPDATE_TOPAXI as in all the
  other SoCs TOPAXI is mapped to the same address.

Changes in v2: None

 drivers/soc/mediatek/mt8173-pm-domains.h | 18 ++++++++---------
 drivers/soc/mediatek/mtk-pm-domains.c    | 23 +++++++++++++++-------
 drivers/soc/mediatek/mtk-pm-domains.h    | 25 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 72b3acaf74fb..3e8ee5dabb43 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -34,10 +34,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg[0] = {
-			.bus_prot_reg_update = true,
-			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
-				MT8173_TOP_AXI_PROT_EN_MM_M1,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT8173_POWER_DOMAIN_VENC_LT] = {
@@ -76,12 +75,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg[0] = {
-			.bus_prot_reg_update = true,
-			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
-				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 6122701d018f..8a21847464c2 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -32,6 +32,7 @@ struct scpsys_domain {
 	int num_clks;
 	struct clk_bulk_data *clks;
 	struct regmap *infracfg;
+	struct regmap *smi;
 };
 
 struct scpsys {
@@ -99,9 +100,9 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 		if (bpd[i].bus_prot_reg_update)
 			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
 		else
-			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
+			regmap_write(regmap, bpd[i].bus_prot_set, mask);
 
-		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, (val & mask) == mask,
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
@@ -116,8 +117,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	int ret;
 
 	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
+	if (ret)
+		return ret;
 
-	return ret;
+	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
 }
 
 static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
@@ -134,9 +137,9 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		if (bpd[i].bus_prot_reg_update)
 			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
 		else
-			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
+			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
-		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, !(val & mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
@@ -150,9 +153,11 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
 	int ret;
 
-	ret = _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
+	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
+	if (ret)
+		return ret;
 
-	return ret;
+	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
@@ -267,6 +272,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->infracfg))
 		return ERR_CAST(pd->infracfg);
 
+	pd->smi = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,smi");
+	if (IS_ERR(pd->smi))
+		return ERR_CAST(pd->smi);
+
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
 		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 125880a58170..c2defbdcdf31 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -34,8 +34,31 @@
 
 #define SPM_MAX_BUS_PROT_DATA		5
 
+#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
+		.bus_prot_mask = (_mask),		\
+		.bus_prot_set = _set,			\
+		.bus_prot_clr = _clr,			\
+		.bus_prot_sta = _sta,			\
+		.bus_prot_reg_update = _update,		\
+	}
+
+#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, false)
+
+#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, true)
+
+#define BUS_PROT_UPDATE_TOPAXI(_mask)				\
+		BUS_PROT_UPDATE(_mask,				\
+				INFRA_TOPAXI_PROTECTEN,		\
+				INFRA_TOPAXI_PROTECTEN_CLR,	\
+				INFRA_TOPAXI_PROTECTSTA1)
+
 struct scpsys_bus_prot_data {
 	u32 bus_prot_mask;
+	u32 bus_prot_set;
+	u32 bus_prot_clr;
+	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 };
 
@@ -47,6 +70,7 @@ struct scpsys_bus_prot_data {
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
  * @caps: The flag for active wake-up action.
  * @bp_infracfg: bus protection for infracfg subsystem
+ * @bp_smi: bus protection for smi subsystem
  */
 struct scpsys_domain_data {
 	u32 sta_mask;
@@ -55,6 +79,7 @@ struct scpsys_domain_data {
 	u32 sram_pdn_ack_bits;
 	u8 caps;
 	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
+	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
 };
 
 struct scpsys_soc_data {
-- 
2.28.0

