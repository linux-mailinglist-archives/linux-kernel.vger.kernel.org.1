Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD24280378
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgJAQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:02:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJAQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:02:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A015929D759
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/12] soc: mediatek: pm-domains: Add extra sram control
Date:   Thu,  1 Oct 2020 18:01:49 +0200
Message-Id: <20201001160154.3587848-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001160154.3587848-1-enric.balletbo@collabora.com>
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
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

Changes in v2:
- Nit, split readl(ctl_addr) | pd->data->sram_pdn_bits in two lines.
- Use regmap API

 drivers/soc/mediatek/mtk-pm-domains.c | 30 +++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 38f2630bdd0a..e0a52d489fea 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -21,6 +21,7 @@
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
+#define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -42,6 +43,8 @@
 #define PWR_ON_BIT			BIT(2)
 #define PWR_ON_2ND_BIT			BIT(3)
 #define PWR_CLK_DIS_BIT			BIT(4)
+#define PWR_SRAM_CLKISO_BIT		BIT(5)
+#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
 
 #define PWR_STATUS_DISP			BIT(3)
 #define PWR_STATUS_MFG			BIT(4)
@@ -155,14 +158,28 @@ static int scpsys_sram_enable(struct scpsys_domain *pd)
 	struct scpsys *scpsys = pd->scpsys;
 	u32 val;
 	int tmp;
+	int ret;
 
 	regmap_read(scpsys->base, pd->data->ctl_offs, &val);
 	val &= ~pd->data->sram_pdn_bits;
 	regmap_write(scpsys->base, pd->data->ctl_offs, val);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
-	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
-					(tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	ret = regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
+				       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_read(scpsys->base, pd->data->ctl_offs, &val);
+		val |= PWR_SRAM_ISOINT_B_BIT;
+		regmap_write(scpsys->base, pd->data->ctl_offs, val);
+		udelay(1);
+		val &= ~PWR_SRAM_CLKISO_BIT;
+		regmap_write(scpsys->base, pd->data->ctl_offs, val);
+	}
+
+	return 0;
 }
 
 static int scpsys_sram_disable(struct scpsys_domain *pd)
@@ -172,6 +189,15 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 	u32 val;
 	int tmp;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_read(scpsys->base, pd->data->ctl_offs, &val);
+		val |= PWR_SRAM_CLKISO_BIT;
+		regmap_write(scpsys->base, pd->data->ctl_offs, val);
+		val &= ~PWR_SRAM_ISOINT_B_BIT;
+		regmap_write(scpsys->base, pd->data->ctl_offs, val);
+		udelay(1);
+	}
+
 	regmap_read(scpsys->base, pd->data->ctl_offs, &val);
 	val |= pd->data->sram_pdn_bits;
 	regmap_write(scpsys->base, pd->data->ctl_offs, val);
-- 
2.28.0

