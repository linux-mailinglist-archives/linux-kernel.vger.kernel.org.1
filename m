Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8F28EA58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbgJOBkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389101AbgJOBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B3C0F26E1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so2056432iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLgr58nL4YXLz9AStz5oFu8PXsI1p32cwUbFvAFdp84=;
        b=KUwyhOQxzQlMlhBqhEFxfEv1Gs9xohE1Vd63uGVKC5YTVFNLA4jYdME5aSZU5Cowap
         oGaVRqyihfURZweK4njmYwd4X1f2zJfH1YX3W5kxf4DRS9RNHDNOnEPxNl+p+5BV98/V
         IhtKm5SZdz8HYh8FZ0cwcXnF0x92PC2pWHkw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLgr58nL4YXLz9AStz5oFu8PXsI1p32cwUbFvAFdp84=;
        b=jZhOZM5LLSTULzPn9VB8v5SBV3++4NWCUQYvZTPRdUiW8NcNSN1dMD3/RHk86GjwVs
         VEq2A8OKOLQbMjcn6Jl8qtT9yKlXFZAVWOY7RSPop0SSGSVdO0L0VeMLMYtyU/tQwQq+
         G2zDLNCYCJ8mE773Xgj7dUo2GJXL/cyzQhvEIUFP8vgZn/cVUkXcnqRcEQfkbAlLEA5r
         1J6nO8Pj5H++aTL0yxiBlUozJvAgyefKqTiKdt+J8coykItMAiB07jzczYdLm/FUJk3s
         Kouk0hxC4VgkVlPu+3lqhIae2t41ZlNAxnyL29qI40hthDi11RRE719FQPaf7paASeYF
         Y4XQ==
X-Gm-Message-State: AOAM531fBxVROuEaL6OX0GFzkQXhXnCLtt8xSIZE8dO+J+rNiXTCoLOE
        k9YTzSFHQZKHIQmlBPHxokMxjUxKS4yevg==
X-Google-Smtp-Source: ABdhPJwO9oWMn8xZ4qqOX/a1PiJl1+OcXrSTCCBErR9RXSvDebUzc2gerDH7NbUtzTgOAsI8Nun2UA==
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr1415608iob.15.1602721394219;
        Wed, 14 Oct 2020 17:23:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
Date:   Wed, 14 Oct 2020 20:23:01 -0400
Message-Id: <20201015002301.101830-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
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
 kernel/rcu/rcu_segcblist.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 271d5d9d7f60..25ffd07f9951 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -147,17 +147,47 @@ static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
  * field to disagree with the actual number of callbacks on the structure.
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
+ *
+ * About memory barriers:
+ * There is a situation where rcu_barrier() locklessly samples the full
+ * length of the segmented cblist before deciding what to do. That can
+ * race with another path that calls this function. rcu_barrier() should
+ * not wrongly assume there are no callbacks, so any transitions from 1->0
+ * and 0->1 have to be carefully ordered with respect to list modifications.
+ *
+ * Memory barrier is needed before adding to length, for the case where
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
+ * Memory barrier is needed after adding to length for the case
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
2.28.0.1011.ga647a8990f-goog

