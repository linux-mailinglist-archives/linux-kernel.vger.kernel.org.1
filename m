Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1082A0463
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgJ3Lhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:37:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59034 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgJ3Lgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D6C5A1F45EBC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 05/16] soc: mediatek: pm_domains: Make bus protection generic
Date:   Fri, 30 Oct 2020 12:36:11 +0100
Message-Id: <20201030113622.201188-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
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

Changes in v4:
- Remove bpd variable from scpsys_bus_protect_[enable|disable]()
- Remove dependency of Kconfig symbol MTK_INFRACFG

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/Kconfig          |  1 -
 drivers/soc/mediatek/mtk-infracfg.c   |  5 ---
 drivers/soc/mediatek/mtk-pm-domains.c | 57 +++++++++++++++++++++------
 include/linux/soc/mediatek/infracfg.h |  5 +++
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 68d800f9e4a5..67cef12dc585 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -48,7 +48,6 @@ config MTK_SCPSYS_PM_DOMAINS
 	bool "MediaTek SCPSYS generic power domain"
 	default ARCH_MEDIATEK
 	depends on PM
-	depends on MTK_INFRACFG
 	select PM_GENERIC_DOMAINS
 	select REGMAP
 	help
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
index 06a16e45356a..6122701d018f 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -86,18 +86,24 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
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
+			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_SET, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, (val & mask) == mask,
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -105,18 +111,34 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
+
+	return ret;
+}
+
+static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
+				       struct regmap *regmap)
 {
-	const struct scpsys_bus_prot_data *bpd = pd->data->bp_infracfg;
 	int i, ret;
 
-	for (i = SPM_MAX_BUS_PROT_DATA; i > 0; i--) {
-		if (!bpd[i].bus_prot_mask)
+	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
+		u32 val, mask = bpd[i].bus_prot_mask;
+
+		if (!mask)
 			continue;
 
-		ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
-							bpd[i].bus_prot_mask,
-							bpd[i].bus_prot_reg_update);
+		if (bpd[i].bus_prot_reg_update)
+			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
+		else
+			regmap_write(regmap, INFRA_TOPAXI_PROTECTEN_CLR, mask);
+
+		ret = regmap_read_poll_timeout(regmap, INFRA_TOPAXI_PROTECTSTA1,
+					       val, !(val & mask),
+					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
 	}
@@ -124,6 +146,15 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 	return 0;
 }
 
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	int ret;
+
+	ret = _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
+
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

