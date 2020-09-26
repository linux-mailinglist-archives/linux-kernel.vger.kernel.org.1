Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B18279A02
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgIZOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIZOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:14:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9B3C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 07:14:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h15so4526762pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=m/uDDlgpBgXWW89xazDHWjz3boz0toRZLi7D2ESN7XU=;
        b=BgE/DG1KpovclMjH/nTyDFh0Pcc7770NEJg1GXpBCY8DWnT2MQJTbbknkYr5PCPPqh
         oUepBgYmeWNUs1Ug1BSEDn99PRdALVsQcAjW4Cywni4dFvrvLR4kF4xNedDEEePVeNgQ
         kFjo9wMXms2AKceIKndrDMYOxX0o4qb8IRtRXCDsnTNt3gv0cGQrNEgus5WOUp0X2a0P
         4gNszvDQ1WF1sDWi4o8np+s3NNZ6ax7WIqldys9kchvWOFgH3waBfWDKLmBhoe4sZPLN
         1zkXZyTxfL4sEx4c5VxvVPTjoN8taF8UfEzvvaHrDyjbEWtQCD7slnhYCV6KsZzbmwpb
         KSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=m/uDDlgpBgXWW89xazDHWjz3boz0toRZLi7D2ESN7XU=;
        b=GZXpEpnsR0b4Q5eaxasThBeTG1SwBIgsz1Gu8ekoCc8t81kCOZejHhBXXnme5LW8JH
         Sqm0l5TTAo2rW/vDdS2sY/cEYTmKs2AhavxEm3DXZIXW91z/3FGXKl/G23QA/dkcbSg1
         q6How+0Li7J3fKRQgbLsLz/XvInEeLPeZe7CDenQGyd2KmadoZUYWsnTipWECP0MtICS
         ss1GX3rgXodDOO8L3+50s/piml/HIrpO0jHXc6tEqYrALASE7EQC7M+4r6xbSeT7useF
         snu9KSDESjRQ0ZMazxx2/NMfmyif+RHFOyRhWKMlcFB0glC2cLnnS1+tsSUawwcX2f5w
         3u8A==
X-Gm-Message-State: AOAM530CKZkFaZQhArMMbXwYvfJ9JAOnHcTm7bqjo58KF3ET1vvF7HTr
        G974zt0BV/tBfVRv0+rfxuyzMXfhcU6R3Q==
X-Google-Smtp-Source: ABdhPJwjnrF1UPRWbzIMd9eg+ICsfjh1JD/aM1fOQp8CRlWO1qsSKd+RnRtXepsbMut5ZHm26nKmH3jvVjQOvw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee8:36f0])
 (user=shakeelb job=sendgmr) by 2002:a63:f342:: with SMTP id
 t2mr2912320pgj.313.1601129646924; Sat, 26 Sep 2020 07:14:06 -0700 (PDT)
Date:   Sat, 26 Sep 2020 07:13:41 -0700
Message-Id: <20200926141341.785180-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] mm: slab: fix potential double free in ___cache_free
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
kmem_caches for all allocations"), it becomes possible to call kfree()
from the slabs_destroy(). The functions cache_flusharray() and
do_drain() calls slabs_destroy() on array_cache of the local CPU without
updating the size of the array_cache. This enables the kfree() call from
the slabs_destroy() to recursively call cache_flusharray() which can
potentially call free_block() on the same elements of the array_cache of
the local CPU and causing double free and memory corruption.

To fix the issue, simply update the local CPU array_cache cache before
calling slabs_destroy().

Fixes: 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Tested-by: Ming Lei <ming.lei@redhat.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
---
 mm/slab.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3160dff6fd76..f658e86ec8ce 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1632,6 +1632,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct page *page)
 		kmem_cache_free(cachep->freelist_cache, freelist);
 }
 
+/*
+ * Update the size of the caches before calling slabs_destroy as it may
+ * recursively call kfree.
+ */
 static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
 {
 	struct page *page, *n;
@@ -2153,8 +2157,8 @@ static void do_drain(void *arg)
 	spin_lock(&n->list_lock);
 	free_block(cachep, ac->entry, ac->avail, node, &list);
 	spin_unlock(&n->list_lock);
-	slabs_destroy(cachep, &list);
 	ac->avail = 0;
+	slabs_destroy(cachep, &list);
 }
 
 static void drain_cpu_caches(struct kmem_cache *cachep)
@@ -3402,9 +3406,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 	}
 #endif
 	spin_unlock(&n->list_lock);
-	slabs_destroy(cachep, &list);
 	ac->avail -= batchcount;
 	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
+	slabs_destroy(cachep, &list);
 }
 
 /*
-- 
2.28.0.681.g6f77f65b4e-goog

