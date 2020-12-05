Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8B2CF94F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 05:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLEE1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 23:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEE1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 23:27:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16736C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 20:26:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so4792638pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 20:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPUA+ChEj7AVpX03CZ1yAGXyVu6fZ/TK5k59pbo/awo=;
        b=Sb0JaQtZj50HV3Ilc20YtcoWLCEBrh/zfhe/011/KRaMcidycuQFB7FUtjSQUqXoH0
         LmIOB+snC/KDnA1x9WtMsoDdh2lGuJwdRWs9FKO78EisPOcRi+Oo7vjSg2LH5YWVvFNB
         dd/nftTSN28dIAT3r9f4gVMjJPPmVSwlKdOSthfyWmeZN4jCMyEo63/MjDZSAGTIkwA0
         IRCZT8CxUVYrBamE2pzXiBKiFh7mHFVhhuZ8zyyzIz/7Kphu6QTzta/b90RmgGquHJTD
         gTrmwOJeb3Zmx72nunJkqMZocOQVKpF1KBXmq0ZTsoHsdv7FGwlneo8Ss9zYTGF40pcX
         di9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPUA+ChEj7AVpX03CZ1yAGXyVu6fZ/TK5k59pbo/awo=;
        b=sgkMAeAZ7xeInuAACQ9I2MxDUJuaeDQPB9KpUyX4wE7utKLLc9LBSGjYDI73JUMKjQ
         SIkwJXqBbDcOuI/YonFuQx4Tr3MYKYhg/Z9SnvIqzV7ey5gHgb1Vy/HJ/VhuZUFyL+SN
         T1hIXbQyvyI2Pv3FTmCoQAPtuuD5nPcfFa5yT3PINMrf9R3C0X1nfBMSpHA5qwWLV3Eb
         dpT1b8pCW51wC5zpCa1Mw7Xt7JsBnSnDsPPldstyB6ZcycdrmUZkbzI8Ab3E7HS+y7bU
         7wQRG95Mb8RT8/0LUavv3CuFCwOgHEX8eKuXrtoYQPlM/gRwpwObanDpKJ+2Lo6qCxgy
         FCUw==
X-Gm-Message-State: AOAM530rMbxxLB5jTQAbJgGnjqLMcOBZAKVYvciT9hDK5+Dt2+sqQuJk
        6lJAfiTcpkG6cpF/gfT1CfLQVSBY8YU=
X-Google-Smtp-Source: ABdhPJxrxYiYK1FNSRR5lJDcfQTvT+cyKSpH+U0dcP1g13CpWr5MeHLIFjl0dD2YaiiqoUBbZWrBpw==
X-Received: by 2002:a63:a902:: with SMTP id u2mr10320293pge.263.1607142393053;
        Fri, 04 Dec 2020 20:26:33 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id x7sm6262654pfn.85.2020.12.04.20.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:26:32 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3] f2fs: fix race of pending_pages in decompression
Date:   Sat,  5 Dec 2020 13:26:26 +0900
Message-Id: <20201205042626.1113600-1-daeho43@gmail.com>
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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3: back to v1 and enabled verity in a unit of cluster
v2: merged verity_pages with pending_pages, and increased the
    pending_pages count only if STEP_VERITY is set on bio
---
 fs/f2fs/compress.c |  2 --
 fs/f2fs/data.c     | 51 ++++++++++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h     |  1 +
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 87090da8693d..832b19986caf 100644
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
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 42254d3859c7..861e5783a5fc 100644
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
@@ -1027,7 +1027,8 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 				      unsigned nr_pages, unsigned op_flag,
-				      pgoff_t first_idx, bool for_write)
+				      pgoff_t first_idx, bool for_write,
+				      bool for_verity)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1049,7 +1050,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		post_read_steps |= 1 << STEP_DECRYPT;
 	if (f2fs_compressed_file(inode))
 		post_read_steps |= 1 << STEP_DECOMPRESS_NOWQ;
-	if (f2fs_need_verity(inode, first_idx))
+	if (for_verity && f2fs_need_verity(inode, first_idx))
 		post_read_steps |= 1 << STEP_VERITY;
 
 	if (post_read_steps) {
@@ -1079,7 +1080,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	struct bio *bio;
 
 	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
-					page->index, for_write);
+					page->index, for_write, true);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
@@ -2133,7 +2134,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				is_readahead ? REQ_RAHEAD : 0, page->index,
-				false);
+				false, true);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
 			bio = NULL;
@@ -2180,6 +2181,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	struct decompress_io_ctx *dic = NULL;
+	struct bio_post_read_ctx *ctx;
+	bool for_verity = false;
 	int i;
 	int ret = 0;
 
@@ -2245,10 +2248,22 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		goto out_put_dnode;
 	}
 
+	if (fsverity_active(cc->inode)) {
+		atomic_set(&dic->verity_pages, cc->nr_cpages);
+		for_verity = true;
+
+		if (bio) {
+			ctx = bio->bi_private;
+			if (!(ctx->enabled_steps & (1 << STEP_VERITY))) {
+				__submit_bio(sbi, bio, DATA);
+				bio = NULL;
+			}
+		}
+	}
+
 	for (i = 0; i < dic->nr_cpages; i++) {
 		struct page *page = dic->cpages[i];
 		block_t blkaddr;
-		struct bio_post_read_ctx *ctx;
 
 		blkaddr = data_blkaddr(dn.inode, dn.node_page,
 						dn.ofs_in_node + i + 1);
@@ -2264,17 +2279,31 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
 					is_readahead ? REQ_RAHEAD : 0,
-					page->index, for_write);
+					page->index, for_write, for_verity);
 			if (IS_ERR(bio)) {
+				unsigned int remained = dic->nr_cpages - i;
+				bool release = false;
+
 				ret = PTR_ERR(bio);
 				dic->failed = true;
-				if (!atomic_sub_return(dic->nr_cpages - i,
-							&dic->pending_pages)) {
+
+				if (for_verity) {
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

