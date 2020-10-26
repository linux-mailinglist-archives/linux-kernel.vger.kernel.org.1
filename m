Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6C29948D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788868AbgJZR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:56:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788713AbgJZRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8F8DB1F44FCC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 04/16] soc: mediatek: pm-domains: Add bus protection protocol
Date:   Mon, 26 Oct 2020 18:55:13 +0100
Message-Id: <20201026175526.2915399-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Bus protection will need to update more then one register
in infracfg. Add support for several operations.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/mt8173-pm-domains.h |  4 +--
 drivers/soc/mediatek/mtk-pm-domains.c    | 36 +++++++++++++++++-------
 drivers/soc/mediatek/mtk-pm-domains.h    |  4 ++-
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index a2a624bbd8b8..341cc287c8ce 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -34,7 +34,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
+		.bp_infracfg[0] = {
 			.bus_prot_reg_update = true,
 			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
 				MT8173_TOP_AXI_PROT_EN_MM_M1,
@@ -76,7 +76,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
+		.bp_infracfg[0] = {
 			.bus_prot_reg_update = true,
 			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
 				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 16503d6db6a8..2121e05cb9a4 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -89,24 +89,40 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 
 static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
-	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int i, ret;
 
-	if (!bp_data->bus_prot_mask)
-		return 0;
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask)
+			break;
 
-	return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
-					       bp_data->bus_prot_reg_update);
+		ret = mtk_infracfg_set_bus_protection(pd->infracfg,
+						      bpd[i].bus_prot_mask,
+						      bpd[i].bus_prot_reg_update);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
-	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int i, ret;
 
-	if (!bp_data->bus_prot_mask)
-		return 0;
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask)
+			return 0;
 
-	return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
-						 bp_data->bus_prot_reg_update);
+		ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
+							bpd[i].bus_prot_mask,
+							bpd[i].bus_prot_reg_update);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 7c8efcb3cef2..e428fe23a7e3 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -32,6 +32,8 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
+#define SPM_MAX_BUS_PROT_DATA		3
+
 struct scpsys_bus_prot_data {
 	u32 bus_prot_mask;
 	bool bus_prot_reg_update;
@@ -52,7 +54,7 @@ struct scpsys_domain_data {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u8 caps;
-	const struct scpsys_bus_prot_data bp_infracfg;
+	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
 };
 
 struct scpsys_soc_data {
-- 
2.28.0

