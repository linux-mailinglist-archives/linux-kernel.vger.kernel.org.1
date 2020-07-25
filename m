Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AFB22D382
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 03:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGYBSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 21:18:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgGYBSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:18:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F2E91C7EF3C05A02CFBC;
        Sat, 25 Jul 2020 09:18:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 09:17:53 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/2] f2fs: compress: delay temp page allocation
Date:   Sat, 25 Jul 2020 09:17:48 +0800
Message-ID: <20200725011748.43688-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we allocate temp pages which is used to pad hole in
cluster during read IO submission, it may take long time before
releasing them in f2fs_decompress_pages(), since they are only
used as temp output buffer in decompression context, so let's
just do the allocation in that context to reduce time of memory
pool resource occupation.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to assign return value in error path
 fs/f2fs/compress.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a20c9f3272af..6e7db450006c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -670,6 +670,7 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
 	int ret;
+	int i;
 
 	dec_page_count(sbi, F2FS_RD_DATA);
 
@@ -688,6 +689,26 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 		goto out_free_dic;
 	}
 
+	dic->tpages = f2fs_kzalloc(sbi, sizeof(struct page *) *
+					dic->cluster_size, GFP_NOFS);
+	if (!dic->tpages) {
+		ret = -ENOMEM;
+		goto out_free_dic;
+	}
+
+	for (i = 0; i < dic->cluster_size; i++) {
+		if (dic->rpages[i]) {
+			dic->tpages[i] = dic->rpages[i];
+			continue;
+		}
+
+		dic->tpages[i] = f2fs_compress_alloc_page();
+		if (!dic->tpages[i]) {
+			ret = -ENOMEM;
+			goto out_free_dic;
+		}
+	}
+
 	if (cops->init_decompress_ctx) {
 		ret = cops->init_decompress_ctx(dic);
 		if (ret)
@@ -1449,22 +1470,6 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->cpages[i] = page;
 	}
 
-	dic->tpages = f2fs_kzalloc(sbi, sizeof(struct page *) *
-					dic->cluster_size, GFP_NOFS);
-	if (!dic->tpages)
-		goto out_free;
-
-	for (i = 0; i < dic->cluster_size; i++) {
-		if (cc->rpages[i]) {
-			dic->tpages[i] = cc->rpages[i];
-			continue;
-		}
-
-		dic->tpages[i] = f2fs_compress_alloc_page();
-		if (!dic->tpages[i])
-			goto out_free;
-	}
-
 	return dic;
 
 out_free:
-- 
2.26.2

