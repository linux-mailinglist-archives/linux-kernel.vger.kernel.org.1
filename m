Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1252EB8A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbhAFDsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAFDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:48:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAFC06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:47:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m5so887118pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=vJphBylUyfRBLd0KjwNu7dzrYLKUuRAIjJORmt8gKFM=;
        b=UADAf0v+riuXRh8QHcdOF92aLenvoNDIgspIEIhT0lmhAdhCE0imRB41B/rwuveGDX
         zFK4V8lOcHkFVg1ZlCAmAbAqkSI2nJ3BDOnLHiuiIQOWOOwDfECZB8OuILZPlB/t82nO
         Suzt75PVVGc61Byu+CU804jeS7X1YZPQxb5IxHxvIEuwT03XoX+1+FG4paLg8ZzoTk8r
         zXBErIbkxOi4Screg7dNZqRY1hwFxtH0O9FpVaInNMx4Rf4Igtkl7PueeLGRw7UNSzjO
         ehvruNgslMrnYBRpBvQi77sde6oLdOWWypyqFS98EPKz/hW0Pxd5YzIUkuQJfSfSccJr
         I6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=vJphBylUyfRBLd0KjwNu7dzrYLKUuRAIjJORmt8gKFM=;
        b=nLd4a89u8Cy6h7K5HzGaiZRWh/h8pcYlOF7bbcIbBuybV2YYUpo59+0xdjC85zR/O6
         NosHlrkeZJ+QP8Fe1JZqRkFbE1PzCSckI6o9giH64rWVAhOkUHjr0+g24Jyddx/4Sb1P
         LZvBJH05FfsmdeJDU8UeEki0xE//a7NSA8DbHLOaqh//UVu4LbYu5TcIZS7ayHmTa0pB
         f5afKRcRGR8gIjaaUwpH0EWTjl88rRnd+kiQ1yFTni01I95PNqZl5qKKUFhqFpEaviXE
         0ASMQTnw6u6i1W2SOn+g5MbvXKd3L5ffOZ+hQV2cgcT+3o1HDgtdIhJ85cIi+vc7jdaq
         WLGw==
X-Gm-Message-State: AOAM531ch0EDqY9f13Ioq64EA0D0Q8G2HyD/HedQwKn0CjwXuaceREFT
        RXFtX2XPM/ujMeRd4oYTXhs=
X-Google-Smtp-Source: ABdhPJyjcEoTJ7mKcLsx8+M6xfjkpI283KIp57+hZihzR132LBI0Yxy5O1+DCbl3qaZocHq7pmhERg==
X-Received: by 2002:a17:902:bf44:b029:da:d140:6f91 with SMTP id u4-20020a170902bf44b02900dad1406f91mr2260025pls.51.1609904842148;
        Tue, 05 Jan 2021 19:47:22 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id 19sm726179pfu.85.2021.01.05.19.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:47:21 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:47:18 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Liang Li <liliang324@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/6] mm: Add batch size for free page reporting
Message-ID: <20210106034715.GA1138@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the page order as the only threshold for page reporting
is not flexible and has some flaws. Because scan a long free
list is not cheap, it's better to wake up the page reporting
worker when there are more pages, wake it up for a sigle page
may not worth.
This patch add a batch size as another threshold to control the
waking up of reporting worker.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 mm/page_reporting.c |  1 +
 mm/page_reporting.h | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cd8e13d41df4..694df981ddd2 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,6 +12,7 @@
 
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
+unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
 
 enum {
 	PAGE_REPORTING_IDLE = 0,
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 2c385dd4ddbd..b8fb3bbb345f 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -12,6 +12,8 @@
 
 #define PAGE_REPORTING_MIN_ORDER	pageblock_order
 
+extern unsigned long page_report_batch_size;
+
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 void __page_reporting_notify(void);
@@ -33,6 +35,8 @@ static inline bool page_reported(struct page *page)
  */
 static inline void page_reporting_notify_free(unsigned int order)
 {
+	static long batch_size;
+
 	/* Called from hot path in __free_one_page() */
 	if (!static_branch_unlikely(&page_reporting_enabled))
 		return;
@@ -41,8 +45,12 @@ static inline void page_reporting_notify_free(unsigned int order)
 	if (order < PAGE_REPORTING_MIN_ORDER)
 		return;
 
-	/* This will add a few cycles, but should be called infrequently */
-	__page_reporting_notify();
+	batch_size += (1 << order) << PAGE_SHIFT;
+	if (batch_size >= page_report_batch_size) {
+		batch_size = 0;
+		/* This add a few cycles, but should be called infrequently */
+		__page_reporting_notify();
+	}
 }
 #else /* CONFIG_PAGE_REPORTING */
 #define page_reported(_page)	false
-- 
2.18.2

