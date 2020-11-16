Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0750C2B3EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKPIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:34:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7246 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgKPIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:34:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZMmq2rB3zkY8s;
        Mon, 16 Nov 2020 16:34:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 16:34:15 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: mtu3: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Mon, 16 Nov 2020 16:34:42 +0800
Message-ID: <1605515682-23771-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/usb/mtu3/mtu3_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b3b4599..a6d7684 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -745,10 +745,9 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 static irqreturn_t mtu3_irq(int irq, void *data)
 {
 	struct mtu3 *mtu = (struct mtu3 *)data;
-	unsigned long flags;
 	u32 level1;
 
-	spin_lock_irqsave(&mtu->lock, flags);
+	spin_lock(&mtu->lock);
 
 	/* U3D_LV1ISR is RU */
 	level1 = mtu3_readl(mtu->mac_base, U3D_LV1ISR);
@@ -769,7 +768,7 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 	if (level1 & QMU_INTR)
 		mtu3_qmu_isr(mtu);
 
-	spin_unlock_irqrestore(&mtu->lock, flags);
+	spin_unlock(&mtu->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

