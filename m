Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863791E5DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgE1LBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:01:43 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52084 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388073AbgE1LBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:01:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TztM4bJ_1590663683;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztM4bJ_1590663683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v11 00/16] per memcg lru lock
Date:   Thu, 28 May 2020 19:00:42 +0800
Message-Id: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version which bases on linux-next 

Johannes Weiner has suggested:
"So here is a crazy idea that may be worth exploring:

Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
linked list.

Can we make PageLRU atomic and use it to stabilize the lru_lock
instead, and then use the lru_lock only serialize list operations?
..."

With new memcg charge path and this solution, we could isolate
LRU pages to exclusive visit them in compaction, page migration, reclaim,
memcg move_accunt, huge page split etc scenarios while keeping pages' 
memcg stable. Then possible to change per node lru locking to per memcg
lru locking. As to pagevec_lru_move_fn funcs, it would be safe to let
pages remain on lru list, lru lock could guard them for list integrity.

The patchset includes 3 parts:
1, some code cleanup and minimum optimization as a preparation.
2, use TestCleanPageLRU as page isolation's precondition
3, replace per node lru_lock with per memcg per node lru_lock

The 3rd part moves per node lru_lock into lruvec, thus bring a lru_lock for
each of memcg per node. So on a large machine, each of memcg don't
have to suffer from per node pgdat->lru_lock competition. They could go
fast with their self lru_lock

Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
containers on a 2s * 26cores * HT box with a modefied case:
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice

With this patchset, the readtwice performance increased about 80%
in concurrent containers.

Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
idea 8 years ago, and others who give comments as well: Daniel Jordan, 
Mel Gorman, Shakeel Butt, Matthew Wilcox etc.

Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!


Alex Shi (14):
  mm/vmscan: remove unnecessary lruvec adding
  mm/page_idle: no unlikely double check for idle page counting
  mm/compaction: correct the comments of compact_defer_shift
  mm/compaction: rename compact_deferred as compact_should_defer
  mm/thp: move lru_add_page_tail func to huge_memory.c
  mm/thp: clean up lru_add_page_tail
  mm/thp: narrow lru locking
  mm/memcg: add debug checking in lock_page_memcg
  mm/lru: introduce TestClearPageLRU
  mm/compaction: do page isolation first in compaction
  mm/mlock: reorder isolation sequence during munlock
  mm/lru: replace pgdat lru_lock with lruvec lock
  mm/lru: introduce the relock_page_lruvec function
  mm/pgdat: remove pgdat lru_lock

Hugh Dickins (2):
  mm/vmscan: use relock for move_pages_to_lru
  mm/lru: revise the comments of lru_lock

 Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |   8 +-
 Documentation/trace/events-kmem.rst                |   2 +-
 Documentation/vm/unevictable-lru.rst               |  22 +--
 include/linux/compaction.h                         |   4 +-
 include/linux/memcontrol.h                         |  92 +++++++++++
 include/linux/mm_types.h                           |   2 +-
 include/linux/mmzone.h                             |   6 +-
 include/linux/page-flags.h                         |   1 +
 include/linux/swap.h                               |   4 +-
 include/trace/events/compaction.h                  |   2 +-
 mm/compaction.c                                    | 104 ++++++++-----
 mm/filemap.c                                       |   4 +-
 mm/huge_memory.c                                   |  51 +++++--
 mm/memcontrol.c                                    |  87 ++++++++++-
 mm/mlock.c                                         |  93 ++++++------
 mm/mmzone.c                                        |   1 +
 mm/page_alloc.c                                    |   1 -
 mm/page_idle.c                                     |   8 -
 mm/rmap.c                                          |   2 +-
 mm/swap.c                                          | 112 ++++----------
 mm/swap_state.c                                    |   6 +-
 mm/vmscan.c                                        | 168 +++++++++++----------
 mm/workingset.c                                    |   4 +-
 24 files changed, 487 insertions(+), 312 deletions(-)

-- 
1.8.3.1

