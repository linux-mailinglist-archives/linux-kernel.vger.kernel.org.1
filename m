Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1E27DDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgI3Bio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3Bio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:38:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB32C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:31:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so31503pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DyzvGQRgkqDsF+X+CX3vPxTw0WIAL5D2XuRcOuAc4xo=;
        b=pX1GRBAXoHZ294HJxVuOebU71Irl2z/i6EhF+JFIKQXcDHkUlOHRFoz9mXbmBZkHGW
         Bknh8LXvVhGpWzzshCbMGRFvVBfIgdalUIxxkpw/Gy0BesclDgpAs0WAOYr4U/E2lC/o
         gt0Dmo0l3ye4fx+Wqsj8lpKsK8yG1BAAs/yYTWznE/NRDD6u0IDlWfS7bgo146DR6q8F
         3zunEJE1RkXB8/G5rr7FVzKwmcd1ZuXBhpNhsv85kbU6UGjb91m0ykUnXg/fTeYNqzd2
         Wccn04GpYvrhh4DRAfnOTOdZYCBS1Nr0/bwPuZamvHo+vVtBW1brS+N8i0pn6EHvuD0V
         J/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DyzvGQRgkqDsF+X+CX3vPxTw0WIAL5D2XuRcOuAc4xo=;
        b=I3rbpOort1ac26QgUiJiqQBEzYBCBKxtO49ooNXKAT//gghlF5tVv7hoYEBXaV4de8
         sOshCdHidHEoIF0yOyz9VLZKwcZwI6+P11jLngLiFZlHdSVprKfBcraoo6ks4e6xjnAg
         OXBcr9oqgIRSUb8dxxC5G8YSREddab/QkuqDv3i5usaOeJAXP5bHohz2pKx6oYQE7ZFm
         3HnW9O9yXPjJwl/JS42Gq7MBpZZYzDXAJkfi4ohHpbIS1akhu5zA/FEPsL3gNRCzqFRz
         2Jhfydpdx/Zc0fi2feMi41Z6BqNRewhFxvXgVNzrz7uTLH6GQ+Gy824KRH4im4n9pbxh
         NEuw==
X-Gm-Message-State: AOAM5327E9fFuXpc1iVfJ0xrtrEkj9c9+ZNhR7gVrSojFiaVu24gJ5nG
        xqsQOw8yDkjEt2YiMy3EjPE=
X-Google-Smtp-Source: ABdhPJx8gbnV2CM4viPMAxO6Lwqn0e/60csThe60GabGRgEqHTXnKmWE4QRrExgGDLf/Eer3UPuzRg==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr279237pgb.436.1601429487994;
        Tue, 29 Sep 2020 18:31:27 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q4sm6929491pfs.193.2020.09.29.18.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 18:31:27 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 for v5.9] mm/page_alloc: handle a missing case for memalloc_nocma_{save/restore} APIs
Date:   Wed, 30 Sep 2020 10:31:12 +0900
Message-Id: <1601429472-12599-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

memalloc_nocma_{save/restore} APIs can be used to skip page allocation
on CMA area, but, there is a missing case and the page on CMA area could
be allocated even if APIs are used. This patch handles this case to fix
the potential issue.

For now, these APIs are used to prevent long-term pinning on the CMA page.
When the long-term pinning is requested on the CMA page, it is migrated to
the non-CMA page before pinning. This non-CMA page is allocated by using
memalloc_nocma_{save/restore} APIs. If APIs doesn't work as intended,
the CMA page is allocated and it is pinned for a long time. This long-term
pin for the CMA page causes cma_alloc() failure and it could result in
wrong behaviour on the device driver who uses the cma_alloc().

Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
specified.

Fixes: 8510e69c8efe (mm/page_alloc: fix memalloc_nocma_{save/restore} APIs)
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97..b5a3f18 100644
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
@@ -3381,7 +3388,13 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	do {
 		page = NULL;
-		if (alloc_flags & ALLOC_HARDER) {
+		/*
+		 * order-0 request can reach here when the pcplist is skipped
+		 * due to non-CMA allocation context. HIGHATOMIC area is
+		 * reserved for high-order atomic allocation, so order-0
+		 * request should skip it.
+		 */
+		if (order > 0 && alloc_flags & ALLOC_HARDER) {
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 			if (page)
 				trace_mm_page_alloc_zone_locked(page, order, migratetype);
-- 
2.7.4

