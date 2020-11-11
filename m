Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2C2AF0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKKMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:39:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7171 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgKKMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:39:30 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWPS70spgz15V50;
        Wed, 11 Nov 2020 20:39:19 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 20:39:16 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengzengkai@huawei.com>
Subject: [PATCH] serial: ar933x_uart: disable clk on error handling path in probe
Date:   Wed, 11 Nov 2020 20:44:26 +0800
Message-ID: <20201111124426.42638-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ar933x_uart_probe() does not invoke clk_disable_unprepare()
on one error handling path. This patch fixes that.

Fixes: 9be1064fe524 ("serial: ar933x_uart: add RS485 support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/tty/serial/ar933x_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 0c80a79d7442..c2be7cf91399 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -789,8 +789,10 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 
 	up->gpios = mctrl_gpio_init(port, 0);
-	if (IS_ERR(up->gpios) && PTR_ERR(up->gpios) != -ENOSYS)
-		return PTR_ERR(up->gpios);
+	if (IS_ERR(up->gpios) && PTR_ERR(up->gpios) != -ENOSYS) {
+		ret = PTR_ERR(up->gpios);
+		goto err_disable_clk;
+	}
 
 	up->rts_gpiod = mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS);
 
-- 
2.20.1

