Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347D02197E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 07:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGIFa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 01:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIFa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:30:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF55206A1;
        Thu,  9 Jul 2020 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594272628;
        bh=4IX4LY45faliARN3WG0EnS0QUvtq8EhBAHND+vk7uOs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ah473ElMO1z3Tf02N5OGRiMwSHdvVhYVuHm0rbf16M6X/Aov5QMICL3UtvboLG0Mr
         hnCJI+kS+5D6PRPDv/teU0Q5B+rPtf0gmXAQ98zHF83tiAn1gFWPNKFGmp37bMBZFA
         KVFEAOjkk+JVSYtHWd70kvWfe1pwff7yEEj5HYGI=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't skip writeback of quota data
Date:   Wed,  8 Jul 2020 22:30:27 -0700
Message-Id: <20200709053027.351974-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need to bypass flushing quota data in background.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 44645f4f914b6..72e8b50e588c1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
 
-	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
+	if (S_ISDIR(inode->i_mode) &&
 			wbc->sync_mode == WB_SYNC_NONE &&
 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
-- 
2.27.0.383.g050319c2ae-goog

