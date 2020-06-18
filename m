Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8011FFC87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgFRUaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgFRUaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71541C061794
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g18so5519762qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaeMJsa0JwOrR7DOfXytCHbkhyKFtstaDW7tXo9dlM4=;
        b=C06cv7c9MQkPf+VxKcFfjcjeaR0O5Wlx8sVFAd0hHi4xBVzw35a1xVtL59UK8qOStm
         U74AA7xF9ITHOJD0K9Q470heXGLcxUIwVwBOLtRW7JykuFbRREoMRDin/iC2qHpgHRNr
         VXFFEXxazBJSYCoA5sElydOkSIzuYYrYzlt7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaeMJsa0JwOrR7DOfXytCHbkhyKFtstaDW7tXo9dlM4=;
        b=Blj8dX1+b6BcWf2eoWPJSE8CWJt0tDP2HPkvDDuk/UKs/ocDVhoo/snR0Z+aMYcVZX
         u2bXhYpj7EsAfMZiuMAKPxdmyyYyPE8xeaH1rylA9i/pdBiSgcmUf8ZhqyjKYE4wBpGi
         t+U+p0xuyZEHxDt9pXQgRFXynMeQtl9lAObSLUNiWHlj2t+c/+dTqh3OzFw5SOb7v5e2
         rWVeDssxrSe++VyKTCggtN9WkPfd4r2kNrftpoMz33DY3IRXckONrg4yyF7uLsIcYUzo
         Re6Y/9F/BNE6YDbesTFIGcrRzUyFO/DBGv7Jyynw/BBws7sQqkI5UQKIjEgnKg7MPxhN
         DS+g==
X-Gm-Message-State: AOAM531MjYk94BqL5p6HN22w8i1F3jnFv/JY4WmGT8ZxF2X3RvZG5znC
        xdGUdTJXXGYNEfi06e1JhlHX3sQn0QM=
X-Google-Smtp-Source: ABdhPJxnnGBICThLdICzPHdg2dIQ662N/Eq2601OifGFAow6Sc+/0M1hvI0LEw8Gw/cdydyeu7V3Rw==
X-Received: by 2002:aed:30cf:: with SMTP id 73mr744qtf.81.1592512206612;
        Thu, 18 Jun 2020 13:30:06 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 3/7] rcu/trace: Add name of the source for gp_seq
Date:   Thu, 18 Jun 2020 16:29:51 -0400
Message-Id: <20200618202955.4024-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gp_seq value can come from either of rdp, rsp or rnp.

Only the rsp is the global source of truth (most accurate GP info). The
rnp can be off by ~1 and the rdp can be off by way more. Add some more
context to traces to clarify where it comes from.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 12 ++++++++----
 kernel/rcu/tree.c          | 32 ++++++++++++++++----------------
 kernel/rcu/tree_plugin.h   |  2 +-
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index a6d49864dcc27..cb5363564f7ed 100644
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
 		__field(unsigned long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
+		__entry->gp_seq_src = gp_seq_src;
 		__entry->gp_seq = gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
+	TP_printk("%s %s_gp_seq=%lu %s",
+		  __entry->rcuname, __entry->gp_seq_src,
+		  __entry->gp_seq, __entry->gpevent)
 );
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c61af6a33fbfd..81df1b837dd9d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1334,7 +1334,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, "rsp", data_race(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1437,9 +1437,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccReadyCB"));
 
 	/* Count CBs for tracing. */
 	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
@@ -1543,7 +1543,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
 		rdp->core_needs_qs = false;
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
+		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("cpuend"));
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
@@ -1559,7 +1559,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
+		trace_rcu_grace_period(rcu_state.name, "rnp", rnp->gp_seq, TPS("cpustart"));
 		need_qs = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_qs;
 		rdp->core_needs_qs = need_qs;
@@ -1660,7 +1660,7 @@ static bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
+	trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -1828,7 +1828,7 @@ static void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
-		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 				       TPS("fqswait"));
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
@@ -1843,7 +1843,7 @@ static void rcu_gp_fqs_loop(void)
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
 		    (gf & RCU_GP_FLAG_FQS)) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
 			gf = 0;
@@ -1851,7 +1851,7 @@ static void rcu_gp_fqs_loop(void)
 				first_gp_fqs = false;
 				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
 			}
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -1862,7 +1862,7 @@ static void rcu_gp_fqs_loop(void)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 					       TPS("fqswaitsig"));
 			ret = 1; /* Keep old FQS timing. */
 			j = jiffies;
@@ -1945,7 +1945,7 @@ static void rcu_gp_cleanup(void)
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
 
 	/* Declare grace period done, trace first to use old GP number. */
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
+	trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	rcu_state.gp_state = RCU_GP_IDLE;
@@ -1962,7 +1962,7 @@ static void rcu_gp_cleanup(void)
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-		trace_rcu_grace_period(rcu_state.name,
+		trace_rcu_grace_period(rcu_state.name, "rsp",
 				       rcu_state.gp_seq,
 				       TPS("newreq"));
 	} else {
@@ -1982,7 +1982,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 					       TPS("reqwait"));
 			rcu_state.gp_state = RCU_GP_WAIT_GPS;
 			swait_event_idle_exclusive(rcu_state.gp_wq,
@@ -1996,7 +1996,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
+			trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq,
 					       TPS("reqwaitsig"));
 		}
 
@@ -2240,7 +2240,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 		return 0;
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+	trace_rcu_grace_period(rcu_state.name, "rsp", READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 	return 0;
 }
@@ -3733,7 +3733,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
-	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
+	trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_cpu_nocb_kthread(cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5be52698..32f761cf16c33 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -262,7 +262,7 @@ static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
 	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
-		trace_rcu_grace_period(TPS("rcu_preempt"),
+		trace_rcu_grace_period(TPS("rcu_preempt"), "rdp",
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-- 
2.27.0.111.gc72c7da667-goog

