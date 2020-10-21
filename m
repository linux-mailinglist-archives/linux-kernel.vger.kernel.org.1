Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BC2952BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504731AbgJUTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504709AbgJUTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a23so3562913qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWsvRyJdoZJ0Iy1nK3H0MirMsg0OsjhNU+4oMtapmg0=;
        b=oTw1OO/k8vgJDEDOkV5+3d2CKbqAjj7IZjyjmIFElx01DzNVEi7vDGMNILtBAhXEJU
         xK1Rw7VPHJ1puAILprlaUxD82NoAyDZjZ/5Wl54CP+2zqUg+thaNxBmvj+pNQlrF4s2o
         jo96VDOA7Vc7fWfL7rKFDHYtwVjTbgYladtyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWsvRyJdoZJ0Iy1nK3H0MirMsg0OsjhNU+4oMtapmg0=;
        b=Hd7XpJiMY1VZYo2c+w3cigIScu8AZcIWoCsXXiN6Aer06W8LCXM8e1qExTMLc0fIH7
         vaBu5ZatJUVhIxKi5W1o2SCunssaDm4+RbdauEJRxPPMZL7DHbcn5MK8KuW+GEQJVgwM
         bHL2SWv2NYeB4UVNadGVfLwGsyAULX3Oh+rJ7WTZmzPtBywmWuTw88vn4d0MmydO8Zt9
         7AIqVa/hj+v4my//vsxI7rrR5YDOn9bkHgIEAXaDOI06JnpMG4ZOS6q9Z57mqTosDhXS
         vpn/zQOWb+PVBeW9VdXFp0VaPyZG62B1ywdCCGw7UdE3zDyEMyuC5rVeewIuQu1b9JAS
         fqQw==
X-Gm-Message-State: AOAM532Kky2xKJypo0Maur0iPpiVzSm+ORE4DB/2uOg9LHda+0yOgcHz
        gAtKco18Ylf5D+S6cVIOTPCQAtd1k79taA==
X-Google-Smtp-Source: ABdhPJzA7fPGYm67jSd0Tqe3Q80R+TJGQah4KbjoThENfRfvp/gvqn+bCji4bwG0LM4mOdbogQIfwQ==
X-Received: by 2002:a37:7e41:: with SMTP id z62mr4519090qkc.495.1603307304271;
        Wed, 21 Oct 2020 12:08:24 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
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
Subject: [PATCH v8 5/6] rcu/tree: segcblist: Remove redundant smp_mb()s
Date:   Wed, 21 Oct 2020 15:08:12 -0400
Message-Id: <20201021190813.3005054-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier *before* the length of the list is updated.

Same reasoning for rcu_segcblist_enqueue().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 19ff82b805fb..f0fcdf9d0f7f 100644
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
index 346a05506935..6c6d3c7036e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.29.0.rc1.297.gfa9743e501-goog

