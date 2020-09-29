Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8627CD92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgI2Mp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:45:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387509AbgI2Moq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:44:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12B1BA077F780E8966CE;
        Tue, 29 Sep 2020 20:44:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 20:44:35 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <yi.zhang@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ubifs: Don't parse authentication mount options in remount process
Date:   Tue, 29 Sep 2020 20:45:30 +0800
Message-ID: <20200929124531.941873-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200929124531.941873-1-chengzhihao1@huawei.com>
References: <20200929124531.941873-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to dump authentication options while remounting,
because authentication initialization can only be doing once in
the first mount process. Dumping authentication mount options in
remount process may cause memory leak if UBIFS has already been
mounted with old authentication mount options.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <stable@vger.kernel.org>  # 4.20+
Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")
---
 fs/ubifs/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 6f85cd618766..9796f5df2f7f 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1110,14 +1110,20 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			break;
 		}
 		case Opt_auth_key:
-			c->auth_key_name = kstrdup(args[0].from, GFP_KERNEL);
-			if (!c->auth_key_name)
-				return -ENOMEM;
+			if (!is_remount) {
+				c->auth_key_name = kstrdup(args[0].from,
+								GFP_KERNEL);
+				if (!c->auth_key_name)
+					return -ENOMEM;
+			}
 			break;
 		case Opt_auth_hash_name:
-			c->auth_hash_name = kstrdup(args[0].from, GFP_KERNEL);
-			if (!c->auth_hash_name)
-				return -ENOMEM;
+			if (!is_remount) {
+				c->auth_hash_name = kstrdup(args[0].from,
+								GFP_KERNEL);
+				if (!c->auth_hash_name)
+					return -ENOMEM;
+			}
 			break;
 		case Opt_ignore:
 			break;
-- 
2.25.4

