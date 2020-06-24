Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481CA207CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406444AbgFXUMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406393AbgFXUMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17BC21527;
        Wed, 24 Jun 2020 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029550;
        bh=0nMQg5rm3SZnSAL196mvtNrlDJeMTB9eWBLOQfyEsMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nw9ewvEyv1H9E0BBM2SJUHYvtyy9uQbimANYea2WdMedw+FY2mgTfgDAQtQZUO6U8
         CPlSbJywJrIcfZlEtjYWYalzeo661FibBBBtqBkZPPJWi3fMAC4DSFG/gWJ2UN2HRQ
         AvPnRpdVtRSO2qIqEMhbsqXIH94Gs1dT3aES4UZQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/17] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Wed, 24 Jun 2020 13:12:22 -0700
Message-Id: <20200624201226.21197-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Rename kvfree_rcu() function to the kvfree_rcu_local() one.
The purpose is to prevent a conflict of two same function
declarations. The kvfree_rcu() will be globally visible
what would lead to a build error. No functional change.

Cc: linux-mm@kvack.org
Cc: rcu@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 9222910..e825804 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -373,14 +373,14 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu(struct rcu_head *head)
+static void kvfree_rcu_local(struct rcu_head *head)
 {
 	struct list_lru_memcg *mlru;
 
@@ -419,7 +419,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu);
+	call_rcu(&old->rcu, kvfree_rcu_local);
 	return 0;
 }
 
-- 
2.9.5

