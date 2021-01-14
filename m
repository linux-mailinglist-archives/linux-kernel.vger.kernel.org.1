Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED872F6127
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbhANMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbhANMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:41:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AA8823A59;
        Thu, 14 Jan 2021 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628055;
        bh=d2Z8NCxe2fjDv1yv6SP6SbppuTV2JP+64LTQ3exydYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpszY4+xUiS/+/IDkKJ6WZutQaQ/A0jvizbsHLlVMcTwiG0zbTq3A5fdNG5r65JmC
         eFiFYqpCvMm4tD2fjMV8czwCXDij++99NbQ1vxLpG7yYkehAakH/wKl2Y9oSe5S1sN
         1d7aYm/mlyP6qDoI/3EVyLsU86Gs0CrLMRkOwmnkmpw+40NTZ134TfME15Al53N3oD
         ubmOcPhzL9aEf6aZSqyBi7ZXWPMlK6I6FCjYxkY6BpsRbvgAmm3IpukXUcleayFLxM
         NG17j+cZWKY4qcl11iM0g4TuitciGOa0xg75k3HYn979RIKv12oPjQ+WIhJ0YVMh2/
         FLZgvhERio6cQ==
Received: by pali.im (Postfix)
        id 8A18B7CA; Thu, 14 Jan 2021 13:40:53 +0100 (CET)
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
Subject: [PATCH mvebu v2 03/10] clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock
Date:   Thu, 14 Jan 2021 13:40:25 +0100
Message-Id: <20210114124032.12765-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

Remove the .set_parent method in clk_pm_cpu_ops.

This method was supposed to be needed by the armada-37xx-cpufreq driver,
but was never actually called due to wrong assumptions in the cpufreq
driver. After this was fixed in the cpufreq driver, this method is not
needed anymore.

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index f5746f9ea929..6507bd2c5f31 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -440,33 +440,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
-	struct regmap *base = pm_cpu->nb_pm_base;
-	int load_level;
-
-	/*
-	 * We set the clock parent only if the DVFS is available but
-	 * not enabled.
-	 */
-	if (IS_ERR(base) || armada_3700_pm_dvfs_is_enabled(base))
-		return -EINVAL;
-
-	/* Set the parent clock for all the load level */
-	for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
-		unsigned int reg, mask,  val,
-			offset = ARMADA_37XX_NB_TBG_SEL_OFF;
-
-		armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
-
-		val = index << offset;
-		mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
-		regmap_update_bits(base, reg, mask, val);
-	}
-	return 0;
-}
-
 static unsigned long clk_pm_cpu_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
@@ -592,7 +565,6 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_pm_cpu_ops = {
 	.get_parent = clk_pm_cpu_get_parent,
-	.set_parent = clk_pm_cpu_set_parent,
 	.round_rate = clk_pm_cpu_round_rate,
 	.set_rate = clk_pm_cpu_set_rate,
 	.recalc_rate = clk_pm_cpu_recalc_rate,
-- 
2.20.1

