Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAB2CE501
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgLDBX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:23:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8634 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgLDBX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:23:58 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnFLq4L7pz15X18;
        Fri,  4 Dec 2020 09:22:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:23:07 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu: ipu-v3: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Fri, 4 Dec 2020 09:23:16 +0800
Message-ID: <1607044999-47666-11-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
References: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
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

