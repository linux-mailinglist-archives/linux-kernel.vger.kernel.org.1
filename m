Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77A2C288F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbgKXNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388593AbgKXNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:28 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C06C2087D;
        Tue, 24 Nov 2020 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225526;
        bh=levK7wUVTU/CP5ZuAopBIMCjvkEhOFNbIvK0MW6TTKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWeVcruDOlUtIfI0n7ZzMU2zPgvQdLwAOfe98mOnNadTtB3A8/V+xCqiryPqyrw92
         kxi5lbehXyS1u7FIu9nPfJi6IoNbfFNIj82JJFRbhVxB1BTxIl9A7VVw7Cv2ydJtub
         f3UcNt6X9jLcrcqcNtAVm3sllMbhaDFiKNsbk1wE=
From:   guoren@kernel.org
To:     peterz@infradead.org, arnd@arndb.de, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/5] csky: Optimize atomic operations with correct barrier usage
Date:   Tue, 24 Nov 2020 13:43:57 +0000
Message-Id: <1606225437-22948-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606225437-22948-1-git-send-email-guoren@kernel.org>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The implementation of csky atomic operations in the past was very
rough. Frankly speaking, the implementation is wrong and limits
hardware performance. Optimize the performance of atomic, spinlock,
cmpxchg more fine-grained by increasing acquire/release memory
barriers. Here are the details of the modification:

 - Add acquire/release barrier for cmpxchg.h.
 - Remove custom atomic.h implementations.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/atomic.h  | 203 +---------------------------------------
 arch/csky/include/asm/barrier.h |  64 ++++++++++---
 arch/csky/include/asm/cmpxchg.h |  85 ++++++++++++++---
 3 files changed, 128 insertions(+), 224 deletions(-)

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
index e369d73..c699c41 100644
--- a/arch/csky/include/asm/atomic.h
+++ b/arch/csky/include/asm/atomic.h
@@ -3,209 +3,10 @@
 #ifndef __ASM_CSKY_ATOMIC_H
 #define __ASM_CSKY_ATOMIC_H
 
-#include <linux/version.h>
-#include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#ifdef CONFIG_CPU_HAS_LDSTEX
-
-#define __atomic_add_unless __atomic_add_unless
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
-{
-	unsigned long tmp, ret;
-
-	smp_mb();
-
-	asm volatile (
-	"1:	ldex.w		%0, (%3) \n"
-	"	mov		%1, %0   \n"
-	"	cmpne		%0, %4   \n"
-	"	bf		2f	 \n"
-	"	add		%0, %2   \n"
-	"	stex.w		%0, (%3) \n"
-	"	bez		%0, 1b   \n"
-	"2:				 \n"
-		: "=&r" (tmp), "=&r" (ret)
-		: "r" (a), "r"(&v->counter), "r"(u)
-		: "memory");
-
-	if (ret != u)
-		smp_mb();
-
-	return ret;
-}
-
-#define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long tmp;						\
-									\
-	asm volatile (							\
-	"1:	ldex.w		%0, (%2) \n"				\
-	"	" #op "		%0, %1   \n"				\
-	"	stex.w		%0, (%2) \n"				\
-	"	bez		%0, 1b   \n"				\
-		: "=&r" (tmp)						\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-}
-
-#define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned long tmp, ret;						\
-									\
-	smp_mb();							\
-	asm volatile (							\
-	"1:	ldex.w		%0, (%3) \n"				\
-	"	" #op "		%0, %2   \n"				\
-	"	mov		%1, %0   \n"				\
-	"	stex.w		%0, (%3) \n"				\
-	"	bez		%0, 1b   \n"				\
-		: "=&r" (tmp), "=&r" (ret)				\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-	smp_mb();							\
-									\
-	return ret;							\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long tmp, ret;						\
-									\
-	smp_mb();							\
-	asm volatile (							\
-	"1:	ldex.w		%0, (%3) \n"				\
-	"	mov		%1, %0   \n"				\
-	"	" #op "		%0, %2   \n"				\
-	"	stex.w		%0, (%3) \n"				\
-	"	bez		%0, 1b   \n"				\
-		: "=&r" (tmp), "=&r" (ret)				\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-	smp_mb();							\
-									\
-	return ret;							\
-}
-
-#else /* CONFIG_CPU_HAS_LDSTEX */
-
-#include <linux/irqflags.h>
-
-#define __atomic_add_unless __atomic_add_unless
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
-{
-	unsigned long tmp, ret, flags;
-
-	raw_local_irq_save(flags);
-
-	asm volatile (
-	"	ldw		%0, (%3) \n"
-	"	mov		%1, %0   \n"
-	"	cmpne		%0, %4   \n"
-	"	bf		2f	 \n"
-	"	add		%0, %2   \n"
-	"	stw		%0, (%3) \n"
-	"2:				 \n"
-		: "=&r" (tmp), "=&r" (ret)
-		: "r" (a), "r"(&v->counter), "r"(u)
-		: "memory");
-
-	raw_local_irq_restore(flags);
-
-	return ret;
-}
-
-#define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long tmp, flags;					\
-									\
-	raw_local_irq_save(flags);					\
-									\
-	asm volatile (							\
-	"	ldw		%0, (%2) \n"				\
-	"	" #op "		%0, %1   \n"				\
-	"	stw		%0, (%2) \n"				\
-		: "=&r" (tmp)						\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-									\
-	raw_local_irq_restore(flags);					\
-}
-
-#define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned long tmp, ret, flags;					\
-									\
-	raw_local_irq_save(flags);					\
-									\
-	asm volatile (							\
-	"	ldw		%0, (%3) \n"				\
-	"	" #op "		%0, %2   \n"				\
-	"	stw		%0, (%3) \n"				\
-	"	mov		%1, %0   \n"				\
-		: "=&r" (tmp), "=&r" (ret)				\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-									\
-	raw_local_irq_restore(flags);					\
-									\
-	return ret;							\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long tmp, ret, flags;					\
-									\
-	raw_local_irq_save(flags);					\
-									\
-	asm volatile (							\
-	"	ldw		%0, (%3) \n"				\
-	"	mov		%1, %0   \n"				\
-	"	" #op "		%0, %2   \n"				\
-	"	stw		%0, (%3) \n"				\
-		: "=&r" (tmp), "=&r" (ret)				\
-		: "r" (i), "r"(&v->counter)				\
-		: "memory");						\
-									\
-	raw_local_irq_restore(flags);					\
-									\
-	return ret;							\
-}
-
-#endif /* CONFIG_CPU_HAS_LDSTEX */
-
-#define atomic_add_return atomic_add_return
-ATOMIC_OP_RETURN(add, +)
-#define atomic_sub_return atomic_sub_return
-ATOMIC_OP_RETURN(sub, -)
-
-#define atomic_fetch_add atomic_fetch_add
-ATOMIC_FETCH_OP(add, +)
-#define atomic_fetch_sub atomic_fetch_sub
-ATOMIC_FETCH_OP(sub, -)
-#define atomic_fetch_and atomic_fetch_and
-ATOMIC_FETCH_OP(and, &)
-#define atomic_fetch_or atomic_fetch_or
-ATOMIC_FETCH_OP(or, |)
-#define atomic_fetch_xor atomic_fetch_xor
-ATOMIC_FETCH_OP(xor, ^)
-
-#define atomic_and atomic_and
-ATOMIC_OP(and, &)
-#define atomic_or atomic_or
-ATOMIC_OP(or, |)
-#define atomic_xor atomic_xor
-ATOMIC_OP(xor, ^)
-
-#undef ATOMIC_FETCH_OP
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
+#define __atomic_acquire_fence() __smp_acquire_fence()
+#define __atomic_release_fence() __smp_release_fence()
 
 #include <asm-generic/atomic.h>
 
diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index a430e7f..6f8269b 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -16,24 +16,64 @@
  * sync.i:      inherit from sync, but also flush cpu pipeline
  * sync.is:     the same with sync.i + sync.s
  *
- * bar.brwarw:  ordering barrier for all load/store instructions before it
- * bar.brwarws: ordering barrier for all load/store instructions before it
- *						and shareable to other cores
- * bar.brar:    ordering barrier for all load       instructions before it
- * bar.brars:   ordering barrier for all load       instructions before it
- *						and shareable to other cores
- * bar.bwaw:    ordering barrier for all store      instructions before it
- * bar.bwaws:   ordering barrier for all store      instructions before it
- *						and shareable to other cores
+ *
+ * bar.brwarws: ordering barrier for all load/store instructions
+ *              before/after it and share to other harts
+ *
+ * |31|30 26|25 21|20 16|15  10|9   5|4           0|
+ *  1  10000 s0000 00000 100001	00001 0 bw br aw ar
+ *
+ * b: before
+ * a: after
+ * r: read
+ * w: write
+ * s: share to other harts
+ *
+ * Here are all combinations:
+ *
+ * bar.brws
+ * bar.brs
+ * bar.bws
+ * bar.arws
+ * bar.ars
+ * bar.aws
+ * bar.brwarws
+ * bar.brarws
+ * bar.bwarws
+ * bar.brwars
+ * bar.brwaws
+ * bar.brars
+ * bar.bwaws
  */
 
 #ifdef CONFIG_CPU_HAS_CACHEV2
 #define mb()		asm volatile ("sync.s\n":::"memory")
 
 #ifdef CONFIG_SMP
-#define __smp_mb()	asm volatile ("bar.brwarws\n":::"memory")
-#define __smp_rmb()	asm volatile ("bar.brars\n":::"memory")
-#define __smp_wmb()	asm volatile ("bar.bwaws\n":::"memory")
+
+#define __bar_brws()	asm volatile (".long 0x842cc200\n":::"memory")
+#define __bar_brs()	asm volatile (".long 0x8424c200\n":::"memory")
+#define __bar_bws()	asm volatile (".long 0x8428c200\n":::"memory")
+#define __bar_arws()	asm volatile (".long 0x8423c200\n":::"memory")
+#define __bar_ars()	asm volatile (".long 0x8421c200\n":::"memory")
+#define __bar_aws()	asm volatile (".long 0x8422c200\n":::"memory")
+#define __bar_brwarws()	asm volatile (".long 0x842fc200\n":::"memory")
+#define __bar_brarws()	asm volatile (".long 0x8427c200\n":::"memory")
+#define __bar_bwarws()	asm volatile (".long 0x842bc200\n":::"memory")
+#define __bar_brwars()	asm volatile (".long 0x842dc200\n":::"memory")
+#define __bar_brwaws()	asm volatile (".long 0x842ec200\n":::"memory")
+#define __bar_brars()	asm volatile (".long 0x8425c200\n":::"memory")
+#define __bar_brars()	asm volatile (".long 0x8425c200\n":::"memory")
+#define __bar_bwaws()	asm volatile (".long 0x842ac200\n":::"memory")
+
+#define __smp_mb()	__bar_brwarws()
+#define __smp_rmb()	__bar_brars()
+#define __smp_wmb()	__bar_bwaws()
+
+#define ACQUIRE_FENCE		".long 0x8427c200\n"
+#define __smp_acquire_fence()	__bar_brarws()
+#define __smp_release_fence()	__bar_brwaws()
+
 #endif /* CONFIG_SMP */
 
 #define sync_is()	asm volatile ("sync.is\n":::"memory")
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index ca03e90..3030608 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -8,7 +8,7 @@
 
 extern void __bad_xchg(void);
 
-#define __xchg(new, ptr, size)					\
+#define __xchg_relaxed(new, ptr, size)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -18,7 +18,6 @@ extern void __bad_xchg(void);
 	case 2:							\
 		align = ((unsigned long) __ptr & 0x3);		\
 		addr = ((unsigned long) __ptr & ~0x3);		\
-		smp_mb();					\
 		if (align) {					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%4) \n"		\
@@ -50,10 +49,8 @@ extern void __bad_xchg(void);
 			: "r" (__new), "r"(addr)		\
 			:);					\
 		}						\
-		smp_mb();					\
 		break;						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	mov		%1, %2   \n"		\
@@ -62,7 +59,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (tmp)		\
 			: "r" (__new), "r"(__ptr)		\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -70,9 +66,32 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
+#define xchg_relaxed(ptr, x)					\
+({								\
+	__xchg_relaxed((x), (ptr), sizeof(*(ptr)));		\
+})
+
+#define xchg_acquire(ptr, x)					\
+({								\
+	__typeof__(*(ptr)) __ret;				\
+	__ret = xchg_relaxed(ptr, x);				\
+	__smp_acquire_fence();					\
+	__ret;							\
+})
+
+#define xchg_release(ptr, x)					\
+({								\
+	__smp_release_fence();					\
+	xchg_relaxed(ptr, x);					\
+})
+
+#define xchg(ptr, x)						\
+({								\
+	__smp_release_fence();					\
+	xchg_acquire(ptr, x);					\
+})
 
-#define __cmpxchg(ptr, old, new, size)				\
+#define __cmpxchg_relaxed(ptr, old, new, size)			\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
@@ -81,7 +100,6 @@ extern void __bad_xchg(void);
 	__typeof__(*(ptr)) __ret = 0;				\
 	switch (size) {						\
 	case 4:							\
-		smp_mb();					\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
 		"	cmpne		%0, %4   \n"		\
@@ -93,7 +111,6 @@ extern void __bad_xchg(void);
 			: "=&r" (__ret), "=&r" (__tmp)		\
 			: "r" (__new), "r"(__ptr), "r"(__old)	\
 			:);					\
-		smp_mb();					\
 		break;						\
 	default:						\
 		__bad_xchg();					\
@@ -101,8 +118,54 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define cmpxchg(ptr, o, n) \
-	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+#define cmpxchg_relaxed(ptr, o, n)				\
+	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg_release(ptr, o, n)				\
+({								\
+	__smp_release_fence();					\
+	cmpxchg_relaxed(ptr, o, n);				\
+})
+
+#define __cmpxchg_acquire(ptr, old, new, size)			\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
+	__typeof__(*(ptr)) __ret = 0;				\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		ACQUIRE_FENCE					\
+		"2:				 \n"		\
+			: "=&r" (__ret), "=&r" (__tmp)		\
+			: "r" (__new), "r"(__ptr), "r"(__old)	\
+			:);					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+
+#define cmpxchg_acquire(ptr, o, n)				\
+	(__cmpxchg_acquire((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg(ptr, o, n)					\
+({								\
+	__typeof__(*(ptr)) __ret;				\
+	__smp_release_fence();					\
+	__ret = cmpxchg_acquire(ptr, o, n);			\
+	__ret;							\
+})
+
 #else
 #include <asm-generic/cmpxchg.h>
 #endif
-- 
2.7.4

