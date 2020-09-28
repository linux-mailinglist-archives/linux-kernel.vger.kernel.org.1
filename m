Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7423A27A9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1Iu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1Iu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:50:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:50:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so350923pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZDjTmD8WXSKHMRbSqfZC1xkl/k+jJPbBPKscEUWmXVo=;
        b=e7SpeOXcZjEd+0h/T9A5Kh+HBS8aO8yWGksPOS+HWKr8Z0FYdq6kbJX84iBnUuhiew
         WJuWvYcmBSLsdNz5tydO4YuXjLZQ6b6DBVu/GD/REKE9aJrogSALKEvo9999IwtaWq7F
         Kd7qQoK12VhqhxHGog2JwChpo7jvDjM3pVB23IVl9rVOTS7eYZ0ZmASboAZKe5bOAQjh
         V/BIfo6LCdI2fCpwo88VkMlk0oDD4nvlBmqsRvHD0+L+9WutRkkcr8KRpND6WFzQyDn/
         7OPTOmCj6TyuY4OFnm/ucUtsz24f4jwxVNS49VQB8L5jXD1ZV0Ds01hqp8w0/hBvtbus
         vnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDjTmD8WXSKHMRbSqfZC1xkl/k+jJPbBPKscEUWmXVo=;
        b=UsKERWmDfm37Y5Tr9Xwd0nih6TTpJ6E8JO4RgKpM+Ij/aP9hBwIDocjFM4kYrP/OdR
         398jDVcYN24Gcg1AE62K/pFDkWtqfGjT/ASv9Kys58AQj2JQKujnsS21KJ7gx3YmG0JL
         OLUog385BtzZXtSMTjV3Nh/T6LOynbAJI8EgY3e75Y5z/8KRVFZlf60ebbqbF8Qs+hKN
         OgS/cgHgdxKF2DpQrwXeeSDDqnDv/dWBpbbdXCRWoIVlc/JTa+YaJv26SXMXbLqI8KIA
         lymqcxMcxAXfnYHy1TnByHywhyw42M9SFBGwMMOkvUwcr3BFBD6oc6DQ4IShZuOVViqu
         IXSQ==
X-Gm-Message-State: AOAM532O9zws4x2o7VZaYSCqnpjBB2RC2YnrbKNc5jcJJ6gVoQ0Gd09i
        2Q0uw1HICfW3v72j9qgoUnw=
X-Google-Smtp-Source: ABdhPJxQRM/bGZin9MRaO9UEh3gXWshfNO2JplvTsuCJwiLvJlWhunRZvrH4MjisGe9C6cDgaeE6Eg==
X-Received: by 2002:a62:1d51:0:b029:13e:d13d:a0fc with SMTP id d78-20020a621d510000b029013ed13da0fcmr9674568pfd.24.1601283058629;
        Mon, 28 Sep 2020 01:50:58 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id g26sm765251pfr.105.2020.09.28.01.50.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 01:50:57 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for memalloc_nocma_{save/restore} APIs
Date:   Mon, 28 Sep 2020 17:50:46 +0900
Message-Id: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

memalloc_nocma_{save/restore} APIs can be used to skip page allocation
on CMA area, but, there is a missing case and the page on CMA area could
be allocated even if APIs are used. This patch handles this case to fix
the potential issue.

Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
specified.

Fixes: 8510e69c8efe (mm/page_alloc: fix memalloc_nocma_{save/restore} APIs)
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97..104d2e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3367,9 +3367,16 @@ struct page *rmqueue(struct zone *preferred_zone,
 	struct page *page;
 
 	if (likely(order == 0)) {
-		page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
+		/*
+		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
+		 * we need to skip it when CMA area isn't allowed.
+		 */
+		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
+				migratetype != MIGRATE_MOVABLE) {
+			page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
 					migratetype, alloc_flags);
-		goto out;
+			goto out;
+		}
 	}
 
 	/*
@@ -3381,7 +3388,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	do {
 		page = NULL;
-		if (alloc_flags & ALLOC_HARDER) {
+		if (order > 0 && alloc_flags & ALLOC_HARDER) {
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 			if (page)
 				trace_mm_page_alloc_zone_locked(page, order, migratetype);
-- 
2.7.4

