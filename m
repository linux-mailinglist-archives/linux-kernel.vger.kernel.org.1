Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B62F41FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbhAMCoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:44:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:42693 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbhAMCoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:44:03 -0500
IronPort-SDR: EksiOWVD6ovy030obxHZJDA2PYhOAnC1oOP5pRwpRQN4GM5uUhaYkMC0lAiasTJaiX1Y+lmA6d
 OaaLBAlFIZZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="262925616"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="262925616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:43:22 -0800
IronPort-SDR: OO9jggQQWgQP8BJSk/eLKhiVD7g+459JSM+lAK+8wyY/+oqr72Fpra09AJQ2PdnGhHlqauw11M
 OWywnTOObgng==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="353281360"
Received: from xizhang-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:43:17 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH] mm: Free unused swap cache page in write protection fault handler
Date:   Wed, 13 Jan 2021 10:42:41 +0800
Message-Id: <20210113024241.179113-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 09854ba94c6a ("mm: do_wp_page() simplification") introduces an
issue as follows.

On a system with free memory as follow before test,

              total        used        free      shared  buff/cache   available
Mem:        1697300      160156     1459220        8648       77924     1419724
Swap:       1048572           0           0

The AnonPages filed of /proc/meminfo is 11712 kB.  After running a
memory eater which will trigger many swapins and write protection
faults, the free memory becomes,

              total        used        free      shared  buff/cache   available
Mem:        1697300      352620     1309004         624       35676     1252380
Swap:       1048572      216924      831648

While the /proc/meminfo shows,

SwapCached:       198908 kB
AnonPages:          1956 kB

Then, with `swapoff -a`, the free memory becomes,

              total        used        free      shared  buff/cache   available
Mem:        1697300      161972     1488184        8648       47144     1433172
Swap:             0           0           0

That is, after swapins and write protection faults, many unused swap
cache pages will be left unfreed in system.  Although the following
page reclaiming or swapoff will free these pages, it's still better to
free these pages at the first place.

So in this patch, at the end of wp_page_copy(), the old unused swap
cache page will be tried to be freed.  With that, after running the
memory eater which will trigger many swapins and write protection
faults, the free memory is,

              total        used        free      shared  buff/cache   available
Mem:        1697300      154020     1509400        1212       33880     1451524
Swap:       1048572       18432     1030140

While the /proc/meminfo shows,

SwapCached:         1240 kB
AnonPages:          1904 kB

BTW: I think this should be in stable after v5.9.

Fixes: 09854ba94c6a ("mm: do_wp_page() simplification")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..2abaff1befcb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2963,6 +2963,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				munlock_vma_page(old_page);
 			unlock_page(old_page);
 		}
+		if (page_copied && PageSwapCache(old_page) &&
+		    !page_mapped(old_page) && trylock_page(old_page)) {
+			try_to_free_swap(old_page);
+			unlock_page(old_page);
+		}
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
-- 
2.29.2

