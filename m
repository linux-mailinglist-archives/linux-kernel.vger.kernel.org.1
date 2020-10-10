Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B928A1C1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgJJWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:51:53 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:4297 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbgJJTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=z7v+PHtCfxxSYzksa8sjIkGNZO+Cebil1muBgONTycw=;
        b=W0oVnutJoRuNz5mp/ETjW03TseZjrsUsoXeM90QXo/qdUG1EtBzL3/iDOJkKnY8Xz9Ro
        P+8GU2kfwuKa4Km36KzWBTsKlE0vCbjciXufqGKBQzRGdovImyBburKt2QJYGpp9CIXaAf
        msZcIAJtVMfmfhP2LUIZ3xM8c+uOVBNpY=
Received: by filterdrecv-p3mdw1-6685f47d68-78qj6 with SMTP id filterdrecv-p3mdw1-6685f47d68-78qj6-18-5F81D403-32
        2020-10-10 15:32:19.538936526 +0000 UTC m=+233775.988108048
Received: from bionic.localdomain (unknown)
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP
        id nmh82tHhTdyiOk1sd1xYvA
        Sat, 10 Oct 2020 15:32:19.255 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 4/6] phy/rockchip: inno-hdmi: do not power on rk3328 post
 pll on reg write
Date:   Sat, 10 Oct 2020 15:32:19 +0000 (UTC)
Message-Id: <20201010153214.19722-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010153214.19722-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20201010153214.19722-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h3onD66qw86ldXqOu?=
 =?us-ascii?Q?J8YOYMUoLGHsGWeoUUrZbkWIwpmdMK4Fhdgb9BS?=
 =?us-ascii?Q?1b5zzZq8k2PWp3qUyoPLNIRJ0xNRnJQ2FQpyxwp?=
 =?us-ascii?Q?z=2FpRPiWuuOjxW6ylTAqX2uVlgyb0s0tO6424TlW?=
 =?us-ascii?Q?GE1wFKEX2plRTJmXJE5jTOnhhgiWLkwPLm2tWXn?=
 =?us-ascii?Q?0oHKce08yCrhhEmViEBBg=3D=3D?=
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>, Vinod Koul <vkoul@kernel.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Algea Cao <algea.cao@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Entity-ID: wSPGWgGSXUap++qShBI+ag==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inno_write is used to configure 0xaa reg, that also hold the
POST_PLL_POWER_DOWN bit.
When POST_PLL_REFCLK_SEL_TMDS is configured the power down bit is not
taken into consideration.

Fix this by keeping the power down bit until configuration is complete.
Also reorder the reg write order for consistency.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 06db69c8373e..3a59a6da0440 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -1020,9 +1020,10 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 
 	inno_write(inno, 0xac, RK3328_POST_PLL_FB_DIV_7_0(cfg->fbdiv));
 	if (cfg->postdiv == 1) {
-		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS);
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
+		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	} else {
 		v = (cfg->postdiv / 2) - 1;
 		v &= RK3328_POST_PLL_POST_DIV_MASK;
@@ -1030,7 +1031,8 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
 		inno_write(inno, 0xaa, RK3328_POST_PLL_POST_DIV_ENABLE |
-			   RK3328_POST_PLL_REFCLK_SEL_TMDS);
+			   RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	}
 
 	for (v = 0; v < 14; v++)
-- 
2.17.1

