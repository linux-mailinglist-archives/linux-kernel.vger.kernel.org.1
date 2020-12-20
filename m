Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF72DF472
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgLTI3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgLTI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608452907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=dqF3OKhxr17IUwJ34K5airZU1BciWL9ISo9Hcrx3KMk=;
        b=HncEORnOxJir6/9C+VngWXyhoHo6Gp9VhSo6y4GcnhWowRmwElhqlYs7n0RE7VR1JrBshL
        bTFXeDlKQdYUr51BigcSy34XBUX1gss0IeZf9/SyDorQNV/1bHACRw1ENkPJfup7aa+9YR
        kpN6T9F60qUDNGGlKdhGM+BLCj4f1L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-tN_ja1CHN8uybVLa_kf2Lg-1; Sun, 20 Dec 2020 03:28:23 -0500
X-MC-Unique: tN_ja1CHN8uybVLa_kf2Lg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00912801817;
        Sun, 20 Dec 2020 08:28:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3934D60C13;
        Sun, 20 Dec 2020 08:28:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v2 4/5] mm: simplify parameter of setup_usemap()
Date:   Sun, 20 Dec 2020 16:27:53 +0800
Message-Id: <20201220082754.6900-5-bhe@redhat.com>
In-Reply-To: <20201220082754.6900-1-bhe@redhat.com>
References: <20201220082754.6900-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter 'zone' has got needed information, let's remove other
unnecessary parameters.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a6626351ed7..7f0a917ab858 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6824,25 +6824,22 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
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
@@ -7037,7 +7034,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 			continue;
 
 		set_pageblock_order();
-		setup_usemap(pgdat, zone, zone_start_pfn, size);
+		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
 		memmap_init_zone(zone);
 	}
-- 
2.17.2

