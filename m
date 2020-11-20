Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3452BB20E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgKTSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728498AbgKTSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605895507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cu8qL4szNEU63B2IWzbd6iRbLN7eMN3hJgKQ47FTKLo=;
        b=YBXhbNOMF7R8XZUnKAIZolS3WnxcS2Qbut6IatBu6wm2FBLApWVqnFStjQSM0BrqOpUp9/
        9IemcP9WATFSFLsXOPuibQvkXtgVysg2SM4RgUTuH/Bgnn9yLyvCd9mY+cmd0qTjwwHdKF
        jDGTQrwNHe902EkEYO1/vDFjhS9N6ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-GBRKpMGgPgSbCSLOwRc5XQ-1; Fri, 20 Nov 2020 13:05:02 -0500
X-MC-Unique: GBRKpMGgPgSbCSLOwRc5XQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B84010151E7;
        Fri, 20 Nov 2020 18:05:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B43CE5D6AD;
        Fri, 20 Nov 2020 18:04:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] mm/page_alloc: clear all pages in post_alloc_hook() with init_on_alloc=1
Date:   Fri, 20 Nov 2020 19:04:52 +0100
Message-Id: <20201120180452.19071-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
leaving the buddy via alloc_pages() and friends to be
initialized/cleared/zeroed on allocation.

However, the same logic is currently not applied to
alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
with init_on_alloc=1 and init_on_free=0. Let's also properly clear
pages on that allocation path.

To achieve that, let's move clearing into post_alloc_hook(). This will not
only affect alloc_contig_pages() allocations but also any pages used as
migration target in compaction code via compaction_alloc().

While this sounds sub-optimal, it's the very same handling as when
allocating migration targets via alloc_migration_target() - pages will
get properly cleared with init_on_free=1. In case we ever want to optimize
migration in that regard, we should tackle all such migration users - if we
believe migration code can be fully trusted.

With this change, we will see double clearing of pages in some
cases. One example are gigantic pages (either allocated via CMA, or
allocated dynamically via alloc_contig_pages()) - which is the right
thing to do (and to be optimized outside of the buddy in the callers) as
discussed in:
  https://lkml.kernel.org/r/20201019182853.7467-1-gpiccoli@canonical.com

This change implies that with init_on_alloc=1
- All CMA allocations will be cleared
- Gigantic pages allocated via alloc_contig_pages() will be cleared
- virtio-mem memory to be unplugged will be cleared. While this is
  suboptimal, it's similar to memory balloon drivers handling, where
  all pages to be inflated will get cleared as well.
- Pages isolated for compaction will be cleared

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This is the follow-up of:
  "[PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages() with
  init_on_alloc=1 or __GFP_ZERO"

v1 -> v2:
- Let's clear anything that leaves the buddy, also affecting compaction.
- Don't implement __GFP_ZERO support for now

---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..108b81c0dfa8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2275,6 +2275,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	kasan_alloc_pages(page, order);
 	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
+
+	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
+		kernel_init_free_pages(page, 1 << order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
@@ -2282,9 +2285,6 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 {
 	post_alloc_hook(page, order, gfp_flags);
 
-	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
-		kernel_init_free_pages(page, 1 << order);
-
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
-- 
2.26.2

