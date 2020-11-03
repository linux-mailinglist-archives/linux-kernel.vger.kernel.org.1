Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7E2A3AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKCDWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgKCDWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:22:36 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140A0207BB;
        Tue,  3 Nov 2020 03:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604373756;
        bh=7aFgfXQwxuCN6CihcO+o9uIp6HKkf3hnQvxiwlMdqW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1tSP/XlAhjfm/smjFoMIvolMvFvjAk4pBWrgGp1ydvgiHjZ1FDzuNEdnn6LMNEi2
         h8t2VSiQnVH4cyzuToFx7aD/qS6m2p1jcgRvsjcGagUyHqfvibV5mAGjOagYMVzD+b
         jFRhc4NpyP8skgEJAJfsqhKVZHra2D7/GAf4bbo8=
Date:   Mon, 2 Nov 2020 19:22:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: move ioctl interface definitions to
 separated file
Message-ID: <20201103032234.GB2875@sol.localdomain>
References: <20201102062131.14205-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102062131.14205-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:21:31PM +0800, Chao Yu wrote:
> +#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
> +						struct f2fs_move_range)
[...]
> +#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
> +						struct f2fs_gc_range)
[...]
> +
> +struct f2fs_gc_range {
> +	__u32 sync;
> +	__u64 start;
> +	__u64 len;
> +};
[...]
> +struct f2fs_move_range {
> +	__u32 dst_fd;		/* destination fd */
> +	__u64 pos_in;		/* start position in src_fd */
> +	__u64 pos_out;		/* start position in dst_fd */
> +	__u64 len;		/* size to move */
> +};

These two structs are weird because there is implicit padding between the __u32
field and the following __u64 field on some 32-bit architectures (e.g. x86_32)
but not others (e.g. arm32).

But f2fs_compat_ioctl() doesn't handle these two ioctls specially, but rather
just calls through to f2fs_ioctl().  That's wrong, and it means that
F2FS_IOC_MOVE_RANGE and F2FS_IOC_GARBAGE_COLLECT_RANGE won't work when called
from an x86_32 binary on an x86_64 kernel.

So something needs to be fixed.  I wonder if it's safe to just explicitly add
the padding field after the fact.  If no one is actually using these two ioctls
in a case where both userspace and the kernel lack the implicit padding (e.g.,
x86_32 userspace with x86_32 kernel), it should be fine...

- Eric
