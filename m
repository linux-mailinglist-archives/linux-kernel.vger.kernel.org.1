Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E061BCDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD1U74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726910AbgD1U7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:59:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988EC03C1AC;
        Tue, 28 Apr 2020 13:59:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so240185ljg.5;
        Tue, 28 Apr 2020 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Asw9tqE4/cLTmlTUoE8ln3vIOlzdWNXgzJMQ+xZMncE=;
        b=juHF/lso7CN/H2XZntLeP+Irbj7xZN6Dce9JzBFxRojjPE6dBRALNOQJr5cKWc8VCl
         GAJBSsQ/YZEVC3bE5B+0VvqbSTECPI8HsuhxuAafleWUngRE8nj5+or1xX4bH7xSOq/X
         td1GjGUpOXtUE5ViUGkt+QVERAU9/smj4Mj0lZn+dw0VyNEX7j9PjFHuV53aVDtF27yS
         Ah8w+nux9V5kT+I6bHmxQEjUyGfSOmoJMaETxviC6ikjLYdJn66EmmOiaG/GNF+No0vt
         saxA/aJO4TdWTGgd1ftgsFZh118rD7Ly4/ZSPP+NDfkIJSMjum6fhzFsojrRQt6CDdjJ
         Zzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Asw9tqE4/cLTmlTUoE8ln3vIOlzdWNXgzJMQ+xZMncE=;
        b=dqEtrHaq3uQZvvNrzh6tN6zlNCI1pwmPrOUecVxTRQhKUTKnaJJASh+XUjNZ5+rKFI
         hHEwMqw/hMfux91GZXM/HF17FgA6HCnmz2a6MVCLprQSukDT61oL/O8qqUYGMnIm74Qm
         owY6oczGtq8dBy3I1/iHw4KZh4njdZhaA5b25cWmrVETZas4P3xYm1/XqKYM+VtoYXhW
         6tmgTx6kcOgyj6rlj4rZdvhgpGZw9pXqkxKoYuySCe8lbjAPu+oSZMgXtiKmg+lGdu9O
         G7lN2TKsNcjFGdFhLHrAepVPQqoZsqQRGCjejsJLIrRuKy3YAZ10DH7Vb0MZd14GlTPz
         3z3Q==
X-Gm-Message-State: AGi0PuYB9VvS96ieZCLGk7Kgl2fW9BjcXoyvyKYCQREVDvcLqDxJ2tlK
        RDhfPtP6MAfDWIYXaJvsn96fXS82W/lEKQ==
X-Google-Smtp-Source: APiQypKV+6RjXJzSL+v6wXMSNXoSgBbylgy6V8bSx38gvWAORGi68jbgQU0ttvjTYKtEMPZIu8JiJw==
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr14774417ljp.236.1588107588713;
        Tue, 28 Apr 2020 13:59:48 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 16/24] mm/list_lru.c: Rename kvfree_rcu() to local variant
Date:   Tue, 28 Apr 2020 22:58:55 +0200
Message-Id: <20200428205903.61704-17-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename kvfree_rcu() function to the kvfree_rcu_local() one. The aim is
to introduce the public API that would conflict with this one. So we
temporarily rename it and remove it in a later commit.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4d5294c39bba..42c95bcb53ca 100644
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
2.20.1

