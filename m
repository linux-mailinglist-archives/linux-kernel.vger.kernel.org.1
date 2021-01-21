Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034322FE34A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAUG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbhAUG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:57:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74AB323976;
        Thu, 21 Jan 2021 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212199;
        bh=9crLphldI+pxbID6OLrwUOxXKprJ2xTa4r9Ylj/4pto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+qbVqX+KKYPjevMwToIsLBnYVWttDKtaMLnA7NQCLfrw2ydSPnUXU+I4dZP6hXfg
         vWm1vNwk+9XYGC0ZcBYivPDUUd7l7swN4X+Vwc6dJr0ppN3QzGMdH9/s1uw4ezSqfd
         zIgWdwN43CnlDkCq4TiVy7n0qVni/f7itK497asRmdIbtyz9ACM69kxADGkVOHMAju
         NOnikyFnWdIeyjPvgseFlED1EczQiMedklhzQ+hvjr6xbyYvl7PWodizro9inJ0fSe
         c9w3etE4/u/gwvciAsH/lM54ocV42e8utvTJQLRYlu3nuygkuVAYCIMXechJgHMiXS
         tI0mOJynrCESg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 04/29] csky: Remove custom asm/atomic.h implementation
Date:   Thu, 21 Jan 2021 14:53:24 +0800
Message-Id: <20210121065349.3188251-4-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Use generic atomic implementation based on cmpxchg. So remove csky
asm/atomic.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 arch/csky/include/asm/atomic.h | 212 ---------------------------------
 1 file changed, 212 deletions(-)
 delete mode 100644 arch/csky/include/asm/atomic.h

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
deleted file mode 100644
index e369d73b13e3..000000000000
--- a/arch/csky/include/asm/atomic.h
+++ /dev/null
@@ -1,212 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_ATOMIC_H
-#define __ASM_CSKY_ATOMIC_H
-
-#include <linux/version.h>
-#include <asm/cmpxchg.h>
-#include <asm/barrier.h>
-
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
-
-#include <asm-generic/atomic.h>
-
-#endif /* __ASM_CSKY_ATOMIC_H */
-- 
2.17.1

