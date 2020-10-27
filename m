Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21C29A2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392396AbgJ0Cot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391051AbgJ0Cot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603766688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oPgZQ9kwH3Dhos275y17fQzttSlkylt7q9lLolsmfA=;
        b=CVamtyBPyV04smcjE9sjABzOPWyzzjDor/ndOdEKby699p0A1I1/TsMtx+MpHxpTSFyXOU
        2PWrWtJA6SPE5tVsDsP2puJjdpRYy55mk1n+eRiNS0ZURbjeeerZELA+2FI8UFVgRGHBE0
        CZp+FqrUA9vaMAuLvfh3vonZ1lButNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-c6rnTZ4DMlqFQsDprG0VmQ-1; Mon, 26 Oct 2020 22:44:43 -0400
X-MC-Unique: c6rnTZ4DMlqFQsDprG0VmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6935F186DD2E;
        Tue, 27 Oct 2020 02:44:42 +0000 (UTC)
Received: from [10.72.13.117] (ovpn-13-117.pek2.redhat.com [10.72.13.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D146F62A0B;
        Tue, 27 Oct 2020 02:44:25 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix error return in map_direct_mr()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mst@redhat.com,
        eli@mellanox.com, parav@mellanox.com, alex.dewar@gmx.co.uk
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201026070637.164321-1-jingxiangfeng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8e37340d-2b4f-caaf-3277-32a697b2d204@redhat.com>
Date:   Tue, 27 Oct 2020 10:44:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026070637.164321-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/26 下午3:06, Jing Xiangfeng wrote:
> Fix to return the variable "err" from the error handling case instead
> of "ret".
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>   drivers/vdpa/mlx5/core/mr.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index ef1c550f8266..4b6195666c58 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -239,7 +239,6 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>   	u64 paend;
>   	struct scatterlist *sg;
>   	struct device *dma = mvdev->mdev->device;
> -	int ret;
>   
>   	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
>   	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
> @@ -277,8 +276,8 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>   done:
>   	mr->log_size = log_entity_size;
>   	mr->nsg = nsg;
> -	ret = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
> -	if (!ret)
> +	err = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
> +	if (!err)
>   		goto err_map;
>   
>   	err = create_direct_mr(mvdev, mr);


Acked-by: Jason Wang <jasowang@redhat.com>


