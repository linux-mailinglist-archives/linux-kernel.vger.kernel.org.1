Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A32E8C73
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhACOAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 09:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhACOAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 09:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED63920782;
        Sun,  3 Jan 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609682399;
        bh=BGD2k4AOyUbJm0QNORL1L22JdnB3YSYyPVCNdaj6s/A=;
        h=From:To:Cc:Subject:Date:From;
        b=RxDhEbIHU3bAdGBMwBVtOxCSm6idQqLMo59kfBOTeQTx2rDGdmZYl3QzeF/m3dN6n
         9dhRVkZh89KHF5K7h9pG16IBzkO7C32Y74z1VMFPsKN7D9f+oGXWiEiZX3ybnteudR
         m6TcxlhdDeah9WyMsRY8fEnQmgpHGNNm7vTyJ/w13S1crAUqsRlMcerPAuGdTMWvgS
         +FCBqKJ9A+VWJTULJXhTOib/DKimT1X03A2aebbOjobokCqCC9zWPmGxhAaKgre+G7
         5qaXHWid+dUdAocEaenX7XhS8vchc/OUFhH/vPYuntp7EGA4tG+VA2pGbVgaPUYeXP
         TWwAVAJQczM5w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: ixp4xx: select TIMER_OF when needed
Date:   Sun,  3 Jan 2021 14:59:24 +0100
Message-Id: <20210103135955.3808976-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing the ixp4xx timer with CONFIG_OF enabled but
CONFIG_TIMER_OF disabled leads to a harmless warning:

arm-linux-gnueabi-ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-ixp4xx.o' being placed in section `__timer_of_table'

Move the select statement from the platform code into the driver
so it always gets enabled in configurations that rely on it.

Fixes: 40df14cc5cc0 ("clocksource/drivers/ixp4xx: Add OF initialization support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/Kconfig | 1 -
 drivers/clocksource/Kconfig  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f7211b57b1e7..165c184801e1 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -13,7 +13,6 @@ config MACH_IXP4XX_OF
 	select I2C
 	select I2C_IOP3XX
 	select PCI
-	select TIMER_OF
 	select USE_OF
 	help
 	  Say 'Y' here to support Device Tree-based IXP4xx platforms.
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..66be9ea69e33 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -79,6 +79,7 @@ config IXP4XX_TIMER
 	bool "Intel XScale IXP4xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
+	select TIMER_OF if OF
 	help
 	  Enables support for the Intel XScale IXP4xx SoC timer.
 
-- 
2.29.2

