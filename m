Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9C2952BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504725AbgJUTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504716AbgJUTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82513C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 140so3670730qko.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZm8tDTjeEnsIl/4g3h5Rv6V/8g9ZNRzmdXeP0nf1YA=;
        b=tux1Fc58xuMWCmI3peVXt87hR/kRh2sKrLMZt8wsg9qHt1N6Dx8YQlFBE6Mc/Yugdj
         UytOalKajKfzuOEqGaNAlMlbmWNl1zVzyIONm+T0rtOamyJc1xTJii9uOaPBs7lF2pQb
         Qb2ao4S89EQiPhMrDW2+YKN0S8TnPmDAJX4Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZm8tDTjeEnsIl/4g3h5Rv6V/8g9ZNRzmdXeP0nf1YA=;
        b=OXatwbNZAVFu4o2wHPoSovQ7PQ+G1hQ36CjDJCTvfDqmEHSF5eOnoqhCeuw9pDyprE
         VyTdc8REbOWR54kygGwIvtOVEfEI7g9HK4IOI09JYzqwVvTuVS0i+GCtLEj3wlMsKDhX
         4nIDWhnMCtCahvirEbPCwvm7YhCcByKgD6hHIqjtim0SPMgCYSR1xu3FUMQQ8ToNrwAd
         TDEhLEHXtNDaAAlD9WagREm7bO99CSKYGJzPG17LBneJ2oCG358aTLVj6O2H2lamFM2e
         q7mvVXSuDd0vBXgTV8cboMkGt2fDazElBOhv8k+vr/qgEhtWmNJ2vSmNlfQ1V8jY3f3u
         xRSQ==
X-Gm-Message-State: AOAM532hibI5ZlsQ9RDfMN0pDNabqJexgKkGXzGCdwaFT3Z7FWFq8IAE
        2T1Hnu9xbKypn33VCdMVBKT8vw/btZjYHg==
X-Google-Smtp-Source: ABdhPJwn/E/690H0Bkz8VUnu3nLOE2mmjLK1/0nk4xHGQ0McBB6oHEJOdrwgfBqjlWHZfKT89zL5Fg==
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr4564231qki.286.1603307305506;
        Wed, 21 Oct 2020 12:08:25 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:24 -0700 (PDT)
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
Subject: [PATCH v8 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
Date:   Wed, 21 Oct 2020 15:08:13 -0400
Message-Id: <20201021190813.3005054-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory barriers are needed when updating the full length of the
segcblist, however it is not fully clearly why one is needed before and
after. This patch therefore adds additional comments to the function
header to explain it.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 40 ++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index f0fcdf9d0f7f..1652b874855e 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -135,17 +135,49 @@ static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
  * field to disagree with the actual number of callbacks on the structure.
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
+ *
+ * About memory barriers:
+ * There is a situation where rcu_barrier() locklessly samples the full
+ * length of the segmented cblist before deciding what to do. That can
+ * race with another path that calls this function such as enqueue or dequeue.
+ * rcu_barrier() should not wrongly assume there are no callbacks, so any
+ * transitions from 1->0 and 0->1 have to be carefully ordered with respect to
+ * list modifications and with whatever follows the rcu_barrier().
+ *
+ * There are at least 2 cases:
+ * CASE 1: Memory barrier is needed before adding to length, for the case where
+ * v is negative which does not happen in current code, but used
+ * to happen. Keep the memory barrier for robustness reasons. When/If the
+ * length transitions from 1 -> 0, the write to 0 has to be ordered *after*
+ * the memory accesses of the CBs that were dequeued and the segcblist
+ * modifications:
+ * P0 (what P1 sees)	P1
+ * set len = 0
+ *                      rcu_barrier sees len as 0
+ * dequeue from list
+ *                      rcu_barrier does nothing.
+ *
+ * CASE 2: Memory barrier is needed after adding to length for the case
+ * where length transitions from 0 -> 1. This is because rcu_barrier()
+ * should never miss an update to the length. So the update to length
+ * has to be seen *before* any modifications to the segmented list. Otherwise a
+ * race can happen.
+ * P0 (what P1 sees)	P1
+ * queue to list
+ *                      rcu_barrier sees len as 0
+ * set len = 1.
+ *                      rcu_barrier does nothing.
  */
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
-	smp_mb__before_atomic(); /* Up to the caller! */
+	smp_mb__before_atomic(); /* Read function's comments */
 	atomic_long_add(v, &rsclp->len);
-	smp_mb__after_atomic(); /* Up to the caller! */
+	smp_mb__after_atomic();  /* Read function's comments */
 #else
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); /* Read function's comments */
 	WRITE_ONCE(rsclp->len, rsclp->len + v);
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); /* Read function's comments */
 #endif
 }
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

