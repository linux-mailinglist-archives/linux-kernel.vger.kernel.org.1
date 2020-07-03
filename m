Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB700213695
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGCIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:40:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgGCIk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:40:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC97FCB10AA7DF8419DD;
        Fri,  3 Jul 2020 16:40:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 16:40:18 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to wait GCed compressed page writeback
Date:   Fri, 3 Jul 2020 16:40:11 +0800
Message-ID: <20200703084011.42755-1-yuchao0@huawei.com>
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

like we did for encrypted page.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b3ecf7d4d6d8..3a847bc36748 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1152,6 +1152,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		f2fs_set_compressed_page(cc->cpages[i], inode,
 					cc->rpages[i + 1]->index, cic);
 		fio.compressed_page = cc->cpages[i];
+
+		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_page,
+						dn.ofs_in_node + i + 1);
+
+		/* wait for GCed page writeback via META_MAPPING */
+		f2fs_wait_on_block_writeback(inode, fio.old_blkaddr);
+
 		if (fio.encrypted) {
 			fio.page = cc->rpages[i + 1];
 			err = f2fs_encrypt_one_page(&fio);
-- 
2.26.2

