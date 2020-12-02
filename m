Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789FC2CBD21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgLBMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:37:34 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgLBMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:37:33 -0500
Received: from orion.localdomain ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5VTm-1k8T4d24fC-016ugz; Wed, 02 Dec 2020 13:34:49 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3] drivers: clk: make gpio-gated clock support optional
Date:   Wed,  2 Dec 2020 13:34:46 +0100
Message-Id: <20201202123446.21902-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:WbLU9N2ykb1bYLaEdCmR6BikyMatnPo3jN3uCRNNZTmRVZT6YSO
 ArUF2XqM8GfeFIm/UHqsHgJ42Bk+dCKEwI2RSbd7XXs5rvHAPYuPq3w8X+ZnEM2VOXMLfTR
 2Lwgt6M4fVeJhI+5vr4B6J7cb3iLuJJjbJ1OaGgCpJpJbDB14qUU/zXCK5XMRD36Nyx5MIA
 jBnFgo78BpzGQj2lBo/7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zY3qHVWMGdc=:p6t0Vho9tx8xhvpEim4SZ4
 cyh0lNXAnLhP4zrruMA3DnvEBg0XuMS59pa50R/WUIogP/BKm+uCCcSHa4l4iyRVAsQaIFr0q
 1nYmk8HO8EiCkmjfb7gXRmFWKHU0Gc515k+kmphY99YlrgSg7gMVAjOdNwXKbK6YFTqZuna9Z
 7x5f3FOdZK9OudpF3+6G+d3yCG2J0Umoh4ktWNTfeRycqHyb/ob5Dk89voDtfar+NhSBY+UFF
 1bSZAbZi6Eg0hjLuIf8clqmup+noDjFd+zc2h/YAGEnXmDzxduoHthNTctgMF0blgz/GSuDeT
 kmwGATo9voiizH4sV4Wn4A51GbRVxgHDQmeQTl7w4O5NZzL/poZOvSgihMikeq3xCpv2YREPg
 KR6zze1YkhB7KbiTfmJ8j1aUUb0GKthYUV67HziDmaa2JAyH7+Wz84JoeEJbY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-gate-clock / gpio-mux-clock driver isn't used much,
just by a few ARM SoCs, so there's no need to always include
it unconditionally.

Thus make it optional, but keep it enabled by default.

changes v3: default to y when gpiolib enabled
            fix depends on gpiolib to uppercase

changes v2: added missing dependency on gpiolib

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/Kconfig  | 8 ++++++++
 drivers/clk/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c715d4681a0b..e4fe406c4e7d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -38,6 +38,14 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_GPIO
+	tristate "GPIO gated clock support"
+	default y if GPIOLIB
+	depends on GPIOLIB
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

