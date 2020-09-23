Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF4275B92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIWPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so23110229qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5j4t27+l0WYqDu/xeamzQpCWOqmDCckcWi8FrgNWBc=;
        b=tK1EqB2bR9LJRqoXs5CmpOMPYB+VH1hMorNjp4Hkhq5DnyCC8II3Av9uv7KnEA/1sI
         WOqujnhJL7302ks4RCDOH9YQpzb7rZBjudaKR3aysv11x+I0EtH7to0vXzolYGWnNuSk
         pUI3bWoQXntwKnQB2SoSVnzf0k8nNDTad0q34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5j4t27+l0WYqDu/xeamzQpCWOqmDCckcWi8FrgNWBc=;
        b=oubAbFXOanW2QvgK+doaGtS+ObuvJmNgJXTFFicJJVmaf6wtGqQWXFwHhzxbQgu8Wq
         ZA74vSAT3PmhI1XcquWoOmPbToFTG1Hij17FhROhAke98e4Yg4E71UQsUU387/OkORTb
         shr/mbhy7HyflIgdPl04FgqwR4NtqzXqnSxTg/f0DQceQTjSykI3FdQRFsjw5WrWekNM
         iJg+fdCrLZYofx63TrNIS6D9Q54G0Il75PwShRXY4/q+5DH9fwVRdy1tfKVYo9nzwmj7
         Qu1EDigd5p+rYaPCosp6wr51o40KyfUfP4cUGv4J1kSiDsGr/EEpPmdVA1U973kXbr4u
         V31w==
X-Gm-Message-State: AOAM533+n54XzS0gW8jqouszPydv56L/Us+eEudPX8yVRCmBMFA7Ie84
        11b6N+eo1+img8c11d2Ig/67KYBLb61QVQ==
X-Google-Smtp-Source: ABdhPJwjVz4hlIIUQqDlMsdkGwdJMIaFsGbu1Hk3HidQzRFK5WMQrlfqCSKtaaNV0Gu3cejRvbnmPw==
X-Received: by 2002:a37:96c7:: with SMTP id y190mr378126qkd.152.1600874535684;
        Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
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
Subject: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many callbacks were executed
Date:   Wed, 23 Sep 2020 11:22:08 -0400
Message-Id: <20200923152211.2403352-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_do_batch() depends on the unsegmented callback list's len field
to know how many CBs are executed. This fields counts down from 0 as CBs are
dequeued.  It is possible that all CBs could not be run because of reaching
limits in which case the remaining unexecuted callbacks are requeued in the
CPU's segcblist.

The number of callbacks that were not requeued are then the negative count (how
many CBs were run) stored in the rcl->len which has been counting down on every
dequeue. This negative count is then added to the per-cpu segmented callback
list's to correct its count.

Such a design works against future efforts to track the length of each segment
of the segmented callback list. The reason is because
rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
list's length field (rcl->len) during extraction.

Also, the design of counting down from 0 is confusing and error-prone IMHO.

This commit therefore explicitly counts have many callbacks were executed in
rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
field, without relying on the negativity of rcl->len.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 kernel/rcu/rcu_segcblist.h | 1 +
 kernel/rcu/tree.c          | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6b9dfb..bb246d8c6ef1 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293afc07b8..b90725f81d77 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 }
 
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7623128d0020..50af465729f4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2427,7 +2427,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2485,9 +2486,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
@@ -2510,7 +2510,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2518,7 +2517,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.28.0.681.g6f77f65b4e-goog

