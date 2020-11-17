Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779712B5AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKQIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:21:34 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12601 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgKQIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:21:33 -0500
X-UUID: 0705bf3d096d4f659d5a58afd1564ded-20201117
X-UUID: 0705bf3d096d4f659d5a58afd1564ded-20201117
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 225383250; Tue, 17 Nov 2020 16:21:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Nov 2020 16:21:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Nov 2020 16:21:26 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH] usb: musb: remove unused variable 'devctl'
Date:   Tue, 17 Nov 2020 16:21:25 +0800
Message-ID: <20201117082125.7619-1-min.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4A52950D1BF0114C89270D23257F406A875C20222DDA92BD96092F5C4159C3FA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

Remove unused 'devctl' variable to fix compile warnings:

    drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
    drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
    but not used [-Wunused-but-set-variable]

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 drivers/usb/musb/musbhsdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 0aacfc8be5a1..7acd1635850d 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -321,8 +321,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
 				musb_channel->channel.status =
 					MUSB_DMA_STATUS_BUS_ABORT;
 			} else {
-				u8 devctl;
-
 				addr = musb_read_hsdma_addr(mbase,
 						bchannel);
 				channel->actual_len = addr
@@ -336,8 +334,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
 						< musb_channel->len) ?
 					"=> reconfig 0" : "=> complete");
 
-				devctl = musb_readb(mbase, MUSB_DEVCTL);
-
 				channel->status = MUSB_DMA_STATUS_FREE;
 
 				/* completed */
-- 
2.18.0

