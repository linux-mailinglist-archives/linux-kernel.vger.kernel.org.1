Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71902F669D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhANRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:02:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbhANRCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:02:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52B50ABD6;
        Thu, 14 Jan 2021 17:02:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D79EA1E053E; Thu, 14 Jan 2021 18:02:12 +0100 (CET)
Date:   Thu, 14 Jan 2021 18:02:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <magnani@ieee.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] udf: fix hole append when File Tail exists
Message-ID: <20210114170212.GB27380@quack2.suse.cz>
References: <20210109224054.5694-1-magnani@ieee.org>
 <20210109224054.5694-2-magnani@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109224054.5694-2-magnani@ieee.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 09-01-21 16:40:53, Steve Magnani wrote:
> From: Steven J. Magnani <magnani@ieee.org>
> 
> When an ALLOCATED_NOT_RECORDED extent ("File Tail") follows the
> extents describing a file body, don't (improperly) try to make use of it
> as part of appending a hole to the file.
> 
> Fixes: fa33cdbf3ece ("udf: Fix incorrect final NOT_ALLOCATED (hole) extent length")
> Signed-off-by: Steven J. Magnani <magnani@ieee.org>

Thanks for the fix! One comment below.

> --- a/fs/udf/inode.c	2020-12-28 20:51:29.000000000 -0600
> +++ b/fs/udf/inode.c	2021-01-02 17:00:39.794157840 -0600
> @@ -520,8 +520,7 @@ static int udf_do_extend_file(struct ino
>  		prealloc_loc = last_ext->extLocation;
>  		prealloc_len = last_ext->extLength;
>  		/* Mark the extent as a hole */
> -		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
> -			(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
> +		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
>  		last_ext->extLocation.logicalBlockNum = 0;
>  		last_ext->extLocation.partitionReferenceNum = 0;
>  	}
> @@ -626,7 +625,6 @@ static void udf_do_extend_final_block(st
>  
>  static int udf_extend_file(struct inode *inode, loff_t newsize)
>  {
> -
>  	struct extent_position epos;
>  	struct kernel_lb_addr eloc;
>  	uint32_t elen;
> @@ -639,6 +637,7 @@ static int udf_extend_file(struct inode
>  	struct kernel_long_ad extent;
>  	int err = 0;
>  	int within_final_block;
> +	loff_t hole_size = 0;
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
>  		adsize = sizeof(struct short_ad);
> @@ -648,7 +647,8 @@ static int udf_extend_file(struct inode
>  		BUG();
>  
>  	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> -	within_final_block = (etype != -1);
> +	within_final_block = (etype == (EXT_RECORDED_ALLOCATED >> 30)) ||
> +			     (etype == (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30));
>  
>  	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
>  	    (epos.bh && epos.offset == sizeof(struct allocExtDesc))) {
> @@ -658,9 +658,15 @@ static int udf_extend_file(struct inode
>  		extent.extLocation.partitionReferenceNum = 0;
>  		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
>  	} else {
> +		int8_t bmap_etype = etype;
>  		epos.offset -= adsize;
>  		etype = udf_next_aext(inode, &epos, &extent.extLocation,
>  				      &extent.extLength, 0);
> +		if ((bmap_etype == -1) &&
> +		    (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30))) {
> +			/* offset is relative to prealloc extent end */
> +			hole_size = extent.extLength;

Rather than introducing 'hole_size', I think we can just update 'offset'
here?

> +		}
>  		extent.extLength |= etype << 30;
>  	}
>  
...

> @@ -729,14 +735,22 @@ static sector_t inode_getblk(struct inod
>  			cur_epos.bh = next_epos.bh;
>  		}
>  
> -		lbcount += elen;
> -
>  		prev_epos.block = cur_epos.block;
>  		cur_epos.block = next_epos.block;
>  
>  		prev_epos.offset = cur_epos.offset;
>  		cur_epos.offset = next_epos.offset;
>  
> +		/* Corner case: preallocated extent that stops short of
> +		 * desired block
> +		 */
> +		if ((etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) &&
> +		    ((lbcount + elen) <= b_off)) {
> +			etype = -1;
> +			break;
> +		}
> +
> +		lbcount += elen;

Honestly, I don't like this special case and it seems rather arbitrary.
Also any EXT_NOT_RECORDED_ALLOCATED inside the file would now break the
block lookup while previously it was gracefully handled. Also I'm not sure
why it's event needed - even if inode_getblk() returns returns -1 and the
'extent' loaded by udf_next_aext() ends up being EXT_NOT_RECORDED_ALLOCATED,
we will end up passing it to udf_do_extend_file() which recognizes it as
preallocation extent and will insert a hole extent before it? Am I missing
something?

								Honza


>  		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
>  		if (etype == -1)
>  			break;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
