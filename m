Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB130370A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbhAZHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbhAYPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:40:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA24C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zTVcMh6i3i1Mimms/eCXJpY7bsAIZ5RGzU7DVcH+StE=; b=YCUOvK6DwclRGMFjkFlVQtpyVD
        br7jFA+paC9YNSjI7I6GNzUFPLtSeCRWtHMdziknlZ/M9FVFvH7HU5YPpnOW9dZTRNpQrz1WGbdm/
        pcU/J4hBC0FH8P3HNXzCOtPTNANagRRL6j2xsR/qj2W6YAsWEispdrjfKIy3gpWBqPw3KG1mQZf8e
        o7WpINEwy4/YdsVc1R4+JVWyrLv8+O9C/dV8XF54INjLsV0lQ9vtHq2UNpdqdWt+Y376n4lmnfDCF
        ve/fRB+1QO3bQNhd5qPV+EI3FMyjslMGFvL56XQtmpCzEjbIDioRJf09CVUmXPJB6mtHkJWU+6Vje
        r3HIdd1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l43Zr-004KsS-HG; Mon, 25 Jan 2021 15:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD4D930768E;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 80E372B6D76D0; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151315.044743526@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:10:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 7/7] rbtree, timerqueue: Use rb_add_cached()
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boiler plate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/timerqueue.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -14,6 +14,14 @@
 #include <linux/rbtree.h>
 #include <linux/export.h>
 
+#define __node_2_tq(_n) \
+	rb_entry((_n), struct timerqueue_node, node)
+
+static inline bool __timerqueue_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __node_2_tq(a)->expires < __node_2_tq(b)->expires;
+}
+
 /**
  * timerqueue_add - Adds timer to timerqueue.
  *
@@ -26,28 +34,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->rb_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct timerqueue_node *ptr;
-	bool leftmost = true;
-
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
 
-	while (*p) {
-		parent = *p;
-		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires < ptr->expires) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	rb_link_node(&node->node, parent, p);
-	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
-
-	return leftmost;
+	return rb_add_cached(&node->node, &head->rb_root, __timerqueue_less);
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 


