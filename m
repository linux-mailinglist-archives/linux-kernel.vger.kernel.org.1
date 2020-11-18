Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5091C2B818F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKRQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:15:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1FAC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:15:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g20so2011470qtu.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJE6rXIzbWSElRW1phJDk97yNh0I3oGRFmJIDcQescw=;
        b=SE9bSGsY7rY7vZ/YERAqp5Aap2XbtOGXi5TykZmuL6lnXFT1tP0Hiy08Y6aKkcx3eU
         09nQLfYB9+JCKnQho7Dq7ZUKlVbBCqXx+8li0Ih4MCsdYi9sB8w909NPOxoQd/8X5mFh
         P5lRTk8JRM+XhkAuWwPLHRv6yWJsn0Y1omjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJE6rXIzbWSElRW1phJDk97yNh0I3oGRFmJIDcQescw=;
        b=Ueay4J771vTbdlaJzSaNDdk0a6sqADi3La/yEutx8z2bE3PhlmI7XCiGnVfACa0kEm
         1dM3TUUHrnJHfP6+eRQ4mB9LF/ytlKtdv6C/PqKIaXeqhaF9AJ83/JOuISdiHmfN1+9m
         vKzKbpPl7FQCFpHYC8oRGo519AOxHodMzS+AQVW4ItKOofk6+vKa8UcAVvw8MN59sbCW
         eTJisxh15dxpVNxn72pYUh+AVw9+g3Jwr78Y1STkK/jFZwzgqgn6pmsNK2lMg8D9TFbB
         agEFk6UIah0DbeEPwygpbzmSsPmNdLnIuNS4aumrNJu92g+hMLOSMDZcvy5cx80/6ofu
         LxWQ==
X-Gm-Message-State: AOAM532TfzqJ91rGa+6RwBxQoMJ5k5Csmc/amz4LkHz+8uWLTfAT8qYY
        3XM41X3rsq7v4rzWHynuMA5lixhAZEHbug==
X-Google-Smtp-Source: ABdhPJxt4kX6XjIEzA4VfTUA005xth8CjWWyICEF6/zG8klopHRXmTIBquPttrtC6/50FW9tKOVccw==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr5386731qtv.65.1605716147933;
        Wed, 18 Nov 2020 08:15:47 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r62sm17089383qkd.80.2020.11.18.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:15:47 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Date:   Wed, 18 Nov 2020 11:15:41 -0500
Message-Id: <20201118161541.3844924-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After rcu_do_batch(), add a check for whether the seglen counts went to
zero if the list was indeed empty.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Added more debug checks.

 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5059b6102afe..6e98bb3804f0 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 	return READ_ONCE(rsclp->seglen[seg]);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
+{
+	long len = 0;
+	int i;
+
+	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
+		len += rcu_segcblist_get_seglen(rsclp, i);
+
+	return len;
+}
+
 /* Set the length of a segment of the rcu_segcblist structure. */
 static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
 {
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..46a42d77f7e1 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
+
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f5b61e10f1de..91e35b521e51 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
+	WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-- 
2.29.2.299.gdc1121823c-goog
