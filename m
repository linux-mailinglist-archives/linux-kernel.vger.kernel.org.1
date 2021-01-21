Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33532FE4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbhAUIPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:15:30 -0500
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:36758 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbhAUIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:14:42 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1421534|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00192036-0.000106734-0.997973;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.JNl771T_1611216832;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.JNl771T_1611216832)
          by smtp.aliyun-inc.com(10.194.97.171);
          Thu, 21 Jan 2021 16:13:52 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] mmc: block: use REQ_HIPRI flag to complete request directly in own complete workqueue
Date:   Thu, 21 Jan 2021 16:13:49 +0800
Message-Id: <20210121081349.8266-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", request is
completed in softirq. This may cause the system to suffer bad preemptoff
time.
The mmc driver has its own complete workqueue, but it can not work
well now.
The REQ_HIPRI flag can be used to complete request directly in its own
complete workqueue and the preemptoff problem could be avoided.

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/mmc/core/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 42e27a298..c27239a89 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1985,8 +1985,10 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	 */
 	if (mq->in_recovery)
 		mmc_blk_mq_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
+	else if (likely(!blk_should_fake_timeout(req->q))) {
+		req->cmd_flags |= REQ_HIPRI;
 		blk_mq_complete_request(req);
+	}
 
 	mmc_blk_mq_dec_in_flight(mq, req);
 }
-- 
2.17.1

