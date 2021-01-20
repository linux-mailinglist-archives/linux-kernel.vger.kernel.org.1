Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6E2FCA26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhATEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727425AbhATEyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611118355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=65zblkXRNcqXjUu30/0eBPVZ8NrtZSSKQfb2vGn4/YE=;
        b=YCA9EsJoAaddHnkofmozbTVbBoj+bmlGO+IuxYONflzuykq79nqYSSxOj6F+PWeKSdvDt8
        3Um+JPUWYcGHJ4QTK0eBcbv4a/rzZUcrjWeKRx6O//6b/bIBoCTemg27fwMjbmpU0mBv+S
        vfPxIZn5ARop6U75oltO0dVEl7NKILc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-e7CY8Bj6NI2BaMikhOC6Rw-1; Tue, 19 Jan 2021 23:52:32 -0500
X-MC-Unique: e7CY8Bj6NI2BaMikhOC6Rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C7351005504;
        Wed, 20 Jan 2021 04:52:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 276D27092B;
        Wed, 20 Jan 2021 04:52:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v4 3/4] mm: simplify parameter of setup_usemap()
Date:   Wed, 20 Jan 2021 12:52:12 +0800
Message-Id: <20210120045213.6571-4-bhe@redhat.com>
In-Reply-To: <20210120045213.6571-1-bhe@redhat.com>
References: <20210120045213.6571-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter 'zone' has got needed information, let's remove other
unnecessary parameters.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbb67d9c1b2a..69cf19baac12 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6761,25 +6761,22 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
 	return usemapsize / 8;
 }
 
-static void __ref setup_usemap(struct pglist_data *pgdat,
-				struct zone *zone,
-				unsigned long zone_start_pfn,
-				unsigned long zonesize)
+static void __ref setup_usemap(struct zone *zone)
 {
-	unsigned long usemapsize = usemap_size(zone_start_pfn, zonesize);
+	unsigned long usemapsize = usemap_size(zone->zone_start_pfn,
+					       zone->spanned_pages);
 	zone->pageblock_flags = NULL;
 	if (usemapsize) {
 		zone->pageblock_flags =
 			memblock_alloc_node(usemapsize, SMP_CACHE_BYTES,
-					    pgdat->node_id);
+					    zone_to_nid(zone));
 		if (!zone->pageblock_flags)
 			panic("Failed to allocate %ld bytes for zone %s pageblock flags on node %d\n",
-			      usemapsize, zone->name, pgdat->node_id);
+			      usemapsize, zone->name, zone_to_nid(zone));
 	}
 }
 #else
-static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
-				unsigned long zone_start_pfn, unsigned long zonesize) {}
+static inline void setup_usemap(struct zone *zone) {}
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
@@ -6974,7 +6971,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 			continue;
 
 		set_pageblock_order();
-		setup_usemap(pgdat, zone, zone_start_pfn, size);
+		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
 		memmap_init_zone(zone);
 	}
-- 
2.17.2

