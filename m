Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8742D3821
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLIBNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgLIBNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:13:46 -0500
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
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: [PATCH v2 sl-b 2/5] mm: Make mem_dump_obj() handle NULL and zero-sized pointers
Date:   Tue,  8 Dec 2020 17:13:00 -0800
Message-Id: <20201209011303.32737-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201209011124.GA31164@paulmck-ThinkPad-P72>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit makes mem_dump_obj() call out NULL and zero-sized pointers
specially instead of classifying them as non-paged memory.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index d0e60d2..8c2449f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -985,7 +985,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 void mem_dump_obj(void *object)
 {
 	if (!virt_addr_valid(object)) {
-		pr_cont(" non-paged (local) memory.\n");
+		if (object == NULL)
+			pr_cont(" NULL pointer.\n");
+		else if (object == ZERO_SIZE_PTR)
+			pr_cont(" zero-size pointer.\n");
+		else
+			pr_cont(" non-paged (local) memory.\n");
 		return;
 	}
 	if (kmem_valid_obj(object)) {
-- 
2.9.5

