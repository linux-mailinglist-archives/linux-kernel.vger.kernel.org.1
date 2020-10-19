Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4DA292495
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgJSJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:29:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgJSJ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:29:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3097AE86B9F87112BE11;
        Mon, 19 Oct 2020 17:29:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 17:29:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <p.zabel@pengutronix.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu: ipu-v3: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Mon, 19 Oct 2020 17:30:13 +0800
Message-ID: <1603099813-27934-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index aa1d4b6..c28764c 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1737,9 +1737,8 @@ static irqreturn_t eof_irq(int irq, void *data)
 	struct ipu_image_convert_run *run;
 	irqreturn_t ret = IRQ_HANDLED;
 	bool tile_complete = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->irqlock, flags);
+	spin_lock(&chan->irqlock);
 
 	/* get current run and its context */
 	run = chan->current_run;
@@ -1778,7 +1777,7 @@ static irqreturn_t eof_irq(int irq, void *data)
 	if (tile_complete)
 		ret = do_tile_complete(run);
 out:
-	spin_unlock_irqrestore(&chan->irqlock, flags);
+	spin_unlock(&chan->irqlock);
 	return ret;
 }
 
-- 
2.7.4

