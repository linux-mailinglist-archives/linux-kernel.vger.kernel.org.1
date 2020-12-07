Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8D2D1AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLGUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLGUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:37:46 -0500
Date:   Mon, 7 Dec 2020 12:37:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607373425;
        bh=0D2ooDXaNUKeLHALauHhhHNJgFgomBWbSNKb8afQF9Y=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHWaYwIdIq/2b1iiexqNp0nTo6SXKpcxAPzqgOFZi9HcabPKpSqHTjZCOeDNVFuxu
         WEwMAsLHSPmv48f8Ev6/vV91rsLTrMAZQVwL4N3La/Vgt8vYrwI0cIkvdN9CKivntm
         1PDs+mICJYJXQzzAVJW1H4zZD9aPNP1MliCB8jcRl/fTehGnUAbiXkIoLP0ps+grn9
         z+ilu2jMfrWIxlzAiV81gXXC/0VpXQUOAhzLxGql/ccrd1Thof74vT7f0o5Ed6dBb0
         9cOWZh7j1zSvct+E7yEESm8X/WcU7pKNqBH8LOrA+SfTNi7N4ypcJ2POhdX+cYMsIg
         RLyrF745SUlGg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: support chksum
Message-ID: <X86Sb2pvD53MzO5+@gmail.com>
References: <20201126103209.67985-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126103209.67985-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 06:32:09PM +0800, Chao Yu wrote:
> +	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {

This really could use some parentheses.  People shouldn't have to look up a
C operator precedence table to understand the code.

> +		u32 provided = le32_to_cpu(dic->cbuf->chksum);
> +		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
> +
> +		if (provided != calculated) {
> +			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
> +				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
> +				printk_ratelimited(
> +					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
> +					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
> +					provided, calculated);
> +			}
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			WARN_ON_ONCE(1);

WARN, WARN_ON_ONCE, BUG, BUG_ON, etc. are only for kernel bugs, not for invalid
inputs from disk or userspace.

There is already a log message printed just above, so it seems this WARN_ON_ONCE
should just be removed.

- Eric
