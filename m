Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD026D9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIQLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:10:41 -0400
Received: from smtp.h3c.com ([60.191.123.56]:12145 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:10:00 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:09:53 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 08H8KxqD004707;
        Thu, 17 Sep 2020 16:20:59 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08H8KLjE002243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 16:20:21 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 16:20:22 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] blk-mq: add cond_resched() in __blk_mq_alloc_rq_maps()
Date:   Thu, 17 Sep 2020 16:13:11 +0800
Message-ID: <20200917081311.11428-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08H8KLjE002243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found it takes more time of blk_mq_alloc_rq_maps() in kernel space when
testing nvme hot-plugging. The test and anlysis as below.

Debug code,
1, blk_mq_alloc_rq_maps():
        u64 start, end;
        depth = set->queue_depth;
        start = ktime_get_ns();
        pr_err("[%d:%s switch:%ld,%ld] queue depth %d, nr_hw_queues %d\n",
                        current->pid, current->comm, current->nvcsw, current->nivcsw,
                        set->queue_depth, set->nr_hw_queues);
        do {
                err = __blk_mq_alloc_rq_maps(set);
                if (!err)
                        break;

                set->queue_depth >>= 1;
                if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN) {
                        err = -ENOMEM;
                        break;
                }
        } while (set->queue_depth);
        end = ktime_get_ns();
        pr_err("[%d:%s switch:%ld,%ld] all hw queues init cost time %lld ns\n",
                        current->pid, current->comm,
                        current->nvcsw, current->nivcsw, end - start);

2, __blk_mq_alloc_rq_maps():
        u64 start, end;
        for (i = 0; i < set->nr_hw_queues; i++) {
                start = ktime_get_ns();
                if (!__blk_mq_alloc_rq_map(set, i))
                        goto out_unwind;
                end = ktime_get_ns();
                pr_err("hw queue %d init cost time %lld\n", i, end - start);
        }

Test nvme hot-plugging with above debug code, we found it totally cost more
than 3ms in kernel space without being scheduled out when alloc rqs for all
16 hw queues with depth 1024, each hw queue cost about 140-250us. The time
cost will be increased with hw queue number and queue depth increasing. And
if __blk_mq_alloc_rq_maps() returns -ENOMEM, it will try "queue_depth >>= 1",
more time will be consumed.
	[  428.428771] nvme nvme0: pci function 10000:01:00.0
	[  428.428798] nvme 10000:01:00.0: enabling device (0000 -> 0002)
	[  428.428806] pcieport 10000:00:00.0: can't derive routing for PCI INT A
	[  428.428809] nvme 10000:01:00.0: PCI INT A: no GSI
	[  432.593374] [4688:kworker/u33:8 switch:663,2] queue depth 30, nr_hw_queues 1
	[  432.593404] hw queue 0 init cost time 22883 ns
	[  432.593408] [4688:kworker/u33:8 switch:663,2] all hw queues init cost time 35960 ns
	[  432.595953] nvme nvme0: 16/0/0 default/read/poll queues
	[  432.595958] [4688:kworker/u33:8 switch:700,2] queue depth 1023, nr_hw_queues 16
	[  432.596203] hw queue 0 init cost time 242630 ns
	[  432.596441] hw queue 1 init cost time 235913 ns
	[  432.596659] hw queue 2 init cost time 216461 ns
	[  432.596877] hw queue 3 init cost time 215851 ns
	[  432.597107] hw queue 4 init cost time 228406 ns
	[  432.597336] hw queue 5 init cost time 227298 ns
	[  432.597564] hw queue 6 init cost time 224633 ns
	[  432.597785] hw queue 7 init cost time 219954 ns
	[  432.597937] hw queue 8 init cost time 150930 ns
	[  432.598082] hw queue 9 init cost time 143496 ns
	[  432.598231] hw queue 10 init cost time 147261 ns
	[  432.598397] hw queue 11 init cost time 164522 ns
	[  432.598542] hw queue 12 init cost time 143401 ns
	[  432.598692] hw queue 13 init cost time 148934 ns
	[  432.598841] hw queue 14 init cost time 147194 ns
	[  432.598991] hw queue 15 init cost time 148942 ns
	[  432.598993] [4688:kworker/u33:8 switch:700,2] all hw queues init cost time 3035099 ns
	[  432.602611]  nvme0n1: p1

So use this patch to trigger schedule between each hw queue init, to avoid
other threads getting stuck. We call cond_resched() only when
"queue depth >= 512". We are not in atomic context when executing
__blk_mq_alloc_rq_maps(), so it is safe to call cond_resched().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785ee..5a71fe53a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3255,11 +3255,16 @@ void blk_mq_exit_queue(struct request_queue *q)
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
+	unsigned int depth = set->queue_depth;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = 0; i < set->nr_hw_queues; i++) {
 		if (!__blk_mq_alloc_map_and_request(set, i))
 			goto out_unwind;
 
+		if (depth >= 512)
+			cond_resched();
+	}
+
 	return 0;
 
 out_unwind:
-- 
2.17.1

