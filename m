Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E62FBFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbhASTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404715AbhASTHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 959F620706;
        Tue, 19 Jan 2021 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611083193;
        bh=GFMcQd7MCGExxp99LiWFW+po75/fewRWAf29QDD2b68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sr0IvLwt5KD1z2YKY0WKaQt210uFFKSvdgLdnsDzgUguo6V/qWCcsRSkTtbBJzPQL
         XGe9OfQlyL4XG0lISytwN9eZxrd8kJCfRsliwuGXBElmMaTZpVLfUtm/a1ezRAQbac
         x3m1XjlEKCbJNKiEaGTnf8fetUdVTH4J+rUYVijzoEEByS+2YnnVKX13PMELaLacZG
         esAUOxhCuR+7607vK8qvLIX4nBuPJFyknZ52/Qy8EvBfNj6/KqHoZm16ANo8S1gTdJ
         6XKHVlcAYbQqLlPkp6A+xzGNBNKCbhxQSI+GggUoDE9LuWPhk/ZyGikAUP5POKfhYs
         YYsqyYnve9x8A==
Date:   Tue, 19 Jan 2021 11:06:32 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: fix to keep isolation of atomic write
Message-ID: <YActuF2es8IGJfGj@google.com>
References: <20201230075557.108818-1-yuchao0@huawei.com>
 <YAC9a6quO2VOirLi@google.com>
 <3923906d-f208-f6c2-f121-5e77e8fb6b28@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3923906d-f208-f6c2-f121-5e77e8fb6b28@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15, Chao Yu wrote:
> On 2021/1/15 5:53, Jaegeuk Kim wrote:
> > On 12/30, Chao Yu wrote:
> > > ThreadA					ThreadB
> > > - f2fs_ioc_start_atomic_write
> > > - write
> > > - f2fs_ioc_commit_atomic_write
> > >   - f2fs_commit_inmem_pages
> > >   - f2fs_drop_inmem_pages
> > >   - f2fs_drop_inmem_pages
> > >    - __revoke_inmem_pages
> > > 					- f2fs_vm_page_mkwrite
> > > 					 - set_page_dirty
> > > 					  - tag ATOMIC_WRITTEN_PAGE and add page
> > > 					    to inmem_pages list
> > >    - clear_inode_flag(FI_ATOMIC_FILE)
> > > 					- f2fs_vm_page_mkwrite
> > > 					  - set_page_dirty
> > > 					   - f2fs_update_dirty_page
> > > 					    - f2fs_trace_pid
> > > 					     - tag inmem page private to pid
> > 
> > Hmm, how about removing fs/f2fs/trace.c to make private more complicated
> > like this? I think we can get IO traces from tracepoints.
> 
> Hmm, actually, there is are issues, one is the trace IO, the other is the
> race issue (atomic_start,commit,drop vs mkwrite) which can make isolation
> semantics of transaction be broken.
> 
> Or can we avoid atomic file racing with file mmap?

No, we can't. We may need to find other way to check the race. :)

> 
> - atomic_start			- file_mmap
> 				 - inode_lock
> 				 - if (FI_ATOMIC_FILE) return
>  - inode_lock
>  - if (FI_MMAP_FILE) return
> 
> Thanks,
> 
> > 
> > > 					- truncate
> > > 					 - f2fs_invalidate_page
> > > 					 - set page->mapping to NULL
> > > 					  then it will cause panic once we
> > > 					  access page->mapping
> > > 
> > > The root cause is we missed to keep isolation of atomic write in the case
> > > of commit_atomic_write vs mkwrite, let commit_atomic_write helds i_mmap_sem
> > > lock to avoid this issue.
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > v2:
> > > - use i_mmap_sem to avoid mkwrite racing with below flows:
> > >   * f2fs_ioc_start_atomic_write
> > >   * f2fs_drop_inmem_pages
> > >   * f2fs_commit_inmem_pages
> > > 
> > >   fs/f2fs/file.c    | 3 +++
> > >   fs/f2fs/segment.c | 7 +++++++
> > >   2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 4e6d4b9120a8..a48ec650d691 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2050,6 +2050,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   		goto out;
> > >   	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > +	down_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	/*
> > >   	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
> > > @@ -2060,6 +2061,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   			  inode->i_ino, get_dirty_pages(inode));
> > >   	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >   	if (ret) {
> > > +		up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >   		goto out;
> > >   	}
> > > @@ -2073,6 +2075,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> > >   	/* add inode in inmem_list first and set atomic_file */
> > >   	set_inode_flag(inode, FI_ATOMIC_FILE);
> > >   	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> > > +	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >   	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index d8570b0359f5..dab870d9faf6 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -327,6 +327,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> > >   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > >   	struct f2fs_inode_info *fi = F2FS_I(inode);
> > > +	down_write(&F2FS_I(inode)->i_mmap_sem);
> > > +
> > >   	while (!list_empty(&fi->inmem_pages)) {
> > >   		mutex_lock(&fi->inmem_lock);
> > >   		__revoke_inmem_pages(inode, &fi->inmem_pages,
> > > @@ -344,6 +346,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> > >   		sbi->atomic_files--;
> > >   	}
> > >   	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> > > +
> > > +	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   }
> > >   void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
> > > @@ -467,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
> > >   	f2fs_balance_fs(sbi, true);
> > >   	down_write(&fi->i_gc_rwsem[WRITE]);
> > > +	down_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	f2fs_lock_op(sbi);
> > >   	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> > > @@ -478,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
> > >   	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> > >   	f2fs_unlock_op(sbi);
> > > +
> > > +	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >   	up_write(&fi->i_gc_rwsem[WRITE]);
> > >   	return err;
> > > -- 
> > > 2.29.2
> > .
> > 
