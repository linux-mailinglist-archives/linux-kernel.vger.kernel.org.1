Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C798C287C59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgJHTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgJHTSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602184703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=t5io78VrWcj/RZGU5mCe/tElO8y5LtF+lfMiccVzxSc=;
        b=G0SFlleO9hPHTM76fRgQ62IlyXoLsxTaIkqR3T6NZOmATSsD9iDqxguan0ZD7my2flSwAN
        kbaep2E8hA91JRpSfcUDS0eNSxuVIHzZIDeB1PvXODV6b69Masem8I0cpVrlH21ZNHFRm0
        C2iwCT2ttK/LTmoWNfEwUAxM4FmKMU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284--77Cd_1OPYC-uvnwtIkbEQ-1; Thu, 08 Oct 2020 15:18:21 -0400
X-MC-Unique: -77Cd_1OPYC-uvnwtIkbEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 923AA6408B;
        Thu,  8 Oct 2020 19:18:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4413F60BFA;
        Thu,  8 Oct 2020 19:18:09 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 6A9294168BA5; Thu,  8 Oct 2020 16:17:42 -0300 (-03)
Message-ID: <20201008191446.007280351@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Oct 2020 16:11:30 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] nohz: only wakeup a single target cpu when kicking a task
References: <20201008191129.152030255@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 


