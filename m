Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE72DF473
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLTI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbgLTI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608452910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=G6aWyCslmxLP7ODhCz+X7C8SvlMRFnnUzbWQk6otugg=;
        b=d6GHzs/T2iS+MD0WFjuMpc6y79mFacwtCQceJOv2F1Gsvf7ZnxCBaUKpfGTqRhg2B4jqkh
        s8epA2BsnBmFeJawhLjaytiUga/47DahtR7aO8wavLPBKt2X2TL2XRnpkwsRX6q4zWZwy8
        URvKeoE83ibR2XDWGHZZOUf9/O5JPOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-y-fGJi0YPCSXyWvApYLK0g-1; Sun, 20 Dec 2020 03:28:26 -0500
X-MC-Unique: y-fGJi0YPCSXyWvApYLK0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E19F5801817;
        Sun, 20 Dec 2020 08:28:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D92A60C13;
        Sun, 20 Dec 2020 08:28:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v2 5/5] mm: remove unneeded local variable in free_area_init_core
Date:   Sun, 20 Dec 2020 16:27:54 +0800
Message-Id: <20201220082754.6900-6-bhe@redhat.com>
In-Reply-To: <20201220082754.6900-1-bhe@redhat.com>
References: <20201220082754.6900-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'zone_start_pfn' is not needed since there's only
one call site in free_area_init_core(). Let's remove it and pass
zone->zone_start_pfn directly to init_currently_empty_zone().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7f0a917ab858..189a86253c93 100644
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

