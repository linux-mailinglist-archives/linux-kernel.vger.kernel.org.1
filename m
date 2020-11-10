Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334EF2ADAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgKJPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:47:53 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:47:53 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id qfnr2300Z4C55Sk06fnru7; Tue, 10 Nov 2020 16:47:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcVs7-001DPN-G8; Tue, 10 Nov 2020 16:47:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcVs7-00DmhG-38; Tue, 10 Nov 2020 16:47:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] clk: qoriq: Add platform dependencies
Date:   Tue, 10 Nov 2020 16:47:50 +0100
Message-Id: <20201110154750.3285411-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale QorIQ clock controller is only present on Freescale E500MC
and Layerscape SoCs.  Add platform dependencies to the CLK_QORIQ config
symbol, to avoid asking the user about it when configuring a kernel
without E500MC or Layerscape support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
v2:
  - Add Acked-by.
---
 drivers/clk/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 07a30a7b90b1eeb8..e902f2de027ca041 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -246,7 +246,8 @@ config COMMON_CLK_AXI_CLKGEN
 
 config CLK_QORIQ
 	bool "Clock driver for Freescale QorIQ platforms"
-	depends on (PPC_E500MC || ARM || ARM64 || COMPILE_TEST) && OF
+	depends on OF
+	depends on PPC_E500MC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	help
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
-- 
2.25.1

