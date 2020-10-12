Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D828AC54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgJLDA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJLDAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:00:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F5C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 20:00:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e7so3212684pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mveunp61B/drSAh/w3VGXwCN01nqcZogrgNyzyeYNp4=;
        b=diE/HhJXpuJO4macfkf04WMNynW8Fu4oW9hPXn+eGneSX6ac+xhJt+boSKPdDFckRs
         G8twQpWdycOoNpOeT+R30syZPqYmCgRXbJ7NB2q9OUBh7QiemOya1UBLIpAEz9aPaI5u
         XKX9AO5ZWPfr3hEof55HLzgxtbBRd/JvwsXd8cEAn3uh3bK7fXD3j3xWHabdVaXxT/fY
         i7T265tkR93WHeXNaIU+TaqXvjxhzKUcAgjY1vmUEp05bLdSk6TRuB9cE0ig9ICtH0tO
         drrk97Kz/J/uE8PbEbPC22pY3Lej4o74grQoGoiDdSj2dPZOTW4tysorsj8vShwLqM7M
         rgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mveunp61B/drSAh/w3VGXwCN01nqcZogrgNyzyeYNp4=;
        b=oq4Yt2TIjMwJcU6cKLMbElCHQlmH6u1pFr2aCkt/jNOTrAMbfdFAEVt9vs78/bwVx+
         P1cTrzvc378f7FF4ap/+1TKpS3d40CHKkoFnvaZdj278eJxO6TG5Cn4iju5CjNZ1l1tw
         WcAif7XSzb04l/W5XefgHUKmuFMENOWD064AKHR4k94Wrb7BV/XsxDMZdUHPsUeDQhIH
         epdpJyhWasbwXOHfYYrBYsCU/W0edw4T+bG5hdCiam7tV1troGxPj5EP/8iynwjK5Co+
         ID7G9Zenn5c2l1Bv7FCNsklqZ/i8UweBi9AFAl35R+rsH/7llJxOsgna9iPFlguNjFJH
         7bjA==
X-Gm-Message-State: AOAM531IvE2uHJ4GYckvGqV/Wi1SdtKsuuKP/sQgnT+/Epw7Tngg6pNc
        gq/v2iX84gdYJhec4yICXmI=
X-Google-Smtp-Source: ABdhPJx6RnncCqxyMt/JKCEkWtzoOKECsbLdUMY1BcEUnkJydNp59283WclXpmoMB9hd37h7ZDbYfg==
X-Received: by 2002:a65:4107:: with SMTP id w7mr4312884pgp.361.1602471654859;
        Sun, 11 Oct 2020 20:00:54 -0700 (PDT)
Received: from localhost.localdomain ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id y4sm17610355pgl.67.2020.10.11.20.00.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 20:00:54 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, sboyd@kernel.org
Cc:     axboe@kernel.dk, akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH V6] kthread: Add debugobject support
Date:   Mon, 12 Oct 2020 10:52:58 +0800
Message-Id: <1602471178-59526-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

kthread_work is not covered by debug objects, but the same problems as with
regular work objects apply.

Some of the issues like reinitialization of an active kthread_work are hard
to debug because the problem manifests itself later in a completely
different context.

Add debugobject support along with the necessary fixup functions to make
debugging of these problems less tedious.

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
V6:
- Changelog update follow tglx's suggestion
- Completion initialized as part of kthread_init_work_onstack() in kthread_flush_worker()/kthread_flush_work()

V5:
- Fix format error checked by checkpatch.pl 

V4:
- Changelog update
- Add comment for KWORK_ENTRY_STATIC
- Code format modification 
- Check worker availability early in kthread_flush_work

V3:
- changelog update
- add fixup_assert_init support
- move debug_kwork_activate/debug_kwork_deactivate before list operation
- name the kconfig CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
- use kthread_init_work_onstack/destroy_kwork_on_stack when kthread_work used on stack
- __init_kwork before clear kthread_work in kthread_init_work
---
 include/linux/kthread.h |  30 +++++++++-
 include/linux/poison.h  |   4 ++
 kernel/kthread.c        | 142 +++++++++++++++++++++++++++++++++++++++++++++---
 lib/Kconfig.debug       |  10 ++++
 4 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0..706302b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -108,6 +108,17 @@ struct kthread_delayed_work {
 	struct timer_list timer;
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
+extern void __init_kwork(struct kthread_work *kwork, int onstack);
+extern void destroy_kwork_on_stack(struct kthread_work *kwork);
+extern void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork);
+#else
+static inline void __init_kwork(struct kthread_work *kwork, int onstack) { }
+static inline void destroy_kwork_on_stack(struct kthread_work *kwork) { }
+static inline void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork) { }
+#endif
+
+
 #define KTHREAD_WORKER_INIT(worker)	{				\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
@@ -115,7 +126,7 @@ struct kthread_delayed_work {
 	}
 
 #define KTHREAD_WORK_INIT(work, fn)	{				\
-	.node = LIST_HEAD_INIT((work).node),				\
+	.node = { .next = KWORK_ENTRY_STATIC },				\
 	.func = (fn),							\
 	}
 
@@ -159,6 +170,15 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 
 #define kthread_init_work(work, fn)					\
 	do {								\
+		__init_kwork(work, 0);						\
+		memset((work), 0, sizeof(struct kthread_work));		\
+		INIT_LIST_HEAD(&(work)->node);				\
+		(work)->func = (fn);					\
+	} while (0)
+
+#define kthread_init_work_onstack(work, fn)					\
+	do {								\
+		__init_kwork(work, 1);						\
 		memset((work), 0, sizeof(struct kthread_work));		\
 		INIT_LIST_HEAD(&(work)->node);				\
 		(work)->func = (fn);					\
@@ -172,6 +192,14 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 			     TIMER_IRQSAFE);				\
 	} while (0)
 
+#define kthread_init_delayed_work_onstack(dwork, fn)				\
+	do {								\
+		kthread_init_work_onstack(&(dwork)->work, (fn));		\
+		__init_timer_on_stack(&(dwork)->timer,				\
+			     kthread_delayed_work_timer_fn,		\
+			     TIMER_IRQSAFE);				\
+	} while (0)
+
 int kthread_worker_fn(void *worker_ptr);
 
 __printf(2, 3)
diff --git a/include/linux/poison.h b/include/linux/poison.h
index dc8ae5d..50811c74 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -82,4 +82,8 @@
 /********** security/ **********/
 #define KEY_DESTROY		0xbd
 
+/********** kernel/kthread **********/
+/*indicate a static kthread_work initializer for the object debugging code.*/
+#define KWORK_ENTRY_STATIC	((void *) 0x600 + POISON_POINTER_DELTA)
+
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa38..426b80f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -68,6 +68,119 @@ enum KTHREAD_BITS {
 	KTHREAD_SHOULD_PARK,
 };
 
+#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
+static struct debug_obj_descr kwork_debug_descr;
+
+static void *kwork_debug_hint(void *addr)
+{
+	return ((struct kthread_work *) addr)->func;
+}
+
+static bool kwork_is_static_object(void *addr)
+{
+	struct kthread_work *kwork = addr;
+
+	return (kwork->node.prev == NULL &&
+		kwork->node.next == KWORK_ENTRY_STATIC);
+}
+
+static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+
+	switch (state) {
+	case ODEBUG_STATE_ACTIVE:
+		kthread_cancel_work_sync(kwork);
+		debug_object_init(kwork, &kwork_debug_descr);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool kwork_fixup_free(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+
+	switch (state) {
+	case ODEBUG_STATE_ACTIVE:
+		kthread_cancel_work_sync(kwork);
+		debug_object_free(kwork, &kwork_debug_descr);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void stub_kthread_work(struct kthread_work *unuse)
+{
+	WARN_ON(1);
+}
+
+static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state state)
+{
+	struct kthread_work *kwork = addr;
+
+	switch (state) {
+	case ODEBUG_STATE_NOTAVAILABLE:
+		kthread_init_work(kwork, stub_kthread_work);
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct debug_obj_descr kwork_debug_descr = {
+	.name			= "kthread_work",
+	.debug_hint		= kwork_debug_hint,
+	.is_static_object	= kwork_is_static_object,
+	.fixup_init		= kwork_fixup_init,
+	.fixup_free		= kwork_fixup_free,
+	.fixup_assert_init	= kwork_fixup_assert_init,
+};
+
+static inline void debug_kwork_activate(struct kthread_work *kwork)
+{
+	debug_object_activate(kwork, &kwork_debug_descr);
+}
+
+static inline void debug_kwork_deactivate(struct kthread_work *kwork)
+{
+	debug_object_deactivate(kwork, &kwork_debug_descr);
+}
+
+static inline void debug_kwork_assert_init(struct kthread_work *kwork)
+{
+	debug_object_assert_init(kwork, &kwork_debug_descr);
+}
+
+void __init_kwork(struct kthread_work *kwork, int onstack)
+{
+	if (onstack)
+		debug_object_init_on_stack(kwork, &kwork_debug_descr);
+	else
+		debug_object_init(kwork, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(__init_kwork);
+
+void destroy_kwork_on_stack(struct kthread_work *kwork)
+{
+	debug_object_free(kwork, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(destroy_kwork_on_stack);
+
+void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork)
+{
+	destroy_timer_on_stack(&kdwork->timer);
+	debug_object_free(&kdwork->work, &kwork_debug_descr);
+}
+EXPORT_SYMBOL_GPL(destroy_delayed_kwork_on_stack);
+#else
+static inline void debug_kwork_activate(struct kthread_work *kwork) { }
+static inline void debug_kwork_deactivate(struct kthread_work *kwork) { }
+static inline void debug_kwork_assert_init(struct kthread_work *kwork) { }
+#endif
+
 static inline void set_kthread_struct(void *kthread)
 {
 	/*
@@ -698,6 +811,7 @@ int kthread_worker_fn(void *worker_ptr)
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
@@ -834,6 +948,7 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
@@ -858,6 +973,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
@@ -896,6 +1012,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
+	debug_kwork_deactivate(work);
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
@@ -926,6 +1043,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	/* Be paranoid and try to detect possible races already now. */
 	kthread_insert_work_sanity_check(worker, work);
 
+	debug_kwork_activate(work);
 	list_add(&work->node, &worker->delayed_work_list);
 	work->worker = worker;
 	timer->expires = jiffies + delay;
@@ -955,6 +1073,7 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
@@ -987,17 +1106,17 @@ static void kthread_flush_work_fn(struct kthread_work *work)
  */
 void kthread_flush_work(struct kthread_work *work)
 {
-	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
-	};
+	struct kthread_flush_work fwork;
 	struct kthread_worker *worker;
 	bool noop = false;
 
+	debug_kwork_assert_init(work);
 	worker = work->worker;
 	if (!worker)
 		return;
 
+	fwork.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done);
+	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
 	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
@@ -1014,6 +1133,7 @@ void kthread_flush_work(struct kthread_work *work)
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
 
@@ -1054,6 +1174,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 	 * be from worker->work_list or from worker->delayed_work_list.
 	 */
 	if (!list_empty(&work->node)) {
+		debug_kwork_deactivate(work);
 		list_del_init(&work->node);
 		return true;
 	}
@@ -1092,6 +1213,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
@@ -1116,10 +1238,12 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 
 static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 {
-	struct kthread_worker *worker = work->worker;
+	struct kthread_worker *worker;
 	unsigned long flags;
 	int ret = false;
 
+	debug_kwork_assert_init(work);
+	worker = work->worker;
 	if (!worker)
 		goto out;
 
@@ -1194,13 +1318,13 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *dwork)
  */
 void kthread_flush_worker(struct kthread_worker *worker)
 {
-	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
-	};
+	struct kthread_flush_work fwork;
 
+	fwork.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done);
+	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
 	kthread_queue_work(worker, &fwork.work);
 	wait_for_completion(&fwork.done);
+	destroy_kwork_on_stack(&fwork.work);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_worker);
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0c781f9..81e0322 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -583,6 +583,16 @@ config DEBUG_OBJECTS_WORK
 	  work queue routines to track the life time of work objects and
 	  validate the work operations.
 
+config DEBUG_OBJECTS_KTHREAD_WORK
+	bool "Debug kthread work objects"
+	depends on DEBUG_OBJECTS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  kthread routines to track the life time of kthread_work objects
+	  and validate the kthread_work operations.
+
+	  If unsure, say N.
+
 config DEBUG_OBJECTS_RCU_HEAD
 	bool "Debug RCU callbacks objects"
 	depends on DEBUG_OBJECTS
-- 
1.9.1

