Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C91B81C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDXVvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 17:51:01 -0400
Received: from v6.sk ([167.172.42.174]:59602 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXVvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:51:01 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8EC90610A8;
        Fri, 24 Apr 2020 21:50:29 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] dmaengine: mmp_tdma: Validate the transfer direction
Date:   Fri, 24 Apr 2020 23:50:20 +0200
Message-Id: <20200424215020.105281-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only support DMA_DEV_TO_MEM and DMA_MEM_TO_DEV. Let's not do
undefined things with other values and reject them.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Changes since v1:
- Replace the extra validation with is_slave_direction() in
  _prep_dma_cyclic(), as Vinod Koul suggested.

 drivers/dma/mmp_tdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 8947e4832ca3..dbc6a48424fa 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -429,6 +429,11 @@ static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int i = 0, buf = 0;
 
+	if (!is_slave_direction(direction)) {
+		dev_err(tdmac->dev, "unsupported transfer direction\n");
+		return NULL;
+	}
+
 	if (tdmac->status != DMA_COMPLETE) {
 		dev_err(tdmac->dev, "controller busy");
 		return NULL;
-- 
2.26.0

