Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB22F99F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbhARGdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:33:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11106 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbhARGdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:33:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DK2492wN8z15vGf;
        Mon, 18 Jan 2021 14:31:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 14:32:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] hugetlbfs: correct obsolete function name in hugetlbfs_read_iter()
Date:   Mon, 18 Jan 2021 01:32:10 -0500
Message-ID: <20210118063210.47118-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 36e789144267 ("kill do_generic_mapping_read"), the function
do_generic_mapping_read() is renamed to do_generic_file_read(). And then
commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read") renamed it
to generic_file_buffered_read(). So replace do_generic_mapping_read() with
generic_file_buffered_read() to keep comment uptodate.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 23ad6ed8b75f..d02616513b43 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -310,7 +310,7 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
 
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
- * data. Its *very* similar to do_generic_mapping_read(), we can't use that
+ * data. Its *very* similar to generic_file_buffered_read(), we can't use that
  * since it has PAGE_SIZE assumptions.
  */
 static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
-- 
2.19.1

