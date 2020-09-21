Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87109271938
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIUCTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:19:01 -0400
Received: from smtp.h3c.com ([60.191.123.50]:12388 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUCTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:19:01 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 08L2Hqvn057876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 10:17:52 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 10:17:53 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] nvme: replace meaningless judgement by checking whether req is null
Date:   Mon, 21 Sep 2020 10:10:52 +0800
Message-ID: <20200921021052.10462-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08L2Hqvn057876
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We met a crash issue when hot-insert a nvme device, blk_mq_tag_to_rq()
returned null(req=null), then crash happened in nvme_end_request():
	req = blk_mq_tag_to_rq();
        struct nvme_request *rq = nvme_req(req); //rq = req + 1
        rq->result = result;  <==crash here!!!

        [ 1124.256246] nvme nvme5: pci function 0000:e1:00.0
        [ 1124.256323] nvme 0000:e1:00.0: enabling device (0000 -> 0002)
        [ 1125.720859] nvme nvme5: 96/0/0 default/read/poll queues
        [ 1125.732483]  nvme5n1: p1 p2 p3
        [ 1125.788049] BUG: unable to handle kernel NULL pointer dereference at 0000000000000130
        [ 1125.788054] PGD 0 P4D 0
        [ 1125.788057] Oops: 0002 [#1] SMP NOPTI
        [ 1125.788059] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G
						------- -t - 4.18.0-147.el8.x86_64 #1
        [ 1125.788065] RIP: 0010:nvme_irq+0xe8/0x240 [nvme]
        [ 1125.788068] RSP: 0018:ffff916b8ec83ed0 EFLAGS: 00010813
        [ 1125.788069] RAX: 0000000000000000 RBX: ffff918ae9211b00 RCX: 0000000000000000
        [ 1125.788070] RDX: 000000000000400b RSI: 0000000000000000 RDI: 0000000000000000
        [ 1125.788071] RBP: ffff918ae8870000 R08: 0000000000000004 R09: ffff918ae8870000
        [ 1125.788072] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
        [ 1125.788073] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
        [ 1125.788075] FS:  0000000000000000(0000) GS:ffff916b8ec80000(0000) knlGS:0000000000000000
        [ 1125.788075] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        [ 1125.788076] CR2: 0000000000000130 CR3: 0000001768f00000 CR4: 0000000000340ee0
        [ 1125.788077] Call Trace:
        [ 1125.788080]  <IRQ>
        [ 1125.788085]  __handle_irq_event_percpu+0x40/0x180
        [ 1125.788087]  handle_irq_event_percpu+0x30/0x80
        [ 1125.788089]  handle_irq_event+0x36/0x53
        [ 1125.788090]  handle_edge_irq+0x82/0x190
        [ 1125.788094]  handle_irq+0xbf/0x100
        [ 1125.788098]  do_IRQ+0x49/0xd0
        [ 1125.788100]  common_interrupt+0xf/0xf

The analysis of the possible cause of above crash as below.

According to the test for io queues, in nvme_pci_enable(), 'dev->q_depth'
is set to 1024; in nvme_create_io_queues()->nvme_alloc_queue(),
'nvmeq->q_depth' is set to 'dev->q_depth'; in nvme_dev_add(),
'dev->tagset.queue_depth' is set to 1023:
         dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
						BLK_MQ_MAX_DEPTH) - 1;
So we got below values for multiple depth:
dev->q_depth            = 1024
dev->tagset.queue_depth = 1023
nvmeq->q_depth          = 1024

In blk_mq_alloc_rqs(), it allocated 1023(dev->tagset.queue_depth) rqs for
one hw queue. In nvme_alloc_queue(), it allocated 1024(nvmeq->q_depth)
cqes for nvmeq->cqes[]. When process cqe in nvme_handle_cqe(), it get it
by:
	struct nvme_completion *cqe = &nvmeq->cqes[idx];

We also added below prints in nvme_handle_cqe() and blk_mq_tag_to_rq():
	static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
	{
		volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
		struct request *req;

		//debug print
		dev_warn(nvmeq->dev->ctrl.device,
			"command_id %d completed on queue %d, nvmeq q_depth %d,
			 nvme tagset q_depth %d, admin q_depth %d\n",
		 	 cqe->command_id, le16_to_cpu(cqe->sq_id),
			 nvmeq->q_depth, nvmeq->dev->tagset.queue_depth,
			 nvmeq->dev->admin_tagset.queue_depth);

		if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
			dev_warn(nvmeq->dev->ctrl.device,
				"invalid id %d completed on queue %d\n",
				cqe->command_id, le16_to_cpu(cqe->sq_id));
			return;
		}

		... ...

		req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
		... ...
	}

	struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags,unsigned int tag)
	{
		//debug print
		printk("tag, nr_tags:%d %d\n", tag, tags->nr_tags);
		if (tag < tags->nr_tags) {
			prefetch(tags->rqs[tag]);
			return tags->rqs[tag];
		}

		return NULL;
	}

According to the output, we know the max tag number(nr_tags) is 1023, but
nvmeq->q_depth is 1024 and nvmeq->cqes[] has 1024 cqes. So if command_id
(tag) is 1023, the judgement "if (unlikely(cqe->command_id >= nvmeq->q_depth))"
in nvme_handle_cqe() is useless, we will get a null pointer, which is
returned by blk_mq_tag_to_rq():
	[   16.649973] nvme nvme0: command_id 968 completed on queue 13,
			nvmeq q_depth 1024, nvme tagset q_depth 1023, admin q_depth 30
	[   16.649974] tag, nr_tags:968 1023

In function blk_mq_alloc_map_and_requests(), it will adjust tagset depth by
'set->queue_depth >>= 1' if there is no enough memory for rqs. If this happens,
the real available number of tags(nr_tags) is much smaller than nvmeq->q_depth.
So the judgement "if (unlikely(cqe->command_id >= nvmeq->q_depth))" is really
meaningless.

It has the same issue for nvme admin queue, whose nvmeq->q_depth is 32, but
tagset depth is 30:
	[    7.489345] nvme nvme2: command id 24 completed on queue 0,
			nvmeq q_depth 32, nvme tagset q_depth 0, admin q_depth 30
	[    7.489347] tag, nr_tags:24 30

This patch is to remove the meaningless judgement, we check whether the returned
req is null, if it is null, directly return. So with this patch, we can avoid a
potential null pointer deference.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/nvme/host/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7..18a857b59 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
-	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
-		dev_warn(nvmeq->dev->ctrl.device,
-			"invalid id %d completed on queue %d\n",
-			cqe->command_id, le16_to_cpu(cqe->sq_id));
-		return;
-	}
-
 	/*
 	 * AEN requests are special as they don't time out and can
 	 * survive any kind of queue freeze and often don't respond to
@@ -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	if (unlikely(!req)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"req is null for tag %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.17.1

