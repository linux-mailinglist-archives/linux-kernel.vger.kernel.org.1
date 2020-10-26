Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90A929947A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788805AbgJZRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788759AbgJZRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B67761F44FD4
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 15/16] soc: mediatek: pm-domains: Add default power off flag
Date:   Mon, 26 Oct 2020 18:55:24 +0100
Message-Id: <20201026175526.2915399-16-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

For some power domain, like conn on MT8192, it should be default OFF.
Because the power on/off control relies the function of connectivity chip
and its firmware. And if project choose other chip vendor solution,
those necessary connectivity functions will not provided.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/mtk-pm-domains.c | 23 +++++++++++++++++------
 drivers/soc/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 63993076a544..fe0e955076a0 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -378,10 +378,16 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	 * software.  The unused domains will be switched off during
 	 * late_init time.
 	 */
-	ret = scpsys_power_on(&pd->genpd);
-	if (ret < 0) {
-		dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
-		goto err_unprepare_clocks;
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
+		if (scpsys_domain_is_on(pd))
+			dev_warn(scpsys->dev,
+				 "%pOF: A default off power domain has been ON\n", node);
+	} else {
+		ret = scpsys_power_on(&pd->genpd);
+		if (ret < 0) {
+			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
+			goto err_unprepare_clocks;
+		}
 	}
 
 	if (scpsys->domains[id]) {
@@ -395,7 +401,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	pd->genpd.power_off = scpsys_power_off;
 	pd->genpd.power_on = scpsys_power_on;
 
-	pm_genpd_init(&pd->genpd, NULL, false);
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
+		pm_genpd_init(&pd->genpd, NULL, true);
+	else
+		pm_genpd_init(&pd->genpd, NULL, false);
+
 	scpsys->domains[id] = &pd->genpd;
 
 	return scpsys->pd_data.domains[id];
@@ -478,7 +488,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
 
-	scpsys_power_off(&pd->genpd);
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
+		scpsys_power_off(&pd->genpd);
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 2ad213be84a5..0fa6a938b40c 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -6,6 +6,7 @@
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_SRAM_ISO		BIT(2)
+#define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.28.0

