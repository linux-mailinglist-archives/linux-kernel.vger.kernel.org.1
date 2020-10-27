Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925229A656
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509019AbgJ0IPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:15:35 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59374 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509006AbgJ0IPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:15:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UDLUy8R_1603786527;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UDLUy8R_1603786527)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Oct 2020 16:15:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Simplify the nvme_req_qid()
Date:   Tue, 27 Oct 2020 16:15:16 +0800
Message-Id: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the request's '->mq_hctx->queue_num' directly to simplify the
nvme_req_qid() function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc11113..0b62b62 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -178,7 +178,8 @@ static inline u16 nvme_req_qid(struct request *req)
 {
 	if (!req->q->queuedata)
 		return 0;
-	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + 1;
+
+	return req->mq_hctx->queue_num + 1;
 }
 
 /* The below value is the specific amount of delay needed before checking
-- 
1.8.3.1

