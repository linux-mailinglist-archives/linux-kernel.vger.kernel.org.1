Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF70B26F902
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIRJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:14:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgIRJOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:14:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCE0D757EFC0FBBD27A2;
        Fri, 18 Sep 2020 17:14:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:14:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] tty: serial: imx: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n
Date:   Fri, 18 Sep 2020 17:13:05 +0800
Message-ID: <20200918091305.3822598-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the link error by selecting SERIAL_CORE_CONSOLE.

aarch64-linux-gnu-ld: drivers/tty/serial/imx_earlycon.o: in function `imx_uart_console_early_write':
imx_earlycon.c:(.text+0x84): undefined reference to `uart_console_write'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9631ccf43378..1044fc387691 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -521,6 +521,7 @@ config SERIAL_IMX_EARLYCON
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
 	select SERIAL_EARLYCON
+	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the earlycon on the Freescale IMX
 	  CPU you can make it the earlycon by answering Y to this option.
-- 
2.25.1

