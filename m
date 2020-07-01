Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4821020D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 04:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGAC1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 22:27:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgGAC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:27:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 61960232CF64741355D5;
        Wed,  1 Jul 2020 10:27:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 10:27:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix return value of move_data_block()
Date:   Wed, 1 Jul 2020 10:27:09 +0800
Message-ID: <20200701022709.128466-1-yuchao0@huawei.com>
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

If f2fs_grab_cache_page() fails, it needs to return -ENOMEM.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3b718da69910..11b4adde9baf 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -849,8 +849,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
 
 	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
 					fio.old_blkaddr, false);
-	if (!mpage)
+	if (!mpage) {
+		err = -ENOMEM;
 		goto up_out;
+	}
 
 	fio.encrypted_page = mpage;
 
-- 
2.26.2

