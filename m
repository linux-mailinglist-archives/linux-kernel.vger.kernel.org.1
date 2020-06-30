Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72D20F71D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbgF3O1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 10:27:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388856AbgF3O06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593527217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1oWFzZRql4rEsDZi7pymoQzhYazF2IoWIrAEApG3l4=;
        b=iNFc5ZjPtfFXm0ueSl9IqpCp5cexT23l2gkJeMUcjjYCEHs8foEi7PCzwLQlTCHE1WD1fL
        Ez6p/9Z4WSAYv034zXVusYm9P6/3lxbUHKpFBaH3ekSojtR0BmXo4iKWiHQlJdWk5sFh/t
        p/rERyYJl/B1BWVChbQtEsC6whT1CCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-vvvtDriVMKizqzFs3goetA-1; Tue, 30 Jun 2020 10:26:55 -0400
X-MC-Unique: vvvtDriVMKizqzFs3goetA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BDA6107ACCA;
        Tue, 30 Jun 2020 14:26:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E26C282EF;
        Tue, 30 Jun 2020 14:26:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v1 3/6] mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
Date:   Tue, 30 Jun 2020 16:26:36 +0200
Message-Id: <20200630142639.22770-4-david@redhat.com>
In-Reply-To: <20200630142639.22770-1-david@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside has_unmovable_pages(), we have a comment describing how unmovable
data could end up in ZONE_MOVABLE - via "movable_core". Also, besides
checking if the first page in the pageblock is reserved, we don't
perform any further checks in case of ZONE_MOVABLE.

In case of memory offlining, we set REPORT_FAILURE, properly
dump_page() the page and handle the error gracefully.
alloc_contig_pages() users currently never allocate from ZONE_MOVABLE.
E.g., hugetlb uses alloc_contig_pages() for the allocation of gigantic
pages only, which will never end up on the MOVABLE zone
(see htlb_alloc_mask()).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 553b49a34cf71..02a01bff6b219 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -58,16 +58,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret) {
 		drain_all_pages(zone);
-	} else {
-		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-
-		if ((isol_flags & REPORT_FAILURE) && unmovable)
-			/*
-			 * printk() with zone->lock held will likely trigger a
-			 * lockdep splat, so defer it here.
-			 */
-			dump_page(unmovable, "unmovable page");
-	}
+	} else if ((isol_flags & REPORT_FAILURE) && unmovable)
+		/*
+		 * printk() with zone->lock held will likely trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(unmovable, "unmovable page");
 
 	return ret;
 }
-- 
2.26.2

