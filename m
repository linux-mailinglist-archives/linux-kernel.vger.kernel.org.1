Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D234A29BD91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811842AbgJ0Qmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:42:49 -0400
Received: from aposti.net ([89.234.176.197]:47530 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1801689AbgJ0Qmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:42:45 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [RESEND PATCH 3/4] usb: musb: dma: Remove unused variable
Date:   Tue, 27 Oct 2020 16:41:59 +0000
Message-Id: <20201027164200.18602-4-paul@crapouillou.net>
In-Reply-To: <20201027164200.18602-1-paul@crapouillou.net>
References: <20201027164200.18602-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused-but-set devctl variable.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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
2.28.0

