Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120512BA18D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKTEvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:51:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52710 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:51:37 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 08B402A457; Thu, 19 Nov 2020 23:51:35 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <bb327f05f8fb61eeb332cc2ba4e8335570976474.1605847196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Update Kconfig help
Date:   Fri, 20 Nov 2020 15:39:56 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is still some missing hardware support that affects all models,
such as sound chip and localtalk support. However, many models are well
supported, including the Quadra 800 emulated by QEMU. Missing hardware
support is mostly documented at the web site, so add the URL.

Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/Kconfig.machine | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 17e8c3a292d7..054ff6392329 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -30,11 +30,9 @@ config MAC
 	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the Apple Macintosh series of
-	  computers (yes, there is experimental support now, at least for part
-	  of the series).
-
-	  Say N unless you're willing to code the remaining necessary support.
-	  ;)
+	  computers. If you plan to use this kernel on a Mac, say Y here and
+	  browse the documentation available at <http://www.mac.linux-m68k.org/>;
+	  otherwise say N.
 
 config APOLLO
 	bool "Apollo support"
-- 
2.26.2

