Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27CA1C6E73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEFKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 06:35:10 -0400
Received: from mail.secom.com.pl ([213.216.87.26]:54526 "EHLO
        mail.secom.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgEFKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:35:09 -0400
Received: from debian-2019.secom.com.pl
        ([192.168.192.41])
        by mail.secom.com.pl; Wed, 06 May 2020 12:34:46 +0200
From:   =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>
Cc:     =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] dma: zynqmp_dma: Move list_del inside zynqmp_dma_free_descriptor.
Date:   Wed,  6 May 2020 12:28:45 +0200
Message-Id: <20200506102844.2259-1-rafal.hibner@secom.com.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <MW2PR02MB37705416E18413689BFFC7C3C9A60@MW2PR02MB3770.namprd02.prod.outlook.com>
References: <MW2PR02MB37705416E18413689BFFC7C3C9A60@MW2PR02MB3770.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List elements are not formally removed from list during zynqmp_dma_reset.

Signed-off-by: Rafal Hibner <rafal.hibner@secom.com.pl>
---
> Looking at this, i think it would make sense to do list_splice_init() before we
> send the list to be freed.

Moving list_del inside zynqmp_dma_free_descriptor fixes the problem just as well
and avoids INIT_LIST_HEAD(list).
I still don't see how list_splice_init would help here.

Regards,
Rafal

---
 drivers/dma/xilinx/zynqmp_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 931e41a72..df0403335 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -434,6 +434,7 @@ static void zynqmp_dma_free_descriptor(struct zynqmp_dma_chan *chan,
 	struct zynqmp_dma_desc_sw *child, *next;
 
 	chan->desc_free_cnt++;
+	list_del(&sdesc->node);
 	list_add_tail(&sdesc->node, &chan->free_list);
 	list_for_each_entry_safe(child, next, &sdesc->tx_list, node) {
 		chan->desc_free_cnt++;
@@ -604,8 +605,6 @@ static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
 		dma_async_tx_callback callback;
 		void *callback_param;
 
-		list_del(&desc->node);
-
 		callback = desc->async_tx.callback;
 		callback_param = desc->async_tx.callback_param;
 		if (callback) {
-- 
2.20.1

