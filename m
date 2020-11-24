Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807F2C2888
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgKXNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbgKXNpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:12 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A502083E;
        Tue, 24 Nov 2020 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225511;
        bh=DtG+IMRw20y2hmtpwA24L+hLLydVfP+wjdec7CN4NLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fr62qrVmPcWWFBSTHa8Z+mPLD0Gpy6BOGwYb001UPRubUQ7CJ4svbYhk1yesBSxg6
         fK6YbIZbLserD+kmm5GIVgzcn9ZS5RYwB8AKxfzqyA4btPWwu/LUrLRsvn0D6V7Slv
         k2w92oIx/T2QQRFoJAcNITvBpDOSJ7ROzmnX6xEQ=
From:   guoren@kernel.org
To:     peterz@infradead.org, arnd@arndb.de, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/5] csky: Remove simple spinlock implementation
Date:   Tue, 24 Nov 2020 13:43:55 +0000
Message-Id: <1606225437-22948-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606225437-22948-1-git-send-email-guoren@kernel.org>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There are two implementation of spinlock in csky:
 - simple one (NR_CPU = 1,2)
 - tick's one (NR_CPU = 3,4,5...)

We needn't the baby codes of simple one now.

Link: https://lore.kernel.org/linux-csky/20200807081253.GD2674@hirez.programming.kicks-ass.net/#t
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/csky/Kconfig                      |   2 +-
 arch/csky/include/asm/spinlock.h       | 164 ---------------------------------
 arch/csky/include/asm/spinlock_types.h |  10 --
 3 files changed, 1 insertion(+), 175 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 268fad5..14ee229 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -7,7 +7,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 7cf3f2b..9feb0fd 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -6,8 +6,6 @@
 #include <linux/spinlock_types.h>
 #include <asm/barrier.h>
 
-#ifdef CONFIG_QUEUED_RWLOCKS
-
 /*
  * Ticket-based spin-locking.
  */
@@ -91,166 +89,4 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
-#else /* CONFIG_QUEUED_RWLOCKS */
-
-/*
- * Test-and-set spin-locking.
- */
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 1b   \n"
-		"	movi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->lock, 0);
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 2f   \n"
-		"	movi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
-
-/*
- * read lock/unlock/trylock
- */
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	blz		%0, 1b   \n"
-		"	addi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	blz		%0, 2f   \n"
-		"	addi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-/*
- * write lock/unlock/trylock
- */
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 1b   \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->lock, 0);
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 2f   \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-#endif /* CONFIG_QUEUED_RWLOCKS */
 #endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 88b8243..8ff0f6f 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -22,16 +22,6 @@ typedef struct {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
 
-#ifdef CONFIG_QUEUED_RWLOCKS
 #include <asm-generic/qrwlock_types.h>
 
-#else /* CONFIG_NR_CPUS > 2 */
-
-typedef struct {
-	u32 lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif /* CONFIG_QUEUED_RWLOCKS */
 #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.7.4

