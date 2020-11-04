Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F902A5CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgKDC3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbgKDC3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:29:10 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D861C216C4;
        Wed,  4 Nov 2020 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604456950;
        bh=2ZfJqIORjLB7q6zIRwiMeO00SRx9XOpoB4zxqcAStZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUbc06gcfBLn8oELert5Splrgauetjeyxyh9ubPz1PBQ2Bjm7XHR0I2uod6IRs2XE
         i/dA/HaJqxwKJ+pcRpLYr+7KSW6WopibJ5K3yrQBVW2cAjWnHU2QL2hx/+b6brHtMv
         YHVYFNlOTWVA7DSDUjnGQ7mltm/2DrNMsC/paekY=
Date:   Tue, 3 Nov 2020 18:29:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201104022908.GA832@sol.localdomain>
References: <20201104021906.108534-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104021906.108534-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:19:06AM +0800, Chao Yu wrote:
> Eric reported a ioctl bug in below link:
> 
> https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/
> 
> That said, on some 32-bit architectures, u64 has only 32-bit alignment,
> notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
> in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
> compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
> due to mismatched value of ioctl command in betweeen binary and f2fs
> module, similarly, F2FS_IOC_MOVE_RANGE will fail too.
> 
> In this patch we introduce two ioctls for compatibility of above special
> 32-bit binary:
> - F2FS_IOC32_GARBAGE_COLLECT_RANGE
> - F2FS_IOC32_MOVE_RANGE
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> 
> Jaegeuk, Eric,
> 
> I have no 32-bit machine now, so I don't run any test on this patch,
> please take a look at this RFC patch first.

You can test this by running a 32-bit binary on a machine with a 64-bit kernel.
E.g. on x86_64, compile a binary with 'gcc -m32'.

>  #ifdef CONFIG_COMPAT
> +static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
> +{
> +	struct compat_f2fs_gc_range __user *urange;
> +	struct f2fs_gc_range range;
> +	int err;
> +
> +	urange = compat_ptr(arg);
> +	err = get_user(range.sync, &urange->sync);
> +	err |= get_user(range.start, &urange->start);
> +	err |= get_user(range.len, &urange->len);
> +	if (err)
> +		return -EFAULT;
> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
> +		return -EIO;
> +	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(file))))
> +		return -ENOSPC;
> +	return f2fs_ioc_gc_range(file, (unsigned long)&range);
> +}

This won't work because f2fs_ioc_gc_range() expects a user pointer.  You'll need
to make the native and compat versions do the copy from user separately, and
have them call a helper function that takes a pointer to the argument in kernel
memory.

- Eric
