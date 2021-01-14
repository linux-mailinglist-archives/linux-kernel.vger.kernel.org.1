Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3832F6122
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhANMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbhANMlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:41:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C688A23A60;
        Thu, 14 Jan 2021 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628055;
        bh=4gebIy8dtRAvDVN1y60MtYCqDlAywN6+YARHQq1N+70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=askES8EyD7ymOVr7SLqvxmQSDQgEc3KliAYdbtSZg7WJP9FN3L5AtU4GEMcTHBtgO
         EwXKvcVxH4Y2AAuSHdMMHEoOnM4lRHWeQKAJOUv3hsAR/8ZfjRtwjBc/hPOuEuRQcF
         08ykBNznSjfr79iKUp34Ur3gGdoYvJFgAG+m+KI+/1yQkHisVuoRL6oZuHj2TMV18F
         j2AaM/2S/D5y2jmZf7/BHasGg6WdxevqY9hXrDGhuM9CCRgt/E4+XCeaBP1ba4p4oq
         hWjqdbwHUWaV+FTIauGKsYMsqPIgmxAH/BMkUqdWhIQ8efmbclnDOOn9KCeEmBLfLI
         9+slAZ/T/xQ4w==
Received: by pali.im (Postfix)
        id D47DA821; Thu, 14 Jan 2021 13:40:53 +0100 (CET)
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
Subject: [PATCH mvebu v2 04/10] cpufreq: armada-37xx: Fix the AVS value for loads L0 and L1
Date:   Thu, 14 Jan 2021 13:40:26 +0100
Message-Id: <20210114124032.12765-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original CPU voltage value for load L1 is too low for Armada-37xx SoC
when base CPU frequency is 1000 or 1200 MHz. It leads to instabilities
where CPU gets stuck soon after dynamic voltage scaling from load L1 to L0.

Update the CPU voltage value for loads L0 and L1 accordingly when base
frequency is 1000 or 1200 MHz. The minimal value is updated from the
original 1.05V to 1.108V.

This change fixes instability issues on 1 GHz variant of Espressobin and
Turris MOX. It is based on previous work from Victor Gu <xigu@marvell.com>
for Espressobin kernel 4.4 [1]. Discussion about this issue is also at
armbian forum [2].

[1] - https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/dc33b62c90696afb6adc7dbcc4ebbd48bedec269
[2] - https://forum.armbian.com/topic/10429-how-to-make-espressobin-v7-stable/

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1c3528232f4b ("cpufreq: armada-37xx: Add AVS support")
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b8dc6c849579..92e531f700f4 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -73,6 +73,7 @@
 #define LOAD_LEVEL_NR	4
 
 #define MIN_VOLT_MV 1000
+#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
 
 /*  AVS value for the corresponding voltage (in mV) */
 static int avs_map[] = {
@@ -208,6 +209,8 @@ static u32 armada_37xx_avs_val_match(int target_vm)
  * - L2 & L3 voltage should be about 150mv smaller than L0 voltage.
  * This function calculates L1 & L2 & L3 AVS values dynamically based
  * on L0 voltage and fill all AVS values to the AVS value table.
+ * When base CPU frequency is 1000 or 1200 MHz then there is additional
+ * minimal avs value for load L0 and L1.
  */
 static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 						struct armada_37xx_dvfs *dvfs)
@@ -239,6 +242,15 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 		for (load_level = 1; load_level < LOAD_LEVEL_NR; load_level++)
 			dvfs->avs[load_level] = avs_min;
 
+		/*
+		 * Set the avs value for load L0 and L1 when base CPU frequency is 1000/1200 MHz,
+		 * otherwise the CPU gets stuck when switching from load L1 to load L0
+		 */
+		if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+			avs_min = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L0_L1_1GHZ);
+			dvfs->avs[0] = dvfs->avs[1] = avs_min;
+		}
+
 		return;
 	}
 
@@ -258,6 +270,20 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 	target_vm = avs_map[l0_vdd_min] - 150;
 	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
 	dvfs->avs[2] = dvfs->avs[3] = armada_37xx_avs_val_match(target_vm);
+
+	/*
+	 * Fix the avs value for load L0 and L1 when base CPU frequency is 1000/1200 MHz,
+	 * otherwise the CPU gets stuck when switching from load L1 to load L0
+	 */
+	if (dvfs->cpu_freq_max >= 1000*1000*1000) {
+		u32 avs_min = armada_37xx_avs_val_match(MIN_VOLT_MV_FOR_L0_L1_1GHZ);
+
+		if (dvfs->avs[0] < avs_min)
+			dvfs->avs[0] = avs_min;
+
+		if (dvfs->avs[1] < avs_min)
+			dvfs->avs[1] = avs_min;
+	}
 }
 
 static void __init armada37xx_cpufreq_avs_setup(struct regmap *base,
-- 
2.20.1

