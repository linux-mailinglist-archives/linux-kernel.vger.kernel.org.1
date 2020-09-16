Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D726CAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIPULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgIPRdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:33:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D355C0073E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:58:23 -0700 (PDT)
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1kIXwv-0004I7-Ps; Wed, 16 Sep 2020 15:58:17 +0200
Date:   Wed, 16 Sep 2020 15:58:17 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20200916135817.3djsqmziqvzo6hmq@flow>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.528661716@infradead.org>
 <20200916101845.5ikjhfk27bgvs3pe@flow>
 <20200916121020.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916121020.GP2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 14:10:20 [+0200], peterz@infradead.org wrote:

squeeze that in please:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a4fe22b8b8418..bed3cd28af578 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6866,7 +6866,7 @@ static int __balance_push_cpu_stop(void *arg)
 	raw_spin_lock_irq(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	update_rq_clock();
+	update_rq_clock(rq);
 
 	if (task_rq(p) == rq && task_on_rq_queued(p)) {
 		cpu = select_fallback_rq(rq->cpu, p);


and count me in :)

Sebastian
