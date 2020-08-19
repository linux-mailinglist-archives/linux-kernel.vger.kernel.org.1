Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6710A24A57F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHSSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:01:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbgHSSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTXMJdhZBiz5u+OdXZ8G7mp+us1mE5cHXQvWaF7Ctms=;
        b=banZQlRDZVm6Fnyi7KuWZM1swZmnaM+utiA+M63nTm26oWFC47gaemTvSNPTmgfPmleVZA
        utqFq4p5SNMHTg7pqsGDzikljEso00yxl7YHA34HBCEGcp77YaMdkIhTzBwnBAFJRhkSsC
        bFhTfLkYe/xf0TCVC5gSsa7n9ieuCts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-87jVByZNPiWTGCSPHgxHhA-1; Wed, 19 Aug 2020 14:00:23 -0400
X-MC-Unique: 87jVByZNPiWTGCSPHgxHhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569C2186A562;
        Wed, 19 Aug 2020 18:00:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A765110013C4;
        Wed, 19 Aug 2020 18:00:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 07/10] mm/memory_hotplug: simplify page onlining
Date:   Wed, 19 Aug 2020 19:59:54 +0200
Message-Id: <20200819175957.28465-8-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't allow to offline memory with holes, all boot memory is online,
and all hotplugged memory cannot have holes.

We can now simplify onlining of pages. As we only allow to online/offline
full sections and sections always span full MAX_ORDER_NR_PAGES, we can just
process MAX_ORDER - 1 pages without further special handling.

The number of onlined pages simply corresponds to the number of pages we
were requested to online.

While at it, refine the comment regarding the callback not exposing all
pages to the buddy.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0011a1115381c..3aba0d956f9b1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -617,31 +617,22 @@ void generic_online_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(generic_online_page);
 
-static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
-			void *arg)
+static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn;
-	int order;
 
 	/*
-	 * Online the pages. The callback might decide to keep some pages
-	 * PG_reserved (to add them to the buddy later), but we still account
-	 * them as being online/belonging to this zone ("present").
+	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
+	 * decide to not expose all pages to the buddy (e.g., expose them
+	 * later). We account all pages as being online and belonging to this
+	 * zone ("present").
 	 */
-	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
-		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
-		/* __free_pages_core() wants pfns to be aligned to the order */
-		if (WARN_ON_ONCE(!IS_ALIGNED(pfn, 1ul << order)))
-			order = 0;
-		(*online_page_callback)(pfn_to_page(pfn), order);
-	}
+	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
+		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
 
 	/* mark all involved sections as online */
 	online_mem_sections(start_pfn, end_pfn);
-
-	*(unsigned long *)arg += nr_pages;
-	return 0;
 }
 
 /* check which state of node_states will be changed when online memory */
@@ -795,7 +786,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       int online_type, int nid)
 {
 	unsigned long flags;
-	unsigned long onlined_pages = 0;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 	int ret;
@@ -831,19 +821,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}
 
-	ret = walk_system_ram_range(pfn, nr_pages, &onlined_pages,
-		online_pages_range);
-	if (ret) {
-		/* not a single memory resource was applicable */
-		if (need_zonelists_rebuild)
-			zone_pcp_reset(zone);
-		goto failed_addition;
-	}
-
-	zone->present_pages += onlined_pages;
+	online_pages_range(pfn, nr_pages);
+	zone->present_pages += nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages += onlined_pages;
+	zone->zone_pgdat->node_present_pages += nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	/*
-- 
2.26.2

