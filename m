Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A393004C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbhAVOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728112AbhAVOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611324029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V4MAmW9o9TEkOOmhJwAHh/aM9Qgr24vL7t9KpVWFRYk=;
        b=FWlOQMhjMvlwuqq4ZDLcgJlI6VHXSYbCspTS1hqyF2ZxyWmPgeUzBGmvLMYn0VN4dGEELj
        AqJusSMKEneUtiYTwj+0XvpyqQBv670DCCgYXNzMyGsWIJxYBJdAX7UPJcYadLDkgqj3ct
        yzR4hLupsjNZU98Z4T97cJETSMGUq1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-6pvEWHQAOIiMiXMcOU5m5Q-1; Fri, 22 Jan 2021 09:00:27 -0500
X-MC-Unique: 6pvEWHQAOIiMiXMcOU5m5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4373D19611B3;
        Fri, 22 Jan 2021 14:00:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A096219C59;
        Fri, 22 Jan 2021 14:00:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com, lkp@intel.com
Subject: [PATCH v5 5/5] mm: remove unneeded local variable in free_area_init_core
Date:   Fri, 22 Jan 2021 21:59:56 +0800
Message-Id: <20210122135956.5946-6-bhe@redhat.com>
In-Reply-To: <20210122135956.5946-1-bhe@redhat.com>
References: <20210122135956.5946-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'zone_start_pfn' is not needed since there's only
one call site in free_area_init_core(). Let's remove it and pass
zone->zone_start_pfn directly to init_currently_empty_zone().

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69cf19baac12..e0df67948ace 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6923,7 +6923,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, freesize, memmap_pages;
-		unsigned long zone_start_pfn = zone->zone_start_pfn;
 
 		size = zone->spanned_pages;
 		freesize = zone->present_pages;
@@ -6972,7 +6971,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 
 		set_pageblock_order();
 		setup_usemap(zone);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
+		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
 		memmap_init_zone(zone);
 	}
 }
-- 
2.17.2

