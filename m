Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E852C97CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgLAHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:04:54 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:38759 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgLAHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:04:54 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3243493|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00467113-0.00219213-0.993137;FP=12105205307651440311|1|1|4|0|-1|-1|-1;HT=ay29a033018047192;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.J1OSVB1_1606806239;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J1OSVB1_1606806239)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 01 Dec 2020 15:04:11 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
Subject: [PATCH] f2fs: Remove unnecessary unlikely()
Date:   Tue,  1 Dec 2020 15:03:57 +0800
Message-Id: <20201201070357.851-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

WARN_ON() already contains an unlikely(), so it's not necessary
to use unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..9f33a508fe51 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -33,10 +33,8 @@
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
-		if (unlikely(condition)) {				\
-			WARN_ON(1);					\
+		if (WARN_ON(condition))					\
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
-		}							\
 	} while (0)
 #endif
 
-- 
2.28.0

