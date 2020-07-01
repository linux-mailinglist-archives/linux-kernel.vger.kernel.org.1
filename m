Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9B210EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgGAPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgGAPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:16:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:16:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so10950408pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eVlqeH2RPGiO//aNy97j7YSMfcTUz/bRuiejQQ3tzco=;
        b=gyHvDK7N8y1vSsK2b/voB3mWUua5SLMvIaWVofrSLiBjYpwKxfDljXgiipx92z7Ews
         TsPTlzsAYjsQ9s8/YtpFXwMYGV5BE90kIfkSvOR/lIRsrB5HJzUOPICViB1xg/cytIeK
         mm+NVX/C0mBVjyuLH97p5Q+WY30lvXPtAQLjqljHPOODXD0Sy1FijFMO5jcu8Im9Bknj
         EkDIfjTWtupw4N01IBHft8QmhcfzyPw9cvZUZgBGkBpxsY+y+a9BU86YdrNjElWvhqx/
         E5iCtoY9GAoa6hzVGfWo5s4qUOsQN5R4CmLgTnI1Y4bzQiPvC25x9rfO8Roe23HnSEOK
         CvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eVlqeH2RPGiO//aNy97j7YSMfcTUz/bRuiejQQ3tzco=;
        b=tv3M8mSqtkymzxLTFh/clFNlAOu0tB8UzHcnkNQeGfAn3zXbE/tCALCT+PJ5DZvD0/
         CVFoBnggqeNQAUQyuQtseHjaQ7J+/7W6OsOS4HtCTaHVl/XLOhd6ABmvpTydC7iI0bfV
         dIZoxhLMB823sxC4FH7SGJtzZwRFNGet/kKkjZJak5SD0Gkyrm6MGjT3a4RSwzQ7cHd5
         V+OE/VD/NjPu3N1rT6sH1ueo1AULpsBNrK7xl5AS/1r8uqSMWYEMFdtv2WIYijxnIRKQ
         6VTLl+PdxWTtaTpPwmK8YSTxjyTZvoh/HXOOREgxAmK1Wn6niHfvxMuJYkyGpUHFjJm+
         7diw==
X-Gm-Message-State: AOAM533PrThHblr32zECIdCgxEDqfLhEOr3jqNNGwv0Xm/GujjPzazov
        SSnPLdYF+Xm2aDaLCsB661w=
X-Google-Smtp-Source: ABdhPJxPoMJstucPR3aT6Ma+CfxIkoeKgGHjY74VMAXq/rqV58BY+HM5FJSE3nxyvKcUS7ZLZeLSGg==
X-Received: by 2002:a63:5915:: with SMTP id n21mr20616538pgb.323.1593616619461;
        Wed, 01 Jul 2020 08:16:59 -0700 (PDT)
Received: from localhost ([144.34.187.180])
        by smtp.gmail.com with ESMTPSA id z2sm6499339pfq.67.2020.07.01.08.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2020 08:16:58 -0700 (PDT)
Date:   Wed, 1 Jul 2020 15:16:45 +0000
From:   Long Li <lonuxli.64@gmail.com>
To:     willy@infradead.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages in
 kmalloc_order
Message-ID: <20200701151645.GA26223@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc cannot allocate memory from HIGHMEM.  Allocating large amounts
of memory currently bypasses the check and will simply leak the memory
when page_address() returns NULL.  To fix this, factor the
GFP_SLAB_BUG_MASK check out of slab & slub, and call it from
kmalloc_order() as well. In order to make the code clear, the warning
message is put in one place.

Signed-off-by: Long Li <lonuxli.64@gmail.com>
---

changes in V3:
-Put the warning message in one place
-updage the change log to be clear

 mm/slab.c        | 10 +++-------
 mm/slab.h        |  1 +
 mm/slab_common.c | 17 +++++++++++++++++
 mm/slub.c        |  9 ++-------
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ac7a223d9ac3..2850fe3c5fb8 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2573,13 +2573,9 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_invalid_flags(flags);
+
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slab.h b/mm/slab.h
index a06f3313e4a0..ab172dca8ce2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -90,6 +90,7 @@ void create_kmalloc_caches(slab_flags_t);
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 #endif
 
+gfp_t kmalloc_invalid_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a143a8c8f874..85a16e323906 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -26,6 +26,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/kmem.h>
 
+#include "internal.h"
+
 #include "slab.h"
 
 enum slab_state slab_state;
@@ -805,6 +807,18 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 }
 #endif /* !CONFIG_SLOB */
 
+gfp_t kmalloc_invalid_flags(gfp_t flags)
+{
+	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
+
+	flags &= ~GFP_SLAB_BUG_MASK;
+	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+			invalid_mask, &invalid_mask, flags, &flags);
+	dump_stack();
+
+	return flags;
+}
+
 /*
  * To avoid unnecessary overhead, we pass through large allocation requests
  * directly to the page allocator. We use __GFP_COMP, because we will need to
@@ -815,6 +829,9 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	void *ret = NULL;
 	struct page *page;
 
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_invalid_flags(flags);
+
 	flags |= __GFP_COMP;
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
diff --git a/mm/slub.c b/mm/slub.c
index 62d2de56549e..039045211df9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1817,13 +1817,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_invalid_flags(flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.17.1

