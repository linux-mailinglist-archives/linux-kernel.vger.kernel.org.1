Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C176283915
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJEPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJEPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ib/vSJZXe359LI8VEGBEO/Vt7X2CKf1PQh+C2xgwOek=; b=D1kHEnenXlQR/bUAlzRe9DtGu+
        teTTDWEoQpi1eBnPgWF00XvURxecroPyonTQzkkGyT6zabc8DYthVrxuaTWR6UEnFTHx69htYXMFj
        rhCW+0xMt7sXsV5l9u8ib6X7LwVlHb8WoyK1WgIl9yuYJrotdPs2/MCuIT5nrXnjhIQWSLFqVLCTE
        675WMls/t/4CeJfe9PE4X/TnOygMlLtPYHxXVXV+/tJAy2+35IFoo7lmAjS6aL8rxXrbgA87jN14B
        iQfVo6yqqS1IZTUzSYILJNRuBMaapxuio3LJMl7ofJD40yF8bZltwPpe2E7aHDStFcSavcTw8+3uy
        oVAVW9gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7W-0008PW-C5; Mon, 05 Oct 2020 15:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7165830769C;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EA60F29A897BD; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150922.156231026@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 12/17] sched,rt: Use cpumask_any*_distribute()
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a bunch of cpumask_any*() instances with
cpumask_any*_distribute(), by injecting this little bit of random in
cpu selection, we reduce the chance two competing balance operations
working off the same lowest_mask pick the same CPU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpumask.h |    6 ++++++
 kernel/sched/cpupri.c   |    4 ++--
 kernel/sched/deadline.c |    2 +-
 kernel/sched/rt.c       |    6 +++---
 lib/cpumask.c           |   18 ++++++++++++++++++
 5 files changed, 30 insertions(+), 6 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -199,6 +199,11 @@ static inline int cpumask_any_and_distri
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
+int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2001,7 +2001,7 @@ static int find_later_rq(struct task_str
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_st
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
@@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_st
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(lowest_mask);
+	cpu = cpumask_any_distribute(lowest_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const str
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
+
+int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_distribute);


