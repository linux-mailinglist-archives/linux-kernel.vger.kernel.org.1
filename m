Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30C32AD573
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgKJLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:39:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgKJLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:39:02 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKjEOEwu+WoojU3QuhjqfgE/KsmyANj68Ljnz4hnlYA=;
        b=P0bW5CTKDetrZt9TXP2gB+3wHgqg/LGdD+zJJnP0Qqgsztnrz6egrN7IESMUyghdnSQ7qS
        LSGHZpDgEPrWb/LmI/7XX2iTtcu5VVcDKGmO+tbt5Uju5QHxFCib/111tJcjI9agWEolOD
        Xps1CeHC4C8bWFjrjSuSa8BLxaMqQWETtskNaqGCYAIoa9PHi3vKsKw47sz/52jlvVACzl
        V2rLOM78iRWMcu9vdP/fobzSEDMOZy/vZ105oC5hO9qGzYIVWG5VXiVEgqjK8vxmvtOmoG
        KGWqCaLkR66alecGs9yfVb3LBrQerr6bthpw9aiRrLvRHq1YCneT2eXtwIM2Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKjEOEwu+WoojU3QuhjqfgE/KsmyANj68Ljnz4hnlYA=;
        b=DxubOoMvgf9vDlBYhz9lQp1NvZjxpEUruZ077jIsg7oWW4AqJxGuOWm0LH2kcHZjF/N1aa
        ZhYT3kyOadYqGuBw==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] kthread: Move prio/affinite change into the newly created thread
Date:   Tue, 10 Nov 2020 12:38:47 +0100
Message-Id: <20201110113848.801379-2-bigeasy@linutronix.de>
In-Reply-To: <20201110113848.801379-1-bigeasy@linutronix.de>
References: <20201110113848.801379-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With enabled threaded interrupts the nouveau driver reported the
following:
| Chain exists of:
|   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
|
|  Possible unsafe locking scenario:
|
|        CPU0                    CPU1
|        ----                    ----
|   lock(&cpuset_rwsem);
|                                lock(&device->mutex);
|                                lock(&cpuset_rwsem);
|   lock(&mm->mmap_lock#2);

The device->mutex is nvkm_device::mutex.

Unblocking the lockchain at `cpuset_rwsem' is probably the easiest thing
to do.
Move the priority reset to the start of the newly created thread.

Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset an=
d __sched_setscheduler()")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.ca=
mel@gmx.de
---
 kernel/kthread.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 933a625621b8d..4a31127c6efbf 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -243,6 +243,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
=20
 static int kthread(void *_create)
 {
+	static const struct sched_param param =3D { .sched_priority =3D 0 };
 	/* Copy data: it's on kthread's stack */
 	struct kthread_create_info *create =3D _create;
 	int (*threadfn)(void *data) =3D create->threadfn;
@@ -273,6 +274,13 @@ static int kthread(void *_create)
 	init_completion(&self->parked);
 	current->vfork_done =3D &self->exited;
=20
+	/*
+	 * The new thread inherited kthreadd's priority and CPU mask. Reset
+	 * back to default in case they have been changed.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result =3D current;
@@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*thre=
adfn)(void *data),
 	}
 	task =3D create->result;
 	if (!IS_ERR(task)) {
-		static const struct sched_param param =3D { .sched_priority =3D 0 };
 		char name[TASK_COMM_LEN];
=20
 		/*
@@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*thr=
eadfn)(void *data),
 		 */
 		vsnprintf(name, sizeof(name), namefmt, args);
 		set_task_comm(task, name);
-		/*
-		 * root may have changed our (kthreadd's) priority or CPU mask.
-		 * The kernel thread should not inherit these properties.
-		 */
-		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
--=20
2.29.2

