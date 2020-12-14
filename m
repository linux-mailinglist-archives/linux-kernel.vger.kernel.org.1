Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E2D2D990F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408020AbgLNNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:40:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9201 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgLNNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:40:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CvjC41NXwzkkXm;
        Mon, 14 Dec 2020 21:38:24 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:38:59 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jirislaby@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty: mxser: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:39:30 +0800
Message-ID: <20201214133930.4190-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/mxser.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3703987c4666..b5f4b75ea6aa 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1213,15 +1213,15 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 		return -ENOTTY;
 
 	mutex_lock(&port->mutex);
-	ss->type = info->type,
-	ss->line = tty->index,
-	ss->port = info->ioaddr,
-	ss->irq = info->board->irq,
-	ss->flags = info->port.flags,
-	ss->baud_base = info->baud_base,
-	ss->close_delay = info->port.close_delay,
-	ss->closing_wait = info->port.closing_wait,
-	ss->custom_divisor = info->custom_divisor,
+	ss->type = info->type;
+	ss->line = tty->index;
+	ss->port = info->ioaddr;
+	ss->irq = info->board->irq;
+	ss->flags = info->port.flags;
+	ss->baud_base = info->baud_base;
+	ss->close_delay = info->port.close_delay;
+	ss->closing_wait = info->port.closing_wait;
+	ss->custom_divisor = info->custom_divisor;
 	mutex_unlock(&port->mutex);
 	return 0;
 }
-- 
2.22.0

