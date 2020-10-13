Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6D28C88B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgJMGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388949AbgJMGLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:11:52 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F404208D5;
        Tue, 13 Oct 2020 06:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602569512;
        bh=RdcM42RUsQgguE+mIVddBaOAVmC+EXsrSMwUWlEemcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvQLuMcn0duMSVgVY9alkWGVdxZK6COUr8i+kqrKvo/2LbZZRDPt3b+Pd1W2xrntr
         Q9LgG383D6Aexv1HMTNm24LTYZU5RPmLyqhnBGyKv0G/bZui/I4VVA6BLDJEyl+H7J
         OXB5B+BRP4lIbLQiDgnyPb3LeE8CHGmUa1dQMoQY=
Date:   Mon, 12 Oct 2020 23:11:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
Message-ID: <20201013061150.GC1062@sol.localdomain>
References: <20201013022429.454161-1-daeho43@gmail.com>
 <20201013022429.454161-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013022429.454161-2-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:24:29AM +0900, Daeho Jeong wrote:
> +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_comp_option option;
> +	int ret;
> +	int writecount;
> +
> +	if (!f2fs_sb_has_compression(sbi))
> +		return -EOPNOTSUPP;
> +
> +	if (!f2fs_compressed_file(inode) || IS_IMMUTABLE(inode))
> +		return -EINVAL;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;

f2fs_readonly() is redundant with mnt_want_write_file().

Also, shouldn't this require a writable file descriptor?  As-is, this ioctl can
be called on a file owned by another user, as long as the caller has read
access.

Note: if you change this to require a writable file descriptor, then
f2fs_readonly(), mnt_want_write_file(), and IS_IMMUTABLE() all would no longer
be needed.

> +
> +	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
> +				sizeof(option)))
> +		return -EFAULT;
> +
> +	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
> +			option.algorithm >= COMPRESS_MAX)
> +		return -EINVAL;

What if f2fs_cops[options.algorithm] == NULL, e.g. COMPRESS_LZ4 without
CONFIG_F2FS_FS_LZ4?  Shouldn't the caller get an error then?

> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	inode_lock(inode);
> +
> +	writecount = atomic_read(&inode->i_writecount);
> +	if ((filp->f_mode & FMODE_WRITE && writecount != 1) ||
> +			(!(filp->f_mode & FMODE_WRITE) && writecount)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}

I don't think the check for i_writecount == 1 accomplishes anything because it
just means there are no *other* writable file descriptors.  It doesn't mean that
some other thread isn't concurrently trying to write to this same file
descriptor.  So the lock needs to be enough.  Is it?

- Eric
