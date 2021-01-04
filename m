Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDD2E9391
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhADKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:45:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42795 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbhADKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:45:44 -0500
X-UUID: 9b5385af24094c0ba70355af701a151c-20210104
X-UUID: 9b5385af24094c0ba70355af701a151c-20210104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2051912601; Mon, 04 Jan 2021 18:44:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 2/2] soc: mediatek: Fix the clock prepared issue
Date:   Mon, 4 Jan 2021 18:44:53 +0800
Message-ID: <1609757093-30618-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com>
References: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this new power domain driver, when adding one power domain
it will prepare the depenedent clocks at the same.
So we only do clk_bulk_enable/disable control during power ON/OFF.
When system suspend, the pm runtime framework will forcely power off
power domains. However, the dependent clocks are disabled but kept
preapred.

In MediaTek clock drivers, PLL would be turned ON when we do
clk_bulk_prepare control.

Clock hierarchy:
PLL -->
       DIV_CK -->
                 CLK_MUX
                 (may be dependent clocks)
                         -->
                             SUBSYS_CG
                             (may be dependent clocks)

It will lead some unexpected clock states during system suspend.
This patch will fix by doing prepare_enable/disable_unprepare on
dependent clocks at the same time while we are going to power on/off
any power domain.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index a160800..f0bcc84 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -216,7 +216,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 	if (ret)
 		goto err_disable_regulator;
 
@@ -234,7 +234,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
-	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
+	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
 	if (ret)
 		goto err_pwr_ack;
 
@@ -251,9 +251,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
-	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
-	clk_bulk_disable(pd->num_clks, pd->clks);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_disable_regulator:
 	scpsys_regulator_disable(pd);
 	return ret;
@@ -274,7 +274,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
 	/* subsys power off */
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
@@ -289,7 +289,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	clk_bulk_disable(pd->num_clks, pd->clks);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 
 	ret = scpsys_regulator_disable(pd);
 	if (ret < 0)
@@ -402,14 +402,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		pd->subsys_clks[i].clk = clk;
 	}
 
-	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
-	if (ret)
-		goto err_put_subsys_clocks;
-
-	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
-	if (ret)
-		goto err_unprepare_clocks;
-
 	/*
 	 * Initially turn on all domains to make the domains usable
 	 * with !CONFIG_PM and to get the hardware in sync with the
@@ -424,7 +416,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = scpsys_power_on(&pd->genpd);
 		if (ret < 0) {
 			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
-			goto err_unprepare_clocks;
+			goto err_put_subsys_clocks;
 		}
 	}
 
@@ -432,7 +424,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = -EINVAL;
 		dev_err(scpsys->dev,
 			"power domain with id %d already exists, check your device-tree\n", id);
-		goto err_unprepare_subsys_clocks;
+		goto err_put_subsys_clocks;
 	}
 
 	pd->genpd.name = pd->data->name ?: node->name;
@@ -448,10 +440,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	return scpsys->pd_data.domains[id];
 
-err_unprepare_subsys_clocks:
-	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
-err_unprepare_clocks:
-	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_subsys_clocks:
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 err_put_clocks:
@@ -529,10 +517,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
 
-	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
-
-	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
 
-- 
1.8.1.1.dirty

