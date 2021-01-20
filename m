Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125ED2FCA25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbhATEyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbhATEyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611118356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V4MAmW9o9TEkOOmhJwAHh/aM9Qgr24vL7t9KpVWFRYk=;
        b=CPGFFj5swBTf4CsKcd69nH04Y2P8Z8RlJTRidqfFRnCVL4Z6d8XMuRx2Bg/lr9sH14CgHZ
        kq6HxyI7f32X9cGGl2mknQ0R09z2Omo/bqAOeAAdWNHCkFiG6rjvAPUfrPy1PN2HnyylBj
        GT7x5Lv7FuS8ZLWe5ki1mtTgo0E/8YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-XXBuItvKPXCIvTiEkUVjrA-1; Tue, 19 Jan 2021 23:52:34 -0500
X-MC-Unique: XXBuItvKPXCIvTiEkUVjrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3302801817;
        Wed, 20 Jan 2021 04:52:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEBE660D11;
        Wed, 20 Jan 2021 04:52:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v4 4/4] mm: remove unneeded local variable in free_area_init_core
Date:   Wed, 20 Jan 2021 12:52:13 +0800
Message-Id: <20210120045213.6571-5-bhe@redhat.com>
In-Reply-To: <20210120045213.6571-1-bhe@redhat.com>
References: <20210120045213.6571-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

