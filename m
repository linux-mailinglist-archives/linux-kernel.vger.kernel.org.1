Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163F62DFF34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgLUSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgLUSEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:04:43 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF35C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:04:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so1871884pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=yCqvw49/Rmb78qrcQ/V5V54EYYCj1w98X72tRqbM6ug=;
        b=ISuBRRAJ/22G4sfeIRuMpcpnOaxALlpU4jqnRl3kvDrtgKm3mszXPYIzziMVzphXMH
         ruF9mJTxXebBWTXxVxxVJrR/0KtJrLr3gAWy3I1zDEMplJnMFY/QdWYLfr0dJk33FAlc
         TpvLGlUWCSWVVP6nYbFhNPkJPaD5yq3x+EkbVN0Hor468AyTqFaqKEG94wph/WDMy+ds
         BZc9tnM5gXI8EZD8GsVCQla/qU2TKGqLzvfJCKGNMK1+3sVcppgRivwQv0tpG8qxOhB5
         xTW6KaPMZOnqtTNFvw+9cwtQ9P9aLpxFu3FYKA8vj0D8s2NEb7i6MZ9AgTB2dwlt6T60
         p26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=yCqvw49/Rmb78qrcQ/V5V54EYYCj1w98X72tRqbM6ug=;
        b=ciCrwKd6fH0oxZldWHQZwQi+T7Trwi96CUf4avYDTa7OdzCP8wFm2qvSM71wPyIBH2
         NfWNQfwFgNZkQt4hcxeIT581CX7LNFfwXrfOgRPsmN0GdijrJKLBH34aYMxS7b8xRtjS
         Vil7X0hXJdzq+ESxrmy5dX9g/iZxU0Zi3IleTSq/LfcwsSsIRQSbHsZkNTv7jTyD/p1M
         V46+NEC3qN82jH3C4TXOnQERcqK7MTiIHUIn31wTkm+X56sKaENEBTLQu4eS4w1ST2fv
         KJweC712WkK7VdwfSumb6oyI537KE8TY9KqhTAPjaiM7/dAOHjpO3Sv5N22cl6461o5R
         O3jA==
X-Gm-Message-State: AOAM5337xnJbREcwDI3AmGuHt7VwNIZg5fB0JtyktgY2evMikjGrCc8H
        RZI/DgMnIfGrD+IV60ktZcVje18gmDk=
X-Google-Smtp-Source: ABdhPJz3AIrbe7WmvCFNyoUxmGYHG4WGKx8LarPfV1FGev4qvJ72uy0P4T4bxfBZHf2YyXIp2rSmQw==
X-Received: by 2002:a17:902:aa8b:b029:da:ef22:8675 with SMTP id d11-20020a170902aa8bb02900daef228675mr16841289plr.15.1608568091235;
        Mon, 21 Dec 2020 08:28:11 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id ev23sm16794186pjb.24.2020.12.21.08.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:28:11 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliang324@gmail.com>
Date:   Mon, 21 Dec 2020 11:28:08 -0500
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
Subject: [RFC v2 PATCH 1/4] mm: make page reporing worker works better for
 low order page
Message-ID: <20201221162806.GA22524@open-light-1.localdomain>
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

'page_reporting_cycle' may take the zone lock for too long when scan
a low order free page list, because the low order page free list may
have a lot iterms and very few pages without the PG_report flag.
Current implementation limits the mini reported order to pageblock_order,
it's ok for most case. If we want to report low order pages, we should
prevent zone lock from being taken too long by the reporting worker, or it
may affect system performance, this patch try to make 'page_reporting_cycle'
work better for low order pages, the zone lock was released periodicly
and cup was yielded voluntarily if needed.

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
 mm/page_reporting.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cd8e13d41df4..0b22db94ce2a 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -6,11 +6,14 @@
 #include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
+#include <linux/sched.h>
 
 #include "page_reporting.h"
 #include "internal.h"
 
 #define PAGE_REPORTING_DELAY	(2 * HZ)
+#define MAX_SCAN_NUM 1024
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
 enum {
@@ -115,7 +118,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	unsigned int page_len = PAGE_SIZE << order;
 	struct page *page, *next;
 	long budget;
-	int err = 0;
+	int err = 0, scan_cnt = 0;
 
 	/*
 	 * Perform early check, if free area is empty there is
@@ -145,8 +148,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
 		/* We are going to skip over the reported pages. */
-		if (PageReported(page))
+		if (PageReported(page)) {
+			if (++scan_cnt >= MAX_SCAN_NUM) {
+				err = scan_cnt;
+				break;
+			}
 			continue;
+		}
+
 
 		/*
 		 * If we fully consumed our budget then update our
@@ -219,6 +228,26 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	return err;
 }
 
+static int
+reporting_order_type(struct page_reporting_dev_info *prdev, struct zone *zone,
+		     unsigned int order, unsigned int mt,
+		     struct scatterlist *sgl, unsigned int *offset)
+{
+	int ret = 0;
+	unsigned long total = 0;
+
+	might_sleep();
+	do {
+		cond_resched();
+		ret = page_reporting_cycle(prdev, zone, order, mt,
+					   sgl, offset);
+		if (ret > 0)
+			total += ret;
+	} while (ret > 0 && total < zone->free_area[order].nr_free);
+
+	return ret;
+}
+
 static int
 page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			    struct scatterlist *sgl, struct zone *zone)
@@ -245,7 +274,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			if (is_migrate_isolate(mt))
 				continue;
 
-			err = page_reporting_cycle(prdev, zone, order, mt,
+			err = reporting_order_type(prdev, zone, order, mt,
 						   sgl, &offset);
 			if (err)
 				return err;
-- 
2.18.2

