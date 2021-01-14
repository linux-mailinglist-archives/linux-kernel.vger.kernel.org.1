Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425792F612F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhANMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbhANMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:42:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DD523A61;
        Thu, 14 Jan 2021 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628056;
        bh=BM2JrmrK5VRVYXEAX31FmsqxA+U0Nplk6UV2WlHNTT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGUG7aVVKLpy0ULIGMXUEMD7z3ejJd1HmKIM0lJ8DsPhmL5gQs8JX3k78U556NlS7
         ia/F0SoOL7h9crLT+zM0RYBO24dV7JHvX9Ju8OHlMRQc9XXK8uZNC3IPCVQhHWWviV
         FBh9DExD1rw2ZCijn4Gdgd8r79UFZnQDsImn+dEkI1azCBgj/6gwhPlyU375PW0TeW
         bPrLKAv1igtFr+i0b1LVWgZ0rFYaIQPLuZI1wsMy+ZIkc3D0fXxOALF4FlY1loW/oN
         iRg6jrcBlIn63S4nrhdQyMhk0PN7D1+imM/HbJX5VZQx8/GZMvvx9QeR6UviO1eRA0
         RajRerSTd0YUQ==
Received: by pali.im (Postfix)
        id 8E51B843; Thu, 14 Jan 2021 13:40:54 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        "Luka Perkov" <luka.perkov@sartura.hr>,
        "Andre Heider" <a.heider@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH mvebu v2 06/10] clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1 to L0
Date:   Thu, 14 Jan 2021 13:40:28 +0100
Message-Id: <20210114124032.12765-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU frequency is at 250 MHz and set_rate() is called with 500 MHz (L1)
quickly followed by a call with 1 GHz (L0), the CPU does not necessarily
stay in L1 for at least 20ms as is required by Marvell errata.

This situation happens frequently with the ondemand cpufreq governor and
can be also reproduced with userspace governor. In most cases it causes CPU
to crash.

This change fixes the above issue and ensures that the CPU always stays in
L1 for at least 20ms when switching from any state to L0.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 61c40f35f5cd ("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz")
Cc: stable@vger.kernel.org
---
 drivers/clk/mvebu/armada-37xx-periph.c | 45 ++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index b15e177bea7e..32ac6b6b7530 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -84,6 +84,7 @@ struct clk_pm_cpu {
 	void __iomem *reg_div;
 	u8 shift_div;
 	struct regmap *nb_pm_base;
+	unsigned long l1_expiration;
 };
 
 #define to_clk_double_div(_hw) container_of(_hw, struct clk_double_div, hw)
@@ -504,22 +505,52 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
  * 2. Sleep 20ms for stabling VDD voltage
  * 3. Then switch from L1 (500/600 MHz) to L0 (1000/1200 MHz).
  */
-static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
+static void clk_pm_cpu_set_rate_wa(struct clk_pm_cpu *pm_cpu,
+				   unsigned int new_level, unsigned long rate,
+				   struct regmap *base)
 {
 	unsigned int cur_level;
 
-	if (rate < 1000 * 1000 * 1000)
-		return;
-
 	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
 	cur_level &= ARMADA_37XX_NB_CPU_LOAD_MASK;
-	if (cur_level <= ARMADA_37XX_DVFS_LOAD_1)
+
+	if (cur_level == new_level)
+		return;
+
+	/*
+	 * System wants to go to L1 on its own. If we are going from L2/L3,
+	 * remember when 20ms will expire. If from L0, set the value so that
+	 * next switch to L0 won't have to wait.
+	 */
+	if (new_level == ARMADA_37XX_DVFS_LOAD_1) {
+		if (cur_level == ARMADA_37XX_DVFS_LOAD_0)
+			pm_cpu->l1_expiration = jiffies;
+		else
+			pm_cpu->l1_expiration = jiffies + msecs_to_jiffies(20);
 		return;
+	}
+
+	/*
+	 * If we are setting to L2/L3, just invalidate L1 expiration time,
+	 * sleeping is not needed.
+	 */
+	if (rate < 1000*1000*1000)
+		goto invalidate_l1_exp;
+
+	/*
+	 * We are going to L0 with rate >= 1GHz. Check whether we have been at
+	 * L1 for long enough time. If not, go to L1 for 20ms.
+	 */
+	if (pm_cpu->l1_expiration && jiffies >= pm_cpu->l1_expiration)
+		goto invalidate_l1_exp;
 
 	regmap_update_bits(base, ARMADA_37XX_NB_CPU_LOAD,
 			   ARMADA_37XX_NB_CPU_LOAD_MASK,
 			   ARMADA_37XX_DVFS_LOAD_1);
 	msleep(20);
+
+invalidate_l1_exp:
+	pm_cpu->l1_expiration = 0;
 }
 
 static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -553,7 +584,9 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 			reg = ARMADA_37XX_NB_CPU_LOAD;
 			mask = ARMADA_37XX_NB_CPU_LOAD_MASK;
 
-			clk_pm_cpu_set_rate_wa(rate, base);
+			/* Apply workaround when base CPU frequency is 1000 or 1200 MHz */
+			if (parent_rate >= 1000*1000*1000)
+				clk_pm_cpu_set_rate_wa(pm_cpu, load_level, rate, base);
 
 			regmap_update_bits(base, reg, mask, load_level);
 
-- 
2.20.1

