Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38A02F612C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbhANMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbhANMmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:42:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CAA123A62;
        Thu, 14 Jan 2021 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628056;
        bh=PHeluWO0cdECj+OdCLH72nVlTA8mvTeQ/OvR4mFUrGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyNC/Ie7XzciQ19TjrjNW6NqeDXP1q6blwAVmmUHqKZcMct8Xd8d41r454+/xsXSG
         f1euTA7CPsUTDHY29mu42PzLoq5I4sLWcrqH6EKbHiJN+mxtZOA3z47/SgoFDhDLcm
         RIDWw1Jq3nOButTBiuj2HKsjC89yykub2fvN5iGrwxqpuEQwlJ4xpvyZhV7gJQC9UC
         R1dhwchqJEQLxVhkhJjw3Q+tJUk3Tw8XHtNePnJ3i8Y80UPFz5dlNv5jh31O4VPmYT
         BXU6csL5R4nSfbvT20OZsKyA2P12GsFmoc+bXbSwXvztsEJTGxiakJJfT2vre65KdZ
         rMHmkJZaZvWrg==
Received: by pali.im (Postfix)
        id 382A9825; Thu, 14 Jan 2021 13:40:54 +0100 (CET)
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
Subject: [PATCH mvebu v2 05/10] clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to 1 GHz
Date:   Thu, 14 Jan 2021 13:40:27 +0100
Message-Id: <20210114124032.12765-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that the workaround introduced by commit 61c40f35f5cd
("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to
1.2GHz") when base CPU frequency is 1.2 GHz is also required when base
CPU frequency is 1 GHz. Otherwise switching CPU frequency directly from
L2 (250 MHz) to L0 (1 GHz) causes a crash.

When base CPU frequency is just 800 MHz no crashed were observed during
switch from L2 to L0.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
Cc: stable@vger.kernel.org # 61c40f35f5cd ("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz")
---
 drivers/clk/mvebu/armada-37xx-periph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 6507bd2c5f31..b15e177bea7e 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -487,8 +487,10 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 /*
- * Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
- * respectively) to L0 frequency (1.2 Ghz) requires a significant
+ * Workaround when base CPU frequnecy is 1000 or 1200 MHz
+ *
+ * Switching the CPU from the L2 or L3 frequencies (250/300 or 200 MHz
+ * respectively) to L0 frequency (1/1.2 GHz) requires a significant
  * amount of time to let VDD stabilize to the appropriate
  * voltage. This amount of time is large enough that it cannot be
  * covered by the hardware countdown register. Due to this, the CPU
@@ -498,15 +500,15 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
  * To work around this problem, we prevent switching directly from the
  * L2/L3 frequencies to the L0 frequency, and instead switch to the L1
  * frequency in-between. The sequence therefore becomes:
- * 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
+ * 1. First switch from L2/L3 (200/250/300 MHz) to L1 (500/600 MHz)
  * 2. Sleep 20ms for stabling VDD voltage
- * 3. Then switch from L1(600MHZ) to L0(1200Mhz).
+ * 3. Then switch from L1 (500/600 MHz) to L0 (1000/1200 MHz).
  */
 static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
 {
 	unsigned int cur_level;
 
-	if (rate != 1200 * 1000 * 1000)
+	if (rate < 1000 * 1000 * 1000)
 		return;
 
 	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
-- 
2.20.1

