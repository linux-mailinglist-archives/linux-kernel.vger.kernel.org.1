Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6726F919
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIRJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:21:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIRJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:21:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 368553497E705AC97713;
        Fri, 18 Sep 2020 17:21:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:21:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] tty: hvc: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n
Date:   Fri, 18 Sep 2020 17:20:30 +0800
Message-ID: <20200918092030.3855438-1-yangyingliang@huawei.com>
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

aarch64-linux-gnu-ld: drivers/tty/hvc/hvc_dcc.o: in function `dcc_early_write':
hvc_dcc.c:(.text+0x164): undefined reference to `uart_console_write'

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

