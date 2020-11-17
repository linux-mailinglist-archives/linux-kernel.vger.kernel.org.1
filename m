Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA22B694C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKQQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:03:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:60195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgKQQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:03:17 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOiLp-1kueNm03x9-00QFEO; Tue, 17 Nov 2020 17:03:09 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] (v2) drivers: clk: make gpio-gated clock support optional
Date:   Tue, 17 Nov 2020 17:03:06 +0100
Message-Id: <20201117160306.21760-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:DHjCkcHF4JV+D/H9vn6hiuerLHesxxqjWv+whhAPfXYe3PLpd2f
 vXBSTvFcEOJoptHYXN42T0LP8oGsscHMyzkbICW0N1y6d5gI2P3j7mHyNXEoUktsQAfWJFT
 vlgr3I9uFKbNCpsj+nvAom90IuQSdLIL5y2NuGAro/Y49GwCRY126YfpBnmMSZDcMn8UA9Y
 5eum4UEVwEBWfGqSvPcPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nuDhTfKWFYQ=:TLnx//cNjXuEVcQGeldan1
 YRkSUqyJoC67kUo7o0/z3cOzQTttBcG712R6qRps4U4tNVNKsqQSJlce+baUrDJYDATI7NzsH
 h9lhTFJ9252aXls1GYDxSx1VNRow5IIbAFMAfllvno6w/U2eDRoG+Gd2W6uBRfTtO9e4kxvud
 GAlMc9zTIwfL1RVKgWtBXIeL+evKjbBWsnngwS9flzrVQajfwybvW/EfAXmMp/4UT1v797EE2
 dZB710fmq5fFSiGkYFFKHgq6fytbUZHFJoVr70Nvd2TAFlFqXqAOD+QyR7NGfQHYm2LDUa4wG
 t/JyWAPRSnoIEzWrhrL4S2uvDiBVPRH3LwAQc04x/OxA7niHiRi6uaSgGcMor8Rs/ziUl1E67
 CDJQ4Dc8a0rFqBaeuxr/M0dcYn/lCy4meVvUraz/51eiRiLEpGoSIlKR4u66m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-gate-clock / gpio-mux-clock driver isn't used much,
just by a few ARM SoCs, so there's no need to always include
it unconditionally.

Thus make it optional, but keep it enabled by default.

fixes v2: added missing dependency on gpiolib

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/Kconfig  | 8 ++++++++
 drivers/clk/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c715d4681a0b..99e0188a15be 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -38,6 +38,14 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_GPIO
+	tristate "GPIO gated clock support"
+	default y
+	select gpiolib
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

