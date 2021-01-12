Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B52F2BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbhALJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:48:34 -0500
Received: from relay.corp-email.com ([222.73.234.233]:27474 "EHLO
        relay.corp-email.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbhALJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:48:32 -0500
X-Greylist: delayed 15978 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 04:48:30 EST
Received: from ([183.47.25.45])
        by relay.corp-email.com ((LNX1044)) with ASMTP (SSL) id GCI00134;
        Tue, 12 Jan 2021 17:47:34 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-06.TCL.com
 (10.74.128.156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 17:47:35 +0800
Received: from localhost.localdomain (172.16.34.38) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 17:47:34 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <mgorman@techsingularity.net>
CC:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <haiwang.fu@tcl.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <rientjes@google.com>, <tang.ding@tcl.com>,
        <vbabka@suse.cz>, <wu-yan@tcl.com>, <xiushui.ye@tcl.com>
Subject: [PATCH] mm, compaction: move high_pfn to the for loop scope.
Date:   Tue, 12 Jan 2021 17:47:20 +0800
Message-ID: <20210112094720.1238444-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112091041.GJ3592@techsingularity.net>
References: <20210112091041.GJ3592@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.34.38]
X-ClientProxiedBy: GCY-EXS-01.TCL.com (10.74.128.151) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   202111217473418390f645091c961f367ccb719166ceb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fast_isolate_freepages, high_pfn will be used if a prefered one(PFN >= low_fn) not found. But the high_pfn
is not reset before searching an free area, so when it was used as freepage, it may from another free area searched before.
And move_freelist_head(freelist, freepage) will have unexpected behavior(eg. corrupt the MOVABLE freelist)

Unable to handle kernel paging request at virtual address dead000000000200
Mem abort info:
  ESR = 0x96000044
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000044
  CM = 0, WnR = 1
[dead000000000200] address between user and kernel address ranges

-000|list_cut_before(inline)
-000|move_freelist_head(inline)
-000|fast_isolate_freepages(inline)
-000|isolate_freepages(inline)
-000|compaction_alloc(?, ?)
-001|unmap_and_move(inline)
-001|migrate_pages([NSD:0xFFFFFF80088CBBD0] from = 0xFFFFFF80088CBD88, [NSD:0xFFFFFF80088CBBC8] get_new_p
-002|__read_once_size(inline)
-002|static_key_count(inline)
-002|static_key_false(inline)
-002|trace_mm_compaction_migratepages(inline)
-002|compact_zone(?, [NSD:0xFFFFFF80088CBCB0] capc = 0x0)
-003|kcompactd_do_work(inline)
-003|kcompactd([X19] p = 0xFFFFFF93227FBC40)
-004|kthread([X20] _create = 0xFFFFFFE1AFB26380)
-005|ret_from_fork(asm)
---|end of frame

The issue was reported on an smart phone product with 6GB ram and 3GB zram as swap device.

This patch fixes the issue by reset high_pfn before searching each free area, which ensure
freepage and freelist match when call move_freelist_head in fast_isolate_freepages().

Link: http://lkml.kernel.org/r/20190118175136.31341-12-mgorman@techsingularity.net
Fixes: 5a811889de10f1eb ("mm, compaction: use free lists to quickly locate a migration target")
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index cc1a7f600a86..75f0e550b18f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1303,7 +1303,7 @@ fast_isolate_freepages(struct compact_control *cc)
 {
 	unsigned int limit = min(1U, freelist_scan_limit(cc) >> 1);
 	unsigned int nr_scanned = 0;
-	unsigned long low_pfn, min_pfn, high_pfn = 0, highest = 0;
+	unsigned long low_pfn, min_pfn, highest = 0;
 	unsigned long nr_isolated = 0;
 	unsigned long distance;
 	struct page *page = NULL;
@@ -1348,6 +1348,7 @@ fast_isolate_freepages(struct compact_control *cc)
 		struct page *freepage;
 		unsigned long flags;
 		unsigned int order_scanned = 0;
+		unsigned long high_pfn = 0;
 
 		if (!area->nr_free)
 			continue;
-- 
2.25.1

