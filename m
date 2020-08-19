Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5324A572
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHSSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:00:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgHSSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOExuJXVTjdqU9mIwAI96S5SS5cAxGCrzKqOGV5r8Ks=;
        b=C43H67C6BiSFNI7kGbgqiIRD2QoAl/el75FympF88RM/BfD6el+DxKRscpI1c7c+/2gdX7
        6QTvu2d2X7iAzKIiuJZM0cGMUD/eE3X+jha+tx3FpIK6dZhqUngeX3slQw91SNW7EHBDSN
        I1UY0T93SPoUs/ugzgIwiO6pC45i550=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-7aTDCCXwMpe_2xpoq45v4g-1; Wed, 19 Aug 2020 14:00:18 -0400
X-MC-Unique: 7aTDCCXwMpe_2xpoq45v4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE59807330;
        Wed, 19 Aug 2020 18:00:17 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FFFF10013C4;
        Wed, 19 Aug 2020 18:00:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 06/10] mm/page_isolation: simplify return value of start_isolate_page_range()
Date:   Wed, 19 Aug 2020 19:59:53 +0200
Message-Id: <20200819175957.28465-7-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers no longer need the number of isolated pageblocks. Let's
simplify.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 2 +-
 mm/page_isolation.c | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 098361fcb4504..0011a1115381c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1503,7 +1503,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
-	if (ret < 0) {
+	if (ret) {
 		reason = "failure to isolate range";
 		goto failed_removal;
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 03f585f95dc60..848664352dfe2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8456,7 +8456,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	ret = start_isolate_page_range(pfn_max_align_down(start),
 				       pfn_max_align_up(end), migratetype, 0);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/*
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 242c03121d731..b066c860e606e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -170,8 +170,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
  *
- * Return: the number of isolated pageblocks on success and -EBUSY if any part
- * of range cannot be isolated.
+ * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned migratetype, int flags)
@@ -179,7 +178,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	unsigned long undo_pfn;
 	struct page *page;
-	int nr_isolate_pageblock = 0;
 
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
@@ -193,10 +191,9 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 				undo_pfn = pfn;
 				goto undo;
 			}
-			nr_isolate_pageblock++;
 		}
 	}
-	return nr_isolate_pageblock;
+	return 0;
 undo:
 	for (pfn = start_pfn;
 	     pfn < undo_pfn;
-- 
2.26.2

