Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6712F6136
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhANMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbhANMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:42:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62ABD23A7A;
        Thu, 14 Jan 2021 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628057;
        bh=urt0rFwgJZsr9A/Y8qW8N/YTnVS/uRrIXRNGH6kQGpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ON8B23mV4B1iifAyQd7F63+r5IWRbFku/3UP17gtKe6ucp0vjiG6EFv1KlxvQsXAu
         Y658JtTwlqsC1zKgn7xqE40KKfdJqq/fkbkX0yTHqjx1kroq4hOtzjQPRhkoovT+LC
         pq/lOXshmv2lg3WvYj+xrRHYQuVXUIKwVktQNe42xHE48jPu9JgqZRU1SIgz6/b1Vp
         21I9t9Nl3jLpbLJM93mVF2BUshi8NJP3lpQZbp3vMadIkpVtmcbyzb5IHn8ghj+mhY
         rc1d7vPcqgno1B0gZMXCN1QRXEYapmK4H4YsY+jai8Kmh5RBchwEbbyIzJSGz+oO8i
         FzHlgdoSm6fgw==
Received: by pali.im (Postfix)
        id 408F8621; Thu, 14 Jan 2021 13:40:55 +0100 (CET)
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
Subject: [PATCH mvebu v2 09/10] cpufreq: armada-37xx: Remove cur_frequency variable
Date:   Thu, 14 Jan 2021 13:40:31 +0100
Message-Id: <20210114124032.12765-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable cur_frequency in armada37xx_cpufreq_driver_init() is unused.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index f08281fc525c..f13646d143de 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -389,7 +389,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	struct armada_37xx_dvfs *dvfs;
 	struct platform_device *pdev;
 	unsigned long freq;
-	unsigned int cur_frequency, base_frequency;
+	unsigned int base_frequency;
 	struct regmap *nb_clk_base, *nb_pm_base, *avs_base;
 	struct device *cpu_dev;
 	int load_lvl, ret;
@@ -450,14 +450,6 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return -EINVAL;
 	}
 
-	/* Get nominal (current) CPU frequency */
-	cur_frequency = clk_get_rate(clk);
-	if (!cur_frequency) {
-		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
-		clk_put(clk);
-		return -EINVAL;
-	}
-
 	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
 	if (!dvfs) {
 		clk_put(clk);
-- 
2.20.1

