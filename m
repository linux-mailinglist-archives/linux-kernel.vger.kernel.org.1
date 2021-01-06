Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28132EB8A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAFDt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbhAFDt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:49:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C62C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:48:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c22so1282200pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=B3WV/j0Yc3UxPycY24YbbsJo25sgb+PzV0Vt6RMFIJ4=;
        b=p3QzQqTq1x0ViyPmHXZ0vVH7lPNwPDUFAlch1JuuQBXeGQHUbPBD7OrSBcWrzru7kX
         JPto5iqfwVBAVg8jfDcNFrfFcMzYeWZRDoTkMplia/JRwuGYC9BulZF7mrDMhvNJ2Gnl
         mt2RFpygGcezHGnLG06Fk7EoTjVa/oK5CGZZRDnTAjoULTWU1PSLj+c/xZ4jpoURjV9G
         uA7yyAYH4by5fB+WwZBA/+N62r9yuIP/55klMvSJZvhz2XBpvlt9sh8SGtkJtiNmLB1v
         NLf2/wPpv1lS3w8i+wu58tKw/9Y+nRf6B4gWunkCsqpJhIW2no6TO5+vlSi24zKvQ9f6
         gqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=B3WV/j0Yc3UxPycY24YbbsJo25sgb+PzV0Vt6RMFIJ4=;
        b=XTc7QdmLMu6Sri8OiFqMe5FJdb76hMuw1hAFGUKRSYgFB9vX2uohBPFdfULWzx3yRj
         4L5XLblmxlq/ZdAjsi0yg6DaG9hzQnWcIk1DJd/TjwlHCIVKB4efMPq55iouvlbLAQCF
         9z6xexwoUkPpntm8glbtJheuxbqIqPdJlEXo+UUbzCo9oQ2vxUOq1vN/3ST4zMUMlLDc
         5wgRX/VGPAoHS/sSyiUGhsBqKO2RaQ7tZFmMcL/WIeJg84MgtVcN9Hp0oVYTyUf+VOaG
         iVYjfXyV7W6Oz73H8WS2xjOFkH9OqQASnlufrdgRpoFSLZdj2dMZqG4iyBmuP70Ineto
         YbAQ==
X-Gm-Message-State: AOAM531xXB7pUja6aDPh1DAJ4//bUJYdox4gFi727aueHe1UI3+/ZAUg
        3REAHfTpbeU5AbpLCTX9k2M=
X-Google-Smtp-Source: ABdhPJz9vssAAYkLAHpWNywNUSwHPNC9skdPEiGDqhNAxr+rje3pVUyq972g8FX64yvm6siaLRbxXA==
X-Received: by 2002:aa7:8641:0:b029:1a1:e2f5:23de with SMTP id a1-20020aa786410000b02901a1e2f523demr2131021pfo.35.1609904892473;
        Tue, 05 Jan 2021 19:48:12 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id t15sm736076pfc.12.2021.01.05.19.48.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:48:11 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:48:09 -0500
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
Subject: [PATCH 2/6] mm: let user decide page reporting option
Message-ID: <20210106034806.GA1146@open-light-1.localdomain>
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

Some key parameters for page reporting are now hard coded, different
users of the framework may have their special requirements, make
these parameter configrable and let the user decide them.

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
 drivers/virtio/virtio_balloon.c |  3 +++
 include/linux/page_reporting.h  |  3 +++
 mm/page_reporting.c             | 13 +++++++++----
 mm/page_reporting.h             |  6 +++---
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8985fc2cea86..684bcc39ef5a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -993,6 +993,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.mini_order = pageblock_order;
+		vb->pr_dev_info.batch_size = 16 * 1024 * 1024; /* 16M */
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
index 694df981ddd2..39bc6a9d7b73 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -13,6 +13,7 @@
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
+int page_report_mini_order = pageblock_order;
 
 enum {
 	PAGE_REPORTING_IDLE = 0,
@@ -44,7 +45,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
 }
 
 /* notify prdev of free page reporting request */
@@ -230,7 +231,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << prdev->mini_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -240,7 +241,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = prdev->mini_order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
@@ -307,7 +308,7 @@ static void page_reporting_process(struct work_struct *work)
 	 */
 	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state == PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
 }
 
 static DEFINE_MUTEX(page_reporting_mutex);
@@ -335,6 +336,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	/* Assign device to allow notifications */
 	rcu_assign_pointer(pr_dev_info, prdev);
 
+	page_report_mini_order = prdev->mini_order;
+	page_report_batch_size = prdev->batch_size;
 	/* enable page reporting notification */
 	if (!static_key_enabled(&page_reporting_enabled)) {
 		static_branch_enable(&page_reporting_enabled);
@@ -352,6 +355,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
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

