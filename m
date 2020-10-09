Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553DC28806D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgJIClR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:41:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgJIClR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:41:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D15DD647429D0F77E087;
        Fri,  9 Oct 2020 10:41:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 10:41:09 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to set SBI_NEED_FSCK flag for inconsistent inode
Date:   Fri, 9 Oct 2020 10:40:48 +0800
Message-ID: <20201009024048.50089-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compressed inode has inconsistent fields on i_compress_algorithm,
i_compr_blocks and i_log_cluster_size, we missed to set SBI_NEED_FSCK
to notice fsck to repair the inode, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d5664bc7d6c6..657db2fb6739 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -299,6 +299,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 						i_log_cluster_size)) {
 		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
 				"compress algorithm: %u, run fsck to fix",
 				  __func__, inode->i_ino,
@@ -307,6 +308,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 		if (le64_to_cpu(ri->i_compr_blocks) >
 				SECTOR_TO_BLOCK(inode->i_blocks)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
 				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 				  __func__, inode->i_ino,
@@ -316,6 +318,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
 			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
 				"log cluster size: %u, run fsck to fix",
 				  __func__, inode->i_ino,
-- 
2.26.2

