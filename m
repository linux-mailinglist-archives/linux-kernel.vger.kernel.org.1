Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727E22C288A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgKXNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388593AbgKXNpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:18 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1E020888;
        Tue, 24 Nov 2020 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225517;
        bh=RUSvMWORfq539a0TAZ04lnu9G2BdKaaWBYoxWuQSlSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeSbrNGVsY6eoOquzuMJjQ0JMFFagXr4dv+XnASZt9l+xgtyHZnHEwecU61ivi5qd
         8RVRhlJ95JHo3MEkMlZJ1UI1Po7OZzzaLH3pX8w9xWI6zJ3RmmvxAPEJfVpGeIzJtp
         zgIXFXqz9FcTKA7H4CKyqNUF8EiTj5sulbdgU35g=
From:   guoren@kernel.org
To:     peterz@infradead.org, arnd@arndb.de, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/5] csky: Add QUEUED_SPINLOCKS supported
Date:   Tue, 24 Nov 2020 13:43:56 +0000
Message-Id: <1606225437-22948-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606225437-22948-1-git-send-email-guoren@kernel.org>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Abiv2 only support ldex.w/stex.w with word(double word) size &
align access. There are not short type instructions. But qspinlock.c
need xchg with short type variable:

xchg_tail -> xchg_releaxed(&lock->tail, ...

typedef struct qspinlock {
        union {
                atomic_t val;

                /*
                 * By using the whole 2nd least significant byte for the
                 * pending bit, we can allow better optimization of the lock
                 * acquisition for the pending bit holder.
                 */
                struct {
                        u8      locked;
                        u8      pending;
                };
                struct {
                        u16     locked_pending;
                        u16     tail; /* half word*/
                };
        };
} arch_spinlock_t;

So we add short emulation in xchg with word length and it only
solve qspinlock's requirement.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/Kbuild           |  2 +
 arch/csky/include/asm/cmpxchg.h        | 43 ++++++++++++++++--
 arch/csky/include/asm/spinlock.h       | 82 +---------------------------------
 arch/csky/include/asm/spinlock_types.h | 18 +-------
 5 files changed, 46 insertions(+), 100 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 14ee229..ac02b17 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,6 +8,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 64876e59..f814d46 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -3,7 +3,9 @@ generic-y += asm-offsets.h
 generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += local64.h
+generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += seccomp.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 8922453..ca03e90 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -12,9 +12,46 @@ extern void __bad_xchg(void);
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(new) __new = (new);				\
-	__typeof__(*(ptr)) __ret;				\
-	unsigned long tmp;					\
+	__typeof__(*(ptr)) __ret = 0;				\
+	unsigned long tmp, tmp2, align, addr;			\
 	switch (size) {						\
+	case 2:							\
+		align = ((unsigned long) __ptr & 0x3);		\
+		addr = ((unsigned long) __ptr & ~0x3);		\
+		smp_mb();					\
+		if (align) {					\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%4) \n"		\
+		"	mov		%1, %0   \n"		\
+		"	lsli		%1, 16   \n"		\
+		"	lsri		%1, 16   \n"		\
+		"	mov		%2, %3   \n"		\
+		"	lsli		%2, 16   \n"		\
+		"	or		%1, %2   \n"		\
+		"	stex.w		%1, (%4) \n"		\
+		"	bez		%1, 1b   \n"		\
+		"	lsri		%0, 16   \n"		\
+			: "=&r" (__ret), "=&r" (tmp),		\
+			  "=&r" (tmp2)				\
+			: "r" (__new), "r"(addr)		\
+			:);					\
+		} else {					\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	mov		%1, %0   \n"		\
+		"	lsri		%1, 16   \n"		\
+		"	lsli		%1, 16   \n"		\
+		"	or		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		"	lsli		%0, 16   \n"		\
+		"	lsri		%0, 16   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(addr)		\
+			:);					\
+		}						\
+		smp_mb();					\
+		break;						\
 	case 4:							\
 		smp_mb();					\
 		asm volatile (					\
@@ -41,7 +78,7 @@ extern void __bad_xchg(void);
 	__typeof__(new) __new = (new);				\
 	__typeof__(new) __tmp;					\
 	__typeof__(old) __old = (old);				\
-	__typeof__(*(ptr)) __ret;				\
+	__typeof__(*(ptr)) __ret = 0;				\
 	switch (size) {						\
 	case 4:							\
 		smp_mb();					\
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 9feb0fd..6d21bdb 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -3,88 +3,8 @@
 #ifndef __ASM_CSKY_SPINLOCK_H
 #define __ASM_CSKY_SPINLOCK_H
 
-#include <linux/spinlock_types.h>
-#include <asm/barrier.h>
-
-/*
- * Ticket-based spin-locking.
- */
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lockval;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%2) \n"
-		"	mov		%1, %0	 \n"
-		"	add		%0, %3	 \n"
-		"	stex.w		%0, (%2) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp), "=&r" (lockval)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-
-	while (lockval.tickets.next != lockval.tickets.owner)
-		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
-
-	smp_mb();
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 tmp, contended, res;
-	u32 ticket_next = 1 << TICKET_NEXT;
-	u32 *p = &lock->lock;
-
-	do {
-		asm volatile (
-		"	ldex.w		%0, (%3)   \n"
-		"	movi		%2, 1	   \n"
-		"	rotli		%1, %0, 16 \n"
-		"	cmpne		%1, %0     \n"
-		"	bt		1f         \n"
-		"	movi		%2, 0	   \n"
-		"	add		%0, %0, %4 \n"
-		"	stex.w		%0, (%3)   \n"
-		"1:				   \n"
-		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
-		: "r"(p), "r"(ticket_next)
-		: "cc");
-	} while (!res);
-
-	if (!contended)
-		smp_mb();
-
-	return !contended;
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
-}
-
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.tickets.owner == lock.tickets.next;
-}
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	return !arch_spin_value_unlocked(READ_ONCE(*lock));
-}
-
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
-
-	return (tickets.next - tickets.owner) > 1;
-}
-#define arch_spin_is_contended	arch_spin_is_contended
-
 #include <asm/qrwlock.h>
+#include <asm/qspinlock.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 8ff0f6f..82f5fd5 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -3,25 +3,11 @@
 #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
 #define __ASM_CSKY_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_CSKY_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
-#define TICKET_NEXT	16
-
-typedef struct {
-	union {
-		u32 lock;
-		struct __raw_tickets {
-			/* little endian */
-			u16 owner;
-			u16 next;
-		} tickets;
-	};
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
-
+#include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
 #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.7.4

