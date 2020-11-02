Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF91F2A26D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgKBJUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:20:20 -0500
Received: from mail.alarsen.net ([144.76.18.233]:38082 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgKBJUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:20:20 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 04:20:20 EST
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:a031:f406:868e:d2a5])
        by joe.alarsen.net (Postfix) with ESMTPS id D61082B83941;
        Mon,  2 Nov 2020 10:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1604308335; bh=bs1n4Ly7yGFHpA6+xzWeP6gZ3iw51qfvak4ogvm185c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoVlaLbu6wtHn5jmtnpiSgZAnpWZ/t301UNwBPpHFiGm4MpdeOUmE9xC4qf8/FsG0
         9/Hu3otr45ghCc3IJpcri3bOI9lR4GmN6RFq6SWQ1KavkgNEEfdmMWcsKRaBIzdDvz
         9CDj7Pzu36MfsJNHOZf8AoR/zUrZRT2ZJZAsMmWk=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id C6B8527C0C96;
        Mon,  2 Nov 2020 10:12:15 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qnx4: do not interpret -EIO as a correct address
Date:   Mon, 02 Nov 2020 10:12:15 +0100
Message-ID: <1966437.kWHqOGhHGQ@alarsen.net>
In-Reply-To: <20201023211604.159074-1-ztong0001@gmail.com>
References: <20201023211604.159074-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2020-10-23 23:16 Tong Zhang wrote:
> qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
> not interpret -EIO as a correct address
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  fs/qnx4/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index e8da1cde87b9..d3a40c5b1a9a 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -59,6 +59,8 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
>  	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
>  
>  	phys = qnx4_block_map( inode, iblock );
> +	if (phys == -EIO)
> +		return -EIO;
>  	if ( phys ) {
>  		// logical block is before EOF
>  		map_bh(bh, inode->i_sb, phys);

The fix looks sane to me, but how about the two other callers of
qnx4_block_map(), are they not affected as well?

Cheers
Anders


