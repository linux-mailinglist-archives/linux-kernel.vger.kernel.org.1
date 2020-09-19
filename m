Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6C270B25
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgISGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:37:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbgISGhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:37:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE9DCAF8C0271C6EA084;
        Sat, 19 Sep 2020 14:37:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 14:36:59 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next v2] tty: hvc: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n
Date:   Sat, 19 Sep 2020 14:35:35 +0800
Message-ID: <20200919063535.2809707-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aarch64-linux-gnu-ld: drivers/tty/hvc/hvc_dcc.o: in function `dcc_early_write':
hvc_dcc.c:(.text+0x164): undefined reference to `uart_console_write'

The driver uses the uart_console_write(), but SERIAL_CORE_CONSOLE is not
selected, so uart_console_write is not defined, then we get the error.
Fix this by selecting SERIAL_CORE_CONSOLE.

Fixes: d1a1af2cdf19 ("hvc: dcc: Add earlycon support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tty/hvc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index d1b27b0522a3..8d60e0ff67b4 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -81,6 +81,7 @@ config HVC_DCC
 	bool "ARM JTAG DCC console"
 	depends on ARM || ARM64
 	select HVC_DRIVER
+	select SERIAL_CORE_CONSOLE
 	help
 	  This console uses the JTAG DCC on ARM to create a console under the HVC
 	  driver. This console is used through a JTAG only on ARM. If you don't have
-- 
2.25.1

