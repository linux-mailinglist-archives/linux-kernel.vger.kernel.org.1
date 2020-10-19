Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FA292706
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgJSMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:12:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55187 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgJSMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:12:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CFFy16H0Vz9tx00;
        Mon, 19 Oct 2020 14:12:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xJGeoSiQjUb4; Mon, 19 Oct 2020 14:12:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CFFy14yYgz9twyp;
        Mon, 19 Oct 2020 14:12:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FBBB8B7A2;
        Mon, 19 Oct 2020 14:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 20zdV455j0Xe; Mon, 19 Oct 2020 14:12:46 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [10.25.210.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59F0C8B7A1;
        Mon, 19 Oct 2020 14:12:46 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 43E636678A; Mon, 19 Oct 2020 12:12:46 +0000 (UTC)
Message-Id: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 19 Oct 2020 12:12:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4.9 sometimes fails to build with "m<>" constraint in
inline assembly.

  CC      lib/iov_iter.o
In file included from ./arch/powerpc/include/asm/cmpxchg.h:6:0,
                 from ./arch/powerpc/include/asm/atomic.h:11,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/crypto.h:15,
                 from ./include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iovec_from_user.part.30':
./arch/powerpc/include/asm/uaccess.h:287:2: error: 'asm' operand has impossible constraints
  __asm__ __volatile__(    \
  ^
./include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
./arch/powerpc/include/asm/uaccess.h:583:34: note: in expansion of macro 'unsafe_op_wrap'
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
                                  ^
./arch/powerpc/include/asm/uaccess.h:329:10: note: in expansion of macro '__get_user_asm'
  case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break; \
          ^
./arch/powerpc/include/asm/uaccess.h:363:3: note: in expansion of macro '__get_user_size_allowed'
   __get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
   ^
./arch/powerpc/include/asm/uaccess.h:100:2: note: in expansion of macro '__get_user_nocheck'
  __get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
  ^
./arch/powerpc/include/asm/uaccess.h:583:49: note: in expansion of macro '__get_user_allowed'
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
                                                 ^
lib/iov_iter.c:1663:3: note: in expansion of macro 'unsafe_get_user'
   unsafe_get_user(len, &uiov[i].iov_len, uaccess_end);
   ^
make[1]: *** [scripts/Makefile.build:283: lib/iov_iter.o] Error 1

Define a UPD_CONSTR macro that is "<>" by default and
only "" with GCC prior to GCC 5.

Fixes: fcf1f26895a4 ("powerpc/uaccess: Add pre-update addressing to __put_user_asm_goto()")
Fixes: 2f279eeb68b8 ("powerpc/uaccess: Add pre-update addressing to __get_user_asm() and __put_user_asm()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc_asm.h | 14 ++++++++++++++
 arch/powerpc/include/asm/uaccess.h |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 511786f0e40d..471c7c57fc98 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -803,6 +803,20 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
 
 #endif /* !CONFIG_PPC_BOOK3E */
 
+#else /* __ASSEMBLY */
+
+/*
+ * Inline assembly memory constraint
+ *
+ * GCC 4.9 doesn't properly handle pre update memory constraint "m<>"
+ *
+ */
+#if defined(GCC_VERSION) && GCC_VERSION < 50000
+#define UPD_CONSTR ""
+#else
+#define UPD_CONSTR "<>"
+#endif
+
 #endif /*  __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 604d705f1bb8..8f27ea48fadb 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -223,7 +223,7 @@ do {								\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m<>" (*addr)				\
+		: "r" (x), "m"UPD_CONSTR (*addr)		\
 		:						\
 		: label)
 
@@ -294,7 +294,7 @@ extern long __get_user_bad(void);
 		".previous\n"				\
 		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
-		: "m<>" (*addr), "i" (-EFAULT), "0" (err))
+		: "m"UPD_CONSTR (*addr), "i" (-EFAULT), "0" (err))
 
 #ifdef __powerpc64__
 #define __get_user_asm2(x, addr, err)			\
-- 
2.25.0

