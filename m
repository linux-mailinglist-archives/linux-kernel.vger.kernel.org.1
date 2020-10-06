Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102822843E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJFBwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgJFBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:52:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vqC9iGoD7lqgix+TSN95BadQSLKBvGAf2S7ZFiabbMY=; b=duV7SRhY3/WT7K6vrncnSS/C8F
        vMoGIHEyMJSoAvRy2ndUdM2nYIUBxy5D+NH3r/uF3yCR4t5uorEdy3hTkig+qMPnqYoTdoiFljrvB
        oJiBMC6CYAo/KlS5ztGrj918TC4Vi6dKJSfsIjq8j8pDzwefj30mrL7jkuGfn8E1mWTESDZKoNmqm
        Su1CgVWoajXbioJHJyhD6Ntvwm2A6HRuRy2O73CDnXMcB5FCEZ9WW5xnBKgJvyz0ZmwFg0+mmTdjx
        8XJVZakhHpME4uhIODL3PezcBcCE6/09bIJR5ut+4G7LqNE/q1kNFko3OvNhrHvBDbvyK8yvFew74
        mV040W5w==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPc9X-00062w-Vr; Tue, 06 Oct 2020 01:52:32 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel/: fix repeated words in comments
Message-ID: <98202fa6-8919-ef63-9efe-c0fad5ca7af1@infradead.org>
Date:   Mon, 5 Oct 2020 18:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix multiple occurrences of duplicated words in kernel/.

Fix one typo/spello on the same line as a duplicate word.
Change one instance of "the the" to "that the".
Otherwise just drop one of the repeated words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/acct.c            |    2 +-
 kernel/cgroup/cpuset.c   |    2 +-
 kernel/dma/direct.c      |    2 +-
 kernel/fork.c            |    2 +-
 kernel/futex.c           |    2 +-
 kernel/irq/timings.c     |    2 +-
 kernel/jump_label.c      |    2 +-
 kernel/kcsan/encoding.h  |    2 +-
 kernel/kexec_core.c      |    2 +-
 kernel/kthread.c         |    2 +-
 kernel/livepatch/state.c |    2 +-
 kernel/pid_namespace.c   |    2 +-
 kernel/power/snapshot.c  |    2 +-
 kernel/smp.c             |    2 +-
 kernel/user_namespace.c  |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

--- lnx-59-rc8.orig/kernel/acct.c
+++ lnx-59-rc8/kernel/acct.c
@@ -25,7 +25,7 @@
  *  Now we silently close acct_file on attempt to reopen. Cleaned sys_acct().
  *  XTerms and EMACS are manifestations of pure evil. 21/10/98, AV.
  *
- *  Fixed a nasty interaction with with sys_umount(). If the accointing
+ *  Fixed a nasty interaction with sys_umount(). If the accounting
  *  was suspeneded we failed to stop it on umount(). Messy.
  *  Another one: remount to readonly didn't stop accounting.
  *	Question: what should we do if we have CAP_SYS_ADMIN but not
--- lnx-59-rc8.orig/kernel/fork.c
+++ lnx-59-rc8/kernel/fork.c
@@ -2164,7 +2164,7 @@ static __latent_entropy struct task_stru
 
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
-	 * forked. It should be noted the the new process's css_set can be changed
+	 * forked. It should be noted that the new process's css_set can be changed
 	 * between here and cgroup_post_fork() if an organisation operation is in
 	 * progress.
 	 */
--- lnx-59-rc8.orig/kernel/futex.c
+++ lnx-59-rc8/kernel/futex.c
@@ -916,7 +916,7 @@ static inline void exit_pi_state_list(st
  * [10] Found  | Found    | task      | !=taskTID | 0/1    | Invalid
  *
  * [1]	Indicates that the kernel can acquire the futex atomically. We
- *	came came here due to a stale FUTEX_WAITERS/FUTEX_OWNER_DIED bit.
+ *	came here due to a stale FUTEX_WAITERS/FUTEX_OWNER_DIED bit.
  *
  * [2]	Valid, if TID does not belong to a kernel thread. If no matching
  *      thread is found then it indicates that the owner TID has died.
--- lnx-59-rc8.orig/kernel/jump_label.c
+++ lnx-59-rc8/kernel/jump_label.c
@@ -19,7 +19,7 @@
 #include <linux/cpu.h>
 #include <asm/sections.h>
 
-/* mutex to protect coming/going of the the jump_label table */
+/* mutex to protect coming/going of the jump_label table */
 static DEFINE_MUTEX(jump_label_mutex);
 
 void jump_label_lock(void)
--- lnx-59-rc8.orig/kernel/kexec_core.c
+++ lnx-59-rc8/kernel/kexec_core.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(kexec_crash_loaded);
  * defined more restrictively in <asm/kexec.h>.
  *
  * The code for the transition from the current kernel to the
- * the new kernel is placed in the control_code_buffer, whose size
+ * new kernel is placed in the control_code_buffer, whose size
  * is given by KEXEC_CONTROL_PAGE_SIZE.  In the best case only a single
  * page of memory is necessary, but some architectures require more.
  * Because this memory must be identity mapped in the transition from
--- lnx-59-rc8.orig/kernel/kthread.c
+++ lnx-59-rc8/kernel/kthread.c
@@ -775,7 +775,7 @@ EXPORT_SYMBOL(kthread_create_worker);
 
 /**
  * kthread_create_worker_on_cpu - create a kthread worker and bind it
- *	it to a given CPU and the associated NUMA node.
+ *	to a given CPU and the associated NUMA node.
  * @cpu: CPU number
  * @flags: flags modifying the default behavior of the worker
  * @namefmt: printf-style name for the kthread worker (task).
--- lnx-59-rc8.orig/kernel/pid_namespace.c
+++ lnx-59-rc8/kernel/pid_namespace.c
@@ -233,7 +233,7 @@ void zap_pid_ns_processes(struct pid_nam
 	 * to pid_ns->child_reaper.  Thus pidns->child_reaper needs to
 	 * stay valid until they all go away.
 	 *
-	 * The code relies on the the pid_ns->child_reaper ignoring
+	 * The code relies on the pid_ns->child_reaper ignoring
 	 * SIGCHILD to cause those EXIT_ZOMBIE processes to be
 	 * autoreaped if reparented.
 	 *
--- lnx-59-rc8.orig/kernel/smp.c
+++ lnx-59-rc8/kernel/smp.c
@@ -741,7 +741,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * for all the required CPUs to finish. This may include the local
  * processor.
  * @cond_func:	A callback function that is passed a cpu id and
- *		the the info parameter. The function is called
+ *		the info parameter. The function is called
  *		with preemption disabled. The function should
  *		return a blooean value indicating whether to IPI
  *		the specified CPU.
--- lnx-59-rc8.orig/kernel/user_namespace.c
+++ lnx-59-rc8/kernel/user_namespace.c
@@ -515,7 +515,7 @@ EXPORT_SYMBOL(from_kgid_munged);
  *
  *	When there is no mapping defined for the user-namespace projid
  *	pair INVALID_PROJID is returned.  Callers are expected to test
- *	for and handle handle INVALID_PROJID being returned.  INVALID_PROJID
+ *	for and handle INVALID_PROJID being returned.  INVALID_PROJID
  *	may be tested for using projid_valid().
  */
 kprojid_t make_kprojid(struct user_namespace *ns, projid_t projid)
--- lnx-59-rc8.orig/kernel/cgroup/cpuset.c
+++ lnx-59-rc8/kernel/cgroup/cpuset.c
@@ -390,7 +390,7 @@ static void guarantee_online_cpus(struct
 			 * The top cpuset doesn't have any online cpu as a
 			 * consequence of a race between cpuset_hotplug_work
 			 * and cpu hotplug notifier.  But we know the top
-			 * cpuset's effective_cpus is on its way to to be
+			 * cpuset's effective_cpus is on its way to be
 			 * identical to cpu_online_mask.
 			 */
 			cpumask_copy(pmask, cpu_online_mask);
--- lnx-59-rc8.orig/kernel/dma/direct.c
+++ lnx-59-rc8/kernel/dma/direct.c
@@ -15,7 +15,7 @@
 #include <linux/set_memory.h>
 
 /*
- * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
+ * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
  * it for entirely different regions. In that case the arch code needs to
  * override the variable below for dma-direct to work properly.
  */
--- lnx-59-rc8.orig/kernel/irq/timings.c
+++ lnx-59-rc8/kernel/irq/timings.c
@@ -604,7 +604,7 @@ int irq_timings_alloc(int irq)
 
 	/*
 	 * Some platforms can have the same private interrupt per cpu,
-	 * so this function may be be called several times with the
+	 * so this function may be called several times with the
 	 * same interrupt number. Just bail out in case the per cpu
 	 * stat structure is already allocated.
 	 */
--- lnx-59-rc8.orig/kernel/kcsan/encoding.h
+++ lnx-59-rc8/kernel/kcsan/encoding.h
@@ -32,7 +32,7 @@
  *	1. different addresses but with the same encoded address race;
  *	2. and both map onto the same watchpoint slots;
  *
- * Both these are assumed to be very unlikely. However, in case it still happens
+ * Both these are assumed to be very unlikely. However, in case it still
  * happens, the report logic will filter out the false positive (see report.c).
  */
 #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
--- lnx-59-rc8.orig/kernel/livepatch/state.c
+++ lnx-59-rc8/kernel/livepatch/state.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(klp_get_state);
  *
  * The function can be called only during transition when a new
  * livepatch is being enabled or when such a transition is reverted.
- * It is typically called only from from pre/post (un)patch
+ * It is typically called only from pre/post (un)patch
  * callbacks.
  *
  * Return: pointer to the latest struct klp_state from already
--- lnx-59-rc8.orig/kernel/power/snapshot.c
+++ lnx-59-rc8/kernel/power/snapshot.c
@@ -735,7 +735,7 @@ zone_found:
 	 */
 
 	/*
-	 * If the zone we wish to scan is the the current zone and the
+	 * If the zone we wish to scan is the current zone and the
 	 * pfn falls into the current node then we do not need to walk
 	 * the tree.
 	 */

