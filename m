Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D708274A90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVVEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:04:44 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:4003 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIVVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=HR4kr+bDhTd27xGffh3PFuiOeC0GhYxHGFLRteOkMOg=;
        b=H0l1IUUOgQ6DfRADAxHaMNevyJ9aeIsU+EiacVdKLWWqms00Apt4LG8XTRw/h+CQD5zi
        JVGVAQxH62QwajlCgnXlBDUM+tk05WQ11Pahu0ZXcPbsjnATV7Kcfbe4JQR4YOaAp4iDOw
        ZZEWSkL0IJ1nk7vmMIz5e89aY4bQi1UPs=
Received: by filterdrecv-p3las1-6f66587546-9bmz7 with SMTP id filterdrecv-p3las1-6f66587546-9bmz7-18-5F6A65BB-96
        2020-09-22 20:59:40.248452326 +0000 UTC m=+82861.327504145
Received: from bionic.localdomain (unknown)
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP
        id otx7jw5jSJKerU6tcBxPgw
        Tue, 22 Sep 2020 20:59:39.785 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/6] phy/rockchip: inno-hdmi: use correct vco_div_5 macro
 on rk3328
Date:   Tue, 22 Sep 2020 20:59:40 +0000 (UTC)
Message-Id: <20200922205933.5540-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922205933.5540-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20200922205933.5540-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h209qa+logUm6JKkF?=
 =?us-ascii?Q?KZU=2FLoAQ++1JQCxG6r=2Fj0UBotsg9vU5lFttle2o?=
 =?us-ascii?Q?FsixhjBKV9ROncidG289=2Fcbr2JexXRoVQWwodyk?=
 =?us-ascii?Q?4q4fS7ox2h8XBXyhZTKM7yFt5I0+YoiMiqMmO8O?=
 =?us-ascii?Q?sIgrFDWbfaqPRF1Q0TxzEob4aTHzWXrJnOtVu7+?=
 =?us-ascii?Q?lWN=2FpmdNi53bnnideunPg=3D=3D?=
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>, Vinod Koul <vkoul@kernel.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Algea Cao <algea.cao@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inno_hdmi_phy_rk3328_clk_set_rate() is using the RK3228 macro
when configuring vco_div_5 on RK3328.

Fix this by using correct vco_div_5 macro for RK3328.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 9ca20c947283..b0ac1d3ee390 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -790,8 +790,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 			 RK3328_PRE_PLL_POWER_DOWN);
 
 	/* Configure pre-pll */
-	inno_update_bits(inno, 0xa0, RK3228_PCLK_VCO_DIV_5_MASK,
-			 RK3228_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
+	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
+			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
 	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
 
 	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
-- 
2.17.1

