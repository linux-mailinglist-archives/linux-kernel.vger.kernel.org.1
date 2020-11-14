Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641592B3038
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKNTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKNTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:31:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4FC0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 11:31:36 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so9824676qtj.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHELGlfHs7ktNTVhZjDhOUh5Vt3OVvcTTYV2WfzR6PY=;
        b=n9176qsGx5gx8cPqre6GKbp7G55Pgxrq+EabtDHR8bphiv9onj9dmloltA/6RSbt9G
         23mfg/2uyTUGFl04acYe8K0L/gQe2GbNpzxQo/lJ2kDtMjxI7Iw6Z6g7Ff+0rJbzb2rc
         sPDI1fPMEZJtjSX/FsiyLxbp9Qg/dac3Pc7EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHELGlfHs7ktNTVhZjDhOUh5Vt3OVvcTTYV2WfzR6PY=;
        b=en9bOPVevavZ1OvrHWvQUauisQMFe06l8aYiy8rUb2PqeHUaRmoQaP0O4B5MQGbnP0
         piO/pLlsjad58nLXoh+vS0N5LEHhzXC2PVxHwJW7fHijrmXlI2qC7oleQhbAvdXM18bh
         Wiqanxr72oiORLuxWwlsjYCNWBbjxRrNiput7QAijQXkmzim5NuuG1biCtESCna35Oz2
         AKOrhYXXIIwbB32WmVLSHSQKioKYMBpnXQSG2X9qq7LHWU/D9g+lT/CgWj6awMWg/nWz
         eKEuqtN/ugqE/ZoiJ0g704gPb+PdsA+S4wjlfbwuf4ZzPyYxGciYpLnCP5kjGZaKR+FR
         Hghw==
X-Gm-Message-State: AOAM53058Xek5MAaJHTnTJskzhWeJ7DHzXtujJathf9ypTZI+LdVVNVy
        Zsp3twEbnNSViZb4rGCUF7+jQjjXW/CmsQ==
X-Google-Smtp-Source: ABdhPJxXcoOC+A31GOYw9y9qr17sxmQLDa7RRQ49PTkCbtsgsv+0/Nmkp0A3ZD/rozMDQw27bfhbTA==
X-Received: by 2002:ac8:5ac4:: with SMTP id d4mr7261848qtd.113.1605382295226;
        Sat, 14 Nov 2020 11:31:35 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id u16sm9819314qth.42.2020.11.14.11.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 11:31:34 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH rcu-dev] rcu/trace: Add tracing for how segcb list changes
Date:   Sat, 14 Nov 2020 14:31:32 -0500
Message-Id: <20201114193132.2660464-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/trace/events/rcu.h | 26 ++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..5fc29400e1a2 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,32 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb_stats,
+
+		TP_PROTO(struct rcu_segcblist *rs, const char *ctx),
+
+		TP_ARGS(rs, ctx),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
+			__array(long, seglen, RCU_CBLIST_NSEGS)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->seglen, rs->seglen, RCU_CBLIST_NSEGS * sizeof(long));
+			memcpy(__entry->gp_seq, rs->gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
+
+		),
+
+		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->seglen[0], __entry->seglen[1], __entry->seglen[2], __entry->seglen[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 413831b48648..b96d26d0d44a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
+
 	return ret;
 }
 
@@ -2473,11 +2477,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
+
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2989,6 +2996,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-- 
2.29.2.299.gdc1121823c-goog

