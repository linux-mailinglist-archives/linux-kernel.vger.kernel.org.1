Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2028D883
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgJNCfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:35:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:41766 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgJNCfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:35:10 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 22:35:08 EDT
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4491EC9973;
        Wed, 14 Oct 2020 10:28:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140199837284096S1602642493459899_;
        Wed, 14 Oct 2020 10:28:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dabb32f45699b564059b761a96482639>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 4/5] clk: rockchip: add pll up and down when change pll freq
Date:   Wed, 14 Oct 2020 10:28:11 +0800
Message-Id: <20201014022812.6733-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014022812.6733-1-zhangqing@rock-chips.com>
References: <20201014022812.6733-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set pll sequence:
        ->set pll to slow mode or other plls
        ->set pll down
        ->set pll params
        ->set pll up
        ->wait pll lock status
        ->set pll to normal mode

To slove the system error:
wait_pll_lock: timeout waiting for pll to lock
pll_set_params: pll update unsucessful,
                trying to restore old params

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 4c6c9167ef50..8adc6f54a605 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -210,6 +210,11 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 		rate_change_remuxed = 1;
 	}
 
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3036_PLLCON1_PWRDOWN,
+			     RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+
 	/* update pll values */
 	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MASK,
 					  RK3036_PLLCON0_FBDIV_SHIFT) |
@@ -231,6 +236,11 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 	pllcon |= rate->frac << RK3036_PLLCON2_FRAC_SHIFT;
 	writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
 
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+	udelay(1);
+
 	/* wait for the pll to lock */
 	ret = rockchip_rk3036_pll_wait_lock(pll);
 	if (ret) {
@@ -692,6 +702,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 		rate_change_remuxed = 1;
 	}
 
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3399_PLLCON3_PWRDOWN,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+
 	/* update pll values */
 	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
 						  RK3399_PLLCON0_FBDIV_SHIFT),
@@ -715,6 +730,12 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 					    RK3399_PLLCON3_DSMPD_SHIFT),
 		       pll->reg_base + RK3399_PLLCON(3));
 
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+	udelay(1);
+
 	/* wait for the pll to lock */
 	ret = rockchip_rk3399_pll_wait_lock(pll);
 	if (ret) {
-- 
2.17.1



