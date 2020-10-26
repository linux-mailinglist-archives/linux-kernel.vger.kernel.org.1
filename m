Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2743D299486
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788749AbgJZRzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788728AbgJZRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 48AD91F44FC9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 07/16] soc: mediatek: pm-domains: Add extra sram control
Date:   Mon, 26 Oct 2020 18:55:16 +0100
Message-Id: <20201026175526.2915399-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

For some power domains like vpu_core on MT8183 whose sram need to do clock
and internal isolation while power on/off sram. We add a cap
"MTK_SCPD_SRAM_ISO" to judge if we need to do the extra sram isolation
control or not.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2:
- Nit, split readl(ctl_addr) | pd->data->sram_pdn_bits in two lines.
- Use regmap API

 drivers/soc/mediatek/mtk-pm-domains.c | 25 +++++++++++++++++++++++--
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 006eb7571d32..82f6d937ed93 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -24,6 +24,8 @@
 #define PWR_ON_BIT			BIT(2)
 #define PWR_ON_2ND_BIT			BIT(3)
 #define PWR_CLK_DIS_BIT			BIT(4)
+#define PWR_SRAM_CLKISO_BIT		BIT(5)
+#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
 
 struct scpsys_domain {
 	struct generic_pm_domain genpd;
@@ -65,12 +67,24 @@ static int scpsys_sram_enable(struct scpsys_domain *pd)
 	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
+	int ret;
 
 	regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits, 0);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
-	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
-					(tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	ret = regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
+				       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT,
+				   PWR_SRAM_ISOINT_B_BIT);
+		udelay(1);
+		regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT, 0);
+	}
+
+	return 0;
 }
 
 static int scpsys_sram_disable(struct scpsys_domain *pd)
@@ -79,6 +93,13 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT,
+				   PWR_SRAM_CLKISO_BIT);
+		udelay(1);
+		regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT, 0);
+	}
+
 	regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits,
 			   pd->data->sram_pdn_bits);
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 7b1abcfc4ba3..4152b96c1b29 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -5,6 +5,7 @@
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
+#define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.28.0

