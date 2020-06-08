Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B881F1865
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgFHMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 08:03:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgFHMDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:03:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA372969A77F174BC765;
        Mon,  8 Jun 2020 20:03:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 8 Jun 2020 20:03:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: remove unused parameter of f2fs_put_rpages_mapping()
Date:   Mon, 8 Jun 2020 20:03:17 +0800
Message-ID: <20200608120317.6716-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200608120317.6716-1-yuchao0@huawei.com>
References: <20200608120317.6716-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a53578a89211..1e02a8c106b0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -89,8 +89,7 @@ static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
 	f2fs_drop_rpages(cc, len, true);
 }
 
-static void f2fs_put_rpages_mapping(struct compress_ctx *cc,
-				struct address_space *mapping,
+static void f2fs_put_rpages_mapping(struct address_space *mapping,
 				pgoff_t start, int len)
 {
 	int i;
@@ -942,7 +941,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		if (!PageUptodate(page)) {
 			f2fs_unlock_rpages(cc, i + 1);
-			f2fs_put_rpages_mapping(cc, mapping, start_idx,
+			f2fs_put_rpages_mapping(mapping, start_idx,
 					cc->cluster_size);
 			f2fs_destroy_compress_ctx(cc);
 			goto retry;
@@ -977,7 +976,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 unlock_pages:
 	f2fs_unlock_rpages(cc, i);
 release_pages:
-	f2fs_put_rpages_mapping(cc, mapping, start_idx, i);
+	f2fs_put_rpages_mapping(mapping, start_idx, i);
 	f2fs_destroy_compress_ctx(cc);
 	return ret;
 }
-- 
2.18.0.rc1

