Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAF2A4F0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKCSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgKCSil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:38:41 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3299B2074B;
        Tue,  3 Nov 2020 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604428721;
        bh=YUU7O0xdkH9I0WPyXBZOk+F4aYmRrcXzu3VCC7u62jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ke2jgXQEiYikomRounWe5La8GXGy6aMYfzYjBicVKTz0+2z3ePhwj2okspsy3x1Sj
         pR9Pi8/c5eQQnno2G9Cv+LNNr0OD0bmFRDuvSb3ZJlb7zJr8cqbpJbCx1RgT+O2n1u
         eVzeZ0z3pW60GVRwYuYpQu2lxvWaFAAVyBYadbAU=
Date:   Tue, 3 Nov 2020 10:38:39 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: move ioctl interface definitions to
 separated file
Message-ID: <20201103183839.GA1273166@google.com>
References: <20201102062131.14205-1-yuchao0@huawei.com>
 <20201103032234.GB2875@sol.localdomain>
 <c7e47bac-16e6-2038-3eb3-0fdb787ce977@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e47bac-16e6-2038-3eb3-0fdb787ce977@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Chao Yu wrote:
> On 2020/11/3 11:22, Eric Biggers wrote:
> > On Mon, Nov 02, 2020 at 02:21:31PM +0800, Chao Yu wrote:
> > > +#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
> > > +						struct f2fs_move_range)
> > [...]
> > > +#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
> > > +						struct f2fs_gc_range)
> > [...]
> > > +
> > > +struct f2fs_gc_range {
> > > +	__u32 sync;
> > > +	__u64 start;
> > > +	__u64 len;
> > > +};
> > [...]
> > > +struct f2fs_move_range {
> > > +	__u32 dst_fd;		/* destination fd */
> > > +	__u64 pos_in;		/* start position in src_fd */
> > > +	__u64 pos_out;		/* start position in dst_fd */
> > > +	__u64 len;		/* size to move */
> > > +};
> > 
> > These two structs are weird because there is implicit padding between the __u32
> > field and the following __u64 field on some 32-bit architectures (e.g. x86_32)
> > but not others (e.g. arm32).
> > 
> > But f2fs_compat_ioctl() doesn't handle these two ioctls specially, but rather
> > just calls through to f2fs_ioctl().  That's wrong, and it means that
> > F2FS_IOC_MOVE_RANGE and F2FS_IOC_GARBAGE_COLLECT_RANGE won't work when called
> > from an x86_32 binary on an x86_64 kernel.
> 
> Nice catch!
> 
> > 
> > So something needs to be fixed.  I wonder if it's safe to just explicitly add
> > the padding field after the fact.  If no one is actually using these two ioctls
> > in a case where both userspace and the kernel lack the implicit padding (e.g.,
> > x86_32 userspace with x86_32 kernel), it should be fine...
> 
> IIRC, Jaegeuk added those interfaces, I hope it's not the requirement from other
> f2fs userspace developers...if it is, there may be users.
> 
> I found one patch in ext4 which fixes the similar issue, I guess we can fix this
> with the same way, thoughts?

Agreed. Please fix along with f2fs-tools/f2fs_io.

> 
> commit 4d92dc0f00a775dc2e1267b0e00befb783902fe7
> Author: Ben Hutchings <ben@decadent.org.uk>
> Date:   Mon May 17 06:00:00 2010 -0400
> 
>     ext4: Fix compat EXT4_IOC_ADD_GROUP
> 
>     struct ext4_new_group_input needs to be converted because u64 has
>     only 32-bit alignment on some 32-bit architectures, notably i386.
> 
> Thanks,
> 
> > 
> > - Eric
> > .
> > 
