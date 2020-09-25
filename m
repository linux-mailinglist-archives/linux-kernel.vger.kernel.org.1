Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6F277E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgIYDXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:23:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:30978 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgIYDXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:23:02 -0400
IronPort-SDR: D1FAKtoK3QmFQgrPA7DRv3H0X9MCaEN9gJr/8YcwHj9JW4b+CsJK42qoC+JSiZqtAFuDDJYCrO
 +0a5vT1oP1Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162327246"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="162327246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 20:22:00 -0700
IronPort-SDR: 7/h2k/G71eK2mqvtVShZGj8Hdd7V4TgF8i5SgX76aYJZkbyrPcTCzi06utt13x3T9tiRbOTVkj
 alaBd3fsAPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="349553146"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2020 20:21:58 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
        <878sd1qllb.fsf@yhuang-dev.intel.com>
        <20200923043459.GL795820@optiplex-lnx>
        <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
        <87blhwng5f.fsf@yhuang-dev.intel.com>
        <20200924020928.GC1023012@optiplex-lnx>
        <877dsjessq.fsf@yhuang-dev.intel.com>
        <20200924063038.GD1023012@optiplex-lnx>
        <87tuvnd3db.fsf@yhuang-dev.intel.com>
        <20200924150833.GE1023012@optiplex-lnx>
Date:   Fri, 25 Sep 2020 11:21:58 +0800
In-Reply-To: <20200924150833.GE1023012@optiplex-lnx> (Rafael Aquini's message
        of "Thu, 24 Sep 2020 11:08:33 -0400")
Message-ID: <87r1qqbkx5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:
>> Or, can you help to run the test with a debug kernel based on upstream
>> kernel.  I can provide some debug patch.
>> 
>
> Sure, I can set your patches to run with the test cases we have that tend to 
> reproduce the issue with some degree of success.

Thanks!

I found a race condition.  During THP splitting, "head" may be unlocked
before calling split_swap_cluster(), because head != page during
deferred splitting.  So we should call split_swap_cluster() before
unlocking.  The debug patch to do that is as below.  Can you help to
test it?

Best Regards,
Huang, Ying

------------------------8<----------------------------
From 24ce0736a9f587d2dba12f12491c88d3e296a491 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 25 Sep 2020 11:10:56 +0800
Subject: [PATCH] dbg: Call split_swap_clsuter() before unlock page during
 split THP

---
 mm/huge_memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index faadc449cca5..8d79e5e6b46e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2444,6 +2444,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	remap_page(head);
 
+	if (PageSwapCache(head)) {
+		swp_entry_t entry = { .val = page_private(head) };
+
+		split_swap_cluster(entry);
+	}
+
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
@@ -2678,12 +2684,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 
 		__split_huge_page(page, list, end, flags);
-		if (PageSwapCache(head)) {
-			swp_entry_t entry = { .val = page_private(head) };
-
-			ret = split_swap_cluster(entry);
-		} else
-			ret = 0;
+		ret = 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
 			pr_alert("total_mapcount: %u, page_count(): %u\n",
-- 
2.28.0

