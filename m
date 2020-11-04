Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E102A5E08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgKDGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:10:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:9224 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgKDGKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:10:16 -0500
IronPort-SDR: Hr5whkKZVbrjr7+nzmet1m/bypHlOZ7zqezUeSuUyVD5oW0TppoyL4aKQfxjTNNrU5SlN4DQZu
 nf1Q5XBF2sHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="187029561"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="187029561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 22:10:15 -0800
IronPort-SDR: txYcJcMOluOi+dwb9fPJCb8Z7iIMmkGOc1fntRQlHry7dsQAOZGxoM4G7PIyX3HW6xn/XIJDIC
 h7BsqmIcpR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="325489774"
Received: from shbuild999.sh.intel.com ([10.239.147.98])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 22:10:13 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH 1/2] mm, oom: dump meminfo for all memory nodes
Date:   Wed,  4 Nov 2020 14:10:09 +0800
Message-Id: <1604470210-124827-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some OOM cases, if there is memory node binding(current->mems_allowed
is not NULL), system may only print the meminfo for these bound nodes,
while other nodes' info could still be important for debugging.

For example on a platform with one normal node (has DMA/DMA32/NORMAL...
zones) and one node which only has movable zone (either for memory hotplug
case or a persistent memory node), some user will run docker while binding
memory to the movable node. many memory allocations originated from the
docker instance will fall back to the other node, and when a OOM happens,
meminfo for both nodes are needed.

So extend the show_mem() to cover all memory nodes.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661..601476cc 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -462,7 +462,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
-		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
+		show_mem(SHOW_MEM_FILTER_NODES, &node_states[N_MEMORY]);
 		if (is_dump_unreclaim_slabs())
 			dump_unreclaimable_slab();
 	}
-- 
2.7.4

