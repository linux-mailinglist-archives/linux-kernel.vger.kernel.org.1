Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4346F2D50F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgLJCh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgLJChx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607567785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kCGLXGuRmo1k3B8nyMMdd3CDg7kUrDixLDWQgjMK8Gk=;
        b=AL9kIvEfbXBJ2NYOP0vVu4sJhgfXSVu8mTkAxHNYsyg1Yc/dqPiddOGcV0ovhuT7fPG5b4
        3F82/upKODemM4mX4hRWPAoVXOHtJ+vk+KnYUU6dKqA3LPo3+zROkYSD7CmxKH4aQBxBx3
        wmjFzmXLnp0I0SQBmxxwGKz5sRGUipE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-RC5U7WOpMi-xb6fWu-Dn2A-1; Wed, 09 Dec 2020 21:36:24 -0500
X-MC-Unique: RC5U7WOpMi-xb6fWu-Dn2A-1
Received: by mail-pf1-f199.google.com with SMTP id e126so2473191pfh.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 18:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCGLXGuRmo1k3B8nyMMdd3CDg7kUrDixLDWQgjMK8Gk=;
        b=PUQqkaLEDHV8cSvZETH5qZpq2ZltVZsUv2MxZ2Sjst6kGckpHBc5SPjuCqCEzdi+IG
         /sO4siYB+fQQY1B0Xd9N/KU6LS9rRK+fLo+kKdekz3fWujpLy+YsOgZXhcHI5AivrT8G
         gjRoNwGydoeyEMdFNyW2Mq+EpgnCGKxeKBYZggMo4JNNn3X4aJm2Z/tmIR5mMd8IGABV
         iQlkYnu4icdOTTvT4WbWc9/Q1hZGyosTUYc1KHYdSGNE4qsE1N5SKi9SFg9/GpBEft6O
         OzXWof/jAfwTFZMoKL9Z802kTVwpQRpAWybW56UObDA9lgb+AJ1AEZJvt2cGpEwH+/rk
         w4/A==
X-Gm-Message-State: AOAM531Wbsje75HMAFWUygP6YLvs66B2PKKkjAO4OoUJSfwJ5HeEw7dl
        cEU0skSorWuyI1Tpk1B+w4HJUepPckFlN2N4JxXTVtvY6LRhdhJqCepw7CP2VfLDS8103X3n39R
        aB4lJwbtjRzf0alvD+jyRtHY9
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr4979744pjb.151.1607567783178;
        Wed, 09 Dec 2020 18:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsTdKo7r6boXwGgpspnOJOqeh3ErWQfa94wNzATv66ZGi8zSeoIYH5d4SSDROzjJ4qZ3Itew==
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr4979727pjb.151.1607567782923;
        Wed, 09 Dec 2020 18:36:22 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x10sm4067133pfc.157.2020.12.09.18.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:36:22 -0800 (PST)
Date:   Thu, 10 Dec 2020 10:36:12 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v5] erofs: avoid using generic_block_bmap
Message-ID: <20201210023612.GA247374@xiangao.remote.csb>
References: <20201209115740.18802-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209115740.18802-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Wed, Dec 09, 2020 at 07:57:40PM +0800, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
> 
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Also, I think Chao has sent his Reviewed-by in the previous reply ---
so unless some major modification happens, it needs to be attached with
all new versions as a common practice...

I will apply it later to for-next, thanks for your patch!

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..ea4f693bee22 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,27 +312,12 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>  		submit_bio(bio);
>  }
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
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(block),
> +	};
>  
>  	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>  		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> @@ -341,7 +326,10 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		return erofs_blknr(map.m_pa);
> +
> +	return 0;
>  }
>  
>  /* for uncompressed (aligned) files and raw access for other files */
> -- 
> 2.25.1
> 

