Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9928B2D3825
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgLIBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgLIBNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
        linux-mm@kvack.org
Subject: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc() memory
Date:   Tue,  8 Dec 2020 17:13:01 -0800
Message-Id: <20201209011303.32737-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201209011124.GA31164@paulmck-ThinkPad-P72>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds vmalloc() support to mem_dump_obj().  Note that the
vmalloc_dump_obj() function combines the checking and dumping, in
contrast with the split between kmem_valid_obj() and kmem_dump_obj().
The reason for the difference is that the checking in the vmalloc()
case involves acquiring a global lock, and redundant acquisitions of
global locks should be avoided, even on not-so-fast paths.

Note that this change causes on-stack variables to be reported as
vmalloc() storage from kernel_clone() or similar, depending on the degree
of inlining that your compiler does.  This is likely more helpful than
the earlier "non-paged (local) memory".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/vmalloc.h |  6 ++++++
 mm/util.c               | 12 +++++++-----
 mm/vmalloc.c            | 12 ++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 938eaf9..c89c2be 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -248,4 +248,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+#ifdef CONFIG_MMU
+bool vmalloc_dump_obj(void *object);
+#else
+static inline bool vmalloc_dump_obj(void *object) { return false; }
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/util.c b/mm/util.c
index 8c2449f..ee99a0a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -984,6 +984,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  */
 void mem_dump_obj(void *object)
 {
+	if (kmem_valid_obj(object)) {
+		kmem_dump_obj(object);
+		return;
+	}
+	if (vmalloc_dump_obj(object))
+		return;
 	if (!virt_addr_valid(object)) {
 		if (object == NULL)
 			pr_cont(" NULL pointer.\n");
@@ -993,10 +999,6 @@ void mem_dump_obj(void *object)
 			pr_cont(" non-paged (local) memory.\n");
 		return;
 	}
-	if (kmem_valid_obj(object)) {
-		kmem_dump_obj(object);
-		return;
-	}
-	pr_cont(" non-slab memory.\n");
+	pr_cont(" non-slab/vmalloc memory.\n");
 }
 EXPORT_SYMBOL_GPL(mem_dump_obj);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a..7421719 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+bool vmalloc_dump_obj(void *object)
+{
+	struct vm_struct *vm;
+	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+
+	vm = find_vm_area(objp);
+	if (!vm)
+		return false;
+	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	return true;
+}
+
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_purge_lock)
-- 
2.9.5

