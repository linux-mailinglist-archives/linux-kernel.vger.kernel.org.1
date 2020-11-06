Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511642A9B85
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgKFSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbgKFSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:03:27 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175C4206FA;
        Fri,  6 Nov 2020 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604685806;
        bh=c1ZlbAy1XM/jjZj1v4QY9q6mR0aO6Q1rz0TZUyEWckE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI78ZZSZ/W0SrbT6UwXYvyuQNl3AOtI+Tj6hwuWBh+K0nvt9kVyRNkGJiYOc9nCyT
         Y2vGkrdAaQQTunN+qlGgCVNKr6N2ojO+bR5BhkB28Rna6qavd0ocabTxphfxl7Uvtr
         1SjmvjpbZt+r/ARA+sFdhtq0OoMKLbcdTpwZVles=
Date:   Fri, 6 Nov 2020 10:03:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201106180324.GA78548@sol.localdomain>
References: <20201106065331.76236-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106065331.76236-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 02:53:31PM +0800, Chao Yu wrote:
> +#if defined(__KERNEL__)
> +struct compat_f2fs_gc_range {
> +	u32 sync;
> +	compat_u64 start;
> +	compat_u64 len;
> +};

There's no need to use '#if defined(__KERNEL__)' in kernel source files.

Likewise for compat_f2fs_move_range.

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

I still don't understand why this checkpoint-related stuff is getting added
here, and only to the compat versions of the ioctls.  It wasn't in the original
version.  If they are needed then they should be added to __f2fs_ioc_gc_range()
and __f2fs_ioc_move_range() (preferably by a separate patch) so that they are
done for both the native and compat versions of these ioctls.

- Eric
