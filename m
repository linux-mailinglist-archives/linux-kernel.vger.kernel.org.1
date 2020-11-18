Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5100F2B8186
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKRQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:10:54 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E7C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:10:54 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so2329365qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XDDrZ32tt5cIxyE+1WWU1U+ktexYvm+jvQM9PDJ7jg=;
        b=DHg/fFC98sb8qkPaHYTS69DZGl3FJBElL+2BsojGP93n4UNMLDB0Ko4EmZSZt1PSPW
         ZeXJK7S+3rB+cjp5IaUhAFpHQ2KoUDRW52MWFY6K2SCTOvS1Se3KxXB2vsQlZUlFgABD
         1mBkkM2dxuUPT1yRb/4PhXQvAtEOAL7wjSRg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XDDrZ32tt5cIxyE+1WWU1U+ktexYvm+jvQM9PDJ7jg=;
        b=bV/q0DG7rYTL1Sb40/FwxYvhQMELMaaRDhyfz5YFM00yLJCg/CG9c1zHS+/qOYr5KK
         gk762GAu51Xrc//I9xVqurf2swOx8EzImchEEWzYDUjGGMwa7s7/tOhJheeEhQUIywpD
         64hG/b8hGzNmDQkCey8Q+ZRiCRf8MgzprHKYxGBPsjEmRMCZ/S24l0dmghittnPoOvqz
         cRHdVVAbKPKU2fru1e3pSs19ZQpFoo02oJY2gTHaS1tvIg5NXbAfVfD18Zp5EJVU4jse
         qhHMHIWWOWLuLsy5BVeQnnWouOTtbdQntPs32rINTsLHNqL0d67OmVC+WDYr6l69GsLT
         BPlg==
X-Gm-Message-State: AOAM531LXc2HflQzxZmMP9GKEeAnLkJ+uOOMDQrhmqr/Jnc0eDdplcwk
        cv9NMgIai1zYvoka6kfuniy/HIcVjEOC2g==
X-Google-Smtp-Source: ABdhPJyg8XatWgCr6orxqOAVodXz3RJ9F2GwbBwPHnW3F6Tlhy9j/LRC1WOTuL8jo7rIVD9reIg3YQ==
X-Received: by 2002:a37:7703:: with SMTP id s3mr5586042qkc.298.1605715853206;
        Wed, 18 Nov 2020 08:10:53 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 21sm17447534qkv.78.2020.11.18.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:10:52 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcu/segcblist: Add debug check for whether seglen is 0 for empty list
Date:   Wed, 18 Nov 2020 11:10:43 -0500
Message-Id: <20201118161043.3823994-1-joel@joelfernandes.org>
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
 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  1 +
 3 files changed, 16 insertions(+)

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
index f5b61e10f1de..928bd10c9c3b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+	WARN_ON_ONCE(count == 0 && !rcu_segcblist_n_segment_cbs(&rdp->cblist));
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-- 
2.29.2.299.gdc1121823c-goog

