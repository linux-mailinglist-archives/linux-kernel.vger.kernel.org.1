Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31128A1EA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgJJWpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:45:10 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:58665 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbgJJTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=HR4kr+bDhTd27xGffh3PFuiOeC0GhYxHGFLRteOkMOg=;
        b=HglME5tep4F8tssX/3Kj3u2SPccF41KenX3c6TfEVBc1wLEKqAh0Ciix6djA/8xPmb7v
        igaha0pQ33dUKRd8vGH9rQ0Qh0atiblOe9BLbjDbBipFGvLESBsKBMfkt5e14T2P/aAkdf
        pF42OMSWjasHOm1B7zD6na0yueFOXbIFk=
Received: by filterdrecv-p3mdw1-6685f47d68-rbs6q with SMTP id filterdrecv-p3mdw1-6685f47d68-rbs6q-18-5F81D402-2
        2020-10-10 15:32:18.198781183 +0000 UTC m=+233784.103325308
Received: from bionic.localdomain (unknown)
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP
        id IDVGaD7fTTeGX5FuXCLoeA
        Sat, 10 Oct 2020 15:32:17.911 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/6] phy/rockchip: inno-hdmi: use correct vco_div_5 macro
 on rk3328
Date:   Sat, 10 Oct 2020 15:32:18 +0000 (UTC)
Message-Id: <20201010153214.19722-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010153214.19722-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20201010153214.19722-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5PeQ=2F8GT5JxvfjTx?=
 =?us-ascii?Q?oREXZhpZWKmUXxK7F7a9E3o4w0pmPqqTCy+z7ob?=
 =?us-ascii?Q?bLB=2FanqZtFMNH+Of8VMqZzD+tyeqX2pBqw+KOzq?=
 =?us-ascii?Q?8rplyos3R3oYCGG1SyRghCFeIMmknMpHrSQtLjg?=
 =?us-ascii?Q?WAqxmgz63p40VxMBp7Cb07IdmOorp8HNJ6JAqiI?=
 =?us-ascii?Q?G+Ew2VDfVYi5uXkWRiwig=3D=3D?=
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

