Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034422724D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgIUNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:11:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbgIUNKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BCADCAD5ED1DF002F2BF;
        Mon, 21 Sep 2020 21:10:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:37 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] s390/3215: simplify the return expression of tty3215_open()
Date:   Mon, 21 Sep 2020 21:11:01 +0800
Message-ID: <20200921131101.93037-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/char/con3215.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 92757f9bd..d8acabbb1 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -978,7 +978,6 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
 static int tty3215_open(struct tty_struct *tty, struct file * filp)
 {
 	struct raw3215_info *raw = tty->driver_data;
-	int retval;
 
 	tty_port_tty_set(&raw->port, tty);
 
@@ -986,11 +985,7 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
 	/*
 	 * Start up 3215 device
 	 */
-	retval = raw3215_startup(raw);
-	if (retval)
-		return retval;
-
-	return 0;
+	return raw3215_startup(raw);
 }
 
 /*
-- 
2.23.0

