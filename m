Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD42D721F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437056AbgLKIou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:44:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9868 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437023AbgLKIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:44:28 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Csknn4gSFz79WL
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:43:09 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:43:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:44:04 +0800
Message-ID: <20201211084404.2151-1-zhengyongjun3@huawei.com>
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
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 545196c85b5c..abb9cbdabaa9 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -358,7 +358,7 @@ int rave_sp_exec(struct rave_sp *sp,
 
 	ackid       = atomic_inc_return(&sp->ackid);
 	reply.ackid = ackid;
-	reply.code  = rave_sp_reply_code((u8)command),
+	reply.code  = rave_sp_reply_code((u8)command);
 
 	mutex_lock(&sp->bus_lock);
 
-- 
2.22.0

