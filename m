Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C21D0A74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgEMIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 04:04:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgEMIEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:04:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74CA9CF991E077D90F12;
        Wed, 13 May 2020 16:04:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 16:04:30 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [RESENT PATCH V2] nvme/core:disable streams when get stream params failed
Date:   Wed, 13 May 2020 16:18:13 +0800
Message-ID: <1589357893-551688-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enable nvme streams, then if get stream params failed, 
We should disable streams before return error in 
nvme_configure_directives() function.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f..29bef53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -553,19 +553,22 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 
 	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
 	if (ret)
-		return ret;
+		goto out_disable_stream;
 
 	ctrl->nssa = le16_to_cpu(s.nssa);
 	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
 		dev_info(ctrl->device, "too few streams (%u) available\n",
 					ctrl->nssa);
-		nvme_disable_streams(ctrl);
-		return 0;
+		goto out_disable_stream;
 	}
 
 	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
 	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
 	return 0;
+
+out_disable_stream:
+	nvme_disable_streams(ctrl);
+	return ret;
 }
 
 /*
-- 
1.8.3.1

