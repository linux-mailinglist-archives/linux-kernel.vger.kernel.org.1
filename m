Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC02DFF55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLUSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLUSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:08:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC02C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:07:58 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g1so9703277ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=TWbytHk0kwDmGNz219zPiK2yM0SvWN9E6mBmb9Rckbw=;
        b=VsX+OIQPLU3ay3St7Stnyt2AOk+euEJgP8drwoX3Wj31/pbdT/Ko9TWjb0JbdVzVs3
         yvCZDHYcwR3dazppXzQqvTB13XlvW3jV2/T97Tkjd0EeqZz7Z6/xpSBapsC5obYpjtOW
         EIET1bZ17a2dSa2aZZ/2oJdKnJZuWAp6/qycQEFnsFg5xM0Oa+uc66jA30Z98VvYyswK
         9jzn5K/MSE/H4hZ3oWj4A4w5UA9Xb6YXejyFg92y7txHX3Y/slWBan9EyrjdoOWikCE5
         R6i2P71yAbGNZxyFgbtJ4uDoCzTPpQEhUCRvtll4kqR1e8QKl1NF4nNpu7774LsZGUR/
         naaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=TWbytHk0kwDmGNz219zPiK2yM0SvWN9E6mBmb9Rckbw=;
        b=PDhs504esPgn2wb6c/1YRlx25WYWtKnn3CepD4D5uwvld/I9zpxsEYLE4QpyEUSiz1
         Csfg3q73H9fDj9ME2sy2C8jhM8LMg0zo+X3L8MCrVBI0vH98EUIKL+YmVy40cyrvyNVo
         xc6vHL3IuDt6/hph+k6hTnCwAM+GWM72Z0I7DkJNh/TX45BszBN0o31UO7wrXFuDi1D5
         tBW4e7Kvgzl153myXPkIQwPCbFm4all9G+4ddaJWu07SBp9tCas0VkZOwY7D9RemG8b1
         qp5EUl2j51JVfu/D1VkYUGWWKb3RQwf8V9AWRNMdzNvALdA/igMREKn02NQy3C571bdv
         AEgQ==
X-Gm-Message-State: AOAM530xUI4fMve0wdoeN1NoPiu1l4F3t24INUC3fWmmr5siv19Z8Xax
        x8bB82tCfmFFnLA2LKv/TzSrJwMGf0k=
X-Google-Smtp-Source: ABdhPJwzr5pBcakDlhPI2PXs+KSqljHYy/00sB78l96c6Dn/mbSBJJ218gj4PIzYRWs0Xx/WSc9ZGQ==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr16051232pgv.418.1608568135985;
        Mon, 21 Dec 2020 08:28:55 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id gm18sm16118590pjb.55.2020.12.21.08.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:28:55 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliang324@gmail.com>
Date:   Mon, 21 Dec 2020 11:28:53 -0500
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
        Liang Li <liliangleo@didiglobal.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC v2 PATCH 2/4] mm: Add batch size for free page reporting
Message-ID: <20201221162851.GA22528@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
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
is not flexible and has some flaws.
When the system's memory becomes very fragmented, there will be a
lot of low order free pages but very few high order pages, limit
the mini order as pageblock_order will prevent most of free pages
from being reclaimed by host for the case of page reclmain through
the virtio-balllon driver.
Scan a long free list is not cheap, it's better to wake up the
page reporting worker when there are more pages, wake it up for a
sigle page may not worth.
This patch add a batch size as another threshold to control the
waking up of reporting worker.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liang Li <liliang324@gmail.com>
---
 mm/page_reporting.c |  2 ++
 mm/page_reporting.h | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 0b22db94ce2a..2f8e3d032fab 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -14,6 +14,8 @@
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 #define MAX_SCAN_NUM 1024
 
+unsigned long page_report_batch_size  __read_mostly = 4 * 1024 * 1024UL;
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
 enum {
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

