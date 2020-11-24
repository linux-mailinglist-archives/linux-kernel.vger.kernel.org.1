Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749F2C288D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgKXNpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388563AbgKXNpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:05 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA03F2067D;
        Tue, 24 Nov 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225504;
        bh=LemYfSoLF+U2R4PPrq4UpblySoUjDJiNIGRdRoINvRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1iUcbfV4nZXIE8Drim85JLvqc6s6LMIsxUfvsT5qPY1LoRlgO9CRAs8CmVWmn8InS
         7EUFR/G7VhEwesMMOO+MrKEqPBUOewAGRqkGcF7NmztTACwH7ZNz8a2wfLC6zvxLqb
         UohwFFAI1DOd7uIOFHs4aLMVlRYKd6VUXBczNNNs=
From:   guoren@kernel.org
To:     peterz@infradead.org, arnd@arndb.de, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS supported
Date:   Tue, 24 Nov 2020 13:43:54 +0000
Message-Id: <1606225437-22948-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606225437-22948-1-git-send-email-guoren@kernel.org>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

riscv only support lr.wd/s(c).w(d) with word(double word) size &
align access. There are not lr.h/sc.h instructions. But qspinlock.c
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

Michael have sent qspinlock before, ref to Link below.

Link: https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Clark <michaeljclark@mac.com>
---
 arch/riscv/Kconfig                      |   2 +
 arch/riscv/include/asm/Kbuild           |   3 +
 arch/riscv/include/asm/cmpxchg.h        |  36 +++++++++
 arch/riscv/include/asm/spinlock.h       | 126 +-------------------------------
 arch/riscv/include/asm/spinlock_types.h |  15 +---
 5 files changed, 46 insertions(+), 136 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2d61c4c..d757ba4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -36,6 +36,8 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 59dd7be..6f5f438 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -6,3 +6,6 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
+generic-y += mcs_spinlock.h
+generic-y += qrwlock.h
+generic-y += qspinlock.h
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 5609185..e178700 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -16,7 +16,43 @@
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
+	register unsigned long __rc, tmp, align, addr;			\
 	switch (size) {							\
+	case 2:								\
+		align = ((unsigned long) __ptr & 0x3);			\
+		addr = ((unsigned long) __ptr & ~0x3);			\
+		if (align) {						\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, 0(%z4)\n"			\
+			"	move %1, %0\n"				\
+			"	slli %1, %1, 16\n"			\
+			"	srli %1, %1, 16\n"			\
+			"	move %2, %z3\n"				\
+			"	slli %2, %2, 16\n"			\
+			"	or   %1, %2, %1\n"			\
+			"	sc.w %2, %1, 0(%z4)\n"			\
+			"	bnez %2, 0b\n"				\
+			"	srli %0, %0, 16\n"			\
+			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
+			: "rJ" (__new), "rJ"(addr)			\
+			: "memory");					\
+		} else {						\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, (%z4)\n"			\
+			"	move %1, %0\n"				\
+			"	srli %1, %1, 16\n"			\
+			"	slli %1, %1, 16\n"			\
+			"	move %2, %z3\n"				\
+			"	or   %1, %2, %1\n"			\
+			"	sc.w %2, %1, 0(%z4)\n"			\
+			"	bnez %2, 0b\n"				\
+			"	slli %0, %0, 16\n"			\
+			"	srli %0, %0, 16\n"			\
+			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
+			: "rJ" (__new), "rJ"(addr)			\
+			: "memory");					\
+		}							\
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index f4f7fa1..b8deb3a 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -7,129 +7,7 @@
 #ifndef _ASM_RISCV_SPINLOCK_H
 #define _ASM_RISCV_SPINLOCK_H
 
-#include <linux/kernel.h>
-#include <asm/current.h>
-#include <asm/fence.h>
-
-/*
- * Simple spin lock operations.  These provide no fairness guarantees.
- */
-
-/* FIXME: Replace this with a ticket lock, like MIPS. */
-
-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	int tmp = 1, busy;
-
-	__asm__ __volatile__ (
-		"	amoswap.w %0, %2, %1\n"
-		RISCV_ACQUIRE_BARRIER
-		: "=r" (busy), "+A" (lock->lock)
-		: "r" (tmp)
-		: "memory");
-
-	return !busy;
-}
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	while (1) {
-		if (arch_spin_is_locked(lock))
-			continue;
-
-		if (arch_spin_trylock(lock))
-			break;
-	}
-}
-
-/***********************************************************/
-
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1b\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1b\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1f\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1f\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	__asm__ __volatile__(
-		RISCV_RELEASE_BARRIER
-		"	amoadd.w x0, %1, %0\n"
-		: "+A" (lock->lock)
-		: "r" (-1)
-		: "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
+#include <asm/qrwlock.h>
+#include <asm/qspinlock.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index f398e76..d033a97 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -6,20 +6,11 @@
 #ifndef _ASM_RISCV_SPINLOCK_TYPES_H
 #define _ASM_RISCV_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(_ASM_RISCV_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.7.4

