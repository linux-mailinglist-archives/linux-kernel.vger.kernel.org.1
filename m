Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612C2CEAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgLDJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLDJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:17:01 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] clk: samsung: mark PM functions as __maybe_unused
Date:   Fri,  4 Dec 2020 10:16:11 +0100
Message-Id: <20201204091616.4128366-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The use of SIMPLE_DEV_PM_OPS() means that the suspend/resume
functions are now unused when CONFIG_PM is disabled:

drivers/clk/samsung/clk-exynos-clkout.c:219:12: error: 'exynos_clkout_resume' defined but not used [-Werror=unused-function]
  219 | static int exynos_clkout_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/clk/samsung/clk-exynos-clkout.c:210:12: error: 'exynos_clkout_suspend' defined but not used [-Werror=unused-function]
  210 | static int exynos_clkout_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

Mark them as __maybe_unused to shut up the otherwise harmless warning.

Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module driver")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add proper changelog text
---
 drivers/clk/samsung/clk-exynos-clkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 9ec2f40cc400..e6d6cbf8c4e6 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -207,7 +207,7 @@ static int exynos_clkout_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_clkout_suspend(struct device *dev)
+static int __maybe_unused exynos_clkout_suspend(struct device *dev)
 {
 	struct exynos_clkout *clkout = dev_get_drvdata(dev);
 
@@ -216,7 +216,7 @@ static int exynos_clkout_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_clkout_resume(struct device *dev)
+static int __maybe_unused exynos_clkout_resume(struct device *dev)
 {
 	struct exynos_clkout *clkout = dev_get_drvdata(dev);
 
-- 
2.27.0

