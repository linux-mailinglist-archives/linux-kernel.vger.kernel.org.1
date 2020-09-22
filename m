Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAB274A91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVVEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:04:48 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:9925 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=kvEiAQjl/OxAvtM+IX3ZURXJtqGWvCvtd2Q+tKQM1BA=;
        b=IiYXmlwlQlh9mv3qt9fRJwqL22t1Rb3ZUAQbOXQDA0WDW2mD+1AF0096pz8UTV2zTkpM
        dkZ7ecS20xtSiBd7DFpygD2mPAG7cnbarJfIl60+Z01WKr4StxQmtcznv8P/4PXGW7tMOt
        HcqroEI+ATq1f3qRfe4gHX3a/UnRm7hAc=
Received: by filterdrecv-p3las1-6f66587546-ttjj9 with SMTP id filterdrecv-p3las1-6f66587546-ttjj9-18-5F6A65BC-45
        2020-09-22 20:59:40.720149015 +0000 UTC m=+82857.797950641
Received: from bionic.localdomain (unknown)
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP
        id aX0E0uBJQUuwakAhcsy3xQ
        Tue, 22 Sep 2020 20:59:40.231 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 2/6] phy/rockchip: inno-hdmi: round fractal pixclock in
 rk3328 recalc_rate
Date:   Tue, 22 Sep 2020 20:59:40 +0000 (UTC)
Message-Id: <20200922205933.5540-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922205933.5540-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20200922205933.5540-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FCONtaL2TMeuT9AH?=
 =?us-ascii?Q?hxlQqopJ7Vg9IZ1f8+ngnvWxq1iOnBOW8q8SrTk?=
 =?us-ascii?Q?l7ANkOvKEubt7lHHU3GDQsNRg+RhNT7RXnITPY5?=
 =?us-ascii?Q?9EOuCeGpQU4urm42YeHDR+1sw7czcyjfzYAu9T5?=
 =?us-ascii?Q?WkRXrt9cAuNElZr2=2FLgziefUS2R+9nFxtAMEJ+R?=
 =?us-ascii?Q?a6M4NA5QPh97L44qwAyEg=3D=3D?=
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

From: Zheng Yang <zhengyang@rock-chips.com>

inno_hdmi_phy_rk3328_clk_recalc_rate() is returning a rate not found
in the pre pll config table when the fractal divider is used.
This can prevent proper power_on because a tmdsclock for the new rate
is not found in the pre pll config table.

Fix this by saving and returning a rounded pixel rate that exist
in the pre pll config table.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index b0ac1d3ee390..093d2334e8cd 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -745,10 +745,12 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
 	}
 
-	inno->pixclock = vco;
-	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
+	inno->pixclock = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
 
-	return vco;
+	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
+		__func__, inno->pixclock, vco);
+
+	return inno->pixclock;
 }
 
 static long inno_hdmi_phy_rk3328_clk_round_rate(struct clk_hw *hw,
-- 
2.17.1

