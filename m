Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3889A2B690E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKQPt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:49:29 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:40507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgKQPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:49:29 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDeAZ-1kWV2Z1QJj-00AjEx; Tue, 17 Nov 2020 16:49:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] drivers: clk: make gpio-gated clock support optional
Date:   Tue, 17 Nov 2020 16:49:15 +0100
Message-Id: <20201117154915.19951-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:PbXwhxgZEHmBSuv2/cxNCEqWXKG8HNRUpU5VDyHQtaeNY2Q3q53
 emv4MJ03ToWKfXlnHO0lBgf6YnxAqhGMwat2O2xWssDus2zJwPXISE3s/90UsQJTo/hX82M
 7I82cTnzgeupAnPOCvoXgXjuWiZu5r1X3FN5f34r7KEmL3LqANbe18yOIFsTb2AGUOCm//r
 c0oemH+sYEj7AD7oAab5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0R1qHjUzETc=:SjUN+Br12J7imWezXdxNi7
 5d1wBxcHv134q1wVsopfeUPHxvbWDv7torQVGiB9OiZBd5+RPP3t7UpXxkA6GeeFP65wPjpiA
 jvAwRo6LS/HHCYdmCN2K+cBAqYt1oXXCerAqrIUMfby9kDVUr1FnJYWCP67m+lrvre9osu2QC
 PAsimuwCNtFXfjzCteljXYI8JsuElSxdSCyNztzLEw2yjW52N8e1xeesd1pcgdWPk9M8MFevQ
 3ijmUaiYROZsA5ZomixqGQsUN67EFYZYllZ8wz+ITGQxAKGKufUKhVFFatG0h8Q7Yesj7m5Gq
 6YGw6RVx7dO7fSiyBz+K9VVJEEYlAetdzi4upwW2T1GHStJQi9lCqGvFWIhj7aIXx/R2+CUlx
 Xw2YuTTjcaon8TelJTYWNcwLXqpJWjgt3MPlBMLEk067chgNIF3qz8AoYETZN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-gate-clock / gpio-mux-clock driver isn't used much,
just by a few ARM SoCs, so there's no need to always include
it unconditionally.

Thus make it optional, but keep it enabled by default.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/Kconfig  | 7 +++++++
 drivers/clk/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c715d4681a0b..ec5b3a75bcf4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -38,6 +38,13 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_GPIO
+	tristate "GPIO gated clock support"
+	default y
+	help
+	  Supports gpio gated clocks, which can be enabled/disabled via
+	  gpio output.
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index da8fcf147eb1..0692ab5abc6d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
-obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
+obj-$(CONFIG_COMMON_CLK_GPIO)	+= clk-gpio.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
 endif
-- 
2.11.0

