Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887292F6391
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbhANO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:58:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbhANO6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:58:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8496AC5B;
        Thu, 14 Jan 2021 14:57:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8150C1E0488; Thu, 14 Jan 2021 15:57:40 +0100 (CET)
Date:   Thu, 14 Jan 2021 15:57:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <magnani@ieee.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] udf: fix silent AED tagLocation corruption
Message-ID: <20210114145740.GA27380@quack2.suse.cz>
References: <20210107234116.6190-1-magnani@ieee.org>
 <20210107234116.6190-2-magnani@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107234116.6190-2-magnani@ieee.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 17:41:16, Steve Magnani wrote:
> From: Steven J. Magnani <magnani@ieee.org>
> 
> When extending a file, make sure that the pointer to the last written
> extent does not get adjusted into the header (tag) portion of an
> Allocation Extent Descriptor. Otherwise, a subsequent call to
> udf_update_exents() can clobber the AED's tagLocation field, replacing
> it with the logical block number of a file extent.
> 
> Signed-off-by: Steven J. Magnani <magnani@ieee.org>

Thanks! It took me some time to understand what's the actual problem but
eventually I've understood - I've updated the changelog and a comment to
explain a bit more and merged the patch into my tree.

								Honza

> ---
> --- a/fs/udf/inode.c	2020-12-28 20:51:29.000000000 -0600
> +++ b/fs/udf/inode.c	2021-01-01 19:20:37.163767576 -0600
> @@ -547,11 +547,14 @@ static int udf_do_extend_file(struct ino
>  
>  		udf_write_aext(inode, last_pos, &last_ext->extLocation,
>  				last_ext->extLength, 1);
> -		/*
> -		 * We've rewritten the last extent but there may be empty
> -		 * indirect extent after it - enter it.
> -		 */
> -		udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
> +
> +		if (new_block_bytes || prealloc_len) {
> +			/*
> +			 * We've rewritten the last extent but there may be empty
> +			 * indirect extent after it - enter it.
> +			 */
> +			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
> +		}
>  	}
>  
>  	/* Managed to do everything necessary? */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
