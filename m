Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FBF2B8E59
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKSJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:01:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7952 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKSJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:01:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcDDQ26RbzhcQj;
        Thu, 19 Nov 2020 17:00:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 17:01:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <afaerber@suse.de>, <manivannan.sadhasivam@linaro.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Thu, 19 Nov 2020 17:01:29 +0800
Message-ID: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/tty/serial/owl-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c149f8c3..472fdaf 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned long flags;
 	u32 stat;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	stat = owl_uart_read(port, OWL_UART_STAT);
 
@@ -268,7 +267,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
 	owl_uart_write(port, stat, OWL_UART_STAT);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

