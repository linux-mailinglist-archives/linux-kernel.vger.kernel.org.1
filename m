Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCE2574C2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHaHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 03:55:31 -0400
Received: from smtp.h3c.com ([60.191.123.56]:28759 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgHaHzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:55:31 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07V725q5024120
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:02:05 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07V704Zl018891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 15:00:04 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 15:00:07 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()
Date:   Mon, 31 Aug 2020 14:53:11 +0800
Message-ID: <20200831065311.40731-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07V704Zl018891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We met a crash issue when hot-insert a nvme device, blk_mq_tag_to_rq()
returned null(req=null), then crash happened in nvme_end_request():
	struct nvme_request *rq = nvme_req(req);
	rq->result = result;  <==crash here

The test env is, a server is configured with 2 backplanes, each backplane
support 8 nvme devices, this crash happened when hot-insert a nvme device
to the second backplane. We measured the signal, which is send out of cpu
to ack nvme interrupt, the signal is very weak when it reached the second
backplane, the device can't distinguish it as a ack signal. So it caused
the device can't clear the interrupt flag.
After updating related driver, the signal sending out of cpu to the second
backplane is good, the crash issue disappeared.

As blk_mq_tag_to_rq() may return null, so it should be check whether it is
null before using it to prevent a crash.

	[ 1124.256246] nvme nvme5: pci function 0000:e1:00.0
	[ 1124.256323] nvme 0000:e1:00.0: enabling device (0000 -> 0002)
	[ 1125.720859] nvme nvme5: 96/0/0 default/read/poll queues
	[ 1125.732483]  nvme5n1: p1 p2 p3
	[ 1125.788049] BUG: unable to handle kernel NULL pointer dereference at 0000000000000130
	[ 1125.788054] PGD 0 P4D 0
	[ 1125.788057] Oops: 0002 [#1] SMP NOPTI
	[ 1125.788059] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G   --------- -t - 4.18.0-147.el8.x86_64 #1
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
 drivers/nvme/host/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47..32712a41c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -939,6 +939,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
+	struct blk_mq_tags *tags;
 
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
@@ -959,7 +960,15 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	tags = nvme_queue_tagset(nvmeq);
+	req = blk_mq_tag_to_rq(tags, cqe->command_id);
+	if (unlikely(!req)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"req is null(tag:%d nr_tags:%d) on queue %d\n"
+			cqe->command_id, tags->nr_tags, le16_to_cpu(cqe->sq_id);
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_end_request(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.17.1

