Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B92A0448
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJ3Lgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgJ3Lgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C7A211F45EC2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 07/16] soc: mediatek: pm-domains: Add extra sram control
Date:   Fri, 30 Oct 2020 12:36:13 +0100
Message-Id: <20201030113622.201188-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
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
Seires-changes: 4
- Use the regmap_[clear|set]_bits helpers.

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Nit, split readl(ctl_addr) | pd->data->sram_pdn_bits in two lines.
- Use regmap API

 drivers/soc/mediatek/mtk-pm-domains.c | 23 +++++++++++++++++++++--
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 8a21847464c2..a6f25933dbf0 100644
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
@@ -65,12 +67,23 @@ static int scpsys_sram_enable(struct scpsys_domain *pd)
 	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
+	int ret;
 
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
-	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
-					(tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	ret = regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
+				       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT);
+		udelay(1);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT);
+	}
+
+	return 0;
 }
 
 static int scpsys_sram_disable(struct scpsys_domain *pd)
@@ -79,6 +92,12 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_ISO)) {
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_CLKISO_BIT);
+		udelay(1);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT);
+	}
+
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index c2defbdcdf31..f190a0d9e592 100644
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

