Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD52AA6D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgKGRQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgKGRQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:16:37 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA66920878;
        Sat,  7 Nov 2020 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604769397;
        bh=VMqMnbjzVosHlpvEbYLFq0+HfLfBtdYGJjT4bgAoHwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ui2PMqzN7ca8Nvf247liiW9Wo9Ev9y9RKgduhAAE7ePQEy/9u/ZCaeqZo1TEG3Hn
         2ppqn5AxFu2mu8oB0jzJIzyI68sr3m6vuJSfiRrdBbDURRJ9A8biG/YMQZU7a72gAF
         tudE7+nsHEas5RborIZ10LGVZLpKlJu3BblKxiRA=
Date:   Sat, 7 Nov 2020 09:16:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201107171635.GA841@sol.localdomain>
References: <20201106065331.76236-1-yuchao0@huawei.com>
 <20201106180324.GA78548@sol.localdomain>
 <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 05:25:23PM +0800, Chao Yu wrote:
> On 2020/11/7 2:03, Eric Biggers wrote:
> > On Fri, Nov 06, 2020 at 02:53:31PM +0800, Chao Yu wrote:
> > > +#if defined(__KERNEL__)
> > > +struct compat_f2fs_gc_range {
> > > +	u32 sync;
> > > +	compat_u64 start;
> > > +	compat_u64 len;
> > > +};
> > 
> > There's no need to use '#if defined(__KERNEL__)' in kernel source files.
> > 
> > Likewise for compat_f2fs_move_range.
> 
> Correct.
> 
> > 
> > > +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
> > > +{
> > > +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
> > > +	struct compat_f2fs_gc_range __user *urange;
> > > +	struct f2fs_gc_range range;
> > > +	int err;
> > > +
> > > +	if (unlikely(f2fs_cp_error(sbi)))
> > > +		return -EIO;
> > > +	if (!f2fs_is_checkpoint_ready(sbi))
> > > +		return -ENOSPC;
> > 
> > I still don't understand why this checkpoint-related stuff is getting added
> > here, and only to the compat versions of the ioctls.  It wasn't in the original
> > version.  If they are needed then they should be added to __f2fs_ioc_gc_range()
> > and __f2fs_ioc_move_range() (preferably by a separate patch) so that they are
> 
> If so, cp-related stuff will be checked redundantly in both f2fs_ioctl() and
> __f2fs_ioc_xxx() function for native GC_RANGE and MOVE_RANGE ioctls, it's
> not needed.
> 

Oh I see, the cp-related checks are at the beginning of f2fs_ioctl() too.

In that case a much better approach would be to add __f2fs_ioctl() which is
called by f2fs_ioctl() and f2fs_compat_ioctl(), and have f2fs_ioctl() and
f2fs_compat_ioctl() do the cp-related checks but not __f2fs_ioctl().

I feel that's still not entirely correct, because ENOTTY should take precedence
over EIO or ENOSPC from the cp-related stuff.  But at least it would be
consistent between the native and compat ioctls, and the cp-related checks
wouldn't have to be duplicated in random ioctls...

- Eric
