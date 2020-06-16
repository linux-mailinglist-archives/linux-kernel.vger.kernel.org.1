Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F691FBEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgFPTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 15:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgFPTCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:02:10 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7E720B1F;
        Tue, 16 Jun 2020 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592334130;
        bh=6C54LEMm6tqkAKhNPEqK9zytbvYMYwufDD8ydBfabkU=;
        h=From:To:Cc:Subject:Date:From;
        b=uwNu/TASBPqqXi5PzxB79pLj2zqp321gHhSiY79uM113hFDQqa6Ad4+Z2Z9EmaFfF
         hp9DBtOlWGbAMDqs6bGhlngfiMV5d2xB7wCN4S5ooL4DPg0GatCCfeqnvl2Ce2ht0i
         Lds5H2EJwxMuuQncnDEfCDUFytWCAY+BdUuhtz18=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid checkpatch error
Date:   Tue, 16 Jun 2020 12:02:08 -0700
Message-Id: <20200616190208.206595-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR:INITIALISED_STATIC: do not initialise statics to NULL

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1e02a8c106b0a..4dca9e4567348 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -506,7 +506,7 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
-static mempool_t *compress_page_pool = NULL;
+static mempool_t *compress_page_pool;
 static int num_compress_pages = 512;
 module_param(num_compress_pages, uint, 0444);
 MODULE_PARM_DESC(num_compress_pages,
-- 
2.27.0.290.gba653c62da-goog

