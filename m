Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A02D0E88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLGK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:59:00 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37716 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbgLGK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:59:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1358769|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0423175-0.000134208-0.957548;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.J48LPz9_1607338688;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.J48LPz9_1607338688)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 07 Dec 2020 18:58:15 +0800
From:   liush <liush@allwinnertech.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, iny.windzz@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Shaohua Liu <liush@allwinnertech.com>
Subject: [PATCH 2/2] f2fs: don't check PAGE_SIZE again in sanity_check_raw_super()
Date:   Mon,  7 Dec 2020 18:58:07 +0800
Message-Id: <1607338687-8477-2-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607338687-8477-1-git-send-email-liush@allwinnertech.com>
References: <1607338687-8477-1-git-send-email-liush@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Many flash devices read and write a single IO based on a multiple
of 4KB, and we support only 4KB page cache size now.

Since we already check page size in init_f2fs_fs(), so remove page
size check in sanity_check_raw_super().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Shaohua Liu <liush@allwinnertech.com>
---
 fs/f2fs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d3ccf89647df..a39a81ab8dee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2770,13 +2770,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	/* Currently, support only 4KB page cache size */
-	if (F2FS_BLKSIZE != PAGE_SIZE) {
-		f2fs_info(sbi, "Invalid page_cache_size (%lu), supports only 4KB",
-			  PAGE_SIZE);
-		return -EFSCORRUPTED;
-	}
-
 	/* Currently, support only 4KB block size */
 	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
 	if (blocksize != F2FS_BLKSIZE) {
-- 
2.25.1

