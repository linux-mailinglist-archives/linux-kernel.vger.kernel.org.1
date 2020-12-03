Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A02CCFC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgLCGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:47:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8925 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgLCGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:47:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmmZR3xBZz781v;
        Thu,  3 Dec 2020 14:46:07 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 14:46:23 +0800
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH 1/2] sched: Move '\n' to the prior seq_printf in
 show_schedstat()
Message-ID: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
Date:   Thu, 3 Dec 2020 14:46:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little clean up that moving the '\n' to the prior seq_printf. and
remove the separate seq_printf which for line breaks.

No functional changes.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/sched/stats.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..e99403df3f90 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -30,15 +30,13 @@ static int show_schedstat(struct seq_file *seq, void *v)

 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu\n",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);

-		seq_printf(seq, "\n");
-
 #ifdef CONFIG_SMP
 		/* domain-specific stats */
 		rcu_read_lock();
-- 
2.18.4
