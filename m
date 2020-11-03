Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32332A4802
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgKCO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgKCO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:16 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBFC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:26:16 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b18so14736140qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pwlmj4S+t9kYvpBmI6FO8yidTh6/5mCBssZ7DgFshcw=;
        b=TJ1E7uQSNXcSGMuratBV9hviR3pgv6AN+eetN3/UkrcDp62+4sE7XMY6HMSVjeG5oo
         ET42mUK0GEZhArCM9KntX5xcsv1D0mSnw2HkrMaDeQIbKEKSzkJZ7AllOZodIw/SnMpV
         8uwwVi8H3+xiWyb1fKTzJhFxtcLyRYwIIUPO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pwlmj4S+t9kYvpBmI6FO8yidTh6/5mCBssZ7DgFshcw=;
        b=kFlm0AhBwF5l6HaQF+EapiG19Y45LKzvQY97G0KjxM6j/Lqed6d9fIF339PrvLKd7H
         9MvggcoXxRwwT5NCCYd5m5QXGpb5vLPmOCKLUb0BgapKAExSLvCryyulDo0mvx9FiBRp
         iLMLyuTShw1tkSRSu1MG4Vx2KfYSRozLqdV2+umDxiTdvVFQF4NjTyN6a0sXQALlFhlA
         uwIOBk+j2WWX/1y3dpYxaJLUOxTDQg6J0REHInWLAZhZlgXH/lEoUzP5PjEz355a9+vI
         mtref828kpB5/b/kOb0cHl2x647XK9m+qyp3tcpCKnGlke66nMdaskGobBP2wpUmgQT3
         2d9Q==
X-Gm-Message-State: AOAM532x6+/j5a3gWsMsfcaa8Uhlx203u5KtmYiBmnxmtd1xWmhEKOvI
        jEzlBT8nsJSlmm4GO+zjoxGDdaWaHX3xmw==
X-Google-Smtp-Source: ABdhPJyyRtLcHUSyoraBwwT3WhoLxP1sA0h0ffWSFOOpCol8pv4a9Pv6TjK7xaN/MedfgD5nav8gpw==
X-Received: by 2002:a37:a606:: with SMTP id p6mr19355711qke.14.1604413575092;
        Tue, 03 Nov 2020 06:26:15 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:14 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v9 6/7] rcu/tree: segcblist: Remove redundant smp_mb()s
Date:   Tue,  3 Nov 2020 09:26:02 -0500
Message-Id: <20201103142603.1302207-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier *before* and *after* the length of the list is
updated.

Same reasoning for rcu_segcblist_enqueue().

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index e9e72d72f7a6..d96272e8d604 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -268,7 +268,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6c6653b3ec2..fb2a5ac4a59c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.29.1.341.ge80a0c044ae-goog

