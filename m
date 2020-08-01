Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258AE234F95
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 05:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHADZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 23:25:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727824AbgHADZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 23:25:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D03D634FCD7D356B5745;
        Sat,  1 Aug 2020 11:24:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 1 Aug 2020
 11:24:52 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yi.zhang@huawei.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [f2fs-dev][PATCH] f2fs: update_sit_entry: Make the judgment condition of f2fs_bug_on more intuitive
Date:   Sat, 1 Aug 2020 11:24:50 +0800
Message-ID: <20200801032450.3028986-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current judgment condition of f2fs_bug_on in function update_sit_entry():
  new_vblocks >> (sizeof(unsigned short) << 3) ||
	new_vblocks > sbi->blocks_per_seg

which equivalents to:
  new_vblocks < 0 || new_vblocks > sbi->blocks_per_seg

The latter is more intuitive.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reported-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 196f31503511..41836447418d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2140,7 +2140,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	new_vblocks = se->valid_blocks + del;
 	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 
-	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
+	f2fs_bug_on(sbi, (new_vblocks < 0 ||
 				(new_vblocks > sbi->blocks_per_seg)));
 
 	se->valid_blocks = new_vblocks;
-- 
2.25.4

