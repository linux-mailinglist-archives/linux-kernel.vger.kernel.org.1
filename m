Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21523B58C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgHDHYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:24:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729616AbgHDHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596525870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94kv3iM7voNuc/GuCMOJeaJASAgCqOV3S0igLlKUpuI=;
        b=XjERthes5LJ5fNy24jJ7isPbHSNGxuIjqLrFvMTPAcpInuZbXPb2Suzhx1VlL50J5duksx
        ltM+f2jHiCwiLvaEGsC2WbgfdQBYwE4vDTP4P+fQU7YEa30/bs+22q1mp7cELniL8FXoXZ
        xfJGAtkF4Vk4dWB6KtBLq+c8ZSrn/fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-L0jonywVOf-ICj5W3rU_kA-1; Tue, 04 Aug 2020 03:24:28 -0400
X-MC-Unique: L0jonywVOf-ICj5W3rU_kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A62818064DD;
        Tue,  4 Aug 2020 07:24:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A87215DA74;
        Tue,  4 Aug 2020 07:24:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v3 2/6] mm/page_alloc: tweak comments in has_unmovable_pages()
Date:   Tue,  4 Aug 2020 09:24:04 +0200
Message-Id: <20200804072408.5481-3-david@redhat.com>
In-Reply-To: <20200804072408.5481-1-david@redhat.com>
References: <20200804072408.5481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the split comment regarding bootmem allocations and memory
holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
check.

Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce2942..042ba09d70c5d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
 
-	/*
-	 * TODO we could make this much more efficient by not checking every
-	 * page in the range if we know all of them are in MOVABLE_ZONE and
-	 * that the movable zone guarantees that pages are migratable but
-	 * the later is not the case right now unfortunatelly. E.g. movablecore
-	 * can still lead to having bootmem allocations in zone_movable.
-	 */
-
 	if (is_migrate_cma_page(page)) {
 		/*
 		 * CMA allocations (alloc_contig_range) really need to mark
@@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 
 		page = pfn_to_page(pfn + iter);
 
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movablecore".
+		 */
 		if (PageReserved(page))
 			return page;
 
@@ -8306,14 +8304,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * it.  But now, memory offline itself doesn't call
 		 * shrink_node_slabs() and it still to be fixed.
 		 */
-		/*
-		 * If the page is not RAM, page_count()should be 0.
-		 * we don't need more check. This is an _used_ not-movable page.
-		 *
-		 * The problematic thing here is PG_reserved pages. PG_reserved
-		 * is set to both of a memory hole page and a _used_ kernel
-		 * page at boot.
-		 */
 		return page;
 	}
 	return NULL;
-- 
2.26.2

