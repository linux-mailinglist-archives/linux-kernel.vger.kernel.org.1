Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92726890F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgINKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgINKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:16:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C533B220;
        Mon, 14 Sep 2020 10:16:19 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 1/5] mm,hwpoison: take free pages off the buddy freelists
Date:   Mon, 14 Sep 2020 12:15:55 +0200
Message-Id: <20200914101559.17103-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200914101559.17103-1-osalvador@suse.de>
References: <20200914101559.17103-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series "HWpoison: further fixes and cleanups", v2.

The important bit of this patchset is patch#1, which is a fix to take off
HWPoison pages off a buddy freelist since it can lead us to having
HWPoison pages back in the game without no one noticing it.  So fix it (we
did that already for soft_offline_page [1]).

The other patches are clean-ups and not that important.

This patch (of 5):

The crux of the matter is that historically we left poisoned pages in the
buddy system because we have some checks in place when allocating a page
that a gatekeeper for poisoned pages.  Unfortunately, we do have other
users (e.g: compaction [1]) that scan buddy freelists and try to get a
page from there without checking whether the page is HWPoison.

As I stated already, I think it is fundamentally wrong to keep HWPoison
pages within the buddy systems, checks in place or not.

Let us fix this we same way we did for soft_offline [2], and take the page
off the buddy freelist, so it is completely unreachable.

Note that this is fairly simple to trigger, as we only need to poison free
buddy pages (madvise MADV_HWPOISON) and then we need to run some sort of
memory stress system.

Just for a matter of reference, I put a dump_page in compaction_alloc to
trigger for HWPoison patches:

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

After that, if e.g: someone faults in the page, that someone will get
killed unexpectedly.

While we are at it, I also changed the action result for such cases.
I think that MF_DELAYED is a bit misleading, because in case we could
contain the page and take it off the buddy, such a page is not to be used
again unless it is unpoisoned, so we fixed the situation.

So unless I am missing something, I strongly think that we should report
MF_RECOVERED.

[1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
[2] https://patchwork.kernel.org/patch/11694847/

Link: https://lkml.kernel.org/r/20200908075626.11976-1-osalvador@suse.de
Link: https://lkml.kernel.org/r/20200908075626.11976-2-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memory-failure.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 68f736add7cc..989fb3efdca6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1321,8 +1321,9 @@ int memory_failure(unsigned long pfn, int flags)
 	struct page *hpage;
 	struct page *orig_head;
 	struct dev_pagemap *pgmap;
-	int res;
 	unsigned long page_flags;
+	int res = 0;
+	bool retry = true;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -1362,10 +1363,21 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
+try_again:
 	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
-			return 0;
+			if (take_page_off_buddy(p)) {
+				action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
+				return 0;
+			} else {
+				/* We lost the race, try again */
+				if (retry) {
+					retry = false;
+					goto try_again;
+				}
+				action_result(pfn, MF_MSG_BUDDY, MF_FAILED);
+				return -EBUSY;
+			}
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 			return -EBUSY;
@@ -1391,11 +1403,15 @@ int memory_failure(unsigned long pfn, int flags)
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
 	if (!PageLRU(p) && is_free_buddy_page(p)) {
+		if (!take_page_off_buddy(p))
+			res = -EBUSY;
+
 		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
+			action_result(pfn, MF_MSG_BUDDY, res ? MF_FAILED : MF_RECOVERED);
 		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
-		return 0;
+			action_result(pfn, MF_MSG_BUDDY_2ND, res ? MF_FAILED : MF_RECOVERED);
+
+		return res;
 	}
 
 	lock_page(p);
-- 
2.26.2

