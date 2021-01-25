Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2483025A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbhAYNnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:43:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11588 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbhAYNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:40:04 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPVm41ftRzMPjk;
        Mon, 25 Jan 2021 21:17:56 +0800 (CST)
Received: from huawei.com (10.175.100.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 25 Jan 2021
 21:19:17 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        Tang Yizhou <tangyizhou@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3] mm, oom: Fix a comment in dump_task
Date:   Mon, 25 Jan 2021 21:30:06 +0800
Message-ID: <20210125133006.7242-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.100.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If p is a kthread, it will be checked in oom_unkillable_task() so
we can delete the corresponding comment.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v2: Update CC list
v3: Add Acked-by tags
 mm/oom_kill.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 04b19b7b5435..9f043ad29554 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -395,9 +395,8 @@ static int dump_task(struct task_struct *p, void *arg)
 	task = find_lock_task_mm(p);
 	if (!task) {
 		/*
-		 * This is a kthread or all of p's threads have already
-		 * detached their mm's.  There's no need to report
-		 * them; they can't be oom killed anyway.
+		 * All of p's threads have already detached their mm's. There's
+		 * no need to report them; they can't be oom killed anyway.
 		 */
 		return 0;
 	}
-- 
2.22.0

