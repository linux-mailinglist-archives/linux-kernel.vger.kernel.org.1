Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCED929F097
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgJ2Py4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgJ2Pyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:54:55 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8C0206B2;
        Thu, 29 Oct 2020 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603986895;
        bh=87aI4/JSMDDksYiET/w/mskCfHBQKdtbdR1IFIz2HlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBHEU8f0aEe2A/0HMk7c+LCoGolhLfFyok4S0WPt/8F4nJvewDoafydRcDs9V+Tbn
         0G8iqUnYBYI9na/qMiiHNaV8IBESTZ1sVK3+tw8Q455FAx+c7PRi1qORc3/mHApK5X
         mRZDf2MVLaM6nVZkpr88N7YI+4sSDCs968KKURAY=
Date:   Thu, 29 Oct 2020 08:54:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION
 ioctl
Message-ID: <20201029155453.GB849@sol.localdomain>
References: <20201029041538.4165209-1-daeho43@gmail.com>
 <20201029041538.4165209-2-daeho43@gmail.com>
 <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:29:17PM +0800, Chao Yu wrote:
> > +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > +	struct f2fs_comp_option option;
> > +	int ret = 0;
> > +
> > +	if (!f2fs_sb_has_compression(sbi))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!(filp->f_mode & FMODE_WRITE))
> > +		return -EBADF;
> > +
> > +	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
> > +				sizeof(option)))
> > +		return -EFAULT;
> > +
> > +	if (!f2fs_compressed_file(inode) ||
> > +			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> > +			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
> > +			option.algorithm >= COMPRESS_MAX)
> > +		return -EINVAL;
> > +
> > +	file_start_write(filp);
> > +	inode_lock(inode);
> > +
> > +	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	if (inode->i_size != 0) {
> > +		ret = -EFBIG;
> > +		goto out;
> > +	}
> 
> Hmm...
> 
> Shouldn't it be:
> 
> if (algorithm >= COMPRESS_MAX) {
> 	ret = -ENOPKG;
> 	goto out;
> }
> 
> if (!f2fs_cops[algorithm])
> 	f2fs_warn(...);

Note that my intent with recommending ENOPKG was for it to be returned in the
!f2fs_cops[algorithm] case, similar to how opening an encrypted file when the
encryption algorithm is recognized but not supported by the kernel returns
ENOPKG.  For a truly unrecognized algorithm (algorithm >= COMPRESS_MAX), EINVAL
would probably be more appropriate.  So if !f2fs_cops[algorithm] is now allowed,
then ENOPKG should no longer be among the error codes this ioctl returns.

- Eric
