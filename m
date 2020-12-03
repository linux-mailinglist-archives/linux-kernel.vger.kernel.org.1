Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3112CD964
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgLCOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:38:44 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgLCOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:38:44 -0500
Received: from orion.localdomain ([95.118.71.13]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5FQJ-1k3xq12KJB-011BDE; Thu, 03 Dec 2020 15:35:52 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2] drivers: clk: make gpio-gated clock support optional
Date:   Thu,  3 Dec 2020 15:35:51 +0100
Message-Id: <20201203143551.5482-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:lrjZSZO++TFuXVbnJJDgAvcXp/I+VeQY/3cXAxev1HCLVLq3xz+
 DrogOwTBhvcrHsn6mk7zXZCQQuPAXUMTr5uLVZw68FevVEvZLPLDT+Oe0bRGTEHAqx4nBGb
 mgeWVrvTnk7pY1BbJgKumhZ379SlMpXh0R4ahSixqhE2JqrTp/wyRYpnO8kgZvbiigw6wnX
 8cD1OSpGr5DwDlFKqUbkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yGqkFXJK1c4=:cV4c49wuMDcGfa/pPJ5sAO
 trdoyPkWEa7icfF/iMbO0PhgjeM5Ynif5LhwRHZUPFNA7WAPzbsTzGbJq4u0c5lQHkBAaPpyO
 st+uDGRtbTWh49T/R9yLYnDbRceVd9BM8X3duiEzKw2wqjz/dvA1X1yr7mkcclb5o6SFwbYE4
 aO4uQib9fjh0ML3Ohc6nLhtIuQ8EezYeOqRp/OE0tahjoXuytU+8yZ9WjZn2weFhBr1uwdZnf
 NGwLijMJ9PMCAYo0Gm6Q2ikEQjO5DzzkZfRotUstPOJSM2rzmRmJoX480pLcXeSAQyJ5xX6mO
 Hu1dYgZIJ2a5iztaREXCMeQx7l4s1wPiZlfihuS+yl0updnIExMBpBnL9R2wLFZ76EG9wdLQV
 VwU20oZb6If1RZ4l9jcGSupSssP1iHQkLqNuD50Nu08FPL5gc/8rVgfxQ2QHW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-gate-clock / gpio-mux-clock driver isn't used much,
just by a few ARM SoCs, so there's no need to always include
it unconditionally.

Thus make it optional, but keep it enabled by default.

changes v2: fixed meanwhile removed '---help---'

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

