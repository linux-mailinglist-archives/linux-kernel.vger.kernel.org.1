Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1C2A0DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgJ3SnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:43:24 -0400
Received: from m12-13.163.com ([220.181.12.13]:57815 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3SnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=r3Pis
        AmoB8zoaScdLcnMR1LEUmjIXEEB4sONesOEdjQ=; b=lFTsSwHoYDkpwaUQk1ulL
        /3hlEgXX0Ezg4R206hr3tq5O0LrGy1qWGYVL9M4rTR4k7tBpxNx+tahaL2zVNh73
        /fKnMB7mZsqqztImnptKN2yl3IMrdEmGy3sH35juY8DswSiwm67zko1F37yKhmPb
        pzZSMQQAjFYz8pGs47u6DM=
Received: from localhost (unknown [101.86.209.82])
        by smtp9 (Coremail) with SMTP id DcCowACnCGj4Wpxfg5sdOA--.7945S2;
        Sat, 31 Oct 2020 02:27:05 +0800 (CST)
Date:   Sat, 31 Oct 2020 02:27:04 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/oom_kill: change comment and rename
 is_dump_unreclaim_slabs()
Message-ID: <20201030182704.GA53949@rlk>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
 <20201027151156.GA4336@rlk>
 <20201027192322.GA20500@dhcp22.suse.cz>
 <20201028153141.GB77196@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028153141.GB77196@rlk>
X-CM-TRANSID: DcCowACnCGj4Wpxfg5sdOA--.7945S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7AF4fAFykZr15Zry7Jrb_yoW8GFW3p3
        Z3ta4Utw4rtFZIqFZ3CF4q9F1Fv3y8KF9xGry3Kw1UCw15Jw1Duay8CryjkrnxXFyxGFsx
        XrWakr1kZF1UZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPnYwUUUUU=
X-Originating-IP: [101.86.209.82]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbifxnNX1r6mZj43AAAsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comment of is_dump_unreclaim_slabs(), it just check
whether nr_unreclaimable slabs amount is greater than user
memory, and explain why we dump unreclaim slabs.

Rename it to should_dump_unreclaim_slab() maybe better.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/oom_kill.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661a6410..04b19b7b5435 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -170,11 +170,13 @@ static bool oom_unkillable_task(struct task_struct *p)
 	return false;
 }
 
-/*
- * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
- * than all user memory (LRU pages)
- */
-static bool is_dump_unreclaim_slabs(void)
+/**
+ * Check whether unreclaimable slab amount is greater than
+ * all user memory(LRU pages).
+ * dump_unreclaimable_slab() could help in the case that
+ * oom due to too much unreclaimable slab used by kernel.
+*/
+static bool should_dump_unreclaim_slab(void)
 {
 	unsigned long nr_lru;
 
@@ -463,7 +465,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
-		if (is_dump_unreclaim_slabs())
+		if (should_dump_unreclaim_slab())
 			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
-- 
2.29.0


