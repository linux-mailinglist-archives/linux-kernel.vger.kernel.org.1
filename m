Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27E2FCC11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbhATHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:52:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34352 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbhATHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:50:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DLHj545f5z9tyjv;
        Wed, 20 Jan 2021 08:49:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aUZQ7k60osz0; Wed, 20 Jan 2021 08:49:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DLHj53GvCz9tyjn;
        Wed, 20 Jan 2021 08:49:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 656648B7DF;
        Wed, 20 Jan 2021 08:49:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZfMJvtburgwY; Wed, 20 Jan 2021 08:49:14 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 438648B7E1;
        Wed, 20 Jan 2021 08:49:14 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3ACF166A54; Wed, 20 Jan 2021 07:49:14 +0000 (UTC)
Message-Id: <f9981e819009aa121a998dc483052ec76f78f991.1611128938.git.christophe.leroy@csgroup.eu>
In-Reply-To: <2fed79b1154c872194f98bac4422c23918325e61.1611128938.git.christophe.leroy@csgroup.eu>
References: <2fed79b1154c872194f98bac4422c23918325e61.1611128938.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/44x: Remove STDBINUTILS kconfig option
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Jan 2021 07:49:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STDBINUTILS is just a toggle to allow 256k page size
to appear in the possible page sizes list for the 44x.

Make 256k page size appear all the time with an
explicit warning on binutils, and remove this unneccessary
STDBINUTILS config option.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a685e42d3993..3e29995540a7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -720,18 +720,6 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
-config STDBINUTILS
-	bool "Using standard binutils settings"
-	depends on 44x
-	default y
-	help
-	  Turning this option off allows you to select 256KB PAGE_SIZE on 44x.
-	  Note, that kernel will be able to run only those applications,
-	  which had been compiled using binutils later than 2.17.50.0.3 with
-	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
-	  the older binutils, you can patch them with a trivial patch, which
-	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.
-
 choice
 	prompt "Page size"
 	default PPC_4K_PAGES
@@ -771,17 +759,16 @@ config PPC_64K_PAGES
 	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
 
 config PPC_256K_PAGES
-	bool "256k page size"
-	depends on 44x && !STDBINUTILS && !PPC_47x
+	bool "256k page size (Requires non-standard binutils settings)"
+	depends on 44x && !PPC_47x
 	help
 	  Make the page size 256k.
 
-	  As the ELF standard only requires alignment to support page
-	  sizes up to 64k, you will need to compile all of your user
-	  space applications with a non-standard binutils settings
-	  (see the STDBINUTILS description for details).
-
-	  Say N unless you know what you are doing.
+	  That kernel will be able to run only those applications,
+	  which had been compiled using binutils later than 2.17.50.0.3 with
+	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
+	  the older binutils, you can patch them with a trivial patch, which
+	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.
 
 endchoice
 
-- 
2.25.0

