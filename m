Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B21E92C9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgE3RQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 13:16:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47388 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgE3RQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:16:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49Z7Q8101rzB09b6;
        Sat, 30 May 2020 19:16:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LtJtec1cgfzR; Sat, 30 May 2020 19:16:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49Z7Q802qdzB09b5;
        Sat, 30 May 2020 19:16:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 543C28B7B1;
        Sat, 30 May 2020 19:16:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CG9nwzsSTvMY; Sat, 30 May 2020 19:16:34 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 230B98B75E;
        Sat, 30 May 2020 19:16:34 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DBD8265A0D; Sat, 30 May 2020 17:16:33 +0000 (UTC)
Message-Id: <b459e1600b969047a74e34251a84a3d6fdf1f312.1590858925.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc/32s: Fix another build failure with
 CONFIG_PPC_KUAP_DEBUG
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 30 May 2020 17:16:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'thread' doesn't exist in kuap_check() macro.

Use 'current' instead.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Changed author and signed-off-by ... and added asm/bug.h

There are days when you'd better go sleeping instead of wanting to send the fix.
And there are days you stare at your code, think it is good, prepare the patch,
test it, find another bug, fix it, test it ... and send the first patch you prepared :(
hence this second fix for the same bug.
---
 arch/powerpc/include/asm/book3s/32/kup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index db0a1c281587..a41cfc7cc669 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_BOOK3S_32_KUP_H
 #define _ASM_POWERPC_BOOK3S_32_KUP_H
 
+#include <asm/bug.h>
 #include <asm/book3s/32/mmu-hash.h>
 
 #ifdef __ASSEMBLY__
@@ -75,7 +76,7 @@
 
 .macro kuap_check	current, gpr
 #ifdef CONFIG_PPC_KUAP_DEBUG
-	lwz	\gpr, KUAP(thread)
+	lwz	\gpr, THREAD + KUAP(\current)
 999:	twnei	\gpr, 0
 	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
 #endif
-- 
2.25.0

