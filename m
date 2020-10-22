Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5406C295F33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506343AbgJVM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505297AbgJVM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:58:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29B0CAEDA;
        Thu, 22 Oct 2020 12:58:43 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 2/3] mm: Introduce a new Vmemmap page-type
Date:   Thu, 22 Oct 2020 14:58:34 +0200
Message-Id: <20201022125835.26396-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201022125835.26396-1-osalvador@suse.de>
References: <20201022125835.26396-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new Vmemmap page-type so we can better
picture and handle those kind of pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h         | 6 ++++++
 include/linux/mm_types.h   | 5 +++++
 include/linux/page-flags.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..48845f054136 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3126,6 +3126,12 @@ static inline bool debug_guardpage_enabled(void) { return false; }
 static inline bool page_is_guard(struct page *page) { return false; }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
+static __always_inline unsigned long vmemmap_nr_pages(struct page *page)
+{
+	struct page *head = (struct page *)page->vmemmap_head;
+	return head->vmemmap_pages - (page - head);
+}
+
 #if MAX_NUMNODES > 1
 void __init setup_nr_node_ids(void);
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ae891c0c55fc..0bb8de4262c3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -171,6 +171,11 @@ struct page {
 			 * pmem backed DAX files are mapped.
 			 */
 		};
+		struct {	/* Vmemmap pages */
+			unsigned long vmemmap_head;
+			unsigned long vmemmap_sections; /* Number of sections */
+			unsigned long vmemmap_pages;    /* Number of pages */
+		};
 
 		/** @rcu_head: You can use this to free a page by RCU. */
 		struct rcu_head rcu_head;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..2bad207515fa 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -718,6 +718,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_kmemcg	0x00000200
 #define PG_table	0x00000400
 #define PG_guard	0x00000800
+#define PG_vmemmap     0x00001000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -784,6 +785,11 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+/*
+ * Vmemmap pages (see include/linux/memory_hotplug.h).
+ */
+PAGE_TYPE_OPS(Vmemmap, vmemmap)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
-- 
2.26.2

