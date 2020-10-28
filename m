Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A629D57F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgJ1WDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:03:22 -0400
Received: from m12-18.163.com ([220.181.12.18]:52754 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbgJ1WDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=nAs3v
        bkCmcV6Oy/GkOcEF/dH1rSAqiDrs/rbgl/Dt0I=; b=qUigTwMcCWIF+OxcrVy8g
        cA8If80/dMbSNmPzz/m3D3doUZNlVPvjgjjQ5H0GD3UdmfA478UCyqGCeya3hMsk
        Qp2C0MLBgyL6fqzdBO00lu2V6rhv/UC79dsGVgYHkPriES2abYgQJmgeCbQOvy0T
        47yZWxHAxieyMYxbCfZNZE=
Received: from localhost (unknown [101.86.209.121])
        by smtp14 (Coremail) with SMTP id EsCowAC314PdjplfhT2uAg--.3425S2;
        Wed, 28 Oct 2020 23:31:41 +0800 (CST)
Date:   Wed, 28 Oct 2020 23:31:41 +0800
From:   Hui Su <sh_def@163.com>
To:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, sh_def@163.com
Subject: [PATCH v3] mm/oom_kill: remove comment and rename
 is_dump_unreclaim_slabs()
Message-ID: <20201028153141.GB77196@rlk>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
 <20201027151156.GA4336@rlk>
 <20201027192322.GA20500@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027192322.GA20500@dhcp22.suse.cz>
X-CM-TRANSID: EsCowAC314PdjplfhT2uAg--.3425S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18Wr4xWryrZw4DZw4rGrg_yoW8Xr1Up3
        Z3t34Dtw4rtrZI9F4xCr429r1avws5KFyfJr9xKw18Zw15Xw1UurW8C342vr9IqFyrAFs3
        JrWayr4kZ3WDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uzq2_UUUUU=
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMR3LX1UMWJ7UYAAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment for is_dump_unreclaim_slabs is not really clear whether it is
meant to instruct how to use the function or whether it is an outdated
information of the past implementation of the function. it doesn't realy
help that is_dump_unreclaim_slabs is hard to grasp on its own.

Rename the helper to should_dump_unreclaim_slabs which should make it
clear what it is meant to do and drop the comment as the purpose
should be pretty evident now.

Signed-off-by: Hui Su <sh_def@163.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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
2.29.0


