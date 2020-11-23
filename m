Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A12C04B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgKWLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:10 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:45509 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgKWLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:09 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: [RFC 5/6] dept: Apply Dept to wait_for_completion()/complete()
Date:   Mon, 23 Nov 2020 20:36:31 +0900
Message-Id: <1606131392-22645-5-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
References: <20201123110527.GB9464@X58A-UD3R>
 <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by
wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 44 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/completion.c  | 16 ++++++++++++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e770..05ce6cb 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -26,15 +26,47 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#ifdef CONFIG_DEPT
+#define dept_wfc_init(m, k, s, n)		dept_map_init(m, k, s, n, DEPT_TYPE_WFC)
+#define dept_wfc_reinit(m)			dept_map_reinit(m, NULL, -1, NULL)
+#define dept_wfc_wait(m, ip)			dept_wait(m, 1UL, ip, __func__, 0)
+#define dept_wfc_complete(m, ip)		dept_event(m, 1UL, ip, __func__)
+#define dept_wfc_enter(m, ip)			dept_ecxt_enter(m, 1UL, ip, "completion_context_enter", "complete", 0)
+#define dept_wfc_exit(m, ip)			dept_ecxt_exit(m, ip)
+#else
+#define dept_wfc_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_wfc_reinit(m)			do { } while (0)
+#define dept_wfc_wait(m, ip)			do { } while (0)
+#define dept_wfc_complete(m, ip)		do { } while (0)
+#define dept_wfc_enter(m, ip)			do { } while (0)
+#define dept_wfc_exit(m, ip)			do { } while (0)
+#endif
+
+#ifdef CONFIG_DEPT
+#define WFC_DEPT_MAP_INIT(work) .dmap = { .name = #work, .type = DEPT_TYPE_WFC }
+#else
+#define WFC_DEPT_MAP_INIT(work)
+#endif
+
+#define init_completion_map(x, m)				\
+	do {							\
+		static struct dept_key __dkey;			\
+		__init_completion(x, &__dkey, #x);		\
+	} while (0)
+#define init_completion(x)					\
+	do {							\
+		static struct dept_key __dkey;			\
+		__init_completion(x, &__dkey, #x);		\
+	} while (0)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	WFC_DEPT_MAP_INIT(work) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -82,9 +114,12 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x,
+				     struct dept_key *dkey,
+				     const char *name)
 {
 	x->done = 0;
+	dept_wfc_init(&x->dmap, dkey, 0, name);
 	init_swait_queue_head(&x->wait);
 }
 
@@ -98,6 +133,7 @@ static inline void __init_completion(struct completion *x)
 static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
+	dept_wfc_reinit(&x->dmap);
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554..e144413 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -29,6 +29,7 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 
 	if (x->done != UINT_MAX)
@@ -58,6 +59,7 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	lockdep_assert_RT_in_threaded_ctx();
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
@@ -135,6 +137,7 @@ void complete_all(struct completion *x)
  */
 void __sched wait_for_completion(struct completion *x)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion);
@@ -154,6 +157,7 @@ void __sched wait_for_completion(struct completion *x)
 unsigned long __sched
 wait_for_completion_timeout(struct completion *x, unsigned long timeout)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	return wait_for_common(x, timeout, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_timeout);
@@ -168,6 +172,7 @@ void __sched wait_for_completion(struct completion *x)
  */
 void __sched wait_for_completion_io(struct completion *x)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	wait_for_common_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_io);
@@ -188,6 +193,7 @@ void __sched wait_for_completion_io(struct completion *x)
 unsigned long __sched
 wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	return wait_for_common_io(x, timeout, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_io_timeout);
@@ -203,7 +209,9 @@ void __sched wait_for_completion_io(struct completion *x)
  */
 int __sched wait_for_completion_interruptible(struct completion *x)
 {
-	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
+	long t;
+	dept_wfc_wait(&x->dmap, _RET_IP_);
+	t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
@@ -225,6 +233,7 @@ int __sched wait_for_completion_interruptible(struct completion *x)
 wait_for_completion_interruptible_timeout(struct completion *x,
 					  unsigned long timeout)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	return wait_for_common(x, timeout, TASK_INTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
@@ -240,7 +249,9 @@ int __sched wait_for_completion_interruptible(struct completion *x)
  */
 int __sched wait_for_completion_killable(struct completion *x)
 {
-	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
+	long t;
+	dept_wfc_wait(&x->dmap, _RET_IP_);
+	t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
@@ -263,6 +274,7 @@ int __sched wait_for_completion_killable(struct completion *x)
 wait_for_completion_killable_timeout(struct completion *x,
 				     unsigned long timeout)
 {
+	dept_wfc_wait(&x->dmap, _RET_IP_);
 	return wait_for_common(x, timeout, TASK_KILLABLE);
 }
 EXPORT_SYMBOL(wait_for_completion_killable_timeout);
-- 
1.9.1

