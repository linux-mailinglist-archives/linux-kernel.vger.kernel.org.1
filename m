Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70F2DFF99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgLUSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:21:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F2C061248
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:21:12 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z136so9688501iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=5kDglcd6VQIqjjNw+a1FSAU9ly8u5KobZD9sJqfzmhY=;
        b=DFhcmrJPOlYHNP1sMevkV/MJhv/j7/xlyEEaaigvep8rnOXypKxqL6sSndgMJHPfDV
         /VGqHeHZNOPGVLtc17wQ1soRflBwrZVLAqFrKavH4+dXC7h88ctWw7iMFcbzqa4G+Vyr
         qdZckrzp3v9MysXO0JIpuyu21vuTICM16rPXehkCwbImep5wXGYzmhRP4SfhKEywCKHn
         wkn0tF18a7OoBcCtstBFNASOR/LJAyJJgRGNfBKwap+f6sJaIB5pypH+CSw3lvOOf2X/
         wqdJbJG58gqVQPncHESPYy5TxLsx6e84nNTsNlbYoXtVuLJnucYBfmkrCXvmy9zCosk5
         60xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=5kDglcd6VQIqjjNw+a1FSAU9ly8u5KobZD9sJqfzmhY=;
        b=gT8SVg8ym1Kk6LeKNY0zUU1bxPbSEC3JM6KgaxJZgHSuWPWjUvFcHeIhEDbSAnpFL3
         PsUelr4vU89jRRWg90USANiTwffFVarR29FHYiE7nJzvGm9Pb9BsSd8NtF9rO8LrLlaj
         U30xUl6Zz9FlnJzoyt8itib6qD7HAEpTi2dWx9qpEyVcfa6ete94wqdXzn0qPvGSRJrZ
         Sd8ffeWTLoDAYKrPXZVZEkXPnjkRVYT3Pe7mfGhJwPuTIEtmALtwd3QXmuhBkYxD0AL5
         8/JiN+IpajfXYCtQPYEPe5cOkxB0T52vkyUQbPMAp2Sfeqg0F0q+dCg98wRdH1/GdIjm
         E5Ig==
X-Gm-Message-State: AOAM533FAxPqcRtgcLhi3PSkgMspTi6UjM4XXjW79df02q3hlN6lxBZa
        9E6YR+rOGmR/oTFDqpRP8P3xRbKX+dg=
X-Google-Smtp-Source: ABdhPJyuienqAJue8qcDSJAHs+Vi+ADg974Xm4zu7z826xU1FeXUDlKlvmq8JBTXgMScbLS/qUASkw==
X-Received: by 2002:a63:d855:: with SMTP id k21mr4931948pgj.399.1608568181980;
        Mon, 21 Dec 2020 08:29:41 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id mr7sm15551570pjb.31.2020.12.21.08.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:41 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliang324@gmail.com>
Date:   Mon, 21 Dec 2020 11:29:39 -0500
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
Subject: [RFC v2 PATCH 3/4] mm: let user decide page reporting option
Message-ID: <20201221162937.GA22530@open-light-1.localdomain>
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

Some key parameters for page reporting are now hard coded, different
users of the framework may have their special requirements, make
these parameter configrable and let the user decide them.

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
 drivers/virtio/virtio_balloon.c |  3 +++
 include/linux/page_reporting.h  |  3 +++
 mm/page_reporting.c             | 18 ++++++++++--------
 mm/page_reporting.h             |  6 +++---
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8985fc2cea86..a298517079bb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -993,6 +993,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.mini_order = 6;
+		vb->pr_dev_info.batch_size = 32 * 1024 * 1024; /* 32M */
+		vb->pr_dev_info.delay_jiffies = 2 * HZ; /* 2 seconds */
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 3b99e0ec24f2..63e1e9fbcaa2 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -13,6 +13,9 @@ struct page_reporting_dev_info {
 	int (*report)(struct page_reporting_dev_info *prdev,
 		      struct scatterlist *sg, unsigned int nents);
 
+	unsigned long batch_size;
+	unsigned long delay_jiffies;
+	int mini_order;
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 2f8e3d032fab..20ec3fb1afc4 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,12 +11,10 @@
 #include "page_reporting.h"
 #include "internal.h"
 
-#define PAGE_REPORTING_DELAY	(2 * HZ)
 #define MAX_SCAN_NUM 1024
-
-unsigned long page_report_batch_size  __read_mostly = 4 * 1024 * 1024UL;
-
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
+int page_report_mini_order = pageblock_order;
+unsigned long page_report_batch_size = 32 * 1024 * 1024;
 
 enum {
 	PAGE_REPORTING_IDLE = 0,
@@ -48,7 +46,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
 }
 
 /* notify prdev of free page reporting request */
@@ -260,7 +258,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << prdev->mini_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -270,7 +268,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = prdev->mini_order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
@@ -337,7 +335,7 @@ static void page_reporting_process(struct work_struct *work)
 	 */
 	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state == PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
 }
 
 static DEFINE_MUTEX(page_reporting_mutex);
@@ -365,6 +363,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	/* Assign device to allow notifications */
 	rcu_assign_pointer(pr_dev_info, prdev);
 
+	page_report_mini_order = prdev->mini_order;
+	page_report_batch_size = prdev->batch_size;
 	/* enable page reporting notification */
 	if (!static_key_enabled(&page_reporting_enabled)) {
 		static_branch_enable(&page_reporting_enabled);
@@ -382,6 +382,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 	mutex_lock(&page_reporting_mutex);
 
 	if (rcu_access_pointer(pr_dev_info) == prdev) {
+		if (static_key_enabled(&page_reporting_enabled))
+			static_branch_disable(&page_reporting_enabled);
 		/* Disable page reporting notification */
 		RCU_INIT_POINTER(pr_dev_info, NULL);
 		synchronize_rcu();
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index b8fb3bbb345f..86ac6ffad970 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -9,9 +9,9 @@
 #include <linux/slab.h>
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
+#include <linux/page_reporting.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
-
+extern int page_report_mini_order;
 extern unsigned long page_report_batch_size;
 
 #ifdef CONFIG_PAGE_REPORTING
@@ -42,7 +42,7 @@ static inline void page_reporting_notify_free(unsigned int order)
 		return;
 
 	/* Determine if we have crossed reporting threshold */
-	if (order < PAGE_REPORTING_MIN_ORDER)
+	if (order < page_report_mini_order)
 		return;
 
 	batch_size += (1 << order) << PAGE_SHIFT;
-- 
2.18.2

