Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9722E1D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgLWOLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:11:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgLWOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:11:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FTf4J7gzkvSk;
        Wed, 23 Dec 2020 22:10:14 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:11:01 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] staging: most: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:11:38 +0800
Message-ID: <20201223141138.32456-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/staging/most/net/net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index b6fecb06a0e6..f125bb6da406 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -68,7 +68,7 @@ struct net_dev_context {
 };
 
 static struct list_head net_devices = LIST_HEAD_INIT(net_devices);
-static struct mutex probe_disc_mt; /* ch->linked = true, most_nd_open */
+static DEFINE_MUTEX(probe_disc_mt); /* ch->linked = true, most_nd_open */
 static DEFINE_SPINLOCK(list_lock); /* list_head, ch->linked = false, dev_hold */
 static struct most_component comp;
 
@@ -520,7 +520,6 @@ static int __init most_net_init(void)
 {
 	int err;
 
-	mutex_init(&probe_disc_mt);
 	err = most_register_component(&comp);
 	if (err)
 		return err;
-- 
2.22.0

