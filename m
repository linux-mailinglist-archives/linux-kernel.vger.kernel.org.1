Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51F2724AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgIUNKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbgIUNKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42ADF4B2004922BB7428;
        Mon, 21 Sep 2020 21:10:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] gpu: host1x: simplify the return expression of host1x_cdma_init()
Date:   Mon, 21 Sep 2020 21:10:32 +0800
Message-ID: <20200921131032.91972-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/host1x/cdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index e8d3fda91..08a0f9e10 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -448,8 +448,6 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
  */
 int host1x_cdma_init(struct host1x_cdma *cdma)
 {
-	int err;
-
 	mutex_init(&cdma->lock);
 	init_completion(&cdma->complete);
 
@@ -459,11 +457,7 @@ int host1x_cdma_init(struct host1x_cdma *cdma)
 	cdma->running = false;
 	cdma->torndown = false;
 
-	err = host1x_pushbuffer_init(&cdma->push_buffer);
-	if (err)
-		return err;
-
-	return 0;
+	return host1x_pushbuffer_init(&cdma->push_buffer);
 }
 
 /*
-- 
2.23.0

