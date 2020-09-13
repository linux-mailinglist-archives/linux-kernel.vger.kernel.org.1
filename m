Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCD267F01
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMJqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:46:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgIMJqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:46:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A6B35EFA84FF159A47B;
        Sun, 13 Sep 2020 17:46:10 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 17:46:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH RESEND] mm: memcontrol: Correct the comment of mem_cgroup_iter()
Date:   Sun, 13 Sep 2020 05:44:46 -0400
Message-ID: <20200913094446.47317-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9da83f3fc74b ("mm, memcg: clean up reclaim iter array"), the
arg @reclaim has no priority field anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..a57aa0f42d40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1138,9 +1138,9 @@ static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
  * invocations for reference counting, or use mem_cgroup_iter_break()
  * to cancel a hierarchy walk before the round-trip is complete.
  *
- * Reclaimers can specify a node and a priority level in @reclaim to
- * divide up the memcgs in the hierarchy among all concurrent
- * reclaimers operating on the same node and priority.
+ * Reclaimers can specify a node in @reclaim to divide up the memcgs
+ * in the hierarchy among all concurrent reclaimers operating on the
+ * same node.
  */
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
-- 
2.19.1

