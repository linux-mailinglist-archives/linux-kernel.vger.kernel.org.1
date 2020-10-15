Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0882728EBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgJOEEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOEEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:04:44 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87ABD221FF;
        Thu, 15 Oct 2020 04:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602734683;
        bh=SMk+hp4oh3UF1fUl7YouAMOuc2XW5qG6kfSb2Z+uKzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTEkAcFC98RK8nCk0vXzifTUJ3hJP1Ne7GhKEoTJNeQrYhKuFSkhH5ub5q5ggFoEQ
         FMXHmKRyS6SFV9jCFDgUxUhSiH9uhTeHSJxOKPvlgJcC/e8+wcVqOislMv4lQalWOz
         oJVy5zu4uF2YukTH+5sZ6wtOt7jlZyCgmFDLmKZE=
Date:   Wed, 14 Oct 2020 21:04:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
Message-ID: <20201015040441.GA834@sol.localdomain>
References: <20201013022429.454161-1-daeho43@gmail.com>
 <20201013022429.454161-2-daeho43@gmail.com>
 <20201013061150.GC1062@sol.localdomain>
 <CACOAw_y31yAu=AGAEqvyo2Ankt-ux80E6g6m_sWnz6LyUgBXSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_y31yAu=AGAEqvyo2Ankt-ux80E6g6m_sWnz6LyUgBXSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 11:27:30AM +0900, Daeho Jeong wrote:
> > f2fs_readonly() is redundant with mnt_want_write_file().
> >
> > Also, shouldn't this require a writable file descriptor?  As-is, this ioctl can
> > be called on a file owned by another user, as long as the caller has read
> > access.
> >
> > Note: if you change this to require a writable file descriptor, then
> > f2fs_readonly(), mnt_want_write_file(), and IS_IMMUTABLE() all would no longer
> > be needed.
> 
> I agree that f2fs_readonly() is redundant.
> But, sorry, I don't get the rest. I thought mnt_want_write_file() is a
> way to check whether the caller has a proper write permission or not.
> I think just using mnt_want_write_file() is enough for this ioctl. Am
> I missing something?

mnt_want_write_file() checks for write permission to the mount, not to the file.

I think this ioctl wants what f2fs_sec_trim_file() does:

	if (!(filp->f_mode & FMODE_WRITE))
		return -EBADF;

	file_start_write(filp);
	inode_lock(inode);
	...
	inode_unlock(inode);
	file_end_write(filp);


After all you shouldn't be able to change the compression options of a file
given only read access to it, right?

> > I don't think the check for i_writecount == 1 accomplishes anything because it
> > just means there are no *other* writable file descriptors.  It doesn't mean that
> > some other thread isn't concurrently trying to write to this same file
> > descriptor.  So the lock needs to be enough.  Is it?
> 
> This is to detect any possibility of other threads mmap-ing and
> writing the file.
> Using only inode lock is not enough to prevent them from making dirty pages.

Well, as I said, i_writecount == 1 doesn't guarantee that other threads aren't
mmap'ing or writing to the file.  It just guarantees that there aren't any other
writable file descriptors.  (Actually, file descriptions.)  Multiple threads can
be using the same file descriptor (or the same file description) concurrently.

- Eric
