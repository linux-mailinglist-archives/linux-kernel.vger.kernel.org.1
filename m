Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240702F6740
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbhANRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:16:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbhANRQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:16:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78C12AFFA;
        Thu, 14 Jan 2021 17:15:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C31601E053E; Thu, 14 Jan 2021 18:15:17 +0100 (CET)
Date:   Thu, 14 Jan 2021 18:15:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     jack@suse.cz, magnani@ieee.org, linux-kernel@vger.kernel.org,
        282827961@qq.com
Subject: Re: [PATCH] udf: fix the problem that the disc content is not
 displayed
Message-ID: <20210114171517.GC27380@quack2.suse.cz>
References: <20210114132615.16522-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114132615.16522-1-changlianzhi@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-01-21 21:26:15, lianzhi chang wrote:
> When the capacity of the disc is too large (assuming the 4.7G
> specification), the disc (UDF file system) will be burned
> multiple times in the windows (Multisession Usage). When the
> remaining capacity of the CD is less than 300M (estimated
> value, for reference only), open the CD in the Linux system,
> the content of the CD is displayed as blank (the kernel will
> say "No VRS found"). Windows can display the contents of the
> CD normally.
> Through analysis, in the "fs/udf/super.c": udf_check_vsd
> function, the actual value of VSD_MAX_SECTOR_OFFSET may
> be much larger than 0x800000. According to the current code
> logic, it is found that the type of sbi->s_session is "__s32",
>  when the remaining capacity of the disc is less than 300M
> (take a set of test values: sector=3154903040,
> sbi->s_session=1540464, sb->s_blocksize_bits=11 ), the
> calculation result of "sbi->s_session << sb->s_blocksize_bits"
>  will overflow. Therefore, it is necessary to convert the
> type of s_session to "loff_t" (when udf_check_vsd starts,
> assign a value to _sector, which is also converted in this
> way), so that the result will not overflow, and then the
> content of the disc can be displayed normally.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>

There was no need to resend the patch (I've fixed up the problem locally -
it was easy enough) but thanks anyway :).

								Honza

> ---
>  fs/udf/super.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 5bef3a68395d..f2ff98f393fb 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -705,6 +705,7 @@ static int udf_check_vsd(struct super_block *sb)
>  	struct buffer_head *bh = NULL;
>  	int nsr = 0;
>  	struct udf_sb_info *sbi;
> +	loff_t sector_offset;
>  
>  	sbi = UDF_SB(sb);
>  	if (sb->s_blocksize < sizeof(struct volStructDesc))
> @@ -712,7 +713,8 @@ static int udf_check_vsd(struct super_block *sb)
>  	else
>  		sectorsize = sb->s_blocksize;
>  
> -	sector += (((loff_t)sbi->s_session) << sb->s_blocksize_bits);
> +	sector_offset = (loff_t)sbi->s_session << sb->s_blocksize_bits;
> +	sector += sector_offset;
>  
>  	udf_debug("Starting at sector %u (%lu byte sectors)\n",
>  		  (unsigned int)(sector >> sb->s_blocksize_bits),
> @@ -757,8 +759,7 @@ static int udf_check_vsd(struct super_block *sb)
>  
>  	if (nsr > 0)
>  		return 1;
> -	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
> -			VSD_FIRST_SECTOR_OFFSET)
> +	else if (!bh && sector - sector_offset == VSD_FIRST_SECTOR_OFFSET)
>  		return -1;
>  	else
>  		return 0;
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
