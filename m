Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F572319FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgG2HCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 03:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgG2HCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:02:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99112070B;
        Wed, 29 Jul 2020 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596006166;
        bh=PsG28ZKBgOwqSDbxUyTDDzHrSZ08sLR2QQcOJCPJkbg=;
        h=From:To:Cc:Subject:Date:From;
        b=KlNOKaUxeBPVXLkj+pydQcG5m7sPnUW6DnUrO1n1hlDwdy6+BUgLgBCkM9dPrv6uh
         o6+5xOO/UsOYrvMc97JJNWyz1cNIUoHVG6BIf+NEkzghCrLt81UkA6YZQSWmcmfEZp
         /JJ3LPd10QyBCUSEbkgjBSsvpB+t/zQe3qdvyi/g=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix deadlock between quota writes and checkpoint
Date:   Wed, 29 Jul 2020 00:02:44 -0700
Message-Id: <20200729070244.584518-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_write_data_pages(quota_mapping)
 __f2fs_write_data_pages             f2fs_write_checkpoint
  * blk_start_plug(&plug);
  * add bio in write_io[DATA]
                                      - block_operations
                                      - skip syncing quota by
                                                >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
                                      - down_write(&sbi->node_write);
  - f2fs_write_single_data_page
    - f2fs_do_write_data_page
      - f2fs_outplace_write_data
        - do_write_page
           - f2fs_allocate_data_block
            - down_write(node_write)
                                      - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8c782d3f324f0..99c8061da55b9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (type == F2FS_DIRTY_META)
 			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
 							FS_CP_META_IO);
+		else if (type == F2FS_WB_CP_DATA)
+			f2fs_submit_merged_write(sbi, DATA);
 		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
-- 
2.28.0.rc0.142.g3c755180ce-goog

