Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D54273AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgIVGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:33:20 -0400
Received: from smtp.h3c.com ([60.191.123.56]:3441 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgIVGdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:33:19 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08M6WGU6032330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 14:32:16 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 14:32:19 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] nvme: replace meaningless judgement by checking whether req is null
Date:   Tue, 22 Sep 2020 14:25:17 +0800
Message-ID: <20200922062517.30031-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08M6WGU6032330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we use nvmeq->q_depth as the upper limit for a valid tag in
nvme_handle_cqe(), it is not correct. Because the available tag number
is recorded in tagset, which is not equal to nvmeq->q_depth.

The nvme driver registers interrupts for queues before initializing the
tagset, because it uses the number of successful request_irq() calls to
configure the tagset parameters. This allows a race condition with the
current tag validity check if the controller happens to produce an
interrupt with a corrupted CQE before the tagset is initialized.

Replace the driver's indirect tag check with the one already provided by
the block layer. With this patch, we can avoid a null pointer deference
as below.

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

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/nvme/host/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7..f7cf01fc7 100644
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
+			"invalid id %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.17.1

