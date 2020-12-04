Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649682CE4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgLDA7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgLDA7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:59:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFDC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:58:57 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x4so2162024pln.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2GdugjcABCFFYqF5Ss710yIiKdBWRhwPg5hBXvzqgQ=;
        b=kxhO1V1NPowvnogMzpWtPh0iTFVXZLDurDgT+3EUZDgMGzVS14kKhnbFoqQP/2IoVu
         BcmyXK0s09ZA31XVYTlNSxppjd02rm6TAQ4QoivdxRqVNNBucoK5vxqo522PdWpWe5bd
         hGznvXTiCYrhBAUZB5we5HT9jUrnj9gxogBZN4gTxs0JyEhynZCv2/JSGNXjUNXW3fwe
         glVOAhOsKXGNsCkruJP5yf/Vhqgxwh7QtKPudrkKblr25abVQcdrrlsCouE+ls8IngJ/
         hrEKnQRy3i6tClhIxDM+B1InajqmVcpKFxhLBR5Bhn+N0LnFrx32buFjr2Cp/InR717K
         1H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2GdugjcABCFFYqF5Ss710yIiKdBWRhwPg5hBXvzqgQ=;
        b=XYs+Y7/oaTrwyxuATvv8T71CtgkW/Slscnfb/ZgzuG8NId3smnpPoh+dB5+6mDYjcy
         9nNhV1Srh1vhCIofbhVP0cUwTYZAeC0VGphfp1YJct3ERWtHGDYVU9mWbBFpr1yKaBsP
         fPkfBg03pBjksVxFDCndhTmyMTXCF+bBvcHUyTtwWWR+oKS1oiuEobAUac3G/4tR7rmr
         jsksHn3+zEu1zvej+qBsTJkK1nQlBeb+SI/hUZq/D/YGn5WWJ8CJOIkFG1JCFecadGde
         m26NSeo7ZWQzQGkZpccgBCA7br26Gdm+9ltRInYtSWkchHfxDWzGls9iXsCpO8v/BPWc
         Qx7g==
X-Gm-Message-State: AOAM5334W2NtX+5jgcVVCBR66qKnjfNwiNnwP01u4kNvCKpOeYnm9ClM
        ejJH/q4kNrHLdgBfqWkO+qOcv0rmR3M=
X-Google-Smtp-Source: ABdhPJz+1teRJkEgEykEx66mRpfwtEn7m8LkBRryWwxYmAt0dtO8PaP7l6asFTa69aV+igHdsDAbhg==
X-Received: by 2002:a17:90a:4f03:: with SMTP id p3mr1722135pjh.69.1607043536197;
        Thu, 03 Dec 2020 16:58:56 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id u205sm2945781pfc.146.2020.12.03.16.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:58:55 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix race of pending_pages in decompression
Date:   Fri,  4 Dec 2020 09:58:47 +0900
Message-Id: <20201204005847.654074-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

I found out f2fs_free_dic() is invoked in a wrong timing, but
f2fs_verify_bio() still needed the dic info and it triggered the
below kernel panic. It has been caused by the race condition of
pending_pages value between decompression and verity logic, when
the same compression cluster had been split in different bios.
By split bios, f2fs_verify_bio() ended up with decreasing
pending_pages value before it is reset to nr_cpages by
f2fs_decompress_pages() and caused the kernel panic.

[ 4416.564763] Unable to handle kernel NULL pointer dereference
               at virtual address 0000000000000000
...
[ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
[ 4416.908515] pc : fsverity_verify_page+0x20/0x78
[ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
[ 4416.913722] sp : ffffffc019533cd0
[ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
[ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
[ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
[ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
[ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
[ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
[ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
[ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
[ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
[ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
[ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
[ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
[ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
[ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
[ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
[ 4416.929184] Call trace:
[ 4416.929187]  fsverity_verify_page+0x20/0x78
[ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
[ 4416.929192]  f2fs_verity_work+0x58/0x84
[ 4417.050667]  process_one_work+0x270/0x47c
[ 4417.055354]  worker_thread+0x27c/0x4d8
[ 4417.059784]  kthread+0x13c/0x320
[ 4417.063693]  ret_from_fork+0x10/0x18

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c |  4 ++--
 fs/f2fs/data.c     | 24 +++++++++++++++++++-----
 fs/f2fs/f2fs.h     |  1 +
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 87090da8693d..cdf72e153da0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	if (cops->destroy_decompress_ctx)
 		cops->destroy_decompress_ctx(dic);
 out_free_dic:
-	if (verity)
-		atomic_set(&dic->pending_pages, dic->nr_cpages);
 	if (!verity)
 		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
 								ret, false);
@@ -1498,6 +1496,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	dic->inode = cc->inode;
 	atomic_set(&dic->pending_pages, cc->nr_cpages);
+	if (fsverity_active(cc->inode))
+		atomic_set(&dic->verity_pages, cc->nr_cpages);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
 	dic->log_cluster_size = cc->log_cluster_size;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 42254d3859c7..be0567dcace9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -202,7 +202,7 @@ static void f2fs_verify_bio(struct bio *bio)
 		dic = (struct decompress_io_ctx *)page_private(page);
 
 		if (dic) {
-			if (atomic_dec_return(&dic->pending_pages))
+			if (atomic_dec_return(&dic->verity_pages))
 				continue;
 			f2fs_verify_pages(dic->rpages,
 						dic->cluster_size);
@@ -2266,15 +2266,29 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 					is_readahead ? REQ_RAHEAD : 0,
 					page->index, for_write);
 			if (IS_ERR(bio)) {
+				unsigned int remained = dic->nr_cpages - i;
+				bool release = false;
+
 				ret = PTR_ERR(bio);
 				dic->failed = true;
-				if (!atomic_sub_return(dic->nr_cpages - i,
-							&dic->pending_pages)) {
+
+				if (fsverity_active(inode)) {
+					if (!atomic_sub_return(remained,
+						&dic->verity_pages))
+						release = true;
+				} else {
+					if (!atomic_sub_return(remained,
+						&dic->pending_pages))
+						release = true;
+				}
+
+				if (release) {
 					f2fs_decompress_end_io(dic->rpages,
-							cc->cluster_size, true,
-							false);
+						cc->cluster_size, true,
+						false);
 					f2fs_free_dic(dic);
 				}
+
 				f2fs_put_dnode(&dn);
 				*bio_ret = NULL;
 				return ret;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94d16bde5e24..f328f55fb0a0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1341,6 +1341,7 @@ struct decompress_io_ctx {
 	size_t rlen;			/* valid data length in rbuf */
 	size_t clen;			/* valid data length in cbuf */
 	atomic_t pending_pages;		/* in-flight compressed page count */
+	atomic_t verity_pages;		/* in-flight page count for verity */
 	bool failed;			/* indicate IO error during decompression */
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
-- 
2.29.2.576.ga3fc446d84-goog

