Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A943A27C033
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgI2I5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:57:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727468AbgI2I5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:57:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A03EA1992BC6526F4DEC;
        Tue, 29 Sep 2020 16:56:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 16:56:52 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] serial: mvebu-uart: fix unused variable warning
Date:   Tue, 29 Sep 2020 16:56:51 +0800
Message-ID: <20200929085651.158283-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a warning shows that 'ret' becomes an unused variable
after simplify the return expression of mvebu_uart_probe(). So
remove it.

Fixes: b63537020db3 ("serial: mvebu-uart: simplify the return expression of mvebu_uart_probe()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 4e9a590712cb..c9a51f18bf43 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -803,7 +803,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
-	int ret, id, irq;
+	int id, irq;
 
 	if (!reg) {
 		dev_err(&pdev->dev, "no registers defined\n");
-- 
2.23.0

