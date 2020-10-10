Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B728A1EB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgJJWqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:46:23 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:55804 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbgJJTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=kvEiAQjl/OxAvtM+IX3ZURXJtqGWvCvtd2Q+tKQM1BA=;
        b=tYjuFl1TorVmp0KtWe7tqSSQkve1uf+BeZWsmV+DRftXsWo+52JYzcyYPWve+nWqjrOn
        n5ZHSisjDKxoLcy/2RNfEgRIHigVDJFfcT3egaOVrQquwVaXKALo7qIOeSMdJq023YWoXc
        s5BPxXGlEh0xxM2gGWfrduYcZ4Pkbn33Y=
Received: by filterdrecv-p3mdw1-6685f47d68-bjgll with SMTP id filterdrecv-p3mdw1-6685f47d68-bjgll-19-5F81D402-36
        2020-10-10 15:32:18.64429573 +0000 UTC m=+233779.898003005
Received: from bionic.localdomain (unknown)
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP
        id cwumXMZaQkmF52mb04iBbg
        Sat, 10 Oct 2020 15:32:18.360 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 2/6] phy/rockchip: inno-hdmi: round fractal pixclock in
 rk3328 recalc_rate
Date:   Sat, 10 Oct 2020 15:32:18 +0000 (UTC)
Message-Id: <20201010153214.19722-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010153214.19722-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20201010153214.19722-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzVDAzW3kg=2FB4zFwN?=
 =?us-ascii?Q?9VFCDMBaj1mZBeemn9atN=2FqgEFbpLBj5w1oby38?=
 =?us-ascii?Q?ipeb3wBI0xmrA8kzT9B9Gxp=2FuufHI4nnOKnH=2F6M?=
 =?us-ascii?Q?aMferKqlgJXIiJ5dbBu9hIbwD8ZZg=2FFxN9oHfox?=
 =?us-ascii?Q?QpubpJx59agRpSJQXqHk0vYTDFqmTecjADKdTMg?=
 =?us-ascii?Q?7t4jnlezMAPMbz+Ytj9SQ=3D=3D?=
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

