Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77F024FE61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHXM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 08:58:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53308 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgHXMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:55:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:13 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v18 02/32] mm/memcg: bail out early from swap accounting when memcg is disabled
Date:   Mon, 24 Aug 2020 20:54:35 +0800
Message-Id: <1598273705-69124-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we disabled memcg by cgroup_disable=memory, page->memcg will be NULL
and so the charge is skipped and that will trigger a warning like below.
Let's return from the funcs earlier.

 anon flags:0x5005b48008000d(locked|uptodate|dirty|swapbacked)
 raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
 raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
 page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
...
 RIP: 0010:vprintk_emit+0x1f7/0x260
 Code: 00 84 d2 74 72 0f b6 15 27 58 64 01 48 c7 c0 00 d4 72 82 84 d2 74 09 f3 90 0f b6 10 84 d2 75 f7 e8 de 0d 00 00 4c 89 e7 57 9d <0f> 1f 44 00 00 e9 62 ff ff ff 80 3d 88 c9 3a 01 00 0f 85 54 fe ff
 RSP: 0018:ffffc9000faab358 EFLAGS: 00000202
 RAX: ffffffff8272d400 RBX: 000000000000005e RCX: ffff88afd80d0040
 RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000202
 RBP: ffffc9000faab3a8 R08: ffffffff8272d440 R09: 0000000000022480
 R10: 00120c77be68bfac R11: 0000000000cd7568 R12: 0000000000000202
 R13: 0057ffffc0080005 R14: ffffffff820a0130 R15: ffffc9000faab3e8
 ? vprintk_emit+0x140/0x260
 vprintk_default+0x1a/0x20
 vprintk_func+0x4f/0xc4
 ? vprintk_func+0x4f/0xc4
 printk+0x53/0x6a
 ? xas_load+0xc/0x80
 __dump_page.cold.6+0xff/0x4ee
 ? xas_init_marks+0x23/0x50
 ? xas_store+0x30/0x40
 ? free_swap_slot+0x43/0xd0
 ? put_swap_page+0x119/0x320
 ? update_load_avg+0x82/0x580
 dump_page+0x9/0xb
 mem_cgroup_try_charge_swap+0x16e/0x1d0
 get_swap_page+0x130/0x210
 add_to_swap+0x41/0xc0
 shrink_page_list+0x99e/0xdf0
 shrink_inactive_list+0x199/0x360
 shrink_lruvec+0x40d/0x650
 ? _cond_resched+0x14/0x30
 ? _cond_resched+0x14/0x30
 shrink_node+0x226/0x6e0
 do_try_to_free_pages+0xd0/0x400
 try_to_free_pages+0xef/0x130
 __alloc_pages_slowpath.constprop.127+0x38d/0xbd0
 ? ___slab_alloc+0x31d/0x6f0
 __alloc_pages_nodemask+0x27f/0x2c0
 alloc_pages_vma+0x75/0x220
 shmem_alloc_page+0x46/0x90
 ? release_pages+0x1ae/0x410
 shmem_alloc_and_acct_page+0x77/0x1c0
 shmem_getpage_gfp+0x162/0x910
 shmem_fault+0x74/0x210
 ? filemap_map_pages+0x29c/0x410
 __do_fault+0x37/0x190
 handle_mm_fault+0x120a/0x1770
 exc_page_fault+0x251/0x450
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ffdc622e5828..5974b449d783 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7098,6 +7098,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
@@ -7163,6 +7166,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
+	if (mem_cgroup_disabled())
+		return 0;
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
-- 
1.8.3.1

