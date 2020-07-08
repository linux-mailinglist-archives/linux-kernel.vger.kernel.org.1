Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC90217CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGHCSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 22:18:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51135 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbgGHCSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:18:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U24OW9e_1594174692;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U24OW9e_1594174692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 10:18:12 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: use standard block status symbolic names to check return value
Date:   Wed,  8 Jul 2020 10:18:01 +0800
Message-Id: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use the same symbol as the return to check return value,
and will always work in the unlikely event that the defines are reordered.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1ac0717..45cb59c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -873,18 +873,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_IOERR;
 
 	ret = nvme_setup_cmd(ns, req, &cmnd);
-	if (ret)
+	if (ret != BLK_STS_OK)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &cmnd);
-		if (ret)
+		if (ret != BLK_STS_OK)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
 		ret = nvme_map_metadata(dev, req, &cmnd);
-		if (ret)
+		if (ret != BLK_STS_OK)
 			goto out_unmap_data;
 	}
 
-- 
1.8.3.1

