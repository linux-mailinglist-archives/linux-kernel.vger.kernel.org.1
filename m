Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD15296CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462103AbgJWKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376059AbgJWKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A34C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IjuE47JNwAqdmeGJ9n7G5r/lEe4gPS0RRx14k6uLMxI=; b=OazU7Kv7V9q641Stt2zFCBa7HH
        1t4LEI7VtN1yLi+3o0UORl84zLx/whBH1eGbxaQAMnh9v8548fpDMug3EbwV2cqXAQPQE0KppRKAf
        toLKGbNVde4QIadmrSBsFWjfy83Z0cRM5JTUSZsvScfOsRV3ynWRDS+IjnJUurlItKYpa5tJE1pnj
        /joA4xW1klU3/zj+WDnfk+lq8OXo7ICTNYqaJyXBmJ+eCXS3Vu2GWsiufW1DeEqJOKMms/ZgCs7ce
        jRLilE4oZtxVpjFasYsWixcdEzQwgG5cL8o0oWv8YoW3HoBK0/TVpNbXAO4hoaJwlqngnhZOO17XV
        4ayC6W8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFp-0003BR-Uv; Fri, 23 Oct 2020 10:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1B2930797C;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7E5DF29DDA668; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102347.697960969@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 17/19] sched: Add migrate_disable() tracepoints
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XXX write a tracer:

 - 'migirate_disable() -> migrate_enable()' time in task_sched_runtime()
 - 'migrate_pull -> sched-in' time in task_sched_runtime()

The first will give worst case for the second, which is the actual
interference experienced by the task to due migration constraints of
migrate_disable().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/trace/events/sched.h |   12 ++++++++++++
 kernel/sched/core.c          |    4 ++++
 kernel/sched/deadline.c      |    1 +
 kernel/sched/rt.c            |    8 +++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -646,6 +646,18 @@ DECLARE_TRACE(sched_update_nr_running_tp
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_migrate_disable_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
+DECLARE_TRACE(sched_migrate_enable_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
+DECLARE_TRACE(sched_migrate_pull_tp,
+	      TP_PROTO(struct task_struct *p),
+	      TP_ARGS(p));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1732,6 +1732,8 @@ void migrate_disable(void)
 		return;
 	}
 
+	trace_sched_migrate_disable_tp(p);
+
 	preempt_disable();
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
@@ -1764,6 +1766,8 @@ void migrate_enable(void)
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
 	preempt_enable();
+
+	trace_sched_migrate_enable_tp(p);
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2245,6 +2245,7 @@ static void pull_dl_task(struct rq *this
 				goto skip;
 
 			if (is_migration_disabled(p)) {
+				trace_sched_migrate_pull_tp(p);
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1877,7 +1877,12 @@ static int push_rt_task(struct rq *rq, b
 		struct task_struct *push_task = NULL;
 		int cpu;
 
-		if (!pull || rq->push_busy)
+		if (!pull)
+			return 0;
+
+		trace_sched_migrate_pull_tp(next_task);
+
+		if (rq->push_busy)
 			return 0;
 
 		cpu = find_lowest_rq(rq->curr);
@@ -2223,6 +2228,7 @@ static void pull_rt_task(struct rq *this
 				goto skip;
 
 			if (is_migration_disabled(p)) {
+				trace_sched_migrate_pull_tp(p);
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);


