Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD334275509
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIWKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:04:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:04:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3226B207;
        Wed, 23 Sep 2020 10:04:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3BB141E12E3; Wed, 23 Sep 2020 12:04:05 +0200 (CEST)
Date:   Wed, 23 Sep 2020 12:04:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jan Kara <jack@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] udf: Fix memory leak in
 udf_process_sequence()
Message-ID: <20200923100405.GD6719@quack2.suse.cz>
References: <0000000000004c1f4d05afcff2f4@google.com>
 <20200922154531.153922-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922154531.153922-1-yepeilin.cs@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 11:45:31, Peilin Ye wrote:
> udf_process_sequence() is leaking memory. Free `data.part_descs_loc`
> before returning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b78fd02fb19 ("udf: Fix handling of Partition Descriptors")
> Reported-and-tested-by: syzbot+128f4dd6e796c98b3760@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=c5ec4e6f5d818f3c4afd4d59342468eec08a38da
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Thanks for the patch but I've just yesterday written exactly the same patch
and merged it to my tree...

								Honza

> ---
>  fs/udf/super.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 1c42f544096d..b0d862ab3024 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1698,7 +1698,8 @@ static noinline int udf_process_sequence(
>  					"Pointers (max %u supported)\n",
>  					UDF_MAX_TD_NESTING);
>  				brelse(bh);
> -				return -EIO;
> +				ret = -EIO;
> +				goto out;
>  			}
>  
>  			vdp = (struct volDescPtr *)bh->b_data;
> @@ -1718,7 +1719,8 @@ static noinline int udf_process_sequence(
>  			curr = get_volume_descriptor_record(ident, bh, &data);
>  			if (IS_ERR(curr)) {
>  				brelse(bh);
> -				return PTR_ERR(curr);
> +				ret = PTR_ERR(curr);
> +				goto out;
>  			}
>  			/* Descriptor we don't care about? */
>  			if (!curr)
> @@ -1740,28 +1742,32 @@ static noinline int udf_process_sequence(
>  	 */
>  	if (!data.vds[VDS_POS_PRIMARY_VOL_DESC].block) {
>  		udf_err(sb, "Primary Volume Descriptor not found!\n");
> -		return -EAGAIN;
> +		ret = -EAGAIN;
> +		goto out;
>  	}
>  	ret = udf_load_pvoldesc(sb, data.vds[VDS_POS_PRIMARY_VOL_DESC].block);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	if (data.vds[VDS_POS_LOGICAL_VOL_DESC].block) {
>  		ret = udf_load_logicalvol(sb,
>  				data.vds[VDS_POS_LOGICAL_VOL_DESC].block,
>  				fileset);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
>  	}
>  
>  	/* Now handle prevailing Partition Descriptors */
>  	for (i = 0; i < data.num_part_descs; i++) {
>  		ret = udf_load_partdesc(sb, data.part_descs_loc[i].rec.block);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
>  	}
>  
> -	return 0;
> +	ret = 0;
> +out:
> +	kfree(data.part_descs_loc);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
