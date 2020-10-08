Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB8286F17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJHHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:17:55 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38408 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJHHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:17:54 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201008071751epoutp043e2df76ba404db1449065b93e3e15c1a~78y4G7r8g3199131991epoutp04X
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:17:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201008071751epoutp043e2df76ba404db1449065b93e3e15c1a~78y4G7r8g3199131991epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602141471;
        bh=7bOY40C14FlTn6CNSDZ31H6o8aQXRDrmi4JEk/EXl2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0XuCj42JDCBWnp/EgF/0Bnyz0FK7Vwj7uC47o8KegTtLV7++68W2ErWmeW/mnJCK
         gnAuO1wl3sh/gmltiAGDH+GS2rUCvL4ZSTYfJlV+UCGA17s3mpF4S8vzZDsDy0aHRD
         rb/UPHA4tMVGloqD3S/qmsqj6Adg+ja9U92quClk=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201008071750epcas5p305b0c7ce6431d59cbb5d990bc2962f9f~78y3iOnE71100711007epcas5p3G;
        Thu,  8 Oct 2020 07:17:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.D2.09567.E1DBE7F5; Thu,  8 Oct 2020 16:17:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83~78x0pJn5b0806608066epcas5p49;
        Thu,  8 Oct 2020 07:16:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201008071639epsmtrp1813629dc629515a8bfe66f518748448b~78x0oPSwE1688916889epsmtrp1i;
        Thu,  8 Oct 2020 07:16:39 +0000 (GMT)
X-AuditID: b6c32a4b-2f3ff7000000255f-55-5f7ebd1e322e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.9A.08745.6DCBE7F5; Thu,  8 Oct 2020 16:16:38 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008071635epsmtip1811c5c403afefee620d73e8ea180e363~78xxYtWLM1815718157epsmtip17;
        Thu,  8 Oct 2020 07:16:35 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, ndesaulniers@google.com, caij2003@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de, maz@kernel.org,
        valentin.schneider@arm.com, vincent.whitchurch@axis.com,
        nhuck@google.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        will@kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 2/3] arm: introduce IRQ stacks
Date:   Thu,  8 Oct 2020 12:45:32 +0530
Message-Id: <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0xTVxjdfe+1fZRU31oSLwVZ7MYCJisYNN4wU0fitpeRZWzGP3TRWuWl
        JULBPn6HCBumm52zwAojXWmJVjcZIi0o0FomxQ1QV1dJIFUwzCERyKRQCWOAzvZB9t853znn
        O19uLomLHTwpmaMtZHRaVa6MLySu9ycnvZPgOaVMfXFBjmoanhLI72aQ5WorHzX463B02doD
        kPOvER4adln4yFvvAajfpidQj2WIh4I1LzHU0b9AoA5nPY68Q00AddmWcXTv+ifo9Niu916n
        W62tgB4e8eP0aFsW3WMeF9DNziLa2XKGTz/z+QT0YOMKQXfYK+lznS2ADjkTsqIPCfdkM7k5
        xYwuRXFUqPF0dQsKBpNKXb1GQRVYizeAKBJSO6HlOzfPAISkmHID2Gj/EufIAoChpyY87BJT
        IQC/dkdvJLpCVYCbuwB0tGVzgUUAgz1TEYFPyWGL6wYRFmIoEwatiz9GCE6dB9DiN0Zcklcu
        i9UgCGOCSoR/9C1EsIj6ELpHG3lcXQIM+M68OoMkoygars0nh/dA6gYJl/v+5XOefXDt5iOC
        wxI4M9Ap4LAUThv1Ai5QDeBC7xXAEROAF/3z6w174Wx1FRZuwKlkeNWVwo23wvrbbVgY49Qm
        +O3KJMbNRbDbuoET4elA+/qaOBian18/gobnayzrr/oDgBOuYV4NSDD/X9EMQAuIZQrYPDXD
        7ipI0zIlclaVxxZp1fLj+XlOEPlV2zO7weOJoNwLMBJ4ASRxWYxInVmhFIuyVWXljC5fqSvK
        ZVgviCMJ2RaR7J+7R8SUWlXInGCYAka3oWJklLQKG7ifLtz0gUkxdu+O5LX91z6akdaa399s
        fKYvU2TFja7GeT4fYd8eadp2aUaQ+Vt5TL5tqilWVFdmXHG8wauNest+NjX2z4rE2Vu3HeMl
        jgO9SiOxI6jYvBofKG19UDq3zy5tt+pW2YxjJz9+0nBhbaz8YMwW2/jf08uBSfLSL7WK37ee
        PLukf/lZHfwp/eHcFxMH5dScxn9nUD/15OflSW8wPcn8LjI0ZyivlBbm7M5pX+xLGzZYnzcq
        H3auTp9LPXYEVo+9KHGErL5PNZYBjR97M1sdf6ty91IKUTwr8Xzz1R6fNnqItn1/eKlY8ZhO
        M9+0V0oOB37da9q/7ZqiwpghI1iNasd2XMeq/gPOHennxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO61PXXxBnP/mltMmPaCxeLi7lSL
        OevXsFlMuziJ2WLlvJ2MFpseX2O1uLxrDpvFoal7GS0Oz29jsdg55ySrxYcJ/5ksNh/+xGKx
        edNUZotDJ+cyWmyf/5PZ4vw2f4uWO6YOgh5r5q1h9Lh87SKzx/V1AR47Z91l91iwqdRj06pO
        No93586xe5yY8ZvFY/OSeo++LasYPT5vkgvgjuKySUnNySxLLdK3S+DK2Lt9B3vBCY2KXfv6
        2RsY/8p0MXJySAiYSGz/3MDYxcjFISSwg1Fiz47NrBAJaYmf/96zQNjCEiv/PWeHKPrMKHHr
        7U92kASbgJ7Eql17WEASIgJLmCSOXprMCuIwCyxjlGj/uxZslDBQ1Zx5XWAdLAKqEhcOfgKz
        eQXcJXZfnwG1Tk7i5rlO5i5GDg5OAQ+Jvx81QcJCQCUTu+6yTmDkW8DIsIpRMrWgODc9t9iw
        wCgvtVyvODG3uDQvXS85P3cTIzgatLR2MO5Z9UHvECMTB+MhRgkOZiUR3nTvmngh3pTEyqrU
        ovz4otKc1OJDjNIcLErivF9nLYwTEkhPLEnNTk0tSC2CyTJxcEo1MJ1T+Fh58a54TMa/6sX/
        uKRX/d4R5VKZt1H44x9NDVXfTI5QH6G3j1YJ/LZZcTTx7ck/K4yfLBOqkVJZEGNg5nd18hKL
        l2vMpY4uuP/lQtgJrZnBSQtf88/tP7j18CojQZlzrxJ+TMk4u84oqi/f2u2QkbeYg8qKX9ZT
        05+/XKSgfC9TRVRUczOXZrbBzqWXfXOyvufGHOF8wPGWbe7r/GzPXUpWLSVT0260fdi8yv3l
        pO1Be7m2r2m1/v3NsvDL8yzFzyK9R4LSZs16LCqf/EvhP0teXkHi64U+l5Itr3N9s0s7tofV
        5ZT65y3bXi0qPFHfwP/uy+5W/Q1z0ne1pE7f/KdZxeXhNMVGrgthSWeUWIozEg21mIuKEwHn
        VyUa9QIAAA==
X-CMS-MailID: 20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83
References: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
        <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code for switching to IRQ stack.
IRQ stack and Kernel SVC stack have below design.

IRQ STACK:-
                    ------------ IRQ stack top
                    |          |
                    ------------
                    .          .
                    .          .
                    .          .
                    ------------
                    |    sp    | <- irq_stack_base + 0x8
                    ------------
                    |    fp    | <- irq_stack_base + 0x4
                    ------------
                    |tinfo_ptr | /* pointer to thread info */
irq_stack_ptr -->   ------------ IRQ stack base

Kernel SVC stack:-
                    ------------  Kernel stack top
                    |          |
                    ------------
                    .          .
                    .          .
                    .          .
                    ------------
                    |          |
                    |          |
                    ------------
                    |tinfo_ptr |  /* pointer to thread info */
                    ------------ Kernel stack base

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/include/asm/assembler.h |  8 ++++++++
 arch/arm/include/asm/irq.h       |  6 ++++++
 arch/arm/kernel/entry-armv.S     | 41 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/irq.c            | 24 +++++++++++++++++++++++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 8512bdc..82ee6ee 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -212,6 +212,14 @@
 #endif
 	.endm
 
+	.macro	this_cpu_ptr, sym, reg, tmp
+	ldr	\reg, =\sym
+#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
+	mrc	p15, 0, \tmp, cr13, c0, 4
+	add	\reg, \reg, \tmp
+#endif
+	.endm
+
 /*
  * Increment/decrement the preempt count.
  */
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d4114..f3299ab 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -22,10 +22,16 @@
 #define NO_IRQ	((unsigned int)(-1))
 #endif
 
+#define IRQ_STACK_SIZE	THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
 
+#ifdef CONFIG_IRQ_STACK
+DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
+#endif
+
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 55a47df..13a5889 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -32,6 +32,43 @@
 #include "entry-header.S"
 #include <asm/entry-macro-multi.S>
 #include <asm/probes.h>
+#ifdef CONFIG_IRQ_STACK
+#include <asm/irq.h>
+#endif
+
+	.macro  irq_stack_entry
+#ifdef CONFIG_IRQ_STACK
+	mov	r6, sp	/* preserve sp */
+
+	this_cpu_ptr irq_stack_ptr, r7, r8
+	ldr	r7, [r7]
+	mov	r8, r7
+
+	/*
+	 * Compare sp with base of IRQ stack.
+	 * if the top ~(#THREAD_SIZE_ORDER + PAGE_SHIFT) bits match,
+	 * we are on a irq stack.
+	 */
+	eor	r8, r8, sp
+	lsrs	r8, #THREAD_SIZE_ORDER + PAGE_SHIFT
+	beq	9998f
+
+	/*
+	 * store thread info pointer on IRQ stack and
+	 * switch to the irq stack.
+	 */
+	get_thread_info r8
+	stm	r7, {r8, fp, sp}
+	add	sp, r7, #IRQ_STACK_SIZE
+9998:
+#endif
+        .endm
+
+	.macro	irq_stack_exit
+#ifdef CONFIG_IRQ_STACK
+	mov	sp, r6	/* restore sp */
+#endif
+       .endm
 
 /*
  * Interrupt handling.
@@ -41,11 +78,13 @@
 	ldr	r1, =handle_arch_irq
 	mov	r0, sp
 	badr	lr, 9997f
+	irq_stack_entry
 	ldr	pc, [r1]
+9997:
+	irq_stack_exit
 #else
 	arch_irq_handler_default
 #endif
-9997:
 	.endm
 
 	.macro	pabt_helper
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 698b6f6..79872e5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -43,6 +43,15 @@
 
 unsigned long irq_err_count;
 
+#ifdef CONFIG_IRQ_STACK
+DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
+
+/*
+ * irq_stack must be IRQ_STACK_SIZE(THREAD_SIZE) aligned,
+ */
+DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(IRQ_STACK_SIZE);
+#endif
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 #ifdef CONFIG_FIQ
@@ -55,6 +64,20 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
+#ifdef CONFIG_IRQ_STACK
+static void init_irq_stacks(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
+}
+#else
+static inline void init_irq_stacks(void)
+{
+}
+#endif
+
 /*
  * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
  * not come via this function.  Instead, they should provide their
@@ -79,6 +102,7 @@ void __init init_IRQ(void)
 {
 	int ret;
 
+	init_irq_stacks();
 	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
 		irqchip_init();
 	else
-- 
1.9.1

