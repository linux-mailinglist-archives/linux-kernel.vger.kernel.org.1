Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89741C5A85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgEEPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729781AbgEEPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:30 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E9C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:29 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by andre.telenet-ops.be with bizsmtp
        id b37T220193VwRR30137UP8; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-00028N-TW; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000Qq-Rv; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 09/15] ARM: integrator: Drop unneeded select of SPARSE_IRQ
Date:   Tue,  5 May 2020 17:07:16 +0200
Message-Id: <20200505150722.1575-10-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for ARM Ltd. Integrator systems depends on ARCH_MULTIPLATFORM.
As the latter selects SPARSE_IRQ, there is no need for ARCH_INTEGRATOR
to select SPARSE_IRQ.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-integrator/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 982eabc361635e60..fbc35e9db46d1aa9 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -12,7 +12,6 @@ menuconfig ARCH_INTEGRATOR
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
 	select SOC_INTEGRATOR_CM
-	select SPARSE_IRQ
 	select VERSATILE_FPGA_IRQ
 	help
 	  Support for ARM's Integrator platform.
-- 
2.17.1

