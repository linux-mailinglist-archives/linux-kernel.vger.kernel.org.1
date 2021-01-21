Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40C22FE466
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbhAUHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbhAUG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AEE12399A;
        Thu, 21 Jan 2021 06:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212212;
        bh=Z+bg+iAtLQPpdcJLw9E+9nYUzqpHPBWC2aL/oAWGmFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsEEvpNYc67jV886pPWKTIm9jLif/ISCljYrspwBQEIXLjhFojkG7xr8uKKUS9Jkp
         gRBReZ7BAvNeFhRJF3eKnQIQGiH9sF/oDqZ8ynUggkMGcMNM6g+w4oilcAPWLFvT7f
         FVOg2Rtwqw/Wnk9xDzacO4IpGaeIALYgMUNSFxewfNlJKHQ+xVJZAL4aJZavDMUJ0F
         3brA3GJgVp5e2q1L1xeU0OfXl+SE6oZnSphW41P0HenRV1PxiylBLDk2erlPymk9zZ
         y1Mrt6sdNjDzdRcbWCHcmrCFaF4ZJ1slwU8IwDrwpPC/M6Dtmw6nL9Io1Od1Mo4CTI
         nBk6jGKO+ntmw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/29] csky: Cleanup asm/spinlock.h
Date:   Thu, 21 Jan 2021 14:53:28 +0800
Message-Id: <20210121065349.3188251-8-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There are two implementation of spinlock in arch/csky:
 - simple one (NR_CPU = 1,2)
 - tick's one (NR_CPU = 3,4)
Remove the simple one.

There is already smp_mb in spinlock, so remove the definition of
smp_mb__after_spinlock.

Link: https://lore.kernel.org/linux-csky/20200807081253.GD2674@hirez.programming.kicks-ass.net/#t
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>k
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                      |   2 +-
 arch/csky/include/asm/spinlock.h       | 167 -------------------------
 arch/csky/include/asm/spinlock_types.h |  10 --
 3 files changed, 1 insertion(+), 178 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c74a8e2e8549..af640a41b749 100644
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
index 7cf3f2b34cea..69f5aa249c5f 100644
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
@@ -88,169 +86,4 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 
 #include <asm/qrwlock.h>
 
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()	smp_mb()
-
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
index 88b82438b182..8ff0f6ff3a00 100644
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
2.17.1

