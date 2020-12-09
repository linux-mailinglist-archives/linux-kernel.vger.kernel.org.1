Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDA2D3F91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgLIKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:09:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8970 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgLIKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:09:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CrXmz5MJYzhnbT;
        Wed,  9 Dec 2020 18:08:19 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 18:08:42 +0800
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
To:     Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, <guoweichao@oppo.com>,
        <zhangshiming@oppo.com>
References: <20201209023930.15554-1-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
Date:   Wed, 9 Dec 2020 18:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201209023930.15554-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 10:39, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
> 
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/data.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..d6ea0a216b57 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>   		submit_bio(bio);
>   }
>   
> -static int erofs_get_block(struct inode *inode, sector_t iblock,
> -			   struct buffer_head *bh, int create)
> -{
> -	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> -	};
> -	int err;
> -
> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> -	if (err)
> -		return err;
> -
> -	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> -
> -	return err;
> -}
> -
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>   {
>   	struct inode *inode = mapping->host;
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(block),
> +	};
> +	sector_t blknr = 0;

It could be removed?

>   
>   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>   
>   		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> -			return 0;

return 0;

> +			goto out;
>   	}
>   
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		blknr = erofs_blknr(map.m_pa);

return erofs_blknr(map.m_pa);

> +
> +out:
> +	return blknr;

return 0;

Anyway, LGTM.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   }
>   
>   /* for uncompressed (aligned) files and raw access for other files */
> 
