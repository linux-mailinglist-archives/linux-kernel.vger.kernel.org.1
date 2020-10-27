Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653B229B338
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750701AbgJ0Oqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:46:52 -0400
Received: from m12-14.163.com ([220.181.12.14]:53626 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764211AbgJ0Oqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=qRSwq
        qYn8eMUkH/WPS6Vqf/NxeLLNq6KzEsp3gJzgeM=; b=nAZ32Tb0oWw8wmm71pfgu
        +uOSgzTUp7B3FA5HmkMnShqc2o3nJeP869WEvY7/4HTfE9Gtmt0fG4wdu6wCd44O
        errZ/Fvm5/Nhd09HjB2GWU3E/LViZaCZ1BkB4nYBEykOE7BtToiQAsFodPwxSFWT
        9c2tBt6Olr7cjRWaoELs9E=
Received: from localhost (unknown [101.86.209.121])
        by smtp10 (Coremail) with SMTP id DsCowAAnNpqKMphfezi7SQ--.36729S2;
        Tue, 27 Oct 2020 22:45:30 +0800 (CST)
Date:   Tue, 27 Oct 2020 22:45:29 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/oom_kill.c: remove the unmatched comments
Message-ID: <20201027144529.GA3558@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowAAnNpqKMphfezi7SQ--.36729S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1UGw43Cw1DWFW7Kr17Wrg_yoWkZwcEva
        yqvw1DKrWDWasxCFWxGrn3Jr9Ig395Za4UXry8trWftryUAr1fWr4IqrnrJFy5ZFW8Ca45
        WFnrJr43Ar1ayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUneWlDUUUUU==
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitwrKX1aEGMnAZQAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_dump_unreclaim_slabs() just check whether nr_unreclaimable
slabs amount is greater than user memory, not match witch comment.

So delete the comment, and rename it to should_dump_unreclaim_slabs().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/oom_kill.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661a6410..d181e24d7193 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -170,11 +170,7 @@ static bool oom_unkillable_task(struct task_struct *p)
 	return false;
 }
 
-/*
- * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
- * than all user memory (LRU pages)
- */
-static bool is_dump_unreclaim_slabs(void)
+static bool should_dump_unreclaim_slabs(void)
 {
 	unsigned long nr_lru;
 
@@ -463,7 +459,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
-		if (is_dump_unreclaim_slabs())
+		if (should_dump_unreclaim_slabs())
 			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
-- 
2.25.1


