Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8C290828
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409956AbgJPPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409901AbgJPPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:16:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F24C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:16:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b6so1236113pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+gBbJKM527S8wrEw363kKHypxaaVMWtdRemMBbx8kok=;
        b=lICo4UBHGmwCB8HeHziISCpIAjsyMrUp3h20nEHfTwKV+byfAJWh7IqAEjbngYJWqc
         xlqZqgdWw3aGYaFdqqvt44GJNkgA2t8ZH/jb1OzqM3d0cY0tMD9H9RWcmB+tHLv4WkAm
         5bCNBNLOUH5T8niOCYba55RCCZafCaOgttMJ6JeZGTMA9voZi7TITwzbWTVQD/hDqf2y
         M7LPGpcd/MPTangKf6FXDMpQIWxkBLSZSEKE2afImMkK04xwkO+2OEegoL1irwKU9PIM
         uXfr9n/E5bTgaOmt+OBleMj8Ydq/64RH/SsDZdlLPzt9LXxxZmmWzkuvNKtfJiney9/V
         mspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+gBbJKM527S8wrEw363kKHypxaaVMWtdRemMBbx8kok=;
        b=CFVyfpPhJ+k3+yCe9grleIR/0YzRgh60rGvDcxqbxUSuqxrdGANxWTT4YrybfuNhr8
         k3VmTHre5zXWQJXHQluijaUxwwsL9e5c5yubGaYlFSTfsnkH0gBPeJkjsnVm7fpJBt09
         B+8ZCPygYJREb/1SnWk2ibq89ISCxZ8OBFcJFrygRnh3vWyrtVD8KTiMneiaXql5RlO4
         yJqIJFnr/C+d8Cnh1VO8spUSEiWebeSGGVvxXDKXUv3WbdOpWttoJKT9jvGr16EkpLkc
         klBoTvC1x4SEF9ZSqQazHDthAX9cO4nhdpuAl1qHbjTsczp8iTlXIJUr4ywwn3lO+fzf
         wu0g==
X-Gm-Message-State: AOAM5308qLCmtmvku2wdZAcuu92hvUjOHEpJl7KDgd9N/u1H4+oxbFaA
        dH137Krn/2yxvAAoYqPU9K4eaBu8SZKLisJL
X-Google-Smtp-Source: ABdhPJy6chhmLFUq0EQasOHn3OGK8Bm7qii7qIrMkfILamn5LQ3v2fX14resYtZF+l8FFdneY24V0g==
X-Received: by 2002:a17:902:860b:b029:d3:c430:7eb9 with SMTP id f11-20020a170902860bb02900d3c4307eb9mr4452275plo.9.1602861383984;
        Fri, 16 Oct 2020 08:16:23 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i30sm3349154pgb.81.2020.10.16.08.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:16:22 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: cleanup notification modes
Message-ID: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
Date:   Fri, 16 Oct 2020 09:16:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit changed the notification mode from 0/1 to allowing
0/1/TWA_SIGNAL. Clean this up properly, and define a proper enum for
the notification mode. Now we have:

- TWA_NONE. This is 0, same as before the original change, meaning no
  notification requested.
- TWA_RESUME. This is 1, same as before the original change, meaning
  that we use TIF_NOTIFY_RESUME.
- TWA_SIGNAL. This uses TIF_SIGPENDING/JOBCTL_TASK_WORK for the
  notification.

Clean up all the callers, switching their 0/1/false/true to using the
appropriate TWA_* mode for notifications.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

As promised, here's the task_work notification cleanup patch.

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1c08cb9eb9f6..4102b866e7c0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1277,7 +1277,7 @@ static void queue_task_work(struct mce *m, int kill_it)
 	else
 		current->mce_kill_me.func = kill_me_maybe;
 
-	task_work_add(current, &current->mce_kill_me, true);
+	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b494187632b2..af323e2e3100 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -561,7 +561,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * callback has been invoked.
 	 */
 	atomic_inc(&rdtgrp->waitcount);
-	ret = task_work_add(tsk, &callback->work, true);
+	ret = task_work_add(tsk, &callback->work, TWA_RESUME);
 	if (ret) {
 		/*
 		 * Task is exiting. Drop the refcount and free the callback.
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..8360f8d6be65 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -879,7 +879,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 			estatus_node->task_work.func = ghes_kick_task_work;
 			estatus_node->task_work_cpu = smp_processor_id();
 			ret = task_work_add(current, &estatus_node->task_work,
-					    true);
+					    TWA_RESUME);
 			if (ret)
 				estatus_node->task_work.func = NULL;
 		}
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4b9476521da6..b5117576792b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2229,7 +2229,7 @@ static void binder_deferred_fd_close(int fd)
 	__close_fd_get_file(fd, &twcb->file);
 	if (twcb->file) {
 		filp_close(twcb->file, current->files);
-		task_work_add(current, &twcb->twork, true);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
 	} else {
 		kfree(twcb);
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..709ada3151da 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -339,7 +339,7 @@ void fput_many(struct file *file, unsigned int refs)
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_u.fu_rcuhead, true))
+			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
 				return;
 			/*
 			 * After this task has run exit_task_work(),
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2e1dc354cd08..16e1d0e0d9b9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1756,7 +1756,7 @@ static void __io_free_req(struct io_kiocb *req)
 			struct task_struct *tsk;
 
 			tsk = io_wq_get_task(req->ctx->io_wq);
-			task_work_add(tsk, &req->task_work, 0);
+			task_work_add(tsk, &req->task_work, TWA_NONE);
 		}
 	}
 }
@@ -1905,7 +1905,8 @@ static int io_req_task_work_add(struct io_kiocb *req, bool twa_signal_ok)
 {
 	struct task_struct *tsk = req->task;
 	struct io_ring_ctx *ctx = req->ctx;
-	int ret, notify;
+	enum task_work_notify_mode notify;
+	int ret;
 
 	if (tsk->flags & PF_EXITING)
 		return -ESRCH;
@@ -1916,7 +1917,7 @@ static int io_req_task_work_add(struct io_kiocb *req, bool twa_signal_ok)
 	 * processing task_work. There's no reliable way to tell if TWA_RESUME
 	 * will do the job.
 	 */
-	notify = 0;
+	notify = TWA_NONE;
 	if (!(ctx->flags & IORING_SETUP_SQPOLL) && twa_signal_ok)
 		notify = TWA_SIGNAL;
 
@@ -1985,7 +1986,7 @@ static void io_req_task_queue(struct io_kiocb *req)
 
 		init_task_work(&req->task_work, io_req_task_cancel);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, 0);
+		task_work_add(tsk, &req->task_work, TWA_NONE);
 		wake_up_process(tsk);
 	}
 }
@@ -3199,7 +3200,7 @@ static int io_async_buf_func(struct wait_queue_entry *wait, unsigned mode,
 		/* queue just for cancelation */
 		init_task_work(&req->task_work, io_req_task_cancel);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, 0);
+		task_work_add(tsk, &req->task_work, TWA_NONE);
 		wake_up_process(tsk);
 	}
 	return 1;
@@ -4765,7 +4766,7 @@ static int __io_async_wake(struct io_kiocb *req, struct io_poll_iocb *poll,
 
 		WRITE_ONCE(poll->canceled, true);
 		tsk = io_wq_get_task(req->ctx->io_wq);
-		task_work_add(tsk, &req->task_work, 0);
+		task_work_add(tsk, &req->task_work, TWA_NONE);
 		wake_up_process(tsk);
 	}
 	return 1;
diff --git a/fs/namespace.c b/fs/namespace.c
index 294e05a13d17..1a75336668a3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1191,7 +1191,7 @@ static void mntput_no_expire(struct mount *mnt)
 		struct task_struct *task = current;
 		if (likely(!(task->flags & PF_KTHREAD))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
-			if (!task_work_add(task, &mnt->mnt_rcu, true))
+			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
 				return;
 		}
 		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 0fb93aafa478..0d848a1e9e62 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -13,9 +13,14 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
 	twork->func = func;
 }
 
-#define TWA_RESUME	1
-#define TWA_SIGNAL	2
-int task_work_add(struct task_struct *task, struct callback_head *twork, int);
+enum task_work_notify_mode {
+	TWA_NONE,
+	TWA_RESUME,
+	TWA_SIGNAL,
+};
+
+int task_work_add(struct task_struct *task, struct callback_head *twork,
+			enum task_work_notify_mode mode);
 
 struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
 void task_work_run(void);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0e18aaf23a7b..00b0358739ab 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1823,7 +1823,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
 
 	t->utask->dup_xol_addr = area->vaddr;
 	init_task_work(&t->utask->dup_xol_work, dup_xol_work);
-	task_work_add(t, &t->utask->dup_xol_work, true);
+	task_work_add(t, &t->utask->dup_xol_work, TWA_RESUME);
 }
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5df903fccb60..c460e0496006 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1162,7 +1162,7 @@ static int irq_thread(void *data)
 		handler_fn = irq_thread_fn;
 
 	init_task_work(&on_exit_work, irq_thread_dtor);
-	task_work_add(current, &on_exit_work, false);
+	task_work_add(current, &on_exit_work, TWA_NONE);
 
 	irq_thread_check_affinity(desc, action);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..e17012be4d14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2928,7 +2928,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 		curr->node_stamp += period;
 
 		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, true);
+			task_work_add(curr, work, TWA_RESUME);
 	}
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 613b2d634af8..6aad749485de 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,7 +9,7 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
  * @work: the callback to run
- * @notify: send the notification if true
+ * @notify: send chosen notification, if any
  *
  * Queue @work for task_work_run() below and notify the @task if @notify.
  * Fails if the @task is exiting/exited and thus it can't process this @work.
@@ -24,8 +24,8 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * RETURNS:
  * 0 if succeeds or -ESRCH.
  */
-int
-task_work_add(struct task_struct *task, struct callback_head *work, int notify)
+int task_work_add(struct task_struct *task, struct callback_head *work,
+		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
 	unsigned long flags;
@@ -38,6 +38,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
 	} while (cmpxchg(&task->task_works, head, work) != head);
 
 	switch (notify) {
+	case TWA_NONE:
+		break;
 	case TWA_RESUME:
 		set_notify_resume(task);
 		break;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index e26bbccda7cc..61a614c21b9b 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-	ret = task_work_add(parent, newwork, true);
+	ret = task_work_add(parent, newwork, TWA_RESUME);
 	if (!ret)
 		newwork = NULL;
 unlock:
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 536c99646f6a..06e226166aab 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -99,7 +99,7 @@ static void report_access(const char *access, struct task_struct *target,
 	info->access = access;
 	info->target = target;
 	info->agent = agent;
-	if (task_work_add(current, &info->work, true) == 0)
+	if (task_work_add(current, &info->work, TWA_RESUME) == 0)
 		return; /* success */
 
 	WARN(1, "report_access called from exiting task");

-- 
Jens Axboe

