Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4232E2D48B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgLISOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbgLISOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:14:12 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:13:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id p21so1026134pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPpiVwJwbCA/SJkH1A30g3V3EvTXlK0B5wY4Rt0mSqQ=;
        b=Zev595F216Rc3TBUQGuC7gFiQSKi3xmHZh9VbmYr2J0aZ/2J4H0gNmA8rAoP2iJxzw
         XQ01BR8WSQPUviY2uVghZHY9gDSWP4KGi2xuAkF+QfYdzx8EPAUSIXFZYG+p/KsREBql
         KuSlbePTtq1SyObqovFY8f6hdx2QKVK4ZLD0YMotel1p/8OBlAg4nm7rzar9GAKcATnU
         4PjK6uNuC8rYwtxW6ICdinsGM39GvkgviGaovxs5BShJsXa3SFqh4Z4MCZXPYBAI4mK9
         Qj1DxRlkSnGKf7v179o+nfd9tOmE5D7lf8LitLofCqkruylF/PsLMJr/TEdiwOHvRzsA
         UYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPpiVwJwbCA/SJkH1A30g3V3EvTXlK0B5wY4Rt0mSqQ=;
        b=TbDdIX7Ar0CTlrgBpMBDdb/KEmMrVphknYkFP1GOLjB0XQI0C5Hv5qP8qMtg2w9ev8
         iBs/5g0Zk0SZDSwcGJrVXpx1x99fisXOu9h2I8HvXaoY8Jy0sb35s/RzYU5zTlrsjC+j
         RRyxltRdgKcdqFHXa0aYuxRa9pt7ffWssF+VL30SFp2VfGocw2TG15PUwle9FJDGqowD
         IpT3bWrKYGRkCHX/tWd+vQEZbagjOoSFfdEWOdPSPPY1NfMIA9S3LPX94chD5ERKAYLz
         9faZVh7oR0uRrdNqcjeT4V5aY8DsOQlI2gX7CBHnaewW+bSBDC7jBLI3DvtejQTfNJ6V
         UZrw==
X-Gm-Message-State: AOAM532iM8Qbkrr1pnGD5JQrrblBeEBTNqhv0Cgx5E0qwTDycdl94Lr3
        s9mJOQQCH6SmVCQ30vcrUTM=
X-Google-Smtp-Source: ABdhPJz+LnsD+M/2QOtOCDI6Djqe7Vn94N8UA5khAEi/S9ljjHipC9M2D+eY2yr4Pj2X1gTSa4KG3g==
X-Received: by 2002:a17:902:63:b029:db:c0d6:96ec with SMTP id 90-20020a1709020063b02900dbc0d696ecmr3262997pla.13.1607537610507;
        Wed, 09 Dec 2020 10:13:30 -0800 (PST)
Received: from localhost.localdomain ([49.207.201.111])
        by smtp.gmail.com with ESMTPSA id p21sm3078636pfn.15.2020.12.09.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:13:29 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com
Subject: [PATCH] fs: f2fs: fix potential shift-out-of-bounds error in sanity_check_raw_super()
Date:   Wed,  9 Dec 2020 23:43:22 +0530
Message-Id: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sanity_check_raw_super(), if
1 << le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE, then the
block size is deemed to be invalid.

syzbot triggered a shift-out-of-bounds bug by assigning a value of 59 to
le32_to_cpu(raw_super->log_blocksize).
Although the value assigned itself isn't of much significance, this goes
to show that even if the block size is invalid,
le32_to_cpu(raw_super->log_blocksize) can be potentially evaluated to a
value for which the shift exponent becomes too large for the unsigned
int.

Since 1 << le32_to_cpu(raw_super->log_blocksize) must be = 4096 for a
valid block size, le32_to_cpu(raw_super->log_blocksize) must equal 12.
Replacing the existing check with the more direct sanity check
resolves this bug.

Reported-by: syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com
Tested-by: syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 fs/f2fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 33808c397580..4bc7372af43f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2775,7 +2775,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	block_t total_sections, blocks_per_seg;
 	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
 					(bh->b_data + F2FS_SUPER_OFFSET);
-	unsigned int blocksize;
 	size_t crc_offset = 0;
 	__u32 crc = 0;
 
@@ -2802,10 +2801,8 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 
 	/* Currently, support only 4KB block size */
-	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
-	if (blocksize != F2FS_BLKSIZE) {
-		f2fs_info(sbi, "Invalid blocksize (%u), supports only 4KB",
-			  blocksize);
+	if (le32_to_cpu(raw_super->log_blocksize) != 12) {
+		f2fs_info(sbi, "Invalid blocksize. Only 4KB supported");
 		return -EFSCORRUPTED;
 	}
 
-- 
2.25.1

