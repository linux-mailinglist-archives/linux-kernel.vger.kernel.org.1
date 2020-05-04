Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BA1C3D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgEDOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgEDOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:30:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F6F20721;
        Mon,  4 May 2020 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588602640;
        bh=npyVMpEkCqP47vK/3mKvzs371ZtGgQITkgOQX9mdQjY=;
        h=From:To:Cc:Subject:Date:From;
        b=eEJaD0ZEz5VfWYlWTVpOTos5fOnwiNG3g/saqcrKdLWp78+xQuLIWaK/+6+jzg7A6
         lUVoRHynjtW/MoTSZCXKP4hBWLOgKLvzHTEAx46W/NXdOqsy+yFe3tqORj1sPjyHsV
         VND1zcREbsOSfw7FDmp+OZpATxcM3scDDKAEmXFU=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change maximum zstd compression buffer size
Date:   Mon,  4 May 2020 07:30:39 -0700
Message-Id: <20200504143039.155644-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Current zstd compression buffer size is one page and header size less
than cluster size. By this, zstd compression always succeeds even if
the real compression data is failed to fit into the buffer size, and
eventually reading the cluster returns I/O error with the corrupted
compression data.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4c7eaeee52336..a9fa8049b295f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -313,7 +313,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	cc->private = workspace;
 	cc->private2 = stream;
 
-	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	cc->clen = ZSTD_compressBound(PAGE_SIZE << cc->log_cluster_size);
 	return 0;
 }
 
@@ -330,7 +330,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 	ZSTD_inBuffer inbuf;
 	ZSTD_outBuffer outbuf;
 	int src_size = cc->rlen;
-	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	int dst_size = cc->clen;
 	int ret;
 
 	inbuf.pos = 0;
-- 
2.26.2.526.g744177e7f7-goog

