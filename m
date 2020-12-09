Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06542D4145
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgLILlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbgLILlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607513996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQQtBr/xncf1OOMfe6ZF4U94fqdAGaQDE6cOcjJoC+4=;
        b=OUpsrS5s9/e4BJdoda6MSOOoPV06q9d5QW1RxVKem/LWDp6jRak/WIb/cZjKvepEIqV9gc
        rGvF2LUEUVG8EXZieW7/UZY9ujYHv1WAUfcfbc5AdaOFi3kJI6hjDD38p3hEnRlTd65TTy
        3I/FajJkGdc+mqhB39J2IIAHkoC0UWA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-LDWERGrJPnadjwvjyJwcqg-1; Wed, 09 Dec 2020 06:39:54 -0500
X-MC-Unique: LDWERGrJPnadjwvjyJwcqg-1
Received: by mail-pl1-f198.google.com with SMTP id x11so639823plo.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQQtBr/xncf1OOMfe6ZF4U94fqdAGaQDE6cOcjJoC+4=;
        b=kvoNG2z8LMqtLxkElgL8wPj21n/ap+VhtuwwsqJnC9zupgcIJeVRUT8Zu/ybTKdV5B
         ecmrX9oBMWnxnH1henyk8bFcK2faDS7ehpHzu0epy9JQVH1V02iVphOLer36/Yp+XktW
         Z1BrjtBuaL/WMeZQM6+mBu3o36hcycDtWq4RczNw+MplwApaIMHAp90FkDGnQQCZzULX
         MVA4pgXMMc0B4SWfKzrb1RmJwVc6SIguzVh97/fxFzAo+vzExCtlgEeRF3cxXTSHTIYk
         dm3jPrRv3HvuJ1/ZLyH1deXdDwnFWsyueWtZQ+B0hL+a/lsqlzB3tNtswvzXH96Jenx8
         L6/w==
X-Gm-Message-State: AOAM530TG4JQ2qhVZdQDqSc1NuCmIdn57GhAnBMQNL9o2/MbSNwPc4GE
        DTbUwE+T5VcBC8YH0JaavL7dsgjNJLeM74HGSEUxTvi4h466Sq21DRlbAMqAYHD3nZ1zHLuQfxO
        aAOLH+uJtGG87dcj8JC20dP/V
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr1885226pjp.8.1607513993332;
        Wed, 09 Dec 2020 03:39:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu1ZInadIHVy+SdexMutvdjrIhjmSkYMi9geOWjK6ltOjroPKdDiaQxAFCYJyTpFkUIg4+dg==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr1885211pjp.8.1607513993162;
        Wed, 09 Dec 2020 03:39:53 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ci2sm1843192pjb.40.2020.12.09.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:39:52 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:39:41 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        zhangshiming@oppo.com, guoweichao@oppo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
Message-ID: <20201209113941.GB105731@xiangao.remote.csb>
References: <20201209023930.15554-1-huangjianan@oppo.com>
 <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Wed, Dec 09, 2020 at 06:08:41PM +0800, Chao Yu wrote:
> On 2020/12/9 10:39, Huang Jianan wrote:
> > iblock indicates the number of i_blkbits-sized blocks rather than
> > sectors.
> > 
> > In addition, considering buffer_head limits mapped size to 32-bits,
> > should avoid using generic_block_bmap.
> > 
> > Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Could you send out an updated version? I might get a point to freeze
dev branch since it needs some time on linux-next....

Thanks,
Gao Xiang

> > ---
> >   fs/erofs/data.c | 30 ++++++++++--------------------
> >   1 file changed, 10 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 347be146884c..d6ea0a216b57 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
> >   		submit_bio(bio);
> >   }
> > -static int erofs_get_block(struct inode *inode, sector_t iblock,
> > -			   struct buffer_head *bh, int create)
> > -{
> > -	struct erofs_map_blocks map = {
> > -		.m_la = iblock << 9,
> > -	};
> > -	int err;
> > -
> > -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> > -	if (err)
> > -		return err;
> > -
> > -	if (map.m_flags & EROFS_MAP_MAPPED)
> > -		bh->b_blocknr = erofs_blknr(map.m_pa);
> > -
> > -	return err;
> > -}
> > -
> >   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> >   {
> >   	struct inode *inode = mapping->host;
> > +	struct erofs_map_blocks map = {
> > +		.m_la = blknr_to_addr(block),
> > +	};
> > +	sector_t blknr = 0;
> 
> It could be removed?
> 
> >   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
> >   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> >   		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> > -			return 0;
> 
> return 0;
> 
> > +			goto out;
> >   	}
> > -	return generic_block_bmap(mapping, block, erofs_get_block);
> > +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> > +		blknr = erofs_blknr(map.m_pa);
> 
> return erofs_blknr(map.m_pa);
> 
> > +
> > +out:
> > +	return blknr;
> 
> return 0;
> 
> Anyway, LGTM.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >   }
> >   /* for uncompressed (aligned) files and raw access for other files */
> > 
> 

