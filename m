Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90C026BDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgIPHHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgIPHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600240031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9lcStce28iJ3BFfx9sit/J8sWPEU7IP9Yla520UVtYc=;
        b=CbFjJcEAurnAT1rkvpMLfcjBHW0KzuZFgl8eMJyDOGNAEcHYZoR2jGlaTx4pKoYOGcDME8
        OiLIrFDj+bfWDu8ANzQeRacYHEd9B8CHwlcMqx6AXOtrgf/DeTGxEpRHq+YDpGuJh1F6Oh
        bq8AywobbcBJlVWeg17sAU5rzLkM1vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-LRJQr7ETPjGbwKt7aO2cGQ-1; Wed, 16 Sep 2020 03:07:09 -0400
X-MC-Unique: LRJQr7ETPjGbwKt7aO2cGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80B8107464B;
        Wed, 16 Sep 2020 07:07:07 +0000 (UTC)
Received: from x1.bristot.me.redhat.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9EFE1002D46;
        Wed, 16 Sep 2020 07:06:55 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mark Simmons <msimmons@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: Unthrottle PI boosted threads while enqueuing
Date:   Wed, 16 Sep 2020 09:06:39 +0200
Message-Id: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stress-ng has a test (stress-ng --cyclic) that creates a set of threads
under SCHED_DEADLINE with the following parameters:

    dl_runtime   =  10000 (10 us)
    dl_deadline  = 100000 (100 us)
    dl_period    = 100000 (100 us)

These parameters are very aggressive. When using a system without HRTICK
set, these threads can easily execute longer than the dl_runtime because
the throttling happens with 1/HZ resolution.

During the main part of the test, the system works just fine because
the workload does not try to run over the 10 us. The problem happens at
the end of the test, on the exit() path. During exit(), the threads need
to do some cleanups that require real-time mutex locks, mainly those
related to memory management, resulting in this scenario:

Note: locks are rt_mutexes...
 ------------------------------------------------------------------------
    TASK A:		TASK B:				TASK C:
    activation
							activation
			activation

    lock(a): OK!	lock(b): OK!
    			<overrun runtime>
    			lock(a)
    			-> block (task A owns it)
			  -> self notice/set throttled
 +--<			  -> arm replenished timer
 |    			switch-out
 |    							lock(b)
 |    							-> <C prio > B prio>
 |    							-> boost TASK B
 |  unlock(a)						switch-out
 |  -> handle lock a to B
 |    -> wakeup(B)
 |      -> B is throttled:
 |        -> do not enqueue
 |     switch-out
 |
 |
 +---------------------> replenishment timer
			-> TASK B is boosted:
			  -> do not enqueue
 ------------------------------------------------------------------------

BOOM: TASK B is runnable but !enqueued, holding TASK C: the system
crashes with hung task C.

This problem is avoided by removing the throttle state from the boosted
thread while boosting it (by TASK A in the example above), allowing it to
be queued and run boosted.

The next replenishment will take care of the runtime overrun, pushing
the deadline further away. See the "while (dl_se->runtime <= 0)" on
replenish_dl_entity() for more information.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reported-by: Mark Simmons <msimmons@redhat.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Mark Simmons <msimmons@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: linux-kernel@vger.kernel.org

---
 kernel/sched/deadline.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d..50ba5fca0403 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1525,6 +1525,27 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (pi_task && dl_prio(pi_task->normal_prio) && p->dl.dl_boosted) {
 		pi_se = &pi_task->dl;
+		/*
+		 * Because of delays in the detection of the overrun of a
+		 * thread's runtime, it might be the case that a thread
+		 * goes to sleep in a rt mutex with negative runtime. As
+		 * a consequence, the thread will be throttled.
+		 *
+		 * While waiting for the mutex, this thread can also be
+		 * boosted via PI, resulting in a thread that is throttled
+		 * and boosted at the same time.
+		 *
+		 * In this case, the boost overrides the throttle.
+		 */
+		if (p->dl.dl_throttled) {
+			/*
+			 * The replenish timer needs to be canceled. No
+			 * problem if it fires concurrently: boosted threads
+			 * are ignored in dl_task_timer().
+			 */
+			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			p->dl.dl_throttled = 0;
+		}
 	} else if (!dl_prio(p->normal_prio)) {
 		/*
 		 * Special case in which we have a !SCHED_DEADLINE task
-- 
2.26.2

