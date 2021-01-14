Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2B2F6133
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhANMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbhANMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:42:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CD4C23A68;
        Thu, 14 Jan 2021 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628057;
        bh=0EacZozNqX5kdAE9JNs/z+ZT90LRoDz55sehFetkTE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWgHalDW53zNdqiPkj2tk2NUjLZ1JP0c66HbPn2opZoo1wENNJ/h1qhBb2Oz1TcBc
         7wl4l5kCO8KE3hD72Y2HZUtWtUJRhg3+JdpeESHtN+ObWiea15vkB8aFFwDv+5FPLN
         aLWBctsZvruwgu5UEgMUBL7wHDEdS8b3dS0RIByZPcYKXTGnv8SnuHcEu3IKKNT4uq
         VLh4VDWyl91VBrgXjENa+040sxqhobpAr8MiYZJPQE09xd5MjYEBwoP+DyFL+5s5qm
         62l6n0qZEh5K2H9eMxS22rVRLB/wWKdetPmdeMdg4pexH2BK0Ny6rOELTLEM8tESa6
         gYaKx6O/z0BQw==
Received: by pali.im (Postfix)
        id 863C5B5F; Thu, 14 Jan 2021 13:40:55 +0100 (CET)
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
Subject: [PATCH mvebu v2 10/10] cpufreq: armada-37xx: Fix module unloading
Date:   Thu, 14 Jan 2021 13:40:32 +0100
Message-Id: <20210114124032.12765-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is missing module_exit hook. Add proper driver exit function
which unregisters the platform device and cleans up the data.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index f13646d143de..565c40f536ef 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -85,6 +85,8 @@ static int avs_map[] = {
 };
 
 struct armada37xx_cpufreq_state {
+	struct platform_device *pdev;
+	struct device *cpu_dev;
 	struct regmap *regmap;
 	u32 nb_l0l1;
 	u32 nb_l2l3;
@@ -495,6 +497,9 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	if (ret)
 		goto disable_dvfs;
 
+	armada37xx_cpufreq_state->cpu_dev = cpu_dev;
+	armada37xx_cpufreq_state->pdev = pdev;
+	platform_set_drvdata(pdev, dvfs);
 	return 0;
 
 disable_dvfs:
@@ -513,6 +518,26 @@ static int __init armada37xx_cpufreq_driver_init(void)
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
 
+static void __exit armada37xx_cpufreq_driver_exit(void)
+{
+	struct platform_device *pdev = armada37xx_cpufreq_state->pdev;
+	struct armada_37xx_dvfs *dvfs = platform_get_drvdata(pdev);
+	unsigned long freq;
+	int load_lvl;
+
+	platform_device_unregister(pdev);
+
+	armada37xx_cpufreq_disable_dvfs(armada37xx_cpufreq_state->regmap);
+
+	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR; load_lvl++) {
+		freq = dvfs->cpu_freq_max / dvfs->divider[load_lvl];
+		dev_pm_opp_remove(armada37xx_cpufreq_state->cpu_dev, freq);
+	}
+
+	kfree(armada37xx_cpufreq_state);
+}
+module_exit(armada37xx_cpufreq_driver_exit);
+
 static const struct of_device_id __maybe_unused armada37xx_cpufreq_of_match[] = {
 	{ .compatible = "marvell,armada-3700-nb-pm" },
 	{ },
-- 
2.20.1

