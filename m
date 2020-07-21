Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5E227AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGUIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:41:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbgGUIlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:41:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44C6DBF27B7A03B9C9AB;
        Tue, 21 Jul 2020 16:41:15 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 16:41:08 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH] drivers: applicom: remove set but not used variable 'byte_reset_it'
Date:   Tue, 21 Jul 2020 16:41:07 +0800
Message-ID: <20200721084107.13472-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/char/applicom.c: In function 'ac_register_board':
drivers/char/applicom.c:543: warning:
variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/char/applicom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 14b2d8034c51..fd0b21607a7f 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -131,8 +131,6 @@ static int dummy;	/* dev_id for request_irq() */
 static int ac_register_board(unsigned long physloc, void __iomem *loc, 
 		      unsigned char boardno)
 {
-	volatile unsigned char byte_reset_it;
-
 	if((readb(loc + CONF_END_TEST)     != 0x00) ||
 	   (readb(loc + CONF_END_TEST + 1) != 0x55) ||
 	   (readb(loc + CONF_END_TEST + 2) != 0xAA) ||
@@ -160,7 +158,6 @@ static int ac_register_board(unsigned long physloc, void __iomem *loc,
 	apbs[boardno].RamIO = loc;
 	init_waitqueue_head(&apbs[boardno].FlagSleepSend);
 	spin_lock_init(&apbs[boardno].mutex);
-	byte_reset_it = readb(loc + RAM_IT_TO_PC);
 
 	numboards++;
 	return boardno + 1;
-- 
2.17.1

