Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E703A2952B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504710AbgJUTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504692AbgJUTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v200so3695076qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKdEKcgAlSC3vGUomiNT2ehSr9OVUaWkg9AZwqWxc04=;
        b=NvbahGIgLuZfQC+1iIgBB4oPIfdTLLim6MpT8eZztBOtxnGcCLyCLoeuyfwSeLCb0f
         AEpHW0ZbzVyLMsiUD687vBmGen43nxLBZiJ/rXvMl9s2ow0zcuzVl+rl5spOmzf1uX4O
         f0d6WruN7TnOURFuwe/nKbbi2YCef422dw8gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKdEKcgAlSC3vGUomiNT2ehSr9OVUaWkg9AZwqWxc04=;
        b=TQLAqkGTCDOzXgs5p5XYzs/ALYZ7CWmin8jwLT7GDb08Hrlag2z9uEKqUYeo1nTPgZ
         WJDRX2G0r2its6buokHO+7z84e2jxzvlCH55oOgg04QuBYO1+Gw4JQmhgvMi7FcPa+eS
         XdotV+lqjvz/5BnqBECMl3wGC/K5HRNVqyz6CSEgdJOhaZvcsA98qRADyJDS6h0Ckdiz
         A/rLFfcLevq35LprB6l0nDYH3MAef3ZbVyDbE1px0iBmfA1xaSjFC95rHCwv6OUpUxew
         p9T7nmkpcK2IQ2qiyUA5AXsehCVXJtVRIc8qRGcwnZdHhpk1PNwMaUlJJjoe2UUnRdYA
         wy4w==
X-Gm-Message-State: AOAM530wggf7tLEQD2EMAvWgEIiSSO45EqTu7XMKJO25vGXlRq62AnVw
        yGmsbaEbCQdfHcIFewr1hmt5i+NukWQaIw==
X-Google-Smtp-Source: ABdhPJwoY8/oaE1bJADnDReXGEiiAD7vw0Hzjmi1gntf9Zn4IWlvRktc5XO4KkP93TxvHWj0LKFp4g==
X-Received: by 2002:a05:620a:10b7:: with SMTP id h23mr4438524qkk.132.1603307301432;
        Wed, 21 Oct 2020 12:08:21 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 3/6] rcu/trace: Add tracing for how segcb list changes
Date:   Wed, 21 Oct 2020 15:08:10 -0400
Message-Id: <20201021190813.3005054-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track how the segcb list changes before/after acceleration, during
queuing and during dequeuing.

This has proved useful to discover an optimization to avoid unwanted GP
requests when there are no callbacks accelerated. The overhead is minimal as
each segment's length is now stored in the respective segment.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.c | 31 +++++++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  5 +++++
 kernel/rcu/tree.c          |  9 +++++++++
 4 files changed, 70 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..9f2237d9b0c8 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb,
+
+		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
+
+		TP_ARGS(ctx, cb_count, gp_seq),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(int, cb_count, RCU_CBLIST_NSEGS)
+			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
+			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
+		),
+
+		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 357c19bbcb00..b0aaa51e0ee6 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include "rcu_segcblist.h"
+#include "rcu.h"
 
 /* Initialize simple callback list. */
 void rcu_cblist_init(struct rcu_cblist *rclp)
@@ -328,6 +329,36 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
+/*
+ * Return how many CBs each segment along with their gp_seq values.
+ *
+ * This function is O(N) where N is the number of segments. Only used from
+ * tracing code which is usually disabled in production.
+ */
+#ifdef CONFIG_RCU_TRACE
+static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS])
+{
+	int i;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
+		gpseq[i] = rsclp->gp_seq[i];
+	}
+}
+
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, const char *context)
+{
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
+
+	rcu_segcblist_countseq(rsclp, cbs, gps);
+
+	trace_rcu_segcb(context, cbs, gps);
+}
+#endif
+
 /*
  * Extract only those callbacks still pending (not yet ready to be
  * invoked) from the specified rcu_segcblist structure and place them in
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..c2e274ae0912 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+#ifdef CONFIG_RCU_TRACE
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, const char *context);
+#else
+#define trace_rcu_segcb_list(...)
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24c00020ab83..346a05506935 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_list(&rdp->cblist, TPS("SegCbPreAcc"));
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_list(&rdp->cblist, TPS("SegCbPostAcc"));
+
 	return ret;
 }
 
@@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
+
+	trace_rcu_segcb_list(&rdp->cblist, TPS("SegCbDequeued"));
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_list(&rdp->cblist, TPS("SegCBQueued"));
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-- 
2.29.0.rc1.297.gfa9743e501-goog

