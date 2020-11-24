Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D233F2C1E47
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgKXGdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:33:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8394 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgKXGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:33:40 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CgDjn5nzLz72HV;
        Tue, 24 Nov 2020 14:33:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Nov 2020
 14:33:26 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <richard@nod.at>
CC:     <s.hauer@pengutronix.de>, <herbert@gondor.apana.org.au>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH] ubifs: Fix error return code in ubifs_init_authentication()
Date:   Tue, 24 Nov 2020 14:33:20 +0800
Message-ID: <20201124063320.1799-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return PTR_ERR() error code from the error handling case where
ubifs_hash_get_desc() failed instead of 0 in ubifs_init_authentication(),
as done elsewhere in this function.

Fixes: 49525e5eecca5 ("ubifs: Add helper functions for authentication support")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 fs/ubifs/auth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index b93b3cd10bfd..8c50de693e1d 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -338,8 +338,10 @@ int ubifs_init_authentication(struct ubifs_info *c)
 	c->authenticated = true;
 
 	c->log_hash = ubifs_hash_get_desc(c);
-	if (IS_ERR(c->log_hash))
+	if (IS_ERR(c->log_hash)) {
+		err = PTR_ERR(c->log_hash);
 		goto out_free_hmac;
+	}
 
 	err = 0;
 
-- 
2.17.1

