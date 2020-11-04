Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B562A6C54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbgKDSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbgKDSBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:01:55 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD93206F4;
        Wed,  4 Nov 2020 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604512915;
        bh=wXUW33CCdia8aWj2B1exrXaEYZ1hCuHd8oBpvcyoMJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7Q3If8p8K2mQRqrN1dUJltaVQy3W4JMJhMnyK4k1/mqlXg10IbonyhycJTIDMNK7
         zByMKMGDWRA0L9J3TKWsxhXmPljH+0S1iNAgGl7ZTgDHU0hoOS0EfpTZVCqUiaYoXb
         6pVhsOkKq80hhHFp/YNeikg5OMisOdbFAMaT1gFo=
Date:   Wed, 4 Nov 2020 10:01:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201104180153.GB846@sol.localdomain>
References: <20201104064310.15769-1-yuchao0@huawei.com>
 <20201104064310.15769-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064310.15769-2-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:43:10PM +0800, Chao Yu wrote:
> +static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
> +{
> +	struct f2fs_gc_range range;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
> +							sizeof(range)))
> +		return -EFAULT;
> +
> +	return __f2fs_ioc_gc_range(filp, &range);
> +}
[...]
>  #ifdef CONFIG_COMPAT
> +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
> +	struct compat_f2fs_gc_range __user *urange;
> +	struct f2fs_gc_range range;
> +	int err;
> +
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return -EIO;
> +	if (!f2fs_is_checkpoint_ready(sbi))
> +		return -ENOSPC;
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	urange = compat_ptr(arg);
> +	err = get_user(range.sync, &urange->sync);
> +	err |= get_user(range.start, &urange->start);
> +	err |= get_user(range.len, &urange->len);
> +	if (err)
> +		return -EFAULT;
> +
> +	return __f2fs_ioc_gc_range(file, &range);
> +}

It would be better to have __f2fs_ioc_gc_range() handle the f2fs_cp_error(),
f2fs_is_checkpoint_ready(), capable(), and f2fs_readonly() checks, so that they
don't have to be duplicated in the native and compat cases.

Similarly for "move range".

- Eric
