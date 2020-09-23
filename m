Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE87B275B93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgIWPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280AC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n10so186907qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cDK/I8I2FGOXJ4pDRboLgBbzgbuEsc8iKvVonhKc6M=;
        b=FQxKFgrLVOQinONll9EPYAA0puvCwVMcwG69+CNas01VJIfh4ebGI6/+6fbwWYTb0+
         9S7XvUONDEvr+2kzW61eIXyae2AMmP8JGOykHiPmTWAMThztMc0AJyBLXRsFW8BxkN/q
         hqmxdP3O/8DKdR+Q8NI4y49MRTCZwBBJDjseA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cDK/I8I2FGOXJ4pDRboLgBbzgbuEsc8iKvVonhKc6M=;
        b=GHbqBqynBAnmidO1UrPAdnTJ2zIVH9Gx/urt2AltZ1mSimQ7G12XDyRAtwQt/LNobZ
         wX8IcDGtXLnwcZRekUsSpOxhuGdB0DpzySKQGpV5i5+GBSCSoeNa56wrIb/5DB/vw85/
         rtxd7OqiO+hA6/a82gFGE9XYSdTjAttvCXhal048kzFoOTmjZlmodKT6RsR9RQkff0X/
         F8YvNkOZ7VDq4kdHzukOwNXmYWwZ3PjB5E+b2hzyBfi//m28BtIMMxQasgcSK31kzLhe
         02Wie1Hwi1DFPen6qorXPnydE61RiQu9C59WsUUHx6qSMNS1SMmTGussp3LSEpqcbGuE
         ki6g==
X-Gm-Message-State: AOAM533Q3v97HukpvlgRuEgs0pvjIbVUKvTPikiGETZM5MdxHktgEicl
        ZRbUpYw/fSAlzYgXaHrI0DXItl7BYrZ3MQ==
X-Google-Smtp-Source: ABdhPJx4M4mHHcP52Ab020eAVznvdCGqBWcEi2E5yAzfL/eYBL4MI/rLkU/a/7MPD2WMWI2WBzytVA==
X-Received: by 2002:aed:2e25:: with SMTP id j34mr545146qtd.372.1600874538494;
        Wed, 23 Sep 2020 08:22:18 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 3/4] rcu/trace: Add tracing for how segcb list changes
Date:   Wed, 23 Sep 2020 11:22:10 -0400
Message-Id: <20200923152211.2403352-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
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
 kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  5 +++++
 kernel/rcu/tree.c          |  9 +++++++++
 4 files changed, 73 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..7b84df3c95df 100644
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
+			__array(int, cb_count, 4)
+			__array(unsigned long, gp_seq, 4)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
+			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
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
index 0e6d19bd3de9..df0f31e30947 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -13,6 +13,7 @@
 #include <linux/rcupdate.h>
 
 #include "rcu_segcblist.h"
+#include "rcu.h"
 
 /* Initialize simple callback list. */
 void rcu_cblist_init(struct rcu_cblist *rclp)
@@ -343,6 +344,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
+/*
+ * Return how many CBs each segment along with their gp_seq values.
+ *
+ * This function is O(N) where N is the number of callbacks. Only used from
+ * tracing code which is usually disabled in production.
+ */
+#ifdef CONFIG_RCU_TRACE
+static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS])
+{
+	int i;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+		cbcount[i] = 0;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
+		gpseq[i] = rsclp->gp_seq[i];
+	}
+}
+
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context)
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
index 3e0eb1056ae9..15c10d30f88c 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+#ifdef CONFIG_RCU_TRACE
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context);
+#else
+#define trace_rcu_segcb_list(...)
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 50af465729f4..e3381ff67fc6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1492,6 +1492,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbPreAcc");
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1512,6 +1514,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbPostAcc");
+
 	return ret;
 }
 
@@ -2469,6 +2473,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbDequeued");
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2982,6 +2989,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCBQueued");
+
 	/* Go handle any RCU core processing required. */
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
-- 
2.28.0.681.g6f77f65b4e-goog

