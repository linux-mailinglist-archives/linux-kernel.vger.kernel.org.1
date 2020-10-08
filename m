Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7587D286F16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgJHHRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:17:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38367 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJHHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:17:50 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201008071748epoutp04ef12d3b4819843d64610a034853e4f2f~78y1YSYIG3200132001epoutp04W
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:17:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201008071748epoutp04ef12d3b4819843d64610a034853e4f2f~78y1YSYIG3200132001epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602141468;
        bh=JCVpl5uat1cNo0UOKahe14Mr4y41hnbSJQhspIQ7t1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGq2CeXpCHtC+ebIboIqU+Xko/bALQnyXkQnJgkUv9BoymyGORLYiKdpjB9I/AJKc
         7N0fXroeQBOaRrYAH5P7dTo3bjLJncbXM0vR8J0K0EY3bDMzgrFsk663Cr8OWPcYoL
         5KYrzj/BABFyWwG/hm362VLbWU98gybbpuUATBlk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201008071747epcas5p3080d89557d08fd7ca96370e34ddf2fe7~78y0bDCU72238122381epcas5p3y;
        Thu,  8 Oct 2020 07:17:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.9F.09922.B1DBE7F5; Thu,  8 Oct 2020 16:17:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201008071644epcas5p1f5c220b5f58fd4251695af147325b7c4~78x5TahY52909229092epcas5p1c;
        Thu,  8 Oct 2020 07:16:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201008071644epsmtrp226160c6f0adf83520e1508354e1d5fd7~78x5SjAwe2993029930epsmtrp2h;
        Thu,  8 Oct 2020 07:16:44 +0000 (GMT)
X-AuditID: b6c32a4a-321ff700000026c2-25-5f7ebd1b6a25
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.AA.08745.BDCBE7F5; Thu,  8 Oct 2020 16:16:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008071640epsmtip1873f95622fdfeb48cbb973b9655b0c99~78x2KKNPC1744417444epsmtip1t;
        Thu,  8 Oct 2020 07:16:40 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, ndesaulniers@google.com, caij2003@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de, maz@kernel.org,
        valentin.schneider@arm.com, vincent.whitchurch@axis.com,
        nhuck@google.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        will@kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 3/3] arm: Modify stack trace and dump for use with irq stack
Date:   Thu,  8 Oct 2020 12:45:33 +0530
Message-Id: <1602141333-17822-4-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7bCmhq703rp4g7f3JS0mTHvBYnFxd6rF
        nPVr2CymXZzEbLFy3k5Gi02Pr7FaXN41h83i0NS9jBaH57exWOycc5LV4sOE/0wWmw9/YrHY
        vGkqs8Whk3MZLbbP/8lscX6bv0XLHVMHQY8189Ywely+dpHZ4/q6AI+ds+6yeyzYVOqxaVUn
        m8e7c+fYPU7M+M3isXlJvUffllWMHp83yQVwR3HZpKTmZJalFunbJXBl7Gt8w1yw2bBi+8aF
        LA2MKzW6GDk5JARMJA5uPsfWxcjFISSwm1FizZEpLBDOJ0aJ+a1rWSGcz4wSR/f9YYVp+X5y
        PRNEYhejxO/eU8wQzldGieUX/7OAVLEJ6Ems2rUHbJaIwBQmiXlfl4M5zAKLGCXmXOxnBKkS
        FvCRuPNnCRuIzSKgKvHh+DcmEJtXwF1i1bOHLBD75CRunusEWsHBwSngIfH3oybIHAmBPRwS
        t3p+MkHUuEi0TT4CZQtLvDq+hR3ClpL4/G4vG0RDM6PEp31rGSGcKYwSSy9+hPrIXuJ1cwMT
        yAZmAU2J9bv0IcKyElNPrQMbyizAJ9H7+wnUAl6JHfNgbFWJlpsboMZIS3z++JEFZIwE0KHn
        7vJCgmU2o8TKvUvZJzDKzULYsICRcRWjZGpBcW56arFpgVFearlecWJucWleul5yfu4mRnCy
        0vLawfjwwQe9Q4xMHIyHGCU4mJVEeNO9a+KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yr9OBMn
        JJCeWJKanZpakFoEk2Xi4JRqYCo3/mN5rdKZsU0udeXMoGX1p4p+eR8VX/N6okSSrbfA0qj3
        S7ncVBVDjjv8UBS41bjjrefEGW8lMndbrb3/Na35+O68L5f7VvztC7xRsuVCFdPrK09ZneWm
        RymsE+mcEhHDmdGw4G56UdJUro1H/tzS1l7y4HnzEqEcm0z+XEvxY1kv2ppfm5lWfuh7dSt6
        6dO0BHHZP8/X568PLKmKK5iU031b95BMYLLw/82nV4ouf5y95GTn3Cny87913Lo2ifOnY3LS
        gUPGR9gOfpPsVltcWvtQT3TW/gW+D5q/fbobdukU97kz/y0Szxe5z/93QqHFqnHn8xV7MoI+
        PuvMO3WtVLDN/pEEa9nkvU22XUuUWIozEg21mIuKEwFFH7yWxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO7tPXXxBlMuG1tMmPaCxeLi7lSL
        OevXsFlMuziJ2WLlvJ2MFpseX2O1uLxrDpvFoal7GS0Oz29jsdg55ySrxYcJ/5ksNh/+xGKx
        edNUZotDJ+cyWmyf/5PZ4vw2f4uWO6YOgh5r5q1h9Lh87SKzx/V1AR47Z91l91iwqdRj06pO
        No93586xe5yY8ZvFY/OSeo++LasYPT5vkgvgjuKySUnNySxLLdK3S+DK2Nf4hrlgs2HF9o0L
        WRoYV2p0MXJySAiYSHw/uZ6pi5GLQ0hgB6PEpUermSES0hI//71ngbCFJVb+e84OUfSZUWLK
        zU6wBJuAnsSqXXtYQBIiAkuYJI5emswK4jALLGOUaP+7lhWkSljAR+LOnyVsIDaLgKrEh+Pf
        mEBsXgF3iVXPHkKtkJO4ea4TaDUHB6eAh8Tfj5ogYSGgkoldd1knMPItYGRYxSiZWlCcm55b
        bFhglJdarlecmFtcmpeul5yfu4kRHA1aWjsY96z6oHeIkYmD8RCjBAezkghvundNvBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHer7MWxgkJpCeWpGanphakFsFkmTg4pRqYEmwypnH7/qud8Eso
        52LP/uo+Zvm5IqVvokXtTVe8XdYysbo78UVQ3AzVn5HLdd58qv/y5OhL26/vMq8WvxaWtFh7
        fN0a+zilNvWozX9DjhWf95Blc3FkmjF584+oxUurUudrHrHXC4888dth6QSR3WuPO5/4KCIl
        b8S8ban/xs7eSWd5ryf/3rO3QcbQXV+qIkDlW/3p0laNrzkt31dOq0oR70gIlLnxdN/sO2fO
        Lpv7qEI2t6Ff4sO36YXtHkdM955PirmWkiIbX2I799/Cd8vKjb+/u3r70uVKaa65th+nrxPd
        liHn8NguynoN+9SHqRcC7q2IDngyeZL495Wt+09Xl+mldBzK6b63i835uhJLcUaioRZzUXEi
        ANKZDK71AgAA
X-CMS-MailID: 20201008071644epcas5p1f5c220b5f58fd4251695af147325b7c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201008071644epcas5p1f5c220b5f58fd4251695af147325b7c4
References: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
        <CGME20201008071644epcas5p1f5c220b5f58fd4251695af147325b7c4@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows unwind_frame() to traverse from interrupt stack to task
stack correctly.

A similar approach is taken to modify dump_backtrace_entry(),
which expects to find struct pt_regs underneath any call to
functions marked __exception. When on an irq_stack,
the struct pt_regs is stored on the old task stack.

c_backtrace() is also modified on same logic, when traversing from last
IRQ frame, update fp with SVC mode fp.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/include/asm/irq.h   |  7 +++++++
 arch/arm/kernel/stacktrace.c | 21 ++++++++++++++++++++
 arch/arm/kernel/traps.c      | 47 +++++++++++++++++++++++++++++++++++++++++---
 arch/arm/lib/backtrace.S     | 18 +++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index f3299ab..d4c66e9 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -30,6 +30,13 @@
 
 #ifdef CONFIG_IRQ_STACK
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
+
+#define IRQ_STACK_BASE_PTR	(unsigned long)(raw_cpu_read(irq_stack_ptr))
+#define IRQ_STACK_TOP_PTR	(unsigned long)(raw_cpu_read(irq_stack_ptr) + IRQ_STACK_SIZE)
+
+#define IRQ_STACK_TO_TASK_FRAME(ptr)	(*((unsigned long *)(ptr + 0x4)))
+#define IRQ_STACK_TO_TASK_STACK(ptr)	(*((unsigned long *)(ptr + 0x8)))
+
 #endif
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 76ea417..65b9634 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -7,6 +7,9 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
+#ifdef CONFIG_IRQ_STACK
+#include <asm/irq.h>
+#endif
 
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 /*
@@ -42,6 +45,13 @@ int notrace unwind_frame(struct stackframe *frame)
 {
 	unsigned long high, low;
 	unsigned long fp = frame->fp;
+#ifdef CONFIG_IRQ_STACK
+	unsigned long irq_stack_base_p;
+	unsigned long irq_stack_p;
+
+	irq_stack_base_p = IRQ_STACK_BASE_PTR;
+	irq_stack_p = irq_stack_base_p + IRQ_STACK_SIZE;
+#endif
 
 	/* only go to a higher address on the stack */
 	low = frame->sp;
@@ -67,6 +77,17 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->pc = *(unsigned long *)(fp - 4);
 #endif
 
+#ifdef CONFIG_IRQ_STACK
+	/*
+	 * Check whether we are going to walk through from interrupt stack
+	 * to task stack.
+	 * If we reach the end of the stack - and its an interrupt stack,
+	 * read the original task stack pointer base + 4 of IRQ stack.
+	 */
+	if (frame->sp == irq_stack_p)
+		frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_base_p);
+#endif
+
 	return 0;
 }
 #endif
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a78..36b0cda 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -65,8 +65,20 @@ static int __init user_debug_setup(char *str)
 void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
 {
-	unsigned long end = frame + 4 + sizeof(struct pt_regs);
+	unsigned long end;
 
+#ifdef CONFIG_IRQ_STACK
+	unsigned long irq_stack_base_p;
+	unsigned long irq_stack_p;
+
+	irq_stack_base_p = IRQ_STACK_BASE_PTR;
+	irq_stack_p = irq_stack_base_p + IRQ_STACK_SIZE;
+
+	if (frame < irq_stack_p && (frame + sizeof(struct pt_regs)) > irq_stack_p)
+		frame = IRQ_STACK_TO_TASK_STACK(irq_stack_base_p) - 4;
+#endif
+
+	end = frame + 4 + sizeof(struct pt_regs);
 #ifdef CONFIG_KALLSYMS
 	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
 		loglvl, where, (void *)where, from, (void *)from);
@@ -113,6 +125,35 @@ static int verify_stack(unsigned long sp)
 
 	return 0;
 }
+
+#ifdef CONFIG_IRQ_STACK
+static int fp_underflow(unsigned long fp, struct task_struct *tsk)
+{
+	unsigned long end = (unsigned long)end_of_stack(tsk);
+	unsigned long irq_stack_base_p;
+	unsigned long irq_stack_p;
+
+	irq_stack_base_p = IRQ_STACK_BASE_PTR;
+	irq_stack_p = irq_stack_base_p + IRQ_STACK_SIZE;
+
+
+	if (fp > end && fp < end + THREAD_SIZE)
+		return 0;
+
+	if (fp > irq_stack_base_p && fp < irq_stack_p)
+		return 0;
+
+	return 1;
+}
+#else
+static int fp_underflow(unsigned long fp, struct task_struct *tsk)
+{
+	if (fp < (unsigned long)end_of_stack(tsk))
+		return 1;
+
+	return 0;
+}
+#endif
 #endif
 
 /*
@@ -238,7 +279,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	} else if (verify_stack(fp)) {
 		pr_cont("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)end_of_stack(tsk))
+	} else if (fp_underflow(fp, tsk))
 		pr_cont("frame pointer underflow");
 	pr_cont("\n");
 
@@ -292,7 +333,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+			 THREAD_SIZE + (unsigned long)(regs->ARM_sp & ~(THREAD_SIZE - 1)));
 		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 872f658..1a8e645 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -9,6 +9,9 @@
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#ifdef CONFIG_IRQ_STACK
+#include <asm/irq.h>
+#endif
 		.text
 
 @ fp is 0 or stack frame
@@ -96,6 +99,21 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		teq	sv_fp, #0		@ zero saved fp means
 		beq	no_frame		@ no further frames
 
+#ifdef CONFIG_IRQ_STACK
+		/*
+		 * check if it is swtiching from IRQ to SVC,
+		 * then update frame accordingly.
+		 */
+		this_cpu_ptr irq_stack_ptr r2 r3
+		ldr	r3, [r2]
+		add	r2, r3, #IRQ_STACK_SIZE
+		ldr	r0, [frame, #-8]
+		cmp	r2, r0
+		ldreq	sv_fp, [r3, #4]
+		moveq	frame, sv_fp
+		beq	for_each_frame
+#endif
+
 		cmp	sv_fp, frame		@ next frame must be
 		mov	frame, sv_fp		@ above the current frame
 		bhi	for_each_frame
-- 
1.9.1

