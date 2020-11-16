Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55802B4048
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgKPJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:51:31 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43318 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbgKPJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:51:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UFWzOrN_1605520286;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFWzOrN_1605520286)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Nov 2020 17:51:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: remove unused 3 items explanation for /proc/vmstat
Date:   Mon, 16 Nov 2020 17:51:22 +0800
Message-Id: <1605520282-51993-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5647bc293ab1 ("mm: compaction: Move migration fail/success
stats to migrate.c"), removed 3 items in /proc/vmstat. but the docs
still has their explanation. let's remove them.

"compact_blocks_moved",
"compact_pages_moved",
"compact_pagemigrate_failed",

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Yang Shi <yang.shi@linux.alibaba.com> 
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> 
Cc: David Rientjes <rientjes@google.com> 
Cc: Zi Yan <ziy@nvidia.com> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/admin-guide/mm/transhuge.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b2acd0d395ca..3b8a336511a4 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -401,21 +401,6 @@ compact_fail
 	is incremented if the system tries to compact memory
 	but failed.
 
-compact_pages_moved
-	is incremented each time a page is moved. If
-	this value is increasing rapidly, it implies that the system
-	is copying a lot of data to satisfy the huge page allocation.
-	It is possible that the cost of copying exceeds any savings
-	from reduced TLB misses.
-
-compact_pagemigrate_failed
-	is incremented when the underlying mechanism
-	for moving a page failed.
-
-compact_blocks_moved
-	is incremented each time memory compaction examines
-	a huge page aligned range of pages.
-
 It is possible to establish how long the stalls were using the function
 tracer to record how long was spent in __alloc_pages_nodemask and
 using the mm_page_alloc tracepoint to identify which allocations were
-- 
2.29.GIT

