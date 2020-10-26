Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5254529947B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781655AbgJZR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:56:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788766AbgJZRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 879D01F44FD5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 16/16] soc: mediatek: pm-domains: Add support for mt8192
Date:   Mon, 26 Oct 2020 18:55:25 +0100
Message-Id: <20201026175526.2915399-17-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add the needed board data to support mt8192 SoC.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/mt8192-pm-domains.h | 292 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 drivers/soc/mediatek/mtk-pm-domains.h    |   2 +-
 include/linux/soc/mediatek/infracfg.h    |  56 +++++
 4 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/mediatek/mt8192-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
new file mode 100644
index 000000000000..b4bdddb7c817
--- /dev/null
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8192_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8192_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt8192-power.h>
+
+/*
+ * MT8192 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
+	[MT8192_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x0354,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_AUDIO,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_CONN] = {
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x0304,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN_2ND,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CONN,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8192_POWER_DOMAIN_MFG0] = {
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x0308,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_MFG1] = {
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x030c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_MFG1,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MFG1,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_MFG2] = {
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x0310,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_MFG3] = {
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x0314,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_MFG4] = {
+		.sta_mask = BIT(6),
+		.ctl_offs = 0x0318,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_MFG5] = {
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x031c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_MFG6] = {
+		.sta_mask = BIT(8),
+		.ctl_offs = 0x0320,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_DISP] = {
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x0350,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_DISP,
+					MT8192_TOP_AXI_PROT_EN_MM_SET,
+					MT8192_TOP_AXI_PROT_EN_MM_CLR,
+					MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_2_DISP,
+					MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+					MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+					MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_DISP,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_IPE] = {
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x0338,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_ISP] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x0330,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_ISP2] = {
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x0334,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_MDP] = {
+		.sta_mask = BIT(19),
+		.ctl_offs = 0x034c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_VENC] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x0344,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_VDEC] = {
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x033c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_VDEC2] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0340,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_CAM] = {
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x035c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_CAM,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CAM,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_VDNR_CAM,
+				    MT8192_TOP_AXI_PROT_EN_VDNR_SET,
+				    MT8192_TOP_AXI_PROT_EN_VDNR_CLR,
+				    MT8192_TOP_AXI_PROT_EN_VDNR_STA1),
+		},
+	},
+	[MT8192_POWER_DOMAIN_CAM_RAWA] = {
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x0360,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_CAM_RAWB] = {
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0364,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8192_POWER_DOMAIN_CAM_RAWC] = {
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x0368,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+};
+
+static const struct scpsys_soc_data mt8192_scpsys_data = {
+	.domains = scpsys_domain_data_mt8192,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8192),
+	.pwr_sta_offs = 0x016c,
+	.pwr_sta2nd_offs = 0x0170,
+};
+
+#endif /* __SOC_MEDIATEK_MT8192_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index fe0e955076a0..69f8e5458731 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -17,6 +17,7 @@
 
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
+#include "mt8192-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
@@ -522,6 +523,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8183-power-controller",
 		.data = &mt8183_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8192-power-controller",
+		.data = &mt8192_scpsys_data,
+	},
 	{ }
 };
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 0fa6a938b40c..eda453f55126 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -35,7 +35,7 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
-#define SPM_MAX_BUS_PROT_DATA		3
+#define SPM_MAX_BUS_PROT_DATA		5
 
 #define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
 		.bus_prot_mask = (_mask),			\
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 9d01e32e19bc..e7842debc05d 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -2,6 +2,62 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define MT8192_TOP_AXI_PROT_EN_STA1			0x228
+#define MT8192_TOP_AXI_PROT_EN_1_STA1			0x258
+#define MT8192_TOP_AXI_PROT_EN_SET			0x2a0
+#define MT8192_TOP_AXI_PROT_EN_CLR			0x2a4
+#define MT8192_TOP_AXI_PROT_EN_1_SET			0x2a8
+#define MT8192_TOP_AXI_PROT_EN_1_CLR			0x2ac
+#define MT8192_TOP_AXI_PROT_EN_MM_SET			0x2d4
+#define MT8192_TOP_AXI_PROT_EN_MM_CLR			0x2d8
+#define MT8192_TOP_AXI_PROT_EN_MM_STA1			0x2ec
+#define MT8192_TOP_AXI_PROT_EN_2_SET			0x714
+#define MT8192_TOP_AXI_PROT_EN_2_CLR			0x718
+#define MT8192_TOP_AXI_PROT_EN_2_STA1			0x724
+#define MT8192_TOP_AXI_PROT_EN_VDNR_SET			0xb84
+#define MT8192_TOP_AXI_PROT_EN_VDNR_CLR			0xb88
+#define MT8192_TOP_AXI_PROT_EN_VDNR_STA1		0xb90
+#define MT8192_TOP_AXI_PROT_EN_MM_2_SET			0xdcc
+#define MT8192_TOP_AXI_PROT_EN_MM_2_CLR			0xdd0
+#define MT8192_TOP_AXI_PROT_EN_MM_2_STA1		0xdd8
+
+#define MT8192_TOP_AXI_PROT_EN_DISP			(BIT(6) | BIT(23))
+#define MT8192_TOP_AXI_PROT_EN_CONN			(BIT(13) | BIT(18))
+#define MT8192_TOP_AXI_PROT_EN_CONN_2ND			BIT(14)
+#define MT8192_TOP_AXI_PROT_EN_MFG1			GENMASK(22, 21)
+#define MT8192_TOP_AXI_PROT_EN_1_CONN			BIT(10)
+#define MT8192_TOP_AXI_PROT_EN_1_MFG1			BIT(21)
+#define MT8192_TOP_AXI_PROT_EN_1_CAM			BIT(22)
+#define MT8192_TOP_AXI_PROT_EN_2_CAM			BIT(0)
+#define MT8192_TOP_AXI_PROT_EN_2_ADSP			BIT(3)
+#define MT8192_TOP_AXI_PROT_EN_2_AUDIO			BIT(4)
+#define MT8192_TOP_AXI_PROT_EN_2_MFG1			GENMASK(6, 5)
+#define MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND		BIT(7)
+#define MT8192_TOP_AXI_PROT_EN_MM_CAM			(BIT(0) | BIT(2))
+#define MT8192_TOP_AXI_PROT_EN_MM_DISP			(BIT(0) | BIT(2) | \
+							BIT(10) | BIT(12) | \
+							BIT(14) | BIT(16) | \
+							BIT(24) | BIT(26))
+#define MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND		(BIT(1) | BIT(3))
+#define MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND		(BIT(1) | BIT(3) | \
+							BIT(15) | BIT(17) | \
+							BIT(25) | BIT(27))
+#define MT8192_TOP_AXI_PROT_EN_MM_ISP2			BIT(14)
+#define MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND		BIT(15)
+#define MT8192_TOP_AXI_PROT_EN_MM_IPE			BIT(16)
+#define MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND		BIT(17)
+#define MT8192_TOP_AXI_PROT_EN_MM_VDEC			BIT(24)
+#define MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND		BIT(25)
+#define MT8192_TOP_AXI_PROT_EN_MM_VENC			BIT(26)
+#define MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND		BIT(27)
+#define MT8192_TOP_AXI_PROT_EN_MM_2_ISP			BIT(8)
+#define MT8192_TOP_AXI_PROT_EN_MM_2_DISP		(BIT(8) | BIT(12))
+#define MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND		BIT(9)
+#define MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND		(BIT(9) | BIT(13))
+#define MT8192_TOP_AXI_PROT_EN_MM_2_MDP			BIT(12)
+#define MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND		BIT(13)
+#define MT8192_TOP_AXI_PROT_EN_VDNR_CAM			BIT(21)
+
 #define MT8183_TOP_AXI_PROT_EN_STA1			0x228
 #define MT8183_TOP_AXI_PROT_EN_STA1_1			0x258
 #define MT8183_TOP_AXI_PROT_EN_SET			0x2a0
-- 
2.28.0

