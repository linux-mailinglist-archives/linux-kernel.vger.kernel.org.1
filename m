Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387A52EA624
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhAEHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbhAEHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609832854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=XIQjm85waNu2DaAUZ4nRwaahypJ7KcL7+iJQfZLah8o=;
        b=Ca5TnoUw2kq1U9qnaP8DKoOJSeTAjjXBLtcRKYbHL/EQWflnC3PpsPiDBk9wxzDGkOTF1Z
        3mob7y8U7EydpQD6U9L50gIgXaxnW3l4gpaJSQ+NJYnWPCvqhnNtJGJcKLb2Nc+F2+XltH
        CrtRmZk2zo1vKsZFAbnDdp7TVGUPvsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-VOn2FcFUM2Ok6SKyXak3Fw-1; Tue, 05 Jan 2021 02:47:31 -0500
X-MC-Unique: VOn2FcFUM2Ok6SKyXak3Fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8AF107ACF8;
        Tue,  5 Jan 2021 07:47:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-56.pek2.redhat.com [10.72.13.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52A9871C91;
        Tue,  5 Jan 2021 07:47:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v3 4/4] mm: remove unneeded local variable in free_area_init_core
Date:   Tue,  5 Jan 2021 15:47:08 +0800
Message-Id: <20210105074708.18483-5-bhe@redhat.com>
In-Reply-To: <20210105074708.18483-1-bhe@redhat.com>
References: <20210105074708.18483-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'zone_start_pfn' is not needed since there's only
one call site in free_area_init_core(). Let's remove it and pass
zone->zone_start_pfn directly to init_currently_empty_zone().

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e0ce6fb6373b..9cacb8652239 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6986,7 +6986,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, freesize, memmap_pages;
-		unsigned long zone_start_pfn = zone->zone_start_pfn;
 
 		size = zone->spanned_pages;
 		freesize = zone->present_pages;
@@ -7035,7 +7034,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 
 		set_pageblock_order();
 		setup_usemap(zone);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
+		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
 		memmap_init_zone(zone);
 	}
 }
-- 
2.17.2

