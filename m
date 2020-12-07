Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83AA2D0E8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLGLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:00:26 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:51908 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgLGLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:00:26 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2116129|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0159781-0.000759197-0.983263;FP=11324991882870974183|1|1|4|0|-1|-1|-1;HT=ay29a033018047202;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.J47Legk_1607338777;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.J47Legk_1607338777)
          by smtp.aliyun-inc.com(10.147.42.253);
          Mon, 07 Dec 2020 18:59:42 +0800
From:   liush <liush@allwinnertech.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        Shaohua Liu <liush@allwinnertech.com>
Subject: [PATCH 1/2] f2fs: convert to F2FS_*_INO macro
Date:   Mon,  7 Dec 2020 18:59:33 +0800
Message-Id: <1607338774-8541-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use F2FS_ROOT_INO, F2FS_NODE_INO and F2FS_META_INO macro
for better code readability.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Shaohua Liu <liush@allwinnertech.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f51807..d3ccf89647df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3071,9 +3071,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->total_node_count =
 		(le32_to_cpu(raw_super->segment_count_nat) / 2)
 			* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
-	sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
-	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
-	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
+	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
+	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
+	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
-- 
2.25.1

