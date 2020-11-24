Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6B2C205D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgKXIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:50:08 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65510 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730519AbgKXIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:50:08 -0500
X-UUID: 9befa535e3a34f3e90b751a6e93804cb-20201124
X-UUID: 9befa535e3a34f3e90b751a6e93804cb-20201124
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 493252092; Tue, 24 Nov 2020 16:50:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 Nov 2020 16:49:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 Nov 2020 16:49:59 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH v3] usb: musb: remove unused variable 'devctl'
Date:   Tue, 24 Nov 2020 16:49:55 +0800
Message-ID: <20201124084955.30270-1-min.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1E15F157744AEC9989CA4857FFB6D99450DE2308CA458A37E137A2127E0005752000:8
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
changes in v3
suggested by Greg Kroah-Hartman:
Add a comment.

changes in v2
suggested by Alan Stern:
Add void before musb_read to indicate that the register MUSB_DEVCTL
was intended to be read and discarded.
---
 drivers/usb/musb/musbhsdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 0aacfc8be5a1..2a345b4ad015 100644
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
@@ -336,7 +334,11 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
 						< musb_channel->len) ?
 					"=> reconfig 0" : "=> complete");
 
-				devctl = musb_readb(mbase, MUSB_DEVCTL);
+				/*
+				 * Some hardware may need to read the
+				 * MUSB_DEVCTL register once to take effect.
+				 */
+				(void)musb_readb(mbase, MUSB_DEVCTL);
 
 				channel->status = MUSB_DMA_STATUS_FREE;
 
-- 
2.18.0

