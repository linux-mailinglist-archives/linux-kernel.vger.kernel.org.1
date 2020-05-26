Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBAF1C5A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgEEPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729782AbgEEPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:30 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2914C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:29 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by andre.telenet-ops.be with bizsmtp
        id b37U2200Y3VwRR30137UPK; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAO-00028Z-70; Tue, 05 May 2020 17:07:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAO-0000R1-28; Tue, 05 May 2020 17:07:28 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH v2 13/15] ARM: prima2: Drop unneeded select of HAVE_SMP
Date:   Tue,  5 May 2020 17:07:20 +0200
Message-Id: <20200505150722.1575-14-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for CSR SiRF SoCs depends on ARCH_MULTI_V7.
As the latter selects HAVE_SMP, there is no need for ARCH_ATLAS7 to
select HAVE_SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Barry Song <baohua@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-prima2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 6f66785fab01bbc9..ea077f66372dd55a 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -30,7 +30,6 @@ config ARCH_ATLAS7
 	select ARM_GIC
 	select ATLAS7_TIMER
 	select HAVE_ARM_SCU if SMP
-	select HAVE_SMP
 	help
           Support for CSR SiRFSoC ARM Cortex A7 Platform
 
-- 
2.17.1

