Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713E32B3E65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKPIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:15:16 -0500
Received: from m12-18.163.com ([220.181.12.18]:60513 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKPIPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6bJg3ejTvq9DaiVDjf
        gwpQMA4ibvyR5v08cg9A9UN64=; b=ADKc3XSu1C9+3zzQDt8iyXavYVVnpbJbp9
        gNHDFZRSK0FnKO71rShaCFSBPR7JZ+MaVnpu652FoDAB9X1bE9WZVsUpfL9fEAT7
        V4VV93x75U4GJC7TVcz3OBf3xgqFuU/jY3k1/nX3s6PP9Q4HaAA+pPI9dzsDjzLe
        vjOqogkPU=
Received: from localhost.localdomain (unknown [223.104.212.42])
        by smtp14 (Coremail) with SMTP id EsCowACnrQn_NLJfzqOBEQ--.14367S2;
        Mon, 16 Nov 2020 16:14:56 +0800 (CST)
From:   jackygam2001 <jacky_gam_2001@163.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jackygam2001 <jacky_gam_2001@163.com>
Subject: [PATCH] NVME:target:rdma fix bug nonemtpy wait list of queue causing kernel panic
Date:   Mon, 16 Nov 2020 08:14:53 +0000
Message-Id: <20201116081453.74644-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowACnrQn_NLJfzqOBEQ--.14367S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Aw45tw4DKFy7GF15Jwb_yoW8KFyrpF
        WrGr13ua97tr4Ik3y3Aa4UWFWSqw4rur47AryxGwn8JF4jyrWrXanxG3srZry8GF97Jr4r
        CF1Dtrsaka1rJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWq2iUUUUU=
X-Originating-IP: [223.104.212.42]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBXgHeKVaD4iYWGQAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in our lab, when target is processing queue's connection
(queue->state==NVMET_RDMA_Q_CONNECTING), and the host sends
a command which will be put into wait list to target,
Before the command was processed, the host sent a discconnect
command to target, then the target will process disconnect command,
it will schedule a kworker to free the pre allocatedrsps array, and
it will cause kernel panic, because some items of rsps are in wait list.

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
---
 drivers/nvme/target/rdma.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ae6620489457..c6c892a43f68 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1335,6 +1335,35 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 		       queue->send_queue_size + 1);
 }
 
+static void nvmet_rdma_destroy_queue_wait_list(struct nvmet_rdma_queue *queue)
+{
+	unsigned long flags;
+	struct nvmet_rdma_rsp *rsp;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	while (!list_empty(&queue->rsp_wait_list)) {
+		rsp = list_first_entry(&queue->rsp_wait_list,
+				struct nvmet_rdma_rsp, wait_list);
+		list_del(&rsp->wait_list);
+		nvmet_rdma_put_rsp(rsp);
+	}
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+}
+
+static void nvmet_rdma_destroy_queue_wr_wait_list(struct nvmet_rdma_queue *queue)
+{
+	struct nvmet_rdma_rsp *rsp;
+
+	spin_lock(&queue->rsp_wr_wait_lock);
+	while (!list_empty(&queue->rsp_wr_wait_list)) {
+		rsp = list_first_entry(&queue->rsp_wr_wait_list,
+				struct nvmet_rdma_rsp, wait_list);
+		list_del(&rsp->wait_list);
+		nvmet_rdma_put_rsp(rsp);
+	}
+	spin_unlock(&queue->rsp_wr_wait_lock);
+}
+
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
@@ -1347,6 +1376,8 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 				queue->recv_queue_size,
 				!queue->host_qid);
 	}
+	nvmet_rdma_destroy_queue_wr_wait_list(queue);
+	nvmet_rdma_destroy_queue_wait_list(queue);
 	nvmet_rdma_free_rsps(queue);
 	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
 	kfree(queue);
-- 
2.17.1


