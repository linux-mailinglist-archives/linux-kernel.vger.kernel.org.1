Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64E82CF414
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgLDSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgLDSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:30:05 -0500
Date:   Fri, 4 Dec 2020 10:29:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607106564;
        bh=mblh6wVY0lJ08ec0XmcY0LDeZa2RfjpHs2gBm6g+oHI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScpVSwVead6yek1MBaQZ5HkQgQ/kQqzZx4af/u2RcpgxYulzVRv3UF9nviUN0CULo
         goo2392zPidcjax15iva9NvjnPH6QbrV5P4Sg+8Ktph1R1YL9HkSO4WxLf6mgKoyj/
         uwfpBySZnjijiOLCbZzT8nrc/30DzMTCREwtuVLeM09RShuUnsBxi06jFh0bbhca1q
         HZRBvBUEQhtqyMiFZatapWNbYJKh/e1p+CC/Tv5RB2DUljBKGJpiGj0E8GH1fPmvr3
         yeXyziperDOAjoGYKvLvNkmPyFsxJrrR7Is6uXyOTvBCr/znc32gkE+TJ+GVkglTxO
         dy2MZa0A3TH/w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X8qAAiRah/zmowZB@google.com>
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain>
 <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain>
 <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
 <X8nGvfEeTDTLa6FL@sol.localdomain>
 <CACOAw_wfew8xER-CibUtddRKVtcr3k_iGzjQ-bVYxqRUuEVCcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_wfew8xER-CibUtddRKVtcr3k_iGzjQ-bVYxqRUuEVCcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04, Daeho Jeong wrote:
> Thanks for the explanation about verity.
> I got your point. Thanks~

Possible fix can be like this?

---
 fs/f2fs/compress.c |  2 --
 fs/f2fs/data.c     | 19 +++++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 89f73a7c8667..c5fee4d7ea72 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1491,8 +1491,6 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	dic->inode = cc->inode;
 	atomic_set(&dic->pending_pages, cc->nr_cpages);
-	if (fsverity_active(cc->inode))
-		atomic_set(&dic->verity_pages, cc->nr_cpages);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
 	dic->log_cluster_size = cc->log_cluster_size;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e3168f32f943..657fb562d7d4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1035,7 +1035,8 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 				      unsigned nr_pages, unsigned op_flag,
-				      pgoff_t first_idx, bool for_write)
+				      pgoff_t first_idx, bool for_write,
+				      bool for_verity)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1057,7 +1058,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		post_read_steps |= 1 << STEP_DECRYPT;
 	if (f2fs_compressed_file(inode))
 		post_read_steps |= 1 << STEP_DECOMPRESS_NOWQ;
-	if (f2fs_need_verity(inode, first_idx))
+	if (for_verity && f2fs_need_verity(inode, first_idx))
 		post_read_steps |= 1 << STEP_VERITY;
 
 	if (post_read_steps) {
@@ -1087,7 +1088,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	struct bio *bio;
 
 	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
-					page->index, for_write);
+					page->index, for_write, true);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
@@ -2141,7 +2142,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				is_readahead ? REQ_RAHEAD : 0, page->index,
-				false);
+				false, true);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
 			bio = NULL;
@@ -2188,6 +2189,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	struct decompress_io_ctx *dic = NULL;
+	bool for_verity = false;
 	int i;
 	int ret = 0;
 
@@ -2253,6 +2255,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		goto out_put_dnode;
 	}
 
+	if (fsverity_active(cc->inode)) {
+		atomic_set(&dic->verity_pages, cc->nr_cpages);
+		for_verity = true;
+	}
+
 	for (i = 0; i < dic->nr_cpages; i++) {
 		struct page *page = dic->cpages[i];
 		block_t blkaddr;
@@ -2272,7 +2279,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
 					is_readahead ? REQ_RAHEAD : 0,
-					page->index, for_write);
+					page->index, for_write, for_verity);
 			if (IS_ERR(bio)) {
 				unsigned int remained = dic->nr_cpages - i;
 				bool release = false;
@@ -2280,7 +2287,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				ret = PTR_ERR(bio);
 				dic->failed = true;
 
-				if (fsverity_active(inode)) {
+				if (for_verity) {
 					if (!atomic_sub_return(remained,
 						&dic->verity_pages))
 						release = true;
-- 
2.29.2.576.ga3fc446d84-goog

