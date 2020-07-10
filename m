Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB221AD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 05:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGJDUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 23:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGJDUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:20:37 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2130B20657;
        Fri, 10 Jul 2020 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594351236;
        bh=XReK43l5KBhtSYgtoFBk5br0uXqKW/BoDECZFioWyXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RM+jp5A3CPHLVfl7472aQS9ZE6OGOxY0fX3HrOCfrYdtoUpJl/KfOIpDOMvbLjR6B
         USXz7zhntA/C59YAHYW9QpkZSgzGtrt65jttrJmXVpL7Lda75BR+N6CGEoyNQIL07Y
         Ui63RRoDhUxgfDfYnp5mqhbKHzb8ZHlfnZMT/vxc=
Date:   Thu, 9 Jul 2020 20:20:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200710032035.GB545837@google.com>
References: <20200710021505.2405872-1-daeho43@gmail.com>
 <20200710030246.GA545837@google.com>
 <CACOAw_yJvQgDsLRd0-iJqXN06wDXmC3_OqKgKey7p=WeqxzMFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_yJvQgDsLRd0-iJqXN06wDXmC3_OqKgKey7p=WeqxzMFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Daeho Jeong wrote:
> 1. The valid data will be within i_size.
> 2. All the trim operations will be done in a unit of block, even if
> i_size is not aligned with BLKSIZE like the below.
> 
>         index = F2FS_BYTES_TO_BLK(range.start);
>         pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);     <= BLKSIZE aligned
> 
> Are you worried about the case that sudden power-off occurs while a
> file is being truncated?
> ex) 1GB file is being truncated to 4KB -> sudden power-off ->
> i_size(4KB), i_blocks(maybe somewhere between 4KB and 1GB)

Yes. Basically, I believe we can have some data beyond i_size like fsverity.

> 
> 2020년 7월 10일 (금) 오후 12:02, Jaegeuk Kim <jaegeuk@kernel.org>님이 작성:
> >
> > On 07/10, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> > >  1. Added -1 value support for range.len to signify the end of file.
> > >  2. If the end of the range passes over the end of file, it means until
> > >     the end of file.
> > >  3. ignored the case of that range.len is zero to prevent the function
> > >     from making end_addr zero and triggering different behaviour of
> > >     the function.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >  fs/f2fs/file.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 368c80f8e2a1..1c4601f99326 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> > >       file_start_write(filp);
> > >       inode_lock(inode);
> > >
> > > -     if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> > > +     if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> > > +                     range.start >= inode->i_size) {
> > >               ret = -EINVAL;
> > >               goto err;
> > >       }
> > >
> > > -     if (range.start >= inode->i_size) {
> > > -             ret = -EINVAL;
> > > +     if (range.len == 0)
> > >               goto err;
> > > -     }
> > >
> > > -     if (inode->i_size - range.start < range.len) {
> > > -             ret = -E2BIG;
> > > -             goto err;
> > > -     }
> > > -     end_addr = range.start + range.len;
> > > +     if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
> > > +             end_addr = inode->i_size;
> >
> > Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for
> > ending criteria?
> >
> > > +     else
> > > +             end_addr = range.start + range.len;
> > >
> > >       to_end = (end_addr == inode->i_size);
> > >       if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> > > --
> > > 2.27.0.383.g050319c2ae-goog
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
