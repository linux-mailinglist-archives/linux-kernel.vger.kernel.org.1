Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4DE2E0ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgLVNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:34:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9238 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbgLVNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:34:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D0cj25xsTzktP5;
        Tue, 22 Dec 2020 21:32:54 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:33:39 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] f2fs: Replace expression with offsetof()
Date:   Tue, 22 Dec 2020 21:34:15 +0800
Message-ID: <20201222133415.19915-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing offsetof() macro instead of duplicating code.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d5d8ce077f29..000cafb522ec 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2686,7 +2686,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);
 
-	memcpy(dst, src, (unsigned long)&src->i_ext - (unsigned long)src);
+	memcpy(dst, src, offsetof(struct f2fs_inode, i_ext));
 	dst->i_size = 0;
 	dst->i_blocks = cpu_to_le64(1);
 	dst->i_links = cpu_to_le32(1);
-- 
2.22.0

