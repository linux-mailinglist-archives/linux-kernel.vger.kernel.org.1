Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0F2FE47C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbhAUH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbhAUG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27C8235F9;
        Thu, 21 Jan 2021 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212206;
        bh=1U7yvjmMuzK51PmNewaagHReE48I6+8IeKcDglA4DxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN3qfzI2jmDVAzsVy4ucLz7lsp/KEtdOX3ZMJ4sk88qU+eEE4Vw42P1aTfV9iWaVK
         CW97GgYZKu/cxL0ZwBU5+Zudc4qLcWJT2gXgbGn6QtxaxvCO0L8LJ5YEgKh0rSP5VT
         8Id7I/wMCN/G/rsynRYns8R7YdcFxdrIWLkffoKh0bcsnYGNP0/+4Ip7449yT9eqSY
         s8dimmwfShIKiv7KeP+DgBWx6E9wEfC71nTPfJEzQenthpjrqk24/Miu3S5He2YD+w
         J83CUhkevvx12dzyFdc8zWed99LlPj4YsHEAV24yC6AdLOgbfxfYxa35oZ0NTALJ0u
         PR7CcE374mU2Q==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/29] csky: Fixup futex SMP implementation
Date:   Thu, 21 Jan 2021 14:53:26 +0800
Message-Id: <20210121065349.3188251-6-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Arnd said:
I would guess that for csky, this is a mistake, as the architecture
is fairly new and should be able to implement it.

Guo reply:
The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
with asm-generic's implementation.
For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
implementation, so futex_cmpxchg_enabled = 0.

Thx for point it out, we'll implement cmpxchg_inatomic/inuser for
C860 and still use asm-generic for non-smp CPUs.

LTP test:
futex_wait01    1  TPASS  :  futex_wait(): errno=ETIMEDOUT(110): Connection timed out
futex_wait01    2  TPASS  :  futex_wait(): errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
futex_wait01    3  TPASS  :  futex_wait(): errno=ETIMEDOUT(110): Connection timed out
futex_wait01    4  TPASS  :  futex_wait(): errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
futex_wait02    1  TPASS  :  futex_wait() woken up
futex_wait03    1  TPASS  :  futex_wait() woken up
futex_wait04    1  TPASS  :  futex_wait() returned -1: errno=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com/
---
 arch/csky/Kconfig             |   1 +
 arch/csky/include/asm/futex.h | 121 ++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/csky/include/asm/futex.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 21b2ab099c8b..c74a8e2e8549 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUTEX_CMPXCHG if FUTEX && SMP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/csky/include/asm/futex.h b/arch/csky/include/asm/futex.h
new file mode 100644
index 000000000000..6cfd312723fa
--- /dev/null
+++ b/arch/csky/include/asm/futex.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_FUTEX_H
+#define __ASM_CSKY_FUTEX_H
+
+#ifndef CONFIG_SMP
+#include <asm-generic/futex.h>
+#else
+#include <linux/atomic.h>
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <linux/errno.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
+{									\
+	u32 tmp;							\
+									\
+	__atomic_pre_full_fence();					\
+									\
+	__asm__ __volatile__ (						\
+	"1:	ldex.w	%[ov], %[u]			\n"		\
+	"	"insn"					\n"		\
+	"2:	stex.w	%[t], %[u]			\n"		\
+	"	bez	%[t], 1b			\n"		\
+	"	br	4f				\n"		\
+	"3:	mov	%[r], %[e]			\n"		\
+	"4:						\n"		\
+	"	.section __ex_table,\"a\"		\n"		\
+	"	.balign 4				\n"		\
+	"	.long	1b, 3b				\n"		\
+	"	.long	2b, 3b				\n"		\
+	"	.previous				\n"		\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),				\
+	  [u] "+m" (*uaddr), [t] "=&r" (tmp)				\
+	: [op] "Jr" (oparg), [e] "jr" (-EFAULT)				\
+	: "memory");							\
+									\
+	__atomic_post_full_fence();					\
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("mov %[t], %[ov]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor %[t], %[ov], %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 val, tmp;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	__atomic_pre_full_fence();
+
+	__asm__ __volatile__ (
+	"1:	ldex.w	%[v], %[u]			\n"
+	"	cmpne	%[v], %[ov]			\n"
+	"	bt	4f				\n"
+	"	mov	%[t], %[nv]			\n"
+	"2:	stex.w	%[t], %[u]			\n"
+	"	bez	%[t], 1b			\n"
+	"	br	4f				\n"
+	"3:	mov	%[r], %[e]			\n"
+	"4:						\n"
+	"	.section __ex_table,\"a\"		\n"
+	"	.balign 4				\n"
+	"	.long	1b, 3b				\n"
+	"	.long	2b, 3b				\n"
+	"	.previous				\n"
+	: [r] "+r" (ret), [v] "=&r" (val), [u] "+m" (*uaddr),
+	  [t] "=&r" (tmp)
+	: [ov] "Jr" (oldval), [nv] "Jr" (newval), [e] "Jr" (-EFAULT)
+	: "memory");
+
+	__atomic_post_full_fence();
+
+	*uval = val;
+	return ret;
+}
+
+#endif /* CONFIG_SMP */
+#endif /* __ASM_CSKY_FUTEX_H */
-- 
2.17.1

