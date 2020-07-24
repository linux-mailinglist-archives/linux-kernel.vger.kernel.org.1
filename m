Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A760422C2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGXKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 06:21:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbgGXKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:21:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 163CD4A04CD98040B875;
        Fri, 24 Jul 2020 18:21:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 18:21:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: compress: fix to update isize when overwriting compressed file
Date:   Fri, 24 Jul 2020 18:21:36 +0800
Message-ID: <20200724102137.78696-1-yuchao0@huawei.com>
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

We missed to update isize of compressed file in write_end() with
below case:

cluster size is 16KB

- write 14KB data from offset 0
- overwrite 16KB data from offset 0

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 44645f4f914b..1d7280a70e09 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3470,6 +3470,10 @@ static int f2fs_write_end(struct file *file,
 	if (f2fs_compressed_file(inode) && fsdata) {
 		f2fs_compress_write_end(inode, fsdata, page->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+
+		if (pos + copied > i_size_read(inode) &&
+				!f2fs_verity_in_progress(inode))
+			f2fs_i_size_write(inode, pos + copied);
 		return copied;
 	}
 #endif
-- 
2.26.2

