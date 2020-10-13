Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC928D086
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgJMOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbgJMOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:43:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35DAFB19A;
        Tue, 13 Oct 2020 14:43:34 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [PATCH v5 2/4] mm,hwpoison: take free pages off the buddy freelists
Date:   Tue, 13 Oct 2020 16:44:45 +0200
Message-Id: <20201013144447.6706-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013144447.6706-1-osalvador@suse.de>
References: <20201013144447.6706-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crux of the matter is that historically we left poisoned pages in the
buddy system because we have some checks in place when allocating a page
that are gatekeeper for poisoned pages.  Unfortunately, we do have other
users (e.g: compaction [1]) that scan buddy freelists and try to get a
page from there without checking whether the page is HWPoison.

As I stated already, I think it is fundamentally wrong to keep HWPoison
pages within the buddy systems, checks in place or not.

Let us fix this the same way we did for soft_offline [2], taking the page
off the buddy freelist so it is completely unreachable.

Note that this is fairly simple to trigger, as we only need to poison free
buddy pages (madvise MADV_HWPOISON) and then run some sort of memory stress
system.

Just for a matter of reference, I put a dump_page() in compaction_alloc()
to trigger for HWPoison patches:

kernel: page:0000000012b2982b refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1d5db
kernel: flags: 0xfffffc0800000(hwpoison)
kernel: raw: 000fffffc0800000 ffffea00007573c8 ffffc90000857de0 0000000000000000
kernel: raw: 0000000000000001 0000000000000000 00000001ffffffff 0000000000000000
kernel: page dumped because: compaction_alloc

kernel: CPU: 4 PID: 123 Comm: kcompactd0 Tainted: G            E     5.9.0-rc2-mm1-1-default+ #5
kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
kernel: Call Trace:
kernel:  dump_stack+0x6d/0x8b
kernel:  compaction_alloc+0xb2/0xc0
kernel:  migrate_pages+0x2a6/0x12a0
kernel:  ? isolate_freepages+0xc80/0xc80
kernel:  ? __ClearPageMovable+0xb0/0xb0
kernel:  compact_zone+0x5eb/0x11c0
kernel:  ? finish_task_switch+0x74/0x300
kernel:  ? lock_timer_base+0xa8/0x170
kernel:  proactive_compact_node+0x89/0xf0
kernel:  ? kcompactd+0x2d0/0x3a0
kernel:  kcompactd+0x2d0/0x3a0
kernel:  ? finish_wait+0x80/0x80
kernel:  ? kcompactd_do_work+0x350/0x350
kernel:  kthread+0x118/0x130
kernel:  ? kthread_associate_blkcg+0xa0/0xa0
kernel:  ret_from_fork+0x22/0x30

After that, if e.g: a process faults in the page,  it will get killed
unexpectedly.
Fix it by containing the page immediatelly.

Besides that, two more changes can be noticed:

* MF_DELAYED no longer suits as we are fixing the issue by containing
  the page immediately, so it does no longer rely on the allocation-time
  checks to stop HWPoison to be handed over.
  gain unless it is unpoisoned, so we fixed the situation.
  Because of that, let us use MF_RECOVERED from now on.

* The second block that handles PageBuddy pages is no longer needed:
  We call shake_page and then check whether the page is Buddy
  because shake_page calls drain_all_pages, which sends pcp-pages back to
  the buddy freelists, so we could have a chance to handle free pages.
  Currently, get_hwpoison_page already calls drain_all_pages, and we call
  get_hwpoison_page right before coming here, so we should be on the safe
  side.

[1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
[2] https://patchwork.kernel.org/cover/11792607/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e2f12410c594..181bed890c16 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1341,6 +1341,7 @@ int memory_failure(unsigned long pfn, int flags)
 	struct dev_pagemap *pgmap;
 	int res;
 	unsigned long page_flags;
+	bool retry = true;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1358,6 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+try_again:
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
 	if (TestSetPageHWPoison(p)) {
@@ -1382,8 +1384,21 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
-			return 0;
+			if (take_page_off_buddy(p)) {
+				page_ref_inc(p);
+				res = MF_RECOVERED;
+			} else {
+				/* We lost the race, try again */
+				if (retry) {
+					ClearPageHWPoison(p);
+					num_poisoned_pages_dec();
+					retry = false;
+					goto try_again;
+				}
+				res = MF_FAILED;
+			}
+			action_result(pfn, MF_MSG_BUDDY, res);
+			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 			return -EBUSY;
@@ -1407,14 +1422,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
 	shake_page(p, 0);
-	/* shake_page could have turned it free. */
-	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
-		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
-		return 0;
-	}
 
 	lock_page(p);
 
-- 
2.26.2

