Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749D2D38F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgLICsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgLICsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607481999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2jLB9lyGcuiqtUMQzY4BlQmh+O04HP8l3MLhgdpu/U=;
        b=VMDPJdi/q+f5wmvZKn1rFvL5N6xvL1haXvygYQL+c8kWFvv6k5r1Zoy/a7uTQBGLL8kmWg
        L/xPMbRiN01Iwc563Ny41GQ+40RSXOsRzVPn5dcQwMWqI9q91tmmEnVwOee23NADnN5+ql
        xrAbFWGDk3sGmbOswRsgiqW9ZKEa/9Y=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-IHN7BUknNCuXB70aP7C6bg-1; Tue, 08 Dec 2020 21:46:37 -0500
X-MC-Unique: IHN7BUknNCuXB70aP7C6bg-1
Received: by mail-pf1-f200.google.com with SMTP id y2so133254pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 18:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2jLB9lyGcuiqtUMQzY4BlQmh+O04HP8l3MLhgdpu/U=;
        b=HKZnkdpMo8+UNdVnLm6iqCiidbLLVAb8PcGEoI8hFHkqk60IPcyc2/e+pdWCFlkF+n
         qj4rlTrj8JDD2TG8Z6evhKr+UKahk7vTf+Q75ucqjtgbpbLgSHzm5KCuiQSYFqdBMdHU
         evVXCAfjQadr4k1WvGDeEn9uVaFvzLJblorEZLdndLIhKAcB1jpxCLX2vAhGx8MLDbsu
         6NAiIr0x4lTicXDsfcCHi4cAALOMNrxM5Fq/CTfzYN9QjBCfFWkVXPaEHqjybrNPuK+K
         Hc5Zl/d346G2oGrpdDdmLLOg3+ZkTxORX1U2bRc3PUHiPMP3VBOA4MBidbNTif+Mb91O
         Z1ow==
X-Gm-Message-State: AOAM532YqHFaAW7av9Zzxfwea/hYbVfFvPkhCXy+I5JKnVtaDAgnL/bA
        lAwgFbFyX338GFEa5Q59TGnVzzsfhS/IdVfqjVt9oIu+j90XUZTWnA5ku8J/WKuOeD1sLd28AjQ
        oUIh2d8kSvBVCh7Q4oHhibYlX
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr440242plp.54.1607481996881;
        Tue, 08 Dec 2020 18:46:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/24oMdAlXou7IwSbRByn5ZOTlVf5BsBP2Dwbvu/AJDH9tHEmv0SaJrMizo++suZQtTp3JhA==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr440226plp.54.1607481996675;
        Tue, 08 Dec 2020 18:46:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j20sm199721pfd.106.2020.12.08.18.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 18:46:36 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:46:25 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
Message-ID: <20201209024625.GB33948@xiangao.remote.csb>
References: <20201209023930.15554-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209023930.15554-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:39:30AM +0800, Huang Jianan wrote:
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

Looks good to me in general, yet see my v3 reply as below:
https://lore.kernel.org/r/20201209024415.GA33948@xiangao.remote.csb/

Thanks,
Gao Xiang


>  fs/erofs/data.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..d6ea0a216b57 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
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
> +	sector_t blknr = 0;
>  
>  	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>  		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>  
>  		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> -			return 0;
> +			goto out;
>  	}
>  
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		blknr = erofs_blknr(map.m_pa);
> +
> +out:
> +	return blknr;
>  }
>  
>  /* for uncompressed (aligned) files and raw access for other files */
> -- 
> 2.25.1
> 

