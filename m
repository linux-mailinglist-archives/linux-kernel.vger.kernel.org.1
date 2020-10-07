Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9382F286380
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgJGQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:18:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:51155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbgJGQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:17:54 -0400
IronPort-SDR: zOpZw+KOmEYwqQZVLbEFB1fmBwRbvQBhSpOVuBbHQs50UnDPYSODQWykoVESQY70uZUZqtpBUA
 KaViuh65d8BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152772059"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="152772059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:17:54 -0700
IronPort-SDR: X2IE/XN29BTNWoE8aGv5MQ7wZl+bzAfSYYTFKpFc+VaSzSkRV9QPY+ErJSLeZviMfeE30w8Zbj
 CYSPvqYA/JEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="354054949"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2020 09:17:54 -0700
Subject: [RFC][PATCH 6/9] mm/vmscan: add page demotion counter
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 07 Oct 2020 09:17:47 -0700
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
In-Reply-To: <20201007161736.ACC6E387@viggo.jf.intel.com>
Message-Id: <20201007161747.FE7288F0@viggo.jf.intel.com>
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
---

 b/include/linux/vm_event_item.h |    2 ++
 b/mm/vmscan.c                   |    6 ++++++
 b/mm/vmstat.c                   |    2 ++
 3 files changed, 10 insertions(+)

diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.171642439 -0700
+++ b/include/linux/vm_event_item.h	2020-10-07 09:15:32.179642439 -0700
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
--- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.173642439 -0700
+++ b/mm/vmscan.c	2020-10-07 09:15:32.180642439 -0700
@@ -147,6 +147,7 @@ struct scan_control {
 		unsigned int immediate;
 		unsigned int file_taken;
 		unsigned int taken;
+		unsigned int demoted;
 	} nr;
 
 	/* for recording the reclaimed slab by now */
@@ -1134,6 +1135,11 @@ static unsigned int demote_page_list(str
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
--- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.175642439 -0700
+++ b/mm/vmstat.c	2020-10-07 09:15:32.181642439 -0700
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
