Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FD2EA623
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhAEHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbhAEHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609832849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=b2U2nEqaOtojovkjXAeglzjCU2zPKv7iQLxjUumzErg=;
        b=Fmm6KucZj/W5CeqQGV5PkZaQSeqqMh2bhZGd4tr07DYIosvEtGwl2Fat/GOxr3vcGr/sTM
        UCbII3ekUPZFPGoGQkxzcIH8LFI/+JXGG0KuXBRHilxnSsehRZcbdgHxCjdMAg0hXAUISz
        lGgc5PSyYlhZuh1ws16FquQmsIhjRB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-CHXO33XYPL2TcSEPInJL1A-1; Tue, 05 Jan 2021 02:47:27 -0500
X-MC-Unique: CHXO33XYPL2TcSEPInJL1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C115859;
        Tue,  5 Jan 2021 07:47:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-56.pek2.redhat.com [10.72.13.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D6671CA1;
        Tue,  5 Jan 2021 07:47:24 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v3 3/4] mm: simplify parameter of setup_usemap()
Date:   Tue,  5 Jan 2021 15:47:07 +0800
Message-Id: <20210105074708.18483-4-bhe@redhat.com>
In-Reply-To: <20210105074708.18483-1-bhe@redhat.com>
References: <20210105074708.18483-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter 'zone' has got needed information, let's remove other
unnecessary parameters.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b2a46ffdaf0b..e0ce6fb6373b 100644
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

