Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF02FC75B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 03:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbhATCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 21:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbhATBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:45:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4508C0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:46 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c1so15280778qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9lkuj952gZlf+x4X5uCEePkXus+rlNAKcNGEDA8YLvg=;
        b=Q0t8MucHzq07VAgjOeBxpDDYsIE7Lmts5Ml510aZJoJ9FO9ueC3634JdHUzWUpTg2H
         SBn+aXqjlgiZK/8Cka3C65kmtm8+IgTgGF/w86ZboFD4soI4I1ony+ohgZRyvn3NQPyb
         fFOo/5o7kL21OqGDNNBWoYnQqUSQ1JtcIHfNVxmiuK341+aI7pJaSeWYlJUZhghZ4XQR
         6274sBYSUco4VGWEx8T71ToUSAzmngBf8l9EAn9nSdU0fnUH25IW4MQvMc7JD+9l7vNt
         j9LvNCPuAOc0gFsRn3sCKNevjWnO6cSTY9wu37CzEzRJ5yGXcmSooQ+xqCQKohs2rAHF
         svNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lkuj952gZlf+x4X5uCEePkXus+rlNAKcNGEDA8YLvg=;
        b=MzkJidamwhR/TYKiWejyPG1zwTrdticcO9jkNim3GFFa2Mvhk+/LjVzjbzYvteuaKR
         dac4Shq74xsU5thgK45zABmCMgUEthWm+IRTsi9IT85rSd+mTtvc+r/46MZWU0HqVAkb
         KSbRBXzxhYNrhAj/LKk3oYQbWkHZPCzbzHzs6g8TwMd02KusVtyrbERp+w88s0uGEbf7
         Y2dPmKjtNWigxF9jMsAWIoi8Wr0wOkCMdfrMIg7j5VE74htmA6PA4vKxT4o/+4vmsWdU
         4IO/kL5Fai6Z0hN1rIO8jTZ2i8GyDxaRVKHDdeePk2jcKl0DBcS5tAdHlmEtKU7bO63V
         iItQ==
X-Gm-Message-State: AOAM530xbXk2QjxFMaIoEHZUVryz2fv5U7spuU/0YdDe1H6gjubjXOwi
        okgj0BTRpQUs6wxTP1Sms36/NLQQdIaOlA==
X-Google-Smtp-Source: ABdhPJxd4TBlTzGSVJy47qSy922MRq4TG3PdZv3O1/O9T6C2P7ICFr5jCeJguegPDpQDKG0RiMFxsA==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr6695551qtw.186.1611107025776;
        Tue, 19 Jan 2021 17:43:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:45 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 06/14] mm: apply per-task gfp constraints in fast path
Date:   Tue, 19 Jan 2021 20:43:25 -0500
Message-Id: <20210120014333.222547-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function current_gfp_context() is called after fast path. However, soon we
will add more constraints which will also limit zones based on context.
Move this call into fast path, and apply the correct constraints for all
allocations.

Also update .reclaim_idx based on value returned by current_gfp_context()
because it soon will modify the allowed zones.

Note:
With this patch we will do one extra current->flags load during fast path,
but we already load current->flags in fast-path:

__alloc_pages_nodemask()
 prepare_alloc_pages()
  current_alloc_flags(gfp_mask, *alloc_flags);

Later, when we add the zone constrain logic to current_gfp_context() we
will be able to remove current->flags load from current_alloc_flags, and
therefore return fast-path to the current performance level.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0114cdfe4aae..de9bcd08d002 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4979,6 +4979,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	}
 
 	gfp_mask &= gfp_allowed_mask;
+	/*
+	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
+	 * resp. GFP_NOIO which has to be inherited for all allocation requests
+	 * from a particular context which has been marked by
+	 * memalloc_no{fs,io}_{save,restore}.
+	 */
+	gfp_mask = current_gfp_context(gfp_mask);
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
@@ -4994,13 +5001,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
-	/*
-	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
-	 * resp. GFP_NOIO which has to be inherited for all allocation requests
-	 * from a particular context which has been marked by
-	 * memalloc_no{fs,io}_{save,restore}.
-	 */
-	alloc_mask = current_gfp_context(gfp_mask);
+	alloc_mask = gfp_mask;
 	ac.spread_dirty_pages = false;
 
 	/*
-- 
2.25.1

