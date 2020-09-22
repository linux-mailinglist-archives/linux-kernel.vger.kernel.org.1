Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3970274469
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIVOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgIVOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51168B123;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 7/9] mm, page_alloc: move draining pcplists to page isolation users
Date:   Tue, 22 Sep 2020 16:37:10 +0200
Message-Id: <20200922143712.12048-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pcplists are drained during set_migratetype_isolate() which means
once per pageblock processed start_isolate_page_range(). This is somewhat
wasteful. Moreover, the callers might need different guarantees, and the
draining is currently prone to races and does not guarantee that no page
from isolated pageblock will end up on the pcplist after the drain.

Better guarantees are added by later patches and require explicit actions
by page isolation users that need them. Thus it makes sense to move the
current imperfect draining to the callers also as a preparation step.

Suggested-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memory_hotplug.c | 11 ++++++-----
 mm/page_alloc.c     |  2 ++
 mm/page_isolation.c | 10 +++++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9db80ee29caa..08f729922e18 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1524,6 +1524,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		goto failed_removal;
 	}
 
+	drain_all_pages(zone);
+
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
 	node_states_check_changes_offline(nr_pages, zone, &arg);
@@ -1574,11 +1576,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		}
 
 		/*
-		 * per-cpu pages are drained in start_isolate_page_range, but if
-		 * there are still pages that are not free, make sure that we
-		 * drain again, because when we isolated range we might
-		 * have raced with another thread that was adding pages to pcp
-		 * list.
+		 * per-cpu pages are drained after start_isolate_page_range, but
+		 * if there are still pages that are not free, make sure that we
+		 * drain again, because when we isolated range we might have
+		 * raced with another thread that was adding pages to pcp list.
 		 *
 		 * Forward progress should be still guaranteed because
 		 * pages on the pcp list can only belong to MOVABLE_ZONE
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 901907799bdc..4e37bc3f6077 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8432,6 +8432,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	if (ret)
 		return ret;
 
+	drain_all_pages(cc.zone);
+
 	/*
 	 * In case of -EBUSY, we'd like to know which page causes problem.
 	 * So, just fall through. test_pages_isolated() has a tracepoint
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index abfe26ad59fd..57d8bc1e7760 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -49,7 +49,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		spin_unlock_irqrestore(&zone->lock, flags);
-		drain_all_pages(zone);
 		return 0;
 	}
 
@@ -167,11 +166,12 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  *
  * Please note that there is no strong synchronization with the page allocator
  * either. Pages might be freed while their page blocks are marked ISOLATED.
- * In some cases pages might still end up on pcp lists and that would allow
+ * A call to drain_all_pages() after isolation can flush most of them. However
+ * in some cases pages might still end up on pcp lists and that would allow
  * for their allocation even when they are in fact isolated already. Depending
- * on how strong of a guarantee the caller needs drain_all_pages might be needed
- * (e.g. __offline_pages will need to call it after check for isolated range for
- * a next retry).
+ * on how strong of a guarantee the caller needs, further drain_all_pages()
+ * might be needed (e.g. __offline_pages will need to call it after check for
+ * isolated range for a next retry).
  *
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
-- 
2.28.0

