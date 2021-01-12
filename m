Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75E2F27D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbhALF0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:26:30 -0500
Received: from bgp198.corpemail.net ([222.73.254.198]:13758 "EHLO
        bgp198.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbhALF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:26:30 -0500
Received: from ([183.47.25.45])
        by support.corp-email.com ((LNX1044)) with ASMTP (SSL) id FWG00039;
        Tue, 12 Jan 2021 13:20:39 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-05.TCL.com
 (10.74.128.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 13:20:40 +0800
Received: from localhost.localdomain (172.16.34.38) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 13:20:24 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <vbabka@suse.cz>
CC:     <aarcange@redhat.com>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mgorman@techsingularity.net>, <rientjes@google.com>,
        <tang.ding@tcl.com>, <haiwang.fu@tcl.com>, <xiushui.ye@tcl.com>,
        <wu-yan@tcl.com>
Subject: [PATCH] mm, compaction: make sure we isolate a valid freepage when high_pfn is used
Date:   Tue, 12 Jan 2021 13:19:55 +0800
Message-ID: <20210112051955.1221914-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
References: <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.34.38]
X-ClientProxiedBy: GCY-EXS-01.TCL.com (10.74.128.151) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   20211121320399c8403f36c678069a60c87198e36496d
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

Link: http://lkml.kernel.org/r/1558711908-15688-1-git-send-email-suzuki.poulose@arm.com
Fixes: 5a811889de10f1eb ("mm, compaction: use free lists to quickly locate a migration target")
---
 mm/compaction.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index cc1a7f600a86..6754229f4213 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1352,6 +1352,7 @@ fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
+		high_pfn = 0;
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 		list_for_each_entry_reverse(freepage, freelist, lru) {
-- 
2.25.1

