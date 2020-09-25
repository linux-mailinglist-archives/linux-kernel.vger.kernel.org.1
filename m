Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61DC278EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgIYQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:37:13 -0400
Received: from m12-11.163.com ([220.181.12.11]:46136 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgIYQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:37:12 -0400
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 12:37:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=VAiDN
        5izywlcFtHGGT3R5aMJtZWXNyvaAdmazyXoxoA=; b=Omz7qZJ9fqj4l1cmnri9G
        //l1zLOQHzyjjz2ueGVPVVN6UyqqLbY0SEmuFo5PqGttGba0awiJvXkYZvudv9XZ
        2AfaBYzVk8XjDjhewpHXjngqmJGoRoMUnENboqBr4pTbB6ZD3W+dh3nue+MlFQ1f
        SPfHKu7WDk7TV1H+r8JfEw=
Received: from localhost (unknown [101.86.214.224])
        by smtp7 (Coremail) with SMTP id C8CowADn909HGG5fMorxIQ--.36706S2;
        Sat, 26 Sep 2020 00:18:16 +0800 (CST)
Date:   Sat, 26 Sep 2020 00:18:15 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched,fair: fix the spelling of enqueued
Message-ID: <20200925161815.GA43460@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowADn909HGG5fMorxIQ--.36706S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4UKrykAF4kCF4Dur17ZFb_yoWxKFc_uw
        n8ur4Skw18tF90vr13uw4fZr18ta40gFyfCwnrX3yUJry0qr9xGasYkF95A3Z5GrZrZF9x
        XrnxZ3Z3ur1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0vPfPUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgiqX1v2eVi9IgAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just fix the spelling of enqueued.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..fadee2b05df3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -753,7 +753,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	if (entity_is_task(se))
 		sa->load_avg = scale_load_down(se->load.weight);
 
-	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
+	/* when this task enqueued, it will contribute to its cfs_rq's load_avg */
 }
 
 static void attach_entity_cfs_rq(struct sched_entity *se);
-- 
2.25.1


