Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27577273D07
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:13:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbgIVINT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:13:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85E59C86FD06796E813D;
        Tue, 22 Sep 2020 16:13:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 16:13:08 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jack@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] udf: Remove redundant initialization of variable ret
Date:   Tue, 22 Sep 2020 16:13:22 +0800
Message-ID: <20200922081322.70535-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9293fcfbc181 ("udf: Remove struct ustr as non-needed
intermediate storage"), the variable ret is being initialized with
'-ENOMEM' that is meaningless. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..c0c8068116c1 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -854,7 +854,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 	uint8_t *outstr;
 	struct buffer_head *bh;
 	uint16_t ident;
-	int ret = -ENOMEM;
+	int ret;
 	struct timestamp *ts;
 
 	outstr = kmalloc(128, GFP_NOFS);
-- 
2.17.1

