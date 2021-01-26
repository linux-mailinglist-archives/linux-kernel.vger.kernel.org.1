Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B926A303A27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbhAZKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:24:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:51519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731998AbhAZB2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:28:02 -0500
IronPort-SDR: Ook11sQlmHbHXQUp9cWHZn+Jx09yU3/GaMaJVZSpzy7Cff8QbYoSZHSEWFOhE5+yL+8djO3r2H
 6h9pUBmRv7sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264650544"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264650544"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:49 -0800
IronPort-SDR: pQHygxC4qUnWqto+5NjrUq+YoSMkI/NVIU3ZhKR3nJ13hLODU6oenDR2jFFvRNRzK1wvpElQQg
 4+SVD8xUt38Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577639920"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2021 16:41:48 -0800
Subject: [RFC][PATCH 09/13] mm/vmscan: add page demotion counter
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:29 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003429.1045A904@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yang Shi <yang.shi@linux.alibaba.com>

Account the number of demoted pages into reclaim_state->nr_demoted.

Add pgdemote_kswapd and pgdemote_direct VM counters showed in
/proc/vmstat.

[ daveh:
   - __count_vm_events() a bit, and made them look at the THP
     size directly rather than getting data from migrate_pages()
]

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Changes since 202010:
 * remove unused scan-control 'demoted' field
---

 b/include/linux/vm_event_item.h |    2 ++
 b/mm/vmscan.c                   |    5 +++++
 b/mm/vmstat.c                   |    2 ++
 3 files changed, 9 insertions(+)

diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter	2021-01-25 16:23:15.821866693 -0800
+++ b/include/linux/vm_event_item.h	2021-01-25 16:23:15.831866693 -0800
@@ -33,6 +33,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 		PGREUSE,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
+		PGDEMOTE_KSWAPD,
+		PGDEMOTE_DIRECT,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter	2021-01-25 16:23:15.823866693 -0800
+++ b/mm/vmscan.c	2021-01-25 16:23:15.835866693 -0800
@@ -1120,6 +1120,11 @@ static unsigned int demote_page_list(str
 			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
 			    &nr_succeeded);
 
+	if (current_is_kswapd())
+		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
+	else
+		__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
+
 	return nr_succeeded;
 }
 
diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
--- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter	2021-01-25 16:23:15.825866693 -0800
+++ b/mm/vmstat.c	2021-01-25 16:23:15.838866693 -0800
@@ -1244,6 +1244,8 @@ const char * const vmstat_text[] = {
 	"pgreuse",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
+	"pgdemote_kswapd",
+	"pgdemote_direct",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
_
