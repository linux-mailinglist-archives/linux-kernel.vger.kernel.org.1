Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2A253BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH0Cch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 22:32:37 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55042 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgH0Cch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:32:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U6yzcF2_1598495549;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6yzcF2_1598495549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Aug 2020 10:32:34 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3] mm: memcg: Fix memcg reclaim soft lockup
Date:   Thu, 27 Aug 2020 10:32:29 +0800
Message-Id: <1598495549-67324-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
the target memcg doesn't have any reclaimable memory.

It can be easily reproduced as below:
 watchdog: BUG: soft lockup - CPU#0 stuck for 111s![memcg_test:2204]
 CPU: 0 PID: 2204 Comm: memcg_test Not tainted 5.9.0-rc2+ #12
 Call Trace:
  shrink_lruvec+0x49f/0x640
  shrink_node+0x2a6/0x6f0
  do_try_to_free_pages+0xe9/0x3e0
  try_to_free_mem_cgroup_pages+0xef/0x1f0
  try_charge+0x2c1/0x750
  mem_cgroup_charge+0xd7/0x240
  __add_to_page_cache_locked+0x2fd/0x370
  add_to_page_cache_lru+0x4a/0xc0
  pagecache_get_page+0x10b/0x2f0
  filemap_fault+0x661/0xad0
  ext4_filemap_fault+0x2c/0x40
  __do_fault+0x4d/0xf9
  handle_mm_fault+0x1080/0x1790

It only happens on our 1-vcpu instances, because there's no chance
for oom reaper to run to reclaim the to-be-killed process.

Add a cond_resched() at the upper shrink_node_memcgs() to solve this
issue, this will mean that we will get a scheduling point for each
memcg in the reclaimed hierarchy without any dependency on the
reclaimable memory in that memcg thus making it more predictable.

Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/vmscan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796..9727dd8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2615,6 +2615,14 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long reclaimed;
 		unsigned long scanned;
 
+		/*
+		 * This loop can become CPU-bound when target memcgs
+		 * aren't eligible for reclaim - either because they
+		 * don't have any reclaimable pages, or because their
+		 * memory is explicitly protected. Avoid soft lockups.
+		 */
+		cond_resched();
+
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(memcg)) {
-- 
1.8.3.1

