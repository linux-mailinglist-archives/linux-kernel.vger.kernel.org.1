Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21852465D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHQL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 07:57:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbgHQL5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:57:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A904DC06E1AEB05236D;
        Mon, 17 Aug 2020 19:57:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 19:57:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <plagnioj@jcrosoft.com>,
        <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/3] dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()
Date:   Mon, 17 Aug 2020 19:57:27 +0800
Message-ID: <20200817115728.1706719-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817115728.1706719-1-yukuai3@huawei.com>
References: <20200817115728.1706719-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() succeed, at_dma_xlate() doesn't have a
corresponding put_device(). Thus add put_device() to fix the exception
handling for this function implementation.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/at_hdmac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 1c941f839c42..bf874367097c 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1657,8 +1657,10 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_set(DMA_SLAVE, mask);
 
 	atslave = kmalloc(sizeof(*atslave), GFP_KERNEL);
-	if (!atslave)
+	if (!atslave) {
+		put_device(&dmac_pdev->dev);
 		return NULL;
+	}
 
 	atslave->cfg = ATC_DST_H2SEL_HW | ATC_SRC_H2SEL_HW;
 	/*
@@ -1687,8 +1689,10 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	atslave->dma_dev = &dmac_pdev->dev;
 
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
-	if (!chan)
+	if (!chan) {
+		put_device(&dmac_pdev->dev);
 		return NULL;
+	}
 
 	atchan = to_at_dma_chan(chan);
 	atchan->per_if = dma_spec->args[0] & 0xff;
-- 
2.25.4

