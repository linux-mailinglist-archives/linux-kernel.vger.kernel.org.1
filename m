Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64711FFFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 03:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgFSBgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbgFSBgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:36:51 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651DC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:50 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fc4so3769803qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70j3HsCROyS6XqH24ZitawzOe8eA36DvHkQWKxYjcxs=;
        b=wNpITdmaRWLaT1LSJIM6tpVepqUx0AJQNJ+BdcyubRb2S22I+wxfHnBav+OuUeTpSY
         2yfLr19JgWk86zD6AxQcKA/yijnAt/569OUX56IKoiT39Gh/9M94wLxaXIaUFwhfolrf
         wuQyBWOAG4aqq3eFQnpfiVHfTVuY2AflKKmg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70j3HsCROyS6XqH24ZitawzOe8eA36DvHkQWKxYjcxs=;
        b=uP+dGchimvnbsmRl4U4QlOMdJ8dAd+JJqvPmLPf7RgvP92pbIilzrDyacDCqQDzuW+
         dIz6//uh7JNuVd4xA7QVew3GbhjX9a/Hl9v0wlNmPejzQyYkN8uxvmEsx/ZEI9968MCv
         583ammj8ys+IcKn+wcQzopNk7l1t5F1be4bBf1ZD6QNVN0q3zGaLmjM0voiI4U0piVfi
         bz/Yy0Ve2Fe/It+p6Qw5jlksfxDh1av+wurkRPyoiIeBmukZWyHHLyBPSR96cP4yYnvp
         ZjgluY2iQXWc84Cd2Wn44Ea93TkjpF8byHjKHGDTJUVP15SFSkJLfdCFTe4N5oFb0o9l
         LFAg==
X-Gm-Message-State: AOAM533GAse2rHVz/2Mn1ARQqPZ9q/rTR1PdCafFuLZHR8YTmS92QK3F
        Pnmt18eJfcWNIHK6vkCgbTWWLok0QGQ=
X-Google-Smtp-Source: ABdhPJxTIFVx77kqFBEn5R3G3NqGVLhnn0bOXBHCstM+RRGY0r8MutWbr7cmc2IvNn/NhVDlbrpbkA==
X-Received: by 2002:ad4:556b:: with SMTP id w11mr6377038qvy.171.1592530609498;
        Thu, 18 Jun 2020 18:36:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s15sm5379570qtc.95.2020.06.18.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:36:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 3/3] rcu/trace: Add name of the source for gp_seq to prevent confusion
Date:   Thu, 18 Jun 2020 21:36:41 -0400
Message-Id: <20200619013641.63453-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200619013641.63453-1-joel@joelfernandes.org>
References: <20200619013641.63453-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gp_seq value can come from either of rdp, rsp or rnp. This makes the
rcu_grace_period tracepoint extremely confusing since once if left
constantly applying effort to reason about what a gp_seq means.

Only the rsp is the global source of truth (most accurate GP info). The
rnp can be off by ~1 and the rdp can be off by way more. Add some more
context to traces to clarify where it comes from.

While this can be resolved using some trace post-processing, such post-
processing does need extra maintenance of scripts. Just make it easy by
adding more context in the trace itself.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 12 ++++++++----
 kernel/rcu/tree.c          | 32 ++++++++++++++++----------------
 kernel/rcu/tree_plugin.h   |  4 ++--
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd3..bf2d9f2e25f85 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -68,24 +68,28 @@ TRACE_EVENT(rcu_utilization,
  */
 TRACE_EVENT_RCU(rcu_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gp_seq, const char *gpevent),
+	TP_PROTO(const char *rcuname, const char *gp_seq_src,
+		unsigned long gp_seq, const char *gpevent),
 
-	TP_ARGS(rcuname, gp_seq, gpevent),
+	TP_ARGS(rcuname, gp_seq_src, gp_seq, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
+		__field(const char *, gp_seq_src)
 		__field(long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
+		__entry->gp_seq_src = gp_seq_src;
 		__entry->gp_seq = (long)gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %ld %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
+	TP_printk("%s %s_gp_seq=%ld %s",
+		  __entry->rcuname, __entry->gp_seq_src,
+		  __entry->gp_seq, __entry->gpevent)
 );
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d0988a1c1079d..b625811f529fa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1367,7 +1367,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), data_race(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1464,9 +1464,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, TPS("req"), gp_seq_req, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, TPS("req"), gp_seq_req, TPS("AccReadyCB"));
 
 	return ret;
 }
@@ -1566,7 +1566,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
+		trace_rcu_grace_period(rcu_state.name, TPS("rdp"), rdp->gp_seq, TPS("cpuend"));
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
@@ -1582,7 +1582,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
+		trace_rcu_grace_period(rcu_state.name, TPS("rnp"), rnp->gp_seq, TPS("cpustart"));
 		need_qs = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_qs;
 		rdp->core_needs_qs = need_qs;
@@ -1683,7 +1683,7 @@ static bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
+	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -1851,7 +1851,7 @@ static void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
-		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+		trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 				       TPS("fqswait"));
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
@@ -1866,7 +1866,7 @@ static void rcu_gp_fqs_loop(void)
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
 		    (gf & RCU_GP_FLAG_FQS)) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
 			gf = 0;
@@ -1874,7 +1874,7 @@ static void rcu_gp_fqs_loop(void)
 				first_gp_fqs = false;
 				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
 			}
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -1885,7 +1885,7 @@ static void rcu_gp_fqs_loop(void)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 					       TPS("fqswaitsig"));
 			ret = 1; /* Keep old FQS timing. */
 			j = jiffies;
@@ -1968,7 +1968,7 @@ static void rcu_gp_cleanup(void)
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
 
 	/* Declare grace period done, trace first to use old GP number. */
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
+	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	rcu_state.gp_state = RCU_GP_IDLE;
@@ -1985,7 +1985,7 @@ static void rcu_gp_cleanup(void)
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-		trace_rcu_grace_period(rcu_state.name,
+		trace_rcu_grace_period(rcu_state.name, TPS("rsp"),
 				       rcu_state.gp_seq,
 				       TPS("newreq"));
 	} else {
@@ -2005,7 +2005,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 					       TPS("reqwait"));
 			rcu_state.gp_state = RCU_GP_WAIT_GPS;
 			swait_event_idle_exclusive(rcu_state.gp_wq,
@@ -2019,7 +2019,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
 					       TPS("reqwaitsig"));
 		}
 
@@ -2263,7 +2263,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 		return 0;
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 	return 0;
 }
@@ -3875,7 +3875,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
-	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
+	trace_rcu_grace_period(rcu_state.name, TPS("rdp"), rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_cpu_nocb_kthread(cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5be52698..7df8cd968f7fd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -262,7 +262,7 @@ static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
 	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
-		trace_rcu_grace_period(TPS("rcu_preempt"),
+		trace_rcu_grace_period(TPS("rcu_preempt"), TPS("rdp"),
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
@@ -788,7 +788,7 @@ static void rcu_qs(void)
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!");
 	if (!__this_cpu_read(rcu_data.cpu_no_qs.s))
 		return;
-	trace_rcu_grace_period(TPS("rcu_sched"),
+	trace_rcu_grace_period(TPS("rcu_sched"), TPS("rdp"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
-- 
2.27.0.111.gc72c7da667-goog

