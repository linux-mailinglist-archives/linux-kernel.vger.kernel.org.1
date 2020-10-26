Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F329948F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788876AbgJZR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:56:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788705AbgJZRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6E8191F44FCD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/16] soc: mediatek: pm_domains: Make bus protection generic
Date:   Mon, 26 Oct 2020 18:55:14 +0100
Message-Id: <20201026175526.2915399-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Bus protection is not exclusively done by calling the infracfg misc driver.
Make the calls for setting and clearing the bus protection generic so
that we can use other blocks for it as well.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/mtk-infracfg.c   |  5 ---
 drivers/soc/mediatek/mtk-pm-domains.c | 53 +++++++++++++++++++++------
 include/linux/soc/mediatek/infracfg.h |  5 +++
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 4a123796aad3..0590b68e0d78 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -12,11 +12,6 @@
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
-#define INFRA_TOPAXI_PROTECTEN		0x0220
-#define INFRA_TOPAXI_PROTECTSTA1	0x0228
-#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
-#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
-
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
  * @infracfg: The infracfg regmap
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 2121e05cb9a4..92c61e59255b 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -87,18 +87,24 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
 {
-	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_mask)
+		u32 val, mask = bpd[i].bus_prot_mask;
+
+		if (!mask)
 			break;
 
-		ret = mtk_infracfg_set_bus_protection(pd->infracfg,
-						      bpd[i].bus_prot_mask,
-						      bpd[i].bus_prot_reg_update);
+		if (bpd[i].bus_prot_reg_update)
+			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, mask);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, (val & mask) == mask,
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -106,18 +112,34 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
 	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int ret;
+
+	ret = _scpsys_bus_protect_enable(bpd, pd->infracfg);
+	return ret;
+}
+
+static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
+				       struct regmap *regmap)
+{
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_mask)
+		u32 val, mask = bpd[i].bus_prot_mask;
+
+		if (!mask)
 			return 0;
 
-		ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
-							bpd[i].bus_prot_mask,
-							bpd[i].bus_prot_reg_update);
+		if (bpd[i].bus_prot_reg_update)
+			regmap_update_bits(regmap, INFRA_TOPAXI_PROTECTEN, mask, 0);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, !(val & mask),
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -125,6 +147,15 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	return 0;
 }
 
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
+	int ret;
+
+	ret = _scpsys_bus_protect_disable(bpd, pd->infracfg);
+	return ret;
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 233463d789c6..5bcaab767f6a 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -32,6 +32,11 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
+#define INFRA_TOPAXI_PROTECTEN			0x0220
+#define INFRA_TOPAXI_PROTECTSTA1		0x0228
+#define INFRA_TOPAXI_PROTECTEN_SET		0x0260
+#define INFRA_TOPAXI_PROTECTEN_CLR		0x0264
+
 #define REG_INFRA_MISC				0xf00
 #define F_DDR_4GB_SUPPORT_EN			BIT(13)
 
-- 
2.28.0

