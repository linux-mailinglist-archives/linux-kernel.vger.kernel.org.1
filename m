Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F306E2F6135
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbhANMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbhANMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:42:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46AEB23A77;
        Thu, 14 Jan 2021 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628057;
        bh=LdKZoDOyWDT6YlTkOhfHUMj6f5x7Zv3boxD1wlMlooc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXtvzgj4d5uf9V1wv+JQw8qCEuFaia5UV6ZdQNH4UyKiIxW82/vKAEY+XT3ojUcgC
         7/QD5VKZPhr8qbfjP3AohWu8ZMhzfpO+qUcqjNYCDuLmNFscC+BKYhw0AKXvrms7y2
         yALiDpErBQUbBojzT+IDDyQNe595AWw4BquBYKGGPucUfk+AqTfnTvbytYL23+gkD8
         J5fY7W93WO36CQcmigUow88z/+1X4eIfuVp7wdrNsebxtbFCl/8CK2aPqK1jzcwwcv
         DrfCP61QVPJpTSLOKFAKVDeIQ+uxDoNgZBkHlla7BaJ7hcFFIfJaed5LgKH0A17tzF
         xYE86sRYV+7mw==
Received: by pali.im (Postfix)
        id E859A848; Thu, 14 Jan 2021 13:40:54 +0100 (CET)
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
Subject: [PATCH mvebu v2 08/10] cpufreq: armada-37xx: Fix determining base CPU frequency
Date:   Thu, 14 Jan 2021 13:40:30 +0100
Message-Id: <20210114124032.12765-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When current CPU load is not L0 then loading armada-37xx-cpufreq.ko driver
fails with following error:

    # modprobe armada-37xx-cpufreq
    [  502.702097] Unsupported CPU frequency 250 MHz

This issue was partially fixed by commit 8db82563451f ("cpufreq:
armada-37xx: fix frequency calculation for opp"), but only for calculating
CPU frequency for opp.

Fix this also for determination of base CPU frequency.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: stable@vger.kernel.org # 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 002a71775e08..f08281fc525c 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -458,7 +458,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return -EINVAL;
 	}
 
-	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
+	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
 	if (!dvfs) {
 		clk_put(clk);
 		return -EINVAL;
-- 
2.20.1

