Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF82FFB52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbhAVDnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbhAVDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1DC061353
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:38:01 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so3969321qkm.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=QQ8+VWijc/yAWwdAGJiQAVGLSbr2QH6gQ7nJa0fZ29rqha6kVEV4Tn1Wn/RF+EF0N2
         ia7uZK/DGFoMKCqy8hMwTwjULmLMiVTu8+/u9vHIAG5QdyYOeLY04RyS+hFRmfWGGpWB
         kv8RX6M8Dwx0UotH3Laxo94jaM8AYDSrRw379UkUmBC2yGNT7za2V2mVhPEKCQvIZrCR
         82eSdwcQrY+yzusg6u7PVzqBY+kaTDsy8HsUMIH84qMEFHCdth103OK5ng25OVdNZKCc
         wQFaZsHPIjZngIiprFp2d/HogCh02iivfg3T80DvVqsLYuI2bjP3WTwpL+p4NKjlX6Xc
         NY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=PQ27dDOnVbKgfKGwA01h34euYBSB0+D4e+XYK0pGrjPNQKwoyTiTzGh4+oZAMWgesR
         suQC0SPBnqbyzV1fFEqvvUCDBPKmuiYsIweJOGPhtgddwF5/Bh949Y0D0/SfDcvqiIYd
         I8HCCbNBrSsZsHeobE1K0/NVhYzApkBmlzXdXiNqxbWfv1mMm8cWTARGwbme4zlMN1Py
         dSOPzPM/QC1+cPfDffrrmLZzmV8LtiLq4gBQxZFpIJH2TeylmJOPhhLsgwB9u/JaFD8z
         S4DjK3i/DguCaViiU6L3yecaDedgnyUlLXQjsHvEM+wkVJPJfW8YKJD/83QiPxxKJkQU
         zx6A==
X-Gm-Message-State: AOAM5320AnuiETF+MvsHarF1k2kEszCItkxNuydOHiOZKGQDU5vcFnAs
        IKWZYXjM3JACg9VrddaGhsHztg==
X-Google-Smtp-Source: ABdhPJxJ7MxgQzJjGlvCgCXRTmo+0vyGi0SRsSyNOon5zLKQWhZZVvEGOfk+yAAx4jKG8i3uKLqxQA==
X-Received: by 2002:ae9:c013:: with SMTP id u19mr3041084qkk.59.1611286680459;
        Thu, 21 Jan 2021 19:38:00 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:37:59 -0800 (PST)
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
Subject: [PATCH v7 06/14] mm: apply per-task gfp constraints in fast path
Date:   Thu, 21 Jan 2021 22:37:40 -0500
Message-Id: <20210122033748.924330-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
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
index f92d7c810953..c93e801a45e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4981,6 +4981,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
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
@@ -4996,13 +5003,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
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

