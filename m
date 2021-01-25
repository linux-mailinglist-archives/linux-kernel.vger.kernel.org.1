Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C4302CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbhAYUmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbhAYTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:51:03 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E08C061354
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:48:04 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h21so6760772qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=R90VZ3vGcrRYvZbgV7azLdKs09oOeO1Lk8KPeEtI0CYo+B4Bw6mPEKxqL5eg56jNc9
         ZDrbez70bMDtoC6Od7HL0ftNoMEQ3peg7mRtVWsgG325a5PlRlbmKT7RHgvkhtOhId4d
         7dYEeW1LvOtO3oZjif6bi5MbAEz9No5RYl4KG4ubdRNqV0/tlyNZMriVg+YWst3j+WTZ
         PjO8GSotud/xnvOzQkGUVD0179zez9cw1bfDMJSQuTSACrGxlrSUyp4iYu0Ps2hw+Zuv
         dQq7Ilb7K8Fa+eF8jxWDHJeEvOyhu0eMMUe1CmjKngGzlok/qZkPzNDWJsDq0udh+T7i
         vr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhWP1P8Q7i9lD0EGpT6UypXh912bl/nwbH5yu3+aADs=;
        b=jI89YMX0sCH1tafw4th8WD+vFFnGt4USUNaCQi8/V9DImApERNptqSeD056gqgOfkb
         5dYEhwreHQehNjjfdNlrpivEE9csCyQKZ1vHhWrgeE90a9anAWvkUkWsXYEelI7VQzG7
         rv3KjsmFVpbUaiy+5mSn8tTRWo1l4Sqf20u8S2QzUo6LGNvPVy36VAXPlCLBP//gbxON
         hvWVD5s3XX1b4htaPj0AdEUGtVJBiq6z+H/utaq33fhFNc1L7qMwOGitQchsUxbUqUcb
         ukFb5QBOL0I2B2GVekV4wA4aieleSxTifUgOquza+CfRDZ0yE/Q21T5svFgzdk6SV8lw
         jwGQ==
X-Gm-Message-State: AOAM5319NbDvWvlN+608Mxfi1deCFLZsK4M/w1lnaU6a1ZTFUh9wY589
        JGnqfvxwPW+tVo7a21dyMteo2Q==
X-Google-Smtp-Source: ABdhPJy3QWGRlhCdTJ6t8Bl2AWaYHX6rqsFzWzOohroOr2+KwZLFlfWsdO5+EVfO+/raYzXEIL5oIA==
X-Received: by 2002:a0c:c688:: with SMTP id d8mr2432312qvj.8.1611604083512;
        Mon, 25 Jan 2021 11:48:03 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:48:02 -0800 (PST)
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
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v8 06/14] mm: apply per-task gfp constraints in fast path
Date:   Mon, 25 Jan 2021 14:47:43 -0500
Message-Id: <20210125194751.1275316-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
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

