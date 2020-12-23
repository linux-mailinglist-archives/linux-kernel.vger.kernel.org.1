Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5286D2E1D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgLWOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:15:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgLWOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:15:31 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FYF3hfYzkvSj
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:13:21 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:14:10 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty: n_gsm: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 23 Dec 2020 22:14:46 +0800
Message-ID: <20201223141446.944-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/n_gsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 25f3152089c2..e22d766621a4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -266,7 +266,7 @@ struct gsm_mux {
 
 #define MAX_MUX		4			/* 256 minors */
 static struct gsm_mux *gsm_mux[MAX_MUX];	/* GSM muxes */
-static spinlock_t gsm_mux_lock;
+static DEFINE_SPINLOCK(gsm_mux_lock);
 
 static struct tty_driver *gsm_tty_driver;
 
@@ -3258,8 +3258,6 @@ static int __init gsm_init(void)
 	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
 	tty_set_operations(gsm_tty_driver, &gsmtty_ops);
 
-	spin_lock_init(&gsm_mux_lock);
-
 	if (tty_register_driver(gsm_tty_driver)) {
 		put_tty_driver(gsm_tty_driver);
 		tty_unregister_ldisc(N_GSM0710);
-- 
2.22.0

