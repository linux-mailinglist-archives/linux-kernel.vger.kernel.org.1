Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCBE2A4809
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgKCO0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbgKCO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E42C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:26:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id n63so6141381qte.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XljVnWcStqYHGuSnka2+dn76itYpUAMjurOuq71lRa4=;
        b=skQxJpfe2FUrQOCAnPcKJsxT3o5whxVu0caKOjs3mHhUNT43Q3luzcjuEk27r08E+o
         L8sUsNSbXMJtLx+0kF2EFkLsN1iiILRqy+Tdy0ZwQoaXcmaSoKfcobh0VsLD2Z/8JbJd
         obG57ovsSWmKvosTjTdLoMrFcr4tdL9P9ydjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XljVnWcStqYHGuSnka2+dn76itYpUAMjurOuq71lRa4=;
        b=UTpnhw+0h2MOqsUo/9K2ldbcfIqDslANuu8ZFxV2lBH0abfjeqQ9Ef542CVtMQgDCb
         B+voVgQCS3KlNgsWFbngOB32eNuu3+O1/wUosiCBc1JmnCaYcdxcDbbCA/T2im7D1yO6
         BgjHPS/C5DjFZ0P/n4TV086mIcy0cfuSkKvKoc5XcDzmM/UlITQO5P7MExqeQl8vuZ2t
         dOcFdblZs1Brr1a5nwphDkuU04HlSpZmZ2/U2VtFV2MXVcETERVrcuo44XZdEP6wTD14
         /2y23cKyfjIEv2b8qiPhlkYFZ8X726PnNGd9v9IXOhwxrgSlyRVC6qdytr68Zt3ZW5EQ
         X+9A==
X-Gm-Message-State: AOAM530aiI9xCMj+sBq9SN+z4Aw5sActq0CaSUaGliowOObkg7wzUgvZ
        FTyRLjfvsfZq0NXv43QpCDFaQ9m82LAgCQ==
X-Google-Smtp-Source: ABdhPJwxuvIwF/H3Sy646xH8W61LXnw5cX6qbFG/FtX7VU2FoW6PrpEXIy2d2/zCk3/Odqq+HdfWZQ==
X-Received: by 2002:ac8:5a4d:: with SMTP id o13mr1424883qta.74.1604413576242;
        Tue, 03 Nov 2020 06:26:16 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:15 -0800 (PST)
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
Subject: [PATCH v9 7/7] rcu/segcblist: Add additional comments to explain smp_mb()
Date:   Tue,  3 Nov 2020 09:26:03 -0500
Message-Id: <20201103142603.1302207-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
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
index d96272e8d604..9b43d686b1f3 100644
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
+ * v is negative (happens during dequeue). When length transitions from 1 -> 0,
+ * the write to 0 has to be ordered to appear to be *after* the memory accesses
+ * of the CBs that were dequeued and the segcblist modifications:
+ * To illustrate the problematic scenario to avoid:
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
+ * To illustrate the problematic scenario to avoid:
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
2.29.1.341.ge80a0c044ae-goog

