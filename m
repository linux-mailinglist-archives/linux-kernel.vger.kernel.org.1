Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379871C5A90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgEEPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbgEEPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:30 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A758C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:29 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by andre.telenet-ops.be with bizsmtp
        id b37T2200t3VwRR30137TP0; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-000282-N4; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000QZ-Kp; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH v2 04/15] ARM: asm9260: Drop unneeded select of GENERIC_CLOCKEVENTS
Date:   Tue,  5 May 2020 17:07:11 +0200
Message-Id: <20200505150722.1575-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the Alphascale ASM9260 platform depends on ARCH_MULTI_V5,
and thus on ARCH_MULTIPLATFORM.
As the latter selects GENERIC_CLOCKEVENTS, there is no need for
MACH_ASM9260 to select GENERIC_CLOCKEVENTS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-asm9260/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
index e42dbaa53bc61b20..a2e1d0aaf2529aa5 100644
--- a/arch/arm/mach-asm9260/Kconfig
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -4,6 +4,5 @@ config MACH_ASM9260
 	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
 	select ASM9260_TIMER
-	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Alphascale ASM9260 based platform.
-- 
2.17.1

