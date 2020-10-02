Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515EF281DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJBVc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJBVc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:32:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B43206DB;
        Fri,  2 Oct 2020 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601674347;
        bh=BXnB7D0dGvSDenDoY22oXd0SzTll4rH2ewFNsGCrSQA=;
        h=From:To:Cc:Subject:Date:From;
        b=LR7U+bEt/2/CNKafgRz9yu9mA1CtUmFoFJ3bsUQ4A+2jE3r+O/Mim0orfIExLNY0u
         wq+A4QhtpDPSXKtSVPIjuNbaoB3Zkq7YCYuT37VAZVOdg7S76w8uOrrqNDzxj//szF
         UFpZxz8cXufw1DsTb8hN5+RY0UAv7vVBxlQbPgME=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: f2fs_get_meta_page_nofail should not be failed
Date:   Fri,  2 Oct 2020 14:32:26 -0700
Message-Id: <20201002213226.2862930-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, f2fs can break the the consistency.
(e.g., BUG_ON in f2fs_get_sum_page)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 +++------
 fs/f2fs/f2fs.h       | 2 --
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f18386d30f031..7bb3a741a8f16 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -110,15 +110,12 @@ struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	struct page *page;
-	int count = 0;
-
 retry:
 	page = __get_meta_page(sbi, index, true);
 	if (IS_ERR(page)) {
-		if (PTR_ERR(page) == -EIO &&
-				++count <= DEFAULT_RETRY_IO_COUNT)
-			goto retry;
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_flush_merged_writes(sbi);
+		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+		goto retry;
 	}
 	return page;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9d58fd5dae139..d905edb42c327 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -595,8 +595,6 @@ enum {
 					 */
 };
 
-#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
-
 /* congestion wait timeout value, default: 20ms */
 #define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
 
-- 
2.28.0.806.g8561365e88-goog

