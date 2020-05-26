Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E019E88E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 04:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDECv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 22:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgDECv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:51:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F38720752;
        Sun,  5 Apr 2020 02:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586055085;
        bh=J+GeXfiCzFFO7mDslriUKKDucExeUS2dHChanjrxLIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQgxQueHmAHvchuMyRFcU1Ez1086WQ2Dk8Kjj5kKOh3+h1DND63XQfQrz81KAihly
         K6iY9a6XRPLG2C02mwGCAkfH0YNjoo56hckDu7MMNBuGmhSa2Rad99G30e8wDFMpoC
         gLU3EalazrVTYyue1i+NXFUYATEGkV0PFOd51sdI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/9] ARM: Remove redundant CLKDEV_LOOKUP selects
Date:   Sat,  4 Apr 2020 19:51:16 -0700
Message-Id: <20200405025123.154688-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200405025123.154688-1-sboyd@kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These platforms select COMMON_CLK indirectly through use of the
ARCH_MULTIPLATFORM config option that they depend on implicitly via some
V7/V6/V5 multi platform config option. The COMMON_CLK config option
already selects CLKDEV_LOOKUP so it's redundant to have this selected
again.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/Kconfig             | 3 ---
 arch/arm/mach-vt8500/Kconfig | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aabc2a6..eeabdc5a3dd2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -435,7 +435,6 @@ config ARCH_PXA
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
 	select COMMON_CLK
-	select CLKDEV_LOOKUP
 	select CLKSRC_PXA
 	select CLKSRC_MMIO
 	select TIMER_OF
@@ -474,7 +473,6 @@ config ARCH_SA1100
 	bool "SA1100-based"
 	select ARCH_MTD_XIP
 	select ARCH_SPARSEMEM_ENABLE
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_PXA
 	select TIMER_OF if OF
@@ -495,7 +493,6 @@ config ARCH_SA1100
 config ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
 	select ATAGS
-	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 8841199058ea..d01cdd9ad9c7 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -2,7 +2,6 @@
 config ARCH_VT8500
 	bool
 	select GPIOLIB
-	select CLKDEV_LOOKUP
 	select VT8500_TIMER
 	select PINCTRL
 	help
-- 
Sent by a computer, using git, on the internet

