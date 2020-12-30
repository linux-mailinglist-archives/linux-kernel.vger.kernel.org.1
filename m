Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4ED2E7AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgL3Pzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgL3Pzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:55:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC5520575;
        Wed, 30 Dec 2020 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343711;
        bh=NaeLimBXMLNfbWXl+vU/rIqaMdmx4QM/i2SeXbItBXg=;
        h=From:To:Cc:Subject:Date:From;
        b=XOR0+z5QGpi3p6PcmZuRlOdfOU68O3bPa5fNi0zXBmSaKHr7VQcFZhfODsME7iVPY
         CFrAR9CScRgGgClCEUOgoAcFmDxVuA7v2Kyfu6djMMDH417LN8S3TTbMkGr6xBpqlQ
         HOSQkEnq2CBlXn7Zi4O/cMaGqze8VIZxb+h/Gtpu0kdBUrIFMV5Cp0i+Eyu9vgp1tO
         uscDr+vl0tsSwR03uulYn2R8qbzW6qrBiQ+udR6i2yRaTcobXTrj0P93R3ZDxx/P4g
         5PVQgziq1jgITQqWqCHSpIZISM8dOtD3yzP4f6yW50lZu3sZwI+FPnUj3SN9FqFB11
         YdVqWN5ektvDw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: avoid cpuidle link warning
Date:   Wed, 30 Dec 2020 16:54:56 +0100
Message-Id: <20201230155506.1085689-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Since commit 83109d5d5fba ("x86/build: Warn on orphan section placement"),
we get a warning for objects in orphan sections. The cpuidle implementation
for OMAP causes this when CONFIG_CPU_IDLE is disabled:

arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'

Change the definition of CPUIDLE_METHOD_OF_DECLARE() to silently
drop the table and all code referenced from it when CONFIG_CPU_IDLE
is disabled.

Fixes: 06ee7a950b6a ("ARM: OMAP2+: pm33xx-core: Add cpuidle_ops for am335x/am437x")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/cpuidle.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 0d67ed682e07..bc4ffa7ca04c 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -7,9 +7,11 @@
 #ifdef CONFIG_CPU_IDLE
 extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index);
+#define __cpuidle_method_section __used __section("__cpuidle_method_of_table")
 #else
 static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index) { return -ENODEV; }
+#define __cpuidle_method_section __maybe_unused /* drop silently */
 #endif
 
 /* Common ARM WFI state */
@@ -42,8 +44,7 @@ struct of_cpuidle_method {
 
 #define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)			\
 	static const struct of_cpuidle_method __cpuidle_method_of_table_##name \
-	__used __section("__cpuidle_method_of_table")			\
-	= { .method = _method, .ops = _ops }
+	__cpuidle_method_section = { .method = _method, .ops = _ops }
 
 extern int arm_cpuidle_suspend(int index);
 
-- 
2.29.2

