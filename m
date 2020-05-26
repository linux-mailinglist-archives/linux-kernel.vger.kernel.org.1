Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC71AB7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407817AbgDPGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:09:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407769AbgDPGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:09:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G641aU009354;
        Thu, 16 Apr 2020 02:08:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ehn1g9y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 02:08:39 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03G64Bmi009768;
        Thu, 16 Apr 2020 02:08:38 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ehn1g9xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 02:08:38 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03G66qq3003310;
        Thu, 16 Apr 2020 06:08:37 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 30b5h6r15n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 06:08:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03G68acD15991166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 06:08:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 716AB6E04E;
        Thu, 16 Apr 2020 06:08:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7BCD6E053;
        Thu, 16 Apr 2020 06:08:35 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 06:08:35 +0000 (GMT)
Subject: [PATCH v11 14/14] powerpc: Use mm_context vas_windows counter to
 issue CP_ABORT
From:   Haren Myneni <haren@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mikey@neuling.org, srikar@linux.vnet.ibm.com,
        frederic.barrat@fr.ibm.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, hch@infradead.org, oohall@gmail.com,
        clg@kaod.org, herbert@gondor.apana.org.au,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ajd@linux.ibm.com
In-Reply-To: <1587016214.2275.1036.camel@hbabu-laptop>
References: <1587016214.2275.1036.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 15 Apr 2020 23:08:11 -0700
Message-ID: <1587017291.2275.1077.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_01:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=3 clxscore=1015 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


set_thread_uses_vas() sets used_vas flag for a process that opened VAS
window and issue CP_ABORT during context switch for only that process.
In multi-thread application, windows can be shared. For example Thread
A can open a window and Thread B can run COPY/PASTE instructions to
send NX request which may cause corruption or snooping or a covert
channel Also once this flag is set, continue to run CP_ABORT even the
VAS window is closed.

So define vas-windows counter in process mm_context, increment this
counter for each window open and decrement it for window close. If
vas-windows is set, issue CP_ABORT during context switch. It means
clear the foreign real address mapping only if the process / thread
uses COPY/PASTE. Then disable it for that process if windows are not
open.

Moved set_thread_uses_vas() code to vas_tx_win_open() as this
functionality is needed only for userspace open windows. We are adding
VAS userspace support along with this fix. So no need to include this
fix in stable releases.

Fixes: 9d2a4d71332c ("powerpc: Define set_thread_uses_vas()")
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
Reported-by: Nicholas Piggin <npiggin@gmail.com>
Suggested-by: Milton Miller <miltonm@us.ibm.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h    |  3 +++
 arch/powerpc/include/asm/mmu_context.h      | 30 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/processor.h        |  1 -
 arch/powerpc/include/asm/switch_to.h        |  2 --
 arch/powerpc/kernel/process.c               | 24 ++---------------------
 arch/powerpc/platforms/powernv/vas-window.c | 22 ++++++++++++---------
 6 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index bb3deb7..f0a9ff6 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -116,6 +116,9 @@ struct patb_entry {
 	/* Number of users of the external (Nest) MMU */
 	atomic_t copros;
 
+	/* Number of user space windows opened in process mm_context */
+	atomic_t vas_windows;
+
 	struct hash_mm_context *hash_context;
 
 	unsigned long vdso_base;
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 360367c..1a474f6b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -185,11 +185,41 @@ static inline void mm_context_remove_copro(struct mm_struct *mm)
 			dec_mm_active_cpus(mm);
 	}
 }
+
+/*
+ * vas_windows counter shows number of open windows in the mm
+ * context. During context switch, use this counter to clear the
+ * foreign real address mapping (CP_ABORT) for the thread / process
+ * that intend to use COPY/PASTE. When a process closes all windows,
+ * disable CP_ABORT which is expensive to run.
+ *
+ * For user context, register a copro so that TLBIs are seen by the
+ * nest MMU. mm_context_add/remove_vas_window() are used only for user
+ * space windows.
+ */
+static inline void mm_context_add_vas_window(struct mm_struct *mm)
+{
+	atomic_inc(&mm->context.vas_windows);
+	mm_context_add_copro(mm);
+}
+
+static inline void mm_context_remove_vas_window(struct mm_struct *mm)
+{
+	int v;
+
+	mm_context_remove_copro(mm);
+	v = atomic_dec_if_positive(&mm->context.vas_windows);
+
+	/* Detect imbalance between add and remove */
+	WARN_ON(v < 0);
+}
 #else
 static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
 static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
 static inline void mm_context_add_copro(struct mm_struct *mm) { }
 static inline void mm_context_remove_copro(struct mm_struct *mm) { }
+static inline void mm_context_add_vas_windows(struct mm_struct *mm) { }
+static inline void mm_context_remove_vas_windows(struct mm_struct *mm) { }
 #endif
 
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eedcbfb..bfa336f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -272,7 +272,6 @@ struct thread_struct {
 	unsigned 	mmcr0;
 
 	unsigned 	used_ebb;
-	unsigned int	used_vas;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 5b03d8a..012db9a 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -91,8 +91,6 @@ static inline void clear_task_ebb(struct task_struct *t)
 #endif
 }
 
-extern int set_thread_uses_vas(void);
-
 extern int set_thread_tidr(struct task_struct *t);
 
 #endif /* _ASM_POWERPC_SWITCH_TO_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fad50db..ed3f645 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1221,7 +1221,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
 		 */
-		if (current->thread.used_vas)
+		if (current->mm &&
+			atomic_read(&current->mm->context.vas_windows))
 			asm volatile(PPC_CP_ABORT);
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -1460,27 +1461,6 @@ void arch_setup_new_exec(void)
 }
 #endif
 
-int set_thread_uses_vas(void)
-{
-#ifdef CONFIG_PPC_BOOK3S_64
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		return -EINVAL;
-
-	current->thread.used_vas = 1;
-
-	/*
-	 * Even a process that has no foreign real address mapping can use
-	 * an unpaired COPY instruction (to no real effect). Issue CP_ABORT
-	 * to clear any pending COPY and prevent a covert channel.
-	 *
-	 * __switch_to() will issue CP_ABORT on future context switches.
-	 */
-	asm volatile(PPC_CP_ABORT);
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
-	return 0;
-}
-
 #ifdef CONFIG_PPC64
 /**
  * Assign a TIDR (thread ID) for task @t and set it in the thread
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index e15b405..d62787f 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1058,13 +1058,6 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 			rc = -ENODEV;
 			goto free_window;
 		}
-		/*
-		 * A user mapping must ensure that context switch issues
-		 * CP_ABORT for this thread.
-		 */
-		rc = set_thread_uses_vas();
-		if (rc)
-			goto free_window;
 
 		/*
 		 * Window opened by a child thread may not be closed when
@@ -1090,7 +1083,7 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 
 		mmgrab(txwin->mm);
 		mmput(txwin->mm);
-		mm_context_add_copro(txwin->mm);
+		mm_context_add_vas_window(txwin->mm);
 		/*
 		 * Process closes window during exit. In the case of
 		 * multithread application, the child thread can open
@@ -1099,6 +1092,17 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 		 * to take pid reference for parent thread.
 		 */
 		txwin->tgid = find_get_pid(task_tgid_vnr(current));
+		/*
+		 * Even a process that has no foreign real address mapping can
+		 * use an unpaired COPY instruction (to no real effect). Issue
+		 * CP_ABORT to clear any pending COPY and prevent a covert
+		 * channel.
+		 *
+		 * __switch_to() will issue CP_ABORT on future context switches
+		 * if process / thread has any open VAS window (Use
+		 * current->mm->context.vas_windows).
+		 */
+		asm volatile(PPC_CP_ABORT);
 	}
 
 	set_vinst_win(vinst, txwin);
@@ -1332,7 +1336,7 @@ int vas_win_close(struct vas_window *window)
 			/* Drop references to pid and mm */
 			put_pid(window->pid);
 			if (window->mm) {
-				mm_context_remove_copro(window->mm);
+				mm_context_remove_vas_window(window->mm);
 				mmdrop(window->mm);
 			}
 		}
-- 
1.8.3.1



