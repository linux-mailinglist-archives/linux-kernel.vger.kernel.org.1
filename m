Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECA2D6D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394806AbgLKBWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404803AbgLKBUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:46 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mm@kvack.org
Subject: [PATCH v3 sl-b 4/6] mm: Make mem_obj_dump() vmalloc() dumps include start and length
Date:   Thu, 10 Dec 2020 17:20:01 -0800
Message-Id: <20201211012003.16473-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201211011907.GA16110@paulmck-ThinkPad-P72>
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the starting address and number of pages to the vmalloc()
information dumped by way of vmalloc_dump_obj().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7421719..77b1100 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3439,7 +3439,8 @@ bool vmalloc_dump_obj(void *object)
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
 
-- 
2.9.5

