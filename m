Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC021CC3DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEITDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 15:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgEITDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 15:03:43 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1CE206B9;
        Sat,  9 May 2020 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589051022;
        bh=lODxQLx7dBie1ZnMhupf2FdHGusr1dQe5rGiRUF3Jo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTjMTwNBOj/mfAdp1oULKrXa5F6uVH+VTd9N383SHsYike6cDsqCcW4YzqSI8KzII
         3Wuc41WLdW8xahlJNdN9WAUML9Me44/zhOy9Jddo7QgPUlZ26b7mvhiZwqf3+l/wDu
         NGpd+SuvMsIZ7kXkPfwLyBehqvML72jly2TMeM+o=
Date:   Sat, 9 May 2020 12:03:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Sayali Lokhande <sayalil@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net, stummala@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] f2fs: Avoid double lock for cp_rwsem during checkpoint
Message-ID: <20200509190342.GA11239@google.com>
References: <1588244309-1468-1-git-send-email-sayalil@codeaurora.org>
 <20200508161052.GA49579@google.com>
 <0902037e-998d-812e-53e7-90ea7b9957eb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0902037e-998d-812e-53e7-90ea7b9957eb@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Chao Yu wrote:
> On 2020/5/9 0:10, Jaegeuk Kim wrote:
> > Hi Sayali,
> > 
> > In order to address the perf regression, how about this?
> > 
> >>From 48418af635884803ffb35972df7958a2e6649322 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Fri, 8 May 2020 09:08:37 -0700
> > Subject: [PATCH] f2fs: avoid double lock for cp_rwsem during checkpoint
> > 
> > There could be a scenario where f2fs_sync_node_pages gets
> > called during checkpoint, which in turn tries to flush
> > inline data and calls iput(). This results in deadlock as
> > iput() tries to hold cp_rwsem, which is already held at the
> > beginning by checkpoint->block_operations().
> > 
> > Call stack :
> > 
> > Thread A		Thread B
> > f2fs_write_checkpoint()
> > - block_operations(sbi)
> >  - f2fs_lock_all(sbi);
> >   - down_write(&sbi->cp_rwsem);
> > 
> >                         - open()
> >                          - igrab()
> >                         - write() write inline data
> >                         - unlink()
> > - f2fs_sync_node_pages()
> >  - if (is_inline_node(page))
> >   - flush_inline_data()
> >    - ilookup()
> >      page = f2fs_pagecache_get_page()
> >      if (!page)
> >       goto iput_out;
> >      iput_out:
> > 			-close()
> > 			-iput()
> >        iput(inode);
> >        - f2fs_evict_inode()
> >         - f2fs_truncate_blocks()
> >          - f2fs_lock_op()
> >            - down_read(&sbi->cp_rwsem);
> > 
> > Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/node.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 1db8cabf727ef..626d7daca09de 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> >  				goto continue_unlock;
> >  			}
> >  
> > -			/* flush inline_data */
> > -			if (is_inline_node(page)) {
> > +			/* flush inline_data, if it's not sync path. */
> > +			if (do_balance && is_inline_node(page)) {
> 
> IIRC, this flow was designed to avoid running out of free space issue
> during checkpoint:
> 
> 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
> 
> The sceanrio is:
> 1. create fully node blocks
> 2. flush node blocks
> 3. write inline_data for all the node blocks again
> 4. flush node blocks redundantly
> 
> I guess this may cause failing one case of fstest.

Yeah, actually I was hitting 204 failure, and thus, revised like this.
Now, I don't see any regression in fstest.

From 8f1882acfb0a5fc43e5a2bbd576a8f3c681a7d2c Mon Sep 17 00:00:00 2001
From: Sayali Lokhande <sayalil@codeaurora.org>
Date: Thu, 30 Apr 2020 16:28:29 +0530
Subject: [PATCH] f2fs: Avoid double lock for cp_rwsem during checkpoint

There could be a scenario where f2fs_sync_node_pages gets
called during checkpoint, which in turn tries to flush
inline data and calls iput(). This results in deadlock as
iput() tries to hold cp_rwsem, which is already held at the
beginning by checkpoint->block_operations().

Call stack :

Thread A		Thread B
f2fs_write_checkpoint()
- block_operations(sbi)
 - f2fs_lock_all(sbi);
  - down_write(&sbi->cp_rwsem);

                        - open()
                         - igrab()
                        - write() write inline data
                        - unlink()
- f2fs_sync_node_pages()
 - if (is_inline_node(page))
  - flush_inline_data()
   - ilookup()
     page = f2fs_pagecache_get_page()
     if (!page)
      goto iput_out;
     iput_out:
			-close()
			-iput()
       iput(inode);
       - f2fs_evict_inode()
        - f2fs_truncate_blocks()
         - f2fs_lock_op()
           - down_read(&sbi->cp_rwsem);

Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  9 ++++++++-
 fs/f2fs/f2fs.h       |  4 ++--
 fs/f2fs/node.c       | 10 +++++-----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d49f7a01d8a26..928aea4ff663d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1168,6 +1168,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	};
 	int err = 0, cnt = 0;
 
+	/*
+	 * Let's flush node pages first to flush inline_data.
+	 * We'll actually guarantee everything below under f2fs_lock_all.
+	 */
+	f2fs_sync_node_pages(sbi, &wbc, false, false, FS_CP_NODE_IO);
+
 retry_flush_quotas:
 	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
@@ -1222,7 +1228,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
-		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
+		err = f2fs_sync_node_pages(sbi, &wbc, false,
+					true, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err) {
 			up_write(&sbi->node_change);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d916540f12813..ac6ae42b9dd4e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3286,8 +3286,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id);
 int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
-			struct writeback_control *wbc,
-			bool do_balance, enum iostat_type io_type);
+		struct writeback_control *wbc,
+		bool do_balance, bool sync, enum iostat_type io_type);
 int f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
 bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1db8cabf727ef..fd00a8c119088 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1808,8 +1808,8 @@ static bool flush_dirty_inode(struct page *page)
 }
 
 int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
-				struct writeback_control *wbc,
-				bool do_balance, enum iostat_type io_type)
+			struct writeback_control *wbc,
+			bool do_balance, bool sync, enum iostat_type io_type)
 {
 	pgoff_t index;
 	struct pagevec pvec;
@@ -1870,8 +1870,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto continue_unlock;
 			}
 
-			/* flush inline_data */
-			if (is_inline_node(page)) {
+			/* flush inline_data, if it's async context. */
+			if (!sync && is_inline_node(page)) {
 				clear_inline_node(page);
 				unlock_page(page);
 				flush_inline_data(sbi, ino_of_node(page));
@@ -1999,7 +1999,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	blk_start_plug(&plug);
-	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
+	f2fs_sync_node_pages(sbi, wbc, true, false, FS_NODE_IO);
 	blk_finish_plug(&plug);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 
-- 
2.26.2.645.ge9eca65c58-goog

