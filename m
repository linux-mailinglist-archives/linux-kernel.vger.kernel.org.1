Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA92E0A90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLVNXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgLVNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608643301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdryUCYmuCIWhvhpUE/OQc73WJE93eW750eMifhQAGI=;
        b=fLX8WXSKSUF+6yThxZo6XNd0gd/EEu4ofPKBCl6ZKdYZHsSHvFF8MDGvXufIOzXZ9wfY9C
        z9ghGMYAAelkw1GC+y2N9o4vThxQID/YoOkOYFPGxVPIHt8FaLvhovUlQOeXIqPtiwhD4e
        +otMGHAIvKZKjtnpReOetPU9ANbvEj4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-F_sBvIFgPimULQhn5NLPXw-1; Tue, 22 Dec 2020 08:21:40 -0500
X-MC-Unique: F_sBvIFgPimULQhn5NLPXw-1
Received: by mail-pj1-f71.google.com with SMTP id mz17so1296457pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdryUCYmuCIWhvhpUE/OQc73WJE93eW750eMifhQAGI=;
        b=OPfkSJU2cKoFeF9NjcnsVJ9Uh63SXdWTj8EKYUaP3cbtRBMCow3erZxhmGsd/O4LoH
         51d5Ib7yYQzqPCbtQxcCHsIPyWxRPl5zN5jR5+TekJTfCoPNe0r0qe60hv/faKGkEj6F
         ujmgXLuSvUf6qobHBVX/waC6FV5QXfquvQ3tMkD+b6DfoDmH6FvklPIqN9UtRniD1dez
         lTDSxvk+pogYJIQ6zrSof6Epo9SSjZ55db2JXy+Gi7Rva42mpW3PEx/n4U8cAdUkSkgP
         uN8uQgRxI0Kt9QRvBqP1RJvlSPcBcpQLv9XIKyKssu1LM8NQ36hHKZtwfcxwlQzzbJ4h
         bppA==
X-Gm-Message-State: AOAM530bN+LwJwnB9WUWBNL/VdOt4qQgis8qJwsUd8V4rtQNktBWN7qL
        tWnqkzYuaK3MiJVWGGigfuRty61c4JA7YbtiszetXdOvLs60zHyfYywpU4eeEnJ4PoNyvsaF1lG
        IRPiiwCtNMcOQY/flyTQzHcmW
X-Received: by 2002:a17:902:8b87:b029:dc:3c87:722a with SMTP id ay7-20020a1709028b87b02900dc3c87722amr10101587plb.47.1608643298905;
        Tue, 22 Dec 2020 05:21:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzebaf0lcytn3IB/zKjocApFENCKd/pu5322hbOoUiUsohHm9WVacAEUzy1ZQAd+D6z+mSc4g==
X-Received: by 2002:a17:902:8b87:b029:dc:3c87:722a with SMTP id ay7-20020a1709028b87b02900dc3c87722amr10101556plb.47.1608643298579;
        Tue, 22 Dec 2020 05:21:38 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s10sm20579305pgg.76.2020.12.22.05.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 05:21:38 -0800 (PST)
Date:   Tue, 22 Dec 2020 21:21:27 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222132127.GC1831635@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201214140428.44944-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Mon, Dec 14, 2020 at 10:04:27PM +0800, Huang Jianan wrote:
> direct IO is useful in certain scenarios for uncompressed files.
> For example, it can avoid double pagecache when use the uncompressed
> file to mount upper layer filesystem.
> 
> In addition, another patch adds direct IO test for the stress tool
> which was mentioned here:
> https://lore.kernel.org/linux-erofs/20200206135631.1491-1-hsiangkao@aol.com/
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/data.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..3067aa3defff 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -6,6 +6,8 @@
>   */
>  #include "internal.h"
>  #include <linux/prefetch.h>
> +#include <linux/uio.h>
> +#include <linux/blkdev.h>
>  
>  #include <trace/events/erofs.h>
>  
> @@ -312,6 +314,60 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>  		submit_bio(bio);
>  }
>  
> +static int erofs_get_block(struct inode *inode, sector_t iblock,
> +			   struct buffer_head *bh, int create)
> +{
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(iblock),
> +	};
> +	int err;
> +
> +	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (err)
> +		return err;
> +
> +	if (map.m_flags & EROFS_MAP_MAPPED)
> +		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
> +
> +	return err;
> +}
> +
> +static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
> +			   loff_t offset)
> +{
> +	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);

It would be better to fold in check_direct_IO, also the READ_ONCE above
is somewhat weird...

No rush here, since 5.11-rc1 haven't be out yet, we have >= 2 months to
work it out.

Thanks,
Gao Xiang

> +	unsigned blkbits = i_blkbits;
> +	unsigned blocksize_mask = (1 << blkbits) - 1;
> +	unsigned long align = offset | iov_iter_alignment(iter);
> +	struct block_device *bdev = inode->i_sb->s_bdev;
> +
> +	if (align & blocksize_mask) {
> +		if (bdev)
> +			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +		blocksize_mask = (1 << blkbits) - 1;
> +		if (align & blocksize_mask)
> +			return -EINVAL;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t erofs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
> +	struct inode *inode = mapping->host;
> +	loff_t offset = iocb->ki_pos;
> +	int err;
> +
> +	err = check_direct_IO(inode, iter, offset);
> +	if (err)
> +		return err < 0 ? err : 0;
> +
> +	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
> +				    erofs_get_block, NULL, NULL,
> +				    DIO_LOCKING | DIO_SKIP_HOLES);
> +}
> +
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
> @@ -336,6 +392,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  const struct address_space_operations erofs_raw_access_aops = {
>  	.readpage = erofs_raw_access_readpage,
>  	.readahead = erofs_raw_access_readahead,
> +	.direct_IO = erofs_direct_IO,
>  	.bmap = erofs_bmap,
>  };
>  
> -- 
> 2.25.1
> 

