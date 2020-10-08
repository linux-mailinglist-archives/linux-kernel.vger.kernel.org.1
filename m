Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6C286F18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgJHHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:18:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15446 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJHHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:17:58 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201008071755epoutp03aca3ba62dbaa9c29c0fe641b65a630c6~78y7b7why0978409784epoutp034
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:17:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201008071755epoutp03aca3ba62dbaa9c29c0fe641b65a630c6~78y7b7why0978409784epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602141475;
        bh=Vf5REYWqW81SHW1qFAuyX9aUQajo/8TbNcbRUGivZr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0PI5z1u/VKzG1O/TlV/YgeeQHSx4bOFkb8kB7rzN7aUN8Urwyg61QpnyUbbv23HU
         COLurLWJwbVC0mHWkRp2elCkODEKYxfX2N7pAVDwEEGzCqFqMgGVGaJJEi7PvB0MWT
         FU58bI3c/mqGvCG2H1WfS/07CEoAhmexEDRFcRWE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20201008071754epcas5p24636bafeeba46dd3f61352fb627ba5c7~78y65RvQA1424614246epcas5p2J;
        Thu,  8 Oct 2020 07:17:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.9F.09922.22DBE7F5; Thu,  8 Oct 2020 16:17:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201008071633epcas5p20f5c533ac67ab235997e7e4a8ad3022b~78xva7Asx2308523085epcas5p2u;
        Thu,  8 Oct 2020 07:16:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201008071633epsmtrp15269389e67d4a8a91a98a3906c78d6e2~78xvaE7Tz1688916889epsmtrp1g;
        Thu,  8 Oct 2020 07:16:33 +0000 (GMT)
X-AuditID: b6c32a4a-337ff700000026c2-3e-5f7ebd229670
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.D8.08604.1DCBE7F5; Thu,  8 Oct 2020 16:16:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008071630epsmtip1fd5b3c2fc6c841c8feae3a254a7a7056~78xsfNEN21840618406epsmtip12;
        Thu,  8 Oct 2020 07:16:30 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, ndesaulniers@google.com, caij2003@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de, maz@kernel.org,
        valentin.schneider@arm.com, vincent.whitchurch@axis.com,
        nhuck@google.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        will@kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/3] arm: introduce self pointer in thread info
Date:   Thu,  8 Oct 2020 12:45:31 +0530
Message-Id: <1602141333-17822-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7bCmpq7S3rp4gy+ThC0mTHvBYnFxd6rF
        nPVr2CymXZzEbLFy3k5Gi02Pr7FaXN41h83i0NS9jBaH57exWOycc5LV4sOE/0wWmw9/YrHY
        vGkqs8Whk3MZLbbP/8lscX6bv0XLHVMHQY8189Ywely+dpHZ4/q6AI+ds+6yeyzYVOqxaVUn
        m8e7c+fYPU7M+M3isXlJvUffllWMHp83yQVwR3HZpKTmZJalFunbJXBlrF/7grHggWLFhRkr
        mBoYW6W7GDk5JARMJA6en84OYgsJ7GaUaJpc3cXIBWR/YpRYfWUTC4TzjVHiUdMiZpiOtve3
        oRJ7GSVuzXvLBuF8ZZRoXnCfFaSKTUBPYtWuPWBVIgJTmCTmfV0O5jALLGKUmHOxnxGkSljA
        XuLMn09gNouAqsSZB9eYQGxeAXeJmfeaWSD2yUncPNcJtJuDg1PAQ+LvR02QORICezgktlyZ
        wgpR4yIxcd5OqPuEJV4d38IOYUtJvOxvY4doaGaU+LRvLSOEM4VRYunFj1Dd9hKvmxuYQDYw
        C2hKrN+lDxGWlZh6ah3YQcwCfBK9v58wQcR5JXbMg7FVJVpuboAaIy3x+eNHqKM9JM6cWMYM
        CZfZjBLb125nmcAoNwthxQJGxlWMkqkFxbnpqcWmBUZ5qeV6xYm5xaV56XrJ+bmbGMHJSstr
        B+PDBx/0DjEycTAeYpTgYFYS4U33rokX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqv040yckEB6
        YklqdmpqQWoRTJaJg1OqgWnN/fW3jPdvEbunnBqyuL9MKsNwVe6nyf0J7FKG3qt9l7owfTr8
        beX+vzVL2T2n5Nzz6Fx84YH+UoeNz4zXJeS7Ojy+flbXtJlzyRa5nHTdZddOBkYzt8Sees0X
        X7732uLVrtcrNsv9Cbm+/WeNxacX5+dt49HryLkZdGRJ92veCOnjm53iolRC1zo8dLGql35X
        mPLfzmGn+PYw4Rlne/fGM24wDtm/b4lUdWGd5+nFmp78bn672UuMjr1tSS+I3smct+XmhLku
        Tz3jw1v/Hy67duPXox2+XCKijkfKrC07P9R3FS7e8fjdZYnwy+JxZ8QKHkf6Z4i5zGxeb3mC
        V/vHplRO3ofzF70MavG4n67EUpyRaKjFXFScCADEoZI3xQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO7FPXXxBjv7RCwmTHvBYnFxd6rF
        nPVr2CymXZzEbLFy3k5Gi02Pr7FaXN41h83i0NS9jBaH57exWOycc5LV4sOE/0wWmw9/YrHY
        vGkqs8Whk3MZLbbP/8lscX6bv0XLHVMHQY8189Ywely+dpHZ4/q6AI+ds+6yeyzYVOqxaVUn
        m8e7c+fYPU7M+M3isXlJvUffllWMHp83yQVwR3HZpKTmZJalFunbJXBlrF/7grHggWLFhRkr
        mBoYW6W7GDk5JARMJNre32bpYuTiEBLYzSjx8/86NoiEtMTPf+9ZIGxhiZX/nrNDFH1mlDi0
        ai87SIJNQE9i1a49YN0iAkuYJI5emswK4jALLGOUaP+7lhWkSljAXuLMn0+MIDaLgKrEmQfX
        mEBsXgF3iZn3mqFWyEncPNfJ3MXIwcEp4CHx96MmSFgIqGRi113WCYx8CxgZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBEeDluYOxu2rPugdYmTiYDzEKMHBrCTCm+5dEy/Em5JY
        WZValB9fVJqTWnyIUZqDRUmc90bhwjghgfTEktTs1NSC1CKYLBMHp1QDk0vwpoYMqY9XKg29
        DuWaTclY9/7X3NlbhBXe3NP9kc69PFvx2blHv3OYtLQnJCWzGjqVlTdO1z7C+kz+kpnrTkft
        dZ8DLprX7tWVd2JOX7aVVzFyJ8cmi30JxZvr1K4eaZTYcCXm8sxfdZ/li7suxsqobb+8REC/
        jaNi25SC4JcCd98d3co961luTYNeSnZNqEASs3TKyZn3DTbMqvD01bnXdOne49hYXVuToNBr
        f9XVlscYcv1Ol/q5cqv7cnUtv6m2lqbHf8sJvbLTXm6VP3XCr9VLI7U+X/KpMD4om9m/um6Z
        0dypUX+jsw+ynZObyWB80bP6ai7/h5TkvadeMDtuP+2acteAZZGPidROJZbijERDLeai4kQA
        vSWzoPUCAAA=
X-CMS-MailID: 20201008071633epcas5p20f5c533ac67ab235997e7e4a8ad3022b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201008071633epcas5p20f5c533ac67ab235997e7e4a8ad3022b
References: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
        <CGME20201008071633epcas5p20f5c533ac67ab235997e7e4a8ad3022b@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

self pointer to thread info is added in thread info.
It is base change required for IRQ stack on ARM.

both stacks will have pointer to thread_info at bottom.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm/Kconfig                   | 10 ++++++++++
 arch/arm/include/asm/assembler.h   |  3 +++
 arch/arm/include/asm/thread_info.h | 27 +++++++++++++++++++++++++++
 include/linux/thread_info.h        |  4 ++++
 kernel/fork.c                      |  1 +
 5 files changed, 45 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2..434442f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1667,6 +1667,16 @@ config STACKPROTECTOR_PER_TASK
 	  Enable this option to switch to a different method that uses a
 	  different canary value for each task.
 
+config IRQ_STACK
+	bool "use separate stacks for Interrupts"
+	default n
+	depends on FRAME_POINTER && !CC_IS_CLANG
+	help
+	  Select this option to use separate stacks for Interrupt handling code.
+	  It will add latency in fetching thread info of one more derefer operation
+	  and add latency in Interrupt serve at time as for each Interrupt, thread_info
+	  pointer needs to be stored at bottom of interrupt stack.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index fce52eed..8512bdc 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -207,6 +207,9 @@
  THUMB(	mov	\rd, sp			)
  THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
 	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
+#ifdef CONFIG_IRQ_STACK
+	ldr	\rd, [\rd]
+#endif
 	.endm
 
 /*
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 536b6b9..a4d5f76 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -44,6 +44,9 @@ struct cpu_context_save {
  * __switch_to() assumes cpu_context follows immediately after cpu_domain.
  */
 struct thread_info {
+#ifdef CONFIG_IRQ_STACK
+	void			*tinfo_ptr;	/* pointer to self thread_info */
+#endif
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
@@ -67,14 +70,33 @@ struct thread_info {
 #endif
 };
 
+
+#ifdef CONFIG_IRQ_STACK
+#define INIT_THREAD_SELF_PTR				\
+	.tinfo_ptr	= &init_thread_union.thread_info,
+#else
+#define INIT_THREAD_SELF_PTR
+#endif
+
 #define INIT_THREAD_INFO(tsk)						\
 {									\
+	INIT_THREAD_SELF_PTR						\
 	.task		= &tsk,						\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
 }
 
+
+#ifdef CONFIG_IRQ_STACK
+#define TASK_THREAD_SELF_POINTER(tsk)				\
+{								\
+	struct thread_info *ti = task_thread_info(tsk);		\
+								\
+	ti->tinfo_ptr = ti;					\
+}
+#endif
+
 /*
  * how to get the thread information struct from C
  */
@@ -82,8 +104,13 @@ struct thread_info {
 
 static inline struct thread_info *current_thread_info(void)
 {
+#ifdef CONFIG_IRQ_STACK
+	return (struct thread_info *)
+		(*((unsigned long *)(current_stack_pointer & ~(THREAD_SIZE - 1))));
+#else
 	return (struct thread_info *)
 		(current_stack_pointer & ~(THREAD_SIZE - 1));
+#endif
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249..ddf7b43 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -43,6 +43,10 @@ enum {
 #define THREAD_ALIGN	THREAD_SIZE
 #endif
 
+#ifndef TASK_THREAD_SELF_POINTER
+#define TASK_THREAD_SELF_POINTER(tsk)
+#endif
+
 #define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 7ef3eb3..d53f5eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -901,6 +901,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 
 	setup_thread_stack(tsk, orig);
+	TASK_THREAD_SELF_POINTER(tsk);
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
-- 
1.9.1

