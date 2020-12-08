Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7E2D1FF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgLHB0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgLHB0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:26:45 -0500
Date:   Mon, 7 Dec 2020 17:26:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607390765;
        bh=dKxMYGEJk/qsfEljvMrUx1suvymwSnTOX+Nd8kkjqAU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lU3x0KdOCyqLG0bPUqEzQKEK6FINx4Paat/QU4vCgl2l6XPe/G3mIHZEWKXCsLA4S
         Xqshe2PrpSSIwniVht2EnpD6EZClKo8wjvWa2UItV/0bZUs8JzOAK2wOCkXI203DgZ
         HOXs8HjeblvoAOT8eovsvqpwgxVtKkcWB5OQRaIyhreM2UmzHagvFmCRjKjTNSQRhG
         QCcNuRlIBUMz2rv95yJL5nXsain7p73KwTPYy5dgTfmdLSHQDexWIanSZiY81TQNRU
         JpRT12rSlNmCUuvGaLWWuzkA64nlbB+ol4hIE1pTuwmyLmYx5pWGAImV4Ji21Td/GT
         dUQg/XZ2sK8IQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: support chksum
Message-ID: <X87WK9SOoJ8cn14T@google.com>
References: <20201126103209.67985-1-yuchao0@huawei.com>
 <X86Sb2pvD53MzO5+@gmail.com>
 <e6bc842d-90a2-d4ce-56be-594bcebaea37@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6bc842d-90a2-d4ce-56be-594bcebaea37@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08, Chao Yu wrote:
> On 2020/12/8 4:37, Eric Biggers wrote:
> > On Thu, Nov 26, 2020 at 06:32:09PM +0800, Chao Yu wrote:
> > > +	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {
> > 
> > This really could use some parentheses.  People shouldn't have to look up a
> > C operator precedence table to understand the code.
> 
> Will add parentheses to avoid misread.
> 
> > 
> > > +		u32 provided = le32_to_cpu(dic->cbuf->chksum);
> > > +		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
> > > +
> > > +		if (provided != calculated) {
> > > +			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
> > > +				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
> > > +				printk_ratelimited(
> > > +					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
> > > +					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
> > > +					provided, calculated);
> > > +			}
> > > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > +			WARN_ON_ONCE(1);
> > 
> > WARN, WARN_ON_ONCE, BUG, BUG_ON, etc. are only for kernel bugs, not for invalid
> > inputs from disk or userspace.
> > 
> > There is already a log message printed just above, so it seems this WARN_ON_ONCE
> > should just be removed.
> 
> Jaegeuk wants to give WARN_ON and marking a FSCK flag without returning EFSCORRUPTED,

I think above printk_ratelimited should be enough.

> 
> Jaegeuk, thoughts?
> 
> Thanks,
> 
> > 
> > - Eric
> > .
> > 
