Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB61C6B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgEFIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:23:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbgEFIXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:23:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 071CC32915EF8542B1BD;
        Wed,  6 May 2020 16:23:15 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 16:23:05 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] nvme/core:disable streams when get stream params failed
Date:   Wed, 6 May 2020 16:37:01 +0800
Message-ID: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
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
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f2adea9..afe1f5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -552,8 +552,10 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 		return ret;
 
 	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
-	if (ret)
+	if (ret) {
+		nvme_disable_streams(ctrl);
 		return ret;
+	}
 
 	ctrl->nssa = le16_to_cpu(s.nssa);
 	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
-- 
1.8.3.1

