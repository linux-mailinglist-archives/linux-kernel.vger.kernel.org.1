Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAD1C5A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgEEPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729781AbgEEPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:32 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985CC061BD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:31 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by xavier.telenet-ops.be with bizsmtp
        id b37T2200R3VwRR30137TZM; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-000280-La; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000QU-KA; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH v2 03/15] ARM: alpine: Drop unneeded select of HAVE_SMP
Date:   Tue,  5 May 2020 17:07:10 +0200
Message-Id: <20200505150722.1575-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Annapurna Labs Alpine platforms depends on ARCH_MULTI_V7.
As the latter selects HAVE_SMP, there is no need for ARCH_ALPINE to
select HAVE_SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-alpine/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index bc04c91294cf12e2..6a68a162385b8534 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -7,7 +7,6 @@ config ARCH_ALPINE
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_ARCH_TIMER
-	select HAVE_SMP
 	select MFD_SYSCON
 	select FORCE_PCI
 	select PCI_HOST_GENERIC
-- 
2.17.1

