Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE84298746
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768913AbgJZHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:14:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14387 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768904AbgJZHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:14:05 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9677440000>; Mon, 26 Oct 2020 00:14:12 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 07:13:49 +0000
Date:   Mon, 26 Oct 2020 09:13:45 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <eli@mellanox.com>,
        <parav@mellanox.com>, <alex.dewar@gmx.co.uk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Fix error return in map_direct_mr()
Message-ID: <20201026071345.GB232593@mtl-vdi-166.wap.labs.mlnx>
References: <20201026070637.164321-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026070637.164321-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603696453; bh=2gdDZLRn+zzx0MBj46NVFGhrup4ApwXxpZuOgBZsaqM=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=HzQqU18LtujLylS7/uEvuHBBUPwLEjds4YkGmbSIXJix643ZD6TEdggjJe0E+KSNW
         Wx9OxHvnXqM5PFZK67knMFui1hguhHmpiEa+UDVmssu8DUHmfS09wd3abBvG6SQB9G
         bAj7/VpvzHtqru3K2/nOrfAoHGDXqAgg6nBCHAWI8Nmqbwsw5Eo58gcicqw/eS+z0U
         K3nw/cxdZSwOstMAEDqhTTYfTxWEAwDRZN29cbBoy+ddQ20OwP34yKeShOMKw6DfYD
         LTiZXQzhyBQX0r1KMYyGIn/yjZD1ESwG0AmSpnIY8RDwOuhnjnWwLK3Ts925siQzUo
         atdBRK7t4cssw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:06:37PM +0800, Jing Xiangfeng wrote:
> Fix to return the variable "err" from the error handling case instead
> of "ret".
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Acked-by: Eli Cohen <elic@nvidia.com>

> ---
>  drivers/vdpa/mlx5/core/mr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index ef1c550f8266..4b6195666c58 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -239,7 +239,6 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  	u64 paend;
>  	struct scatterlist *sg;
>  	struct device *dma = mvdev->mdev->device;
> -	int ret;
>  
>  	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
>  	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
> @@ -277,8 +276,8 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>  done:
>  	mr->log_size = log_entity_size;
>  	mr->nsg = nsg;
> -	ret = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
> -	if (!ret)
> +	err = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
> +	if (!err)
>  		goto err_map;
>  
>  	err = create_direct_mr(mvdev, mr);
> -- 
> 2.17.1
> 
