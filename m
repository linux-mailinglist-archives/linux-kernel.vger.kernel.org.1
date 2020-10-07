Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2928667C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgJGSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728482AbgJGSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t5io78VrWcj/RZGU5mCe/tElO8y5LtF+lfMiccVzxSc=;
        b=AhrIyyYwrgxyBZ/A5J/w+05mi0R4YNoLYuNXRw2I3W7AQiku4EN79ddEL/XjMEIiYbmCde
        ag9aQRC0pfjLGV/MQHNuihWFpNunlOGj+gV7D2BseYCmeL9AXNntaGLMOzlazXtcATRVRn
        cxpJBbq4t1J/vd2LubkPNBfybhlfRT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-3vkYwmyKOvqZie3-SASaXg-1; Wed, 07 Oct 2020 14:05:16 -0400
X-MC-Unique: 3vkYwmyKOvqZie3-SASaXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 170CB18C89F8;
        Wed,  7 Oct 2020 18:05:07 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 759EB7882A;
        Wed,  7 Oct 2020 18:04:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 691E2417D682; Wed,  7 Oct 2020 15:04:33 -0300 (-03)
Message-ID: <20201007180229.724302019@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 07 Oct 2020 15:01:52 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] nohz: only wakeup a single target cpu when kicking a task
References: <20201007180151.623061463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a tick dependency to a task, its necessary to
wakeup the CPU where the task resides to reevaluate tick
dependencies on that CPU.

However the current code wakes up all nohz_full CPUs, which 
is unnecessary.

Switch to waking up a single CPU, by using ordering of writes
to task->cpu and task->tick_dep_mask.

From: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -274,6 +274,31 @@ void tick_nohz_full_kick_cpu(int cpu)
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 
+static void tick_nohz_kick_task(struct task_struct *tsk)
+{
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task concurrently migrates to another cpu,
+	 * we guarantee it sees the new tick dependency upon
+	 * schedule.
+	 *
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
+	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
+	 *      LOAD p->tick_dep_mask           LOAD p->cpu
+	 */
+
+	preempt_disable();
+	if (cpu_online(cpu))
+		tick_nohz_full_kick_cpu(cpu);
+	preempt_enable();
+}
+
 /*
  * Kick all full dynticks CPUs in order to force these to re-evaluate
  * their dependency on the tick and restart it if necessary.
@@ -356,19 +381,8 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cp
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
-		if (tsk == current) {
-			preempt_disable();
-			tick_nohz_full_kick();
-			preempt_enable();
-		} else {
-			/*
-			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
-			 */
-			tick_nohz_full_kick_all();
-		}
-	}
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask))
+		tick_nohz_kick_task(tsk);
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 


