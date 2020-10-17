Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25226290F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410989AbgJQF2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:28:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392021AbgJQF2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:28:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3A8BEC23779967992C84;
        Sat, 17 Oct 2020 09:39:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 17 Oct 2020 09:39:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipmi_si: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Sat, 17 Oct 2020 09:40:10 +0800
Message-ID: <1602898810-31783-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is redundant to do irqsave and irqrestore in hardIRQ context.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 45546ac..97452a8 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1116,7 +1116,6 @@ static void smi_timeout(struct timer_list *t)
 irqreturn_t ipmi_si_irq_handler(int irq, void *data)
 {
 	struct smi_info *smi_info = data;
-	unsigned long   flags;
 
 	if (smi_info->io.si_type == SI_BT)
 		/* We need to clear the IRQ flag for the BT interface. */
@@ -1124,14 +1123,14 @@ irqreturn_t ipmi_si_irq_handler(int irq, void *data)
 				     IPMI_BT_INTMASK_CLEAR_IRQ_BIT
 				     | IPMI_BT_INTMASK_ENABLE_IRQ_BIT);
 
-	spin_lock_irqsave(&(smi_info->si_lock), flags);
+	spin_lock(&(smi_info->si_lock));
 
 	smi_inc_stat(smi_info, interrupts);
 
 	debug_timestamp("Interrupt");
 
 	smi_event_handler(smi_info, 0);
-	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+	spin_unlock(&(smi_info->si_lock));
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

