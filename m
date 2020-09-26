Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A2279574
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgIZAPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgIZAPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:15:05 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2796821D7F;
        Sat, 26 Sep 2020 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601079304;
        bh=3FI5so1k3LpV4f9H4pGXHngEFdStGZj3euUWQSc7guQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djDwGRkSbVrYeYrce1JHOPV3ZhfI3Oi5dsEx0QFI8OZNVcjaS1dgGX+33+rw+k31m
         WKeGYeNieyStj0i8VL1kLKmEcG4IcYAtZHfx0xf1Z+O4uYV1K2GkvVkuD+w4IXrYjz
         niptF/hC9jpCf7Ipl/tZP+8Q0B6D0ISSXkW84BeU=
Date:   Fri, 25 Sep 2020 17:15:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: point man pages for some f2fs utils
Message-ID: <20200926001503.GA976260@google.com>
References: <20200925232256.4136799-1-jaegeuk@kernel.org>
 <20200925232608.GC4136545@google.com>
 <8c6ab915-1bb8-608e-9cc4-2883962deb79@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6ab915-1bb8-608e-9cc4-2883962deb79@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26, Chao Yu wrote:
> On 2020-9-26 7:26, Jaegeuk Kim wrote:
> > On 09/25, Jaegeuk Kim wrote:
> > > This patch adds some missing contexts related to f2fs-tools in f2fs
> > > documentation.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  Documentation/filesystems/f2fs.rst | 46 ++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > > index 0f37c7443d5c5..2b3aef2f5fa1f 100644
> > > --- a/Documentation/filesystems/f2fs.rst
> > > +++ b/Documentation/filesystems/f2fs.rst
> > > @@ -315,7 +315,7 @@ mkfs.f2fs
> > >  The mkfs.f2fs is for the use of formatting a partition as the f2fs filesystem,
> > >  which builds a basic on-disk layout.
> > > 
> > > -The options consist of:
> > > +The quick options consist of:
> > > 
> > >  ===============    ===========================================================
> > >  ``-l [label]``     Give a volume label, up to 512 unicode name.
> > > @@ -337,6 +337,8 @@ The options consist of:
> > >                     1 is set by default, which conducts discard.
> > >  ===============    ===========================================================
> > > 
> > > +Note that, please refer manpage of mkfs.f2fs(8) to get full option list.
> > > +
> > >  fsck.f2fs
> > >  ---------
> > >  The fsck.f2fs is a tool to check the consistency of an f2fs-formatted
> > > @@ -344,10 +346,12 @@ partition, which examines whether the filesystem metadata and user-made data
> > >  are cross-referenced correctly or not.
> > >  Note that, initial version of the tool does not fix any inconsistency.
> > > 
> > > -The options consist of::
> > > +The quick options consist of::
> > > 
> > >    -d debug level [default:0]
> > > 
> > > +Note that, please refer manpage of fsck.f2fs(8) to get full option list.
> > > +
> > >  dump.f2fs
> > >  ---------
> > >  The dump.f2fs shows the information of specific inode and dumps SSA and SIT to
> > > @@ -371,6 +375,44 @@ Examples::
> > >      # dump.f2fs -s 0~-1 /dev/sdx (SIT dump)
> > >      # dump.f2fs -a 0~-1 /dev/sdx (SSA dump)
> > > 
> > > +Note that, please refer manpage of dump.f2fs(8) to get full option list.
> > > +
> > > +sload.f2fs
> > > +----------
> > > +The sload.f2fs gives a way to insert files and directories in the exisiting disk
> > > +image. This tool is useful when building f2fs images given compiled files.
> > > +
> > > +Note that, please refer manpage of sload.f2fs(8) to get full option list.
> > > +
> > > +resize.f2fs
> 
> ^^^^^^^^^
> 
> > > +-----------
> > > +The resize.f2fs can be used when user want to resize the f2fs-formatted disk
> > > +image, while keeping the stored files and directories.
> > > +
> > > +Note that, please refer manpage of resize.f2fs(8) to get full option list.
> > > +
> > > +resize.f2fs
> 
> ^^^^^^^^^
> 
> > > +-----------
> > > +The resize.f2fs let user resize the f2fs-formatted disk image, while preserving
> > > +all the files and directories stored in the image.
> 
> Can merge with above section?
> 
> I noticed that 	("f2fs: Documentation edits/fixes") from Randy Dunlap has
> fixed this, but I think we'd better revise this in-development patch as much
> as possible before upstreaming it.

I can't, as it's now rc6.

> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

My bad to miss posting the patch. It's too late.

> 
> Thanks,
> 
> > > +
> > > +Note that, please refer manpage of resize.f2fs(8) to get full option list.
> > > +
> > > +defrag.f2fs
> > > +-----------
> > > +The defrag.f2fs can be used to defragmente scattered writtend data as well as
> > > +filesystem metadata across the disk. This can improve the write speed by giving
> > > +more free consecutive space.
> > > +
> > > +Note that, please refer manpage of defrag.f2fs(8) to get full option list.
> > > +
> > > +f2fs_io
> > > +-------
> > > +The f2fs_io is a simple tool to issue various filesystem APIs as well as
> > > +f2fs-specific ones, which is very useful for QA tests.
> > > +
> > > +Note that, please refer manpage of f2fs_io(8) to get full option list.
> > > +
> > >  Design
> > >  ======
> > > 
> > > --
> > > 2.28.0.681.g6f77f65b4e-goog
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
