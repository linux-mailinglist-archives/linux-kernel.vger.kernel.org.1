Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E328A1F1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgJJWvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:51:38 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:14372 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbgJJTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=nAJZakghzr7JwdXt31dydBHC6AGXJnAIYTAyCKaQf5U=;
        b=PC35notrsluMKEtXrx+00hA/7mdLEP0dYlDe5YZ4F97AxB2FbB1c+8wCFl2DT/ypo8SJ
        lktfdkzCJKjCzl6ik8zAmz7ahPHYTYZbHZAUJ/VCbQDdzWzpDWDvovYpuhFxqqZFIH7ARr
        liinpjGwGy/EmEckcg2tKrDKhnMhEQcwo=
Received: by filterdrecv-p3mdw1-6685f47d68-ckbbx with SMTP id filterdrecv-p3mdw1-6685f47d68-ckbbx-20-5F81D403-62
        2020-10-10 15:32:19.989765983 +0000 UTC m=+233779.068193756
Received: from bionic.localdomain (unknown)
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP
        id svU4HSZBQumIlycPppIvOg
        Sat, 10 Oct 2020 15:32:19.702 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 5/6] phy/rockchip: inno-hdmi: force set_rate on power_on
Date:   Sat, 10 Oct 2020 15:32:20 +0000 (UTC)
Message-Id: <20201010153214.19722-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010153214.19722-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
 <20201010153214.19722-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyyYIFNv1tq5H+1qU?=
 =?us-ascii?Q?NYBOeobs=2FkbfAS1O=2Fyl8F4W63ETW0ZJQ8LdMpvZ?=
 =?us-ascii?Q?Xyiq4Ios7vQDZpdGL3Mwe6lFjuXN1joLZH8IGtl?=
 =?us-ascii?Q?mCzWhgIW9FS5VY78glB=2FH4sy=2FqfUu8YCOdDElAo?=
 =?us-ascii?Q?zoEZ7hwOMT7MB1ajMJUA7zqvt9i5Rq9fxR5fjUF?=
 =?us-ascii?Q?hRcD=2FqWbBOfWiOucUlMyg=3D=3D?=
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

From: Huicong Xu <xhc@rock-chips.com>

Regular 8-bit and Deep Color video formats mainly differ in TMDS rate and
not in pixel clock rate.
When the hdmiphy clock is configured with the same pixel clock rate using
clk_set_rate() the clock framework do not signal the hdmi phy driver
to set_rate when switching between 8-bit and Deep Color.
This result in pre/post pll not being re-configured when switching between
regular 8-bit and Deep Color video formats.

Fix this by calling set_rate in power_on to force pre pll re-configuration.

Signed-off-by: Huicong Xu <xhc@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 3a59a6da0440..3719309ad0d0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -245,6 +245,7 @@ struct inno_hdmi_phy {
 	struct clk_hw hw;
 	struct clk *phyclk;
 	unsigned long pixclock;
+	unsigned long tmdsclock;
 };
 
 struct pre_pll_config {
@@ -485,6 +486,8 @@ static int inno_hdmi_phy_power_on(struct phy *phy)
 
 	dev_dbg(inno->dev, "Inno HDMI PHY Power On\n");
 
+	inno->plat_data->clk_ops->set_rate(&inno->hw, inno->pixclock, 24000000);
+
 	ret = clk_prepare_enable(inno->phyclk);
 	if (ret)
 		return ret;
@@ -509,6 +512,8 @@ static int inno_hdmi_phy_power_off(struct phy *phy)
 
 	clk_disable_unprepare(inno->phyclk);
 
+	inno->tmdsclock = 0;
+
 	dev_dbg(inno->dev, "Inno HDMI PHY Power Off\n");
 
 	return 0;
@@ -628,6 +633,9 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -670,6 +678,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
@@ -781,6 +790,9 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -820,6 +832,7 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
-- 
2.17.1

