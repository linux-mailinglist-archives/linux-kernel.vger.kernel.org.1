Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4C22EB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgG0LWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 07:22:46 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46059 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgG0LWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595848965; x=1627384965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WYsT653Vi72lc3dyaN5qiishKRvrZsWLBHMGBkYlbuE=;
  b=u8SKtzy2nzzsQLET8vFCllJT/E1Ia30e83Etoh3zkbHX7QJzPPnoW5BC
   0XomA2H74HXTq+ehBVXD6UXnadtuWO7rFUb0Sh1NqUqdAnllzcUgOyigr
   Di0E0TbdCNbvTxSjD2467mGghwRIdEMY6X2NcfvoZN379syqKyGPBvTHX
   qVaXwU8HHL/p2KwBV0KWWl4+ePK4kI3EhJ9nK80na/5+KUz3npQCRvhZS
   ueV5q+/tVWjeE6OoG1CTW6P4Ndm764IHR+V83CyZOXdShOWyWDJMXXU2y
   ANABQMylHIT2mO1IdxSgB3RtP5d3tAVg2Np1g2QZ0trrYUmdklc3ztoPz
   w==;
IronPort-SDR: IcWy4eWiWwLYeI2yzaujhbFwod7UDWwatj9Ia7LDhpGWyy/mFMJcRbRJoUVwFB+//P1E91IM/M
 jYzSJZkCszqDiXlBrM0EJaVmHhRDaxM2fpt3LIIYBY5E32KyjRcty9Eru2PYZp2WQcx3/dacsP
 5hrYY3P3vC0554otpC4AXvH/sjf8PpL3vn1EcgaoMrbif5kNb180Tt3hCZU1+7QcY1svigeDCh
 1IIWFNQhzisWLp8zOD4mDobE/hBuVt8jk3w8LzpyATPxA/o+iO2lGU3KJqoCS9heQ4WMrU5Peq
 d/4=
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="83373032"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2020 04:22:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 04:22:44 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 27 Jul 2020 04:21:57 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH linux-next] clk: sparx5: Review changes
Date:   Mon, 27 Jul 2020 13:22:36 +0200
Message-ID: <20200727112236.8199-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This address the review comments for the sparx5 clk driver from Stephen
Boyd <sboyd@kernel.org>:

 - Remove unused include of of_address.h
 - Remove unused member in s5_hw_clk struct
 - Changed type (to unsigned long) for freq in s5_pll_conf struct
 - Use .parent_data instead of looking up parent name
 - Use devm_of_clk_add_hw_provider
 - Some minor comsmetics

The patch is intended for linux-next (incremental), as the original
driver was already merged.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/clk/clk-sparx5.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk-sparx5.c b/drivers/clk/clk-sparx5.c
index c2e7aa0214ebd..0fad0c1a01862 100644
--- a/drivers/clk/clk-sparx5.c
+++ b/drivers/clk/clk-sparx5.c
@@ -12,7 +12,6 @@
 #include <linux/clk-provider.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/microchip,sparx5.h>
@@ -38,7 +37,6 @@ static const char *clk_names[N_CLOCKS] = {
 struct s5_hw_clk {
 	struct clk_hw hw;
 	void __iomem *reg;
-	int index;
 };

 struct s5_clk_data {
@@ -47,7 +45,7 @@ struct s5_clk_data {
 };

 struct s5_pll_conf {
-	int freq;
+	unsigned long freq;
 	u8 div;
 	bool rot_ena;
 	u8 rot_sel;
@@ -208,8 +206,9 @@ static unsigned long s5_pll_recalc_rate(struct clk_hw *hw,
 		conf.rot_sel = FIELD_GET(PLL_ROT_SEL, val);

 		conf.freq = s5_calc_freq(parent_rate, &conf);
-	} else
+	} else {
 		conf.freq = 0;
+	}

 	return conf.freq;
 }
@@ -246,14 +245,13 @@ static struct clk_hw *s5_clk_hw_get(struct of_phandle_args *clkspec, void *data)
 static int s5_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	int i, ret;
 	struct s5_clk_data *s5_clk;
-	const char *parent_name;
+	struct clk_parent_data pdata = { .index = 0 };
 	struct clk_init_data init = {
 		.ops = &s5_pll_ops,
-		.parent_names = &parent_name,
 		.num_parents = 1,
+		.parent_data = &pdata,
 	};

 	s5_clk = devm_kzalloc(dev, sizeof(*s5_clk), GFP_KERNEL);
@@ -264,18 +262,11 @@ static int s5_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(s5_clk->base))
 		return PTR_ERR(s5_clk->base);

-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name) {
-		dev_err(dev, "%pOFn: missing parent clock\n", np);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < N_CLOCKS; i++) {
 		struct s5_hw_clk *s5_hw = &s5_clk->s5_hw[i];

 		init.name = clk_names[i];
-		s5_hw->index = i;
-		s5_hw->reg = s5_clk->base + (i * sizeof(u32));
+		s5_hw->reg = s5_clk->base + (i * 4);
 		s5_hw->hw.init = &init;
 		ret = devm_clk_hw_register(dev, &s5_hw->hw);
 		if (ret) {
@@ -285,14 +276,7 @@ static int s5_clk_probe(struct platform_device *pdev)
 		}
 	}

-	return of_clk_add_hw_provider(np, s5_clk_hw_get, s5_clk);
-}
-
-static int s5_clk_remove(struct platform_device *pdev)
-{
-	of_clk_del_provider(pdev->dev.of_node);
-
-	return 0;
+	return devm_of_clk_add_hw_provider(dev, s5_clk_hw_get, s5_clk);
 }

 static const struct of_device_id s5_clk_dt_ids[] = {
@@ -303,7 +287,6 @@ MODULE_DEVICE_TABLE(of, s5_clk_dt_ids);

 static struct platform_driver s5_clk_driver = {
 	.probe  = s5_clk_probe,
-	.remove = s5_clk_remove,
 	.driver = {
 		.name = "sparx5-clk",
 		.of_match_table = s5_clk_dt_ids,
--
2.27.0
