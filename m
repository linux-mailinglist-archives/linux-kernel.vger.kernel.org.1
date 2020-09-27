Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFC279FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI0JQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:16:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6810 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgI0JQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4b26vdz9vCy1;
        Sun, 27 Sep 2020 11:16:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fBPNQ09o0oCt; Sun, 27 Sep 2020 11:16:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4b10Pfz9vCxw;
        Sun, 27 Sep 2020 11:16:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 709238B771;
        Sun, 27 Sep 2020 11:16:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m7iUBLyHQ6Us; Sun, 27 Sep 2020 11:16:19 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C9DD8B75B;
        Sun, 27 Sep 2020 11:16:19 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2260265DE8; Sun, 27 Sep 2020 09:16:19 +0000 (UTC)
Message-Id: <b4afedce748ed2858299ceab5ae29b52109263ef.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 02/30] powerpc/vdso: Add missing includes and clean
 vdso_setup_syscall_map()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of including extern references locally in
vdso_setup_syscall_map(), add the missing headers.

sys_ni_syscall() being a function, cast its address to
an unsigned long instead of declaring it as a fake
unsigned long object.

At the same time, remove a comment which paraphrases the
function name.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 23208a051af5..b0332c609104 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,8 +17,10 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/memblock.h>
+#include <linux/syscalls.h>
 #include <vdso/datapage.h>
 
+#include <asm/syscall.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
@@ -639,24 +641,18 @@ static __init int vdso_setup(void)
 static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
-	extern unsigned long *sys_call_table;
-#ifdef CONFIG_PPC64
-	extern unsigned long *compat_sys_call_table;
-#endif
-	extern unsigned long sys_ni_syscall;
-
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i] != sys_ni_syscall)
+		if (sys_call_table[i] != (unsigned long)&sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 		if (IS_ENABLED(CONFIG_COMPAT) &&
-		    compat_sys_call_table[i] != sys_ni_syscall)
+		    compat_sys_call_table[i] != (unsigned long)&sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
-		if (sys_call_table[i] != sys_ni_syscall)
+		if (sys_call_table[i] != (unsigned long)&sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #endif /* CONFIG_PPC64 */
@@ -738,9 +734,6 @@ static int __init vdso_init(void)
 #endif
 
 
-	/*
-	 * Setup the syscall map in the vDOS
-	 */
 	vdso_setup_syscall_map();
 
 	/*
-- 
2.25.0

