Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8780D2643E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgIJKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 06:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbgIJKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:16 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3B521D91;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=fXbQXOaYjx72zqTGIw4X5zbM9zC7or8CP+BA7YjUllo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgGAaeAyek3TLUjXyHworDsQs9TIbSF3FJF2y87ysMsG25t1JhxjL5wXN0UeLvrk+
         sE8Oa5pkxG5b94pYCi8Xx0wH67/ur2NzbjlepfD8k+ixXlql3vRr8WoC46j9imgpEW
         4Gd4OpcbUOj9yDzBtGgOzoAagXw05XZVb0FBN2z0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINw-I1; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] rcu/tree: docs: document bkvcache new members at struct kfree_rcu_cpu
Date:   Thu, 10 Sep 2020 12:24:01 +0200
Message-Id: <40164da02303db3f9bafa6719cf509ffe6af1518.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 53c72b590b3a ("rcu/tree: cache specified number of objects")
added new members for struct kfree_rcu_cpu, but didn't add the
corresponding at the kernel-doc markup, as repoted when doing
"make htmldocs":
	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'bkvcache' not described in 'kfree_rcu_cpu'
	./kernel/rcu/tree.c:3113: warning: Function parameter or member 'nr_bkv_objs' not described in 'kfree_rcu_cpu'

So, move the description for bkvcache to kernel-doc, and add a
description for nr_bkv_objs.

Fixes: 53c72b590b3a ("rcu/tree: cache specified number of objects")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7623128d0020..395e69cda916 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3085,6 +3085,12 @@ struct kfree_rcu_cpu_work {
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
+ * @bkvcache:
+ *	A simple cache list that contains objects for reuse purpose.
+ *	In order to save some per-cpu space the list is singular.
+ *	Even though it is lockless an access has to be protected by the
+ *	per-cpu lock.
+ * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3100,14 +3106,6 @@ struct kfree_rcu_cpu {
 	bool monitor_todo;
 	bool initialized;
 	int count;
-
-	/*
-	 * A simple cache list that contains objects for
-	 * reuse purpose. In order to save some per-cpu
-	 * space the list is singular. Even though it is
-	 * lockless an access has to be protected by the
-	 * per-cpu lock.
-	 */
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
-- 
2.26.2

