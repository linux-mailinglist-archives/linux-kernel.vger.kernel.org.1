Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175F2C5EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392294AbgK0DIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:08:42 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60086 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392286AbgK0DIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:08:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UGebCV9_1606446518;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGebCV9_1606446518)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Nov 2020 11:08:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec
Date:   Fri, 27 Nov 2020 11:08:35 +0800
Message-Id: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
so we could get out early in the situation to avoid useless checking.

Also warning if both parameter are NULL.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3e6a1df3bdb9..4cdb110f84e0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -613,14 +613,13 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	struct mem_cgroup_per_node *mz;
 	struct lruvec *lruvec;
 
-	if (mem_cgroup_disabled()) {
+	VM_WARN_ON_ONCE(!memcg && !pgdat);
+
+	if (mem_cgroup_disabled() || !memcg) {
 		lruvec = &pgdat->__lruvec;
 		goto out;
 	}
 
-	if (!memcg)
-		memcg = root_mem_cgroup;
-
 	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
 	lruvec = &mz->lruvec;
 out:
-- 
2.29.GIT

