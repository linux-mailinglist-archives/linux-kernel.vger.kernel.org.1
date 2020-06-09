Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489C1F4944
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgFIWPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 18:15:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45485 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgFIWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:15:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7so235181lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTrEmgv7RHDZYDuYM0LPp7lzo5g/KSIrjUA4oTLoZNQ=;
        b=VA5dbhNU9cZSbsZx52DDnUol6vyRadTyGMuhWHnZ7lgfaj/Al8fRfVrI/l9oZXZPSv
         1iHyDHqy+baFUnw5va4cvI/RB5TlkioFVmUy0C93IZ29/oCxMCphKUVv0R+s+0dclLbb
         m93R8TpLYTQ4ws+hgTCtT+wSvj95jhuENV3bTreo63fqC9VDrRc7SCFQ/ZcRNRqskdFW
         HxD5jpa1a2BCZQKrx6/7Vdb2PpZ7GsZPUi1GV4U8m4N5MQWuoSBhef+a7CXVeLZeazKQ
         /1twZU2rW0dKB1ujK9IsxZNn4SwsJzHJIkV15sKENL/BtxfookWmOZhF1xS35E6N9yZY
         rYeA==
X-Gm-Message-State: AOAM531cNUoPskpFJCwob1Br6RVc/jDs0eOwhF4ujlGuWS/b1bp6y/T3
        CA2xdH7k3qvOITTO0mb3P29cI6u1U54=
X-Google-Smtp-Source: ABdhPJzb2FBZt+ybfr4zN7HzzmVHi6UAQDQdYo+lqynaVtXgD2iq4meR1/vyhgwUXCfegDjO/PbF9g==
X-Received: by 2002:a19:8ac3:: with SMTP id m186mr19262lfd.131.1591740928724;
        Tue, 09 Jun 2020 15:15:28 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id o19sm4531705ljc.23.2020.06.09.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:15:25 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] f2fs: use kfree() instead of kvfree() to free superblock data
Date:   Wed, 10 Jun 2020 01:14:46 +0300
Message-Id: <20200609221446.24537-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181533.73113-1-efremov@linux.com>
References: <20200605181533.73113-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() instead of kvfree() to free super in read_raw_super_block()
because the memory is allocated with kzalloc() in the function.
Use kfree() instead of kvfree() to free sbi, raw_super in
f2fs_fill_super() and f2fs_put_super() because the memory is allocated
with kzalloc().

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Single patch instead of two separate patches
 - kvfree fixed in f2fs_put_super
Changes in v3:
 - raw_super added to the scope, thanks Chao Yu

 fs/f2fs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8a9955902d84..7b458268ea09 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1241,7 +1241,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi->raw_super);
+	kfree(sbi->raw_super);
 
 	destroy_device_list(sbi);
 	f2fs_destroy_xattr_caches(sbi);
@@ -1257,7 +1257,7 @@ static void f2fs_put_super(struct super_block *sb)
 #ifdef CONFIG_UNICODE
 	utf8_unload(sbi->s_encoding);
 #endif
-	kvfree(sbi);
+	kfree(sbi);
 }
 
 int f2fs_sync_fs(struct super_block *sb, int sync)
@@ -3130,7 +3130,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 	/* No valid superblock */
 	if (!*raw_super)
-		kvfree(super);
+		kfree(super);
 	else
 		err = 0;
 
@@ -3808,11 +3808,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	fscrypt_free_dummy_context(&F2FS_OPTION(sbi).dummy_enc_ctx);
 	kvfree(options);
 free_sb_buf:
-	kvfree(raw_super);
+	kfree(raw_super);
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi);
+	kfree(sbi);
 
 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {
-- 
2.26.2

