Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93C2E1A36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgLWI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:56:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DCC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:56:14 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t22so10009258pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6K+sLQbds6lT1EQKsvW+QH4EoaymFe0n2zEViQ0TTtE=;
        b=cVvERGAR9ZDjsCLfMz6MESVacPIuLG8icEg0rKSPWxT7+6NFoAASq2s3H/KmoVuUl4
         9f59HEeGpHfRj9NFe22Y+kqk8O+bpnzFwnzCkvgfvLgrlr6USEUjIHm3Tc8UerarnDSX
         fp5cTKX4HJLd7AWU7MtYsQS7UU4xel2Z1eh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6K+sLQbds6lT1EQKsvW+QH4EoaymFe0n2zEViQ0TTtE=;
        b=F5ndXTbbuu7oDPlYBkRXeIxN6YKFFCokiquXk2JEWfDLFm/FznTkTElY54MKLtoVHJ
         5bU0EKosa5brtCG2wqbcR/rFLlLG34XtX10Cq4Iv1+P+0arG7+rySzpLHVsDX3QjGGmH
         m71c576APEVLBeDJnFbeeJq/REmDmqJq+wD1ob5+cXtA5JnZkmHpoUbHVn1/XVxvb8du
         tPEOTwC4iT7UKsCAUT24U6K2jQ3MLJ8npp7O9Qcbeel8drWmdG7HR9ICkrgyZGaawm9t
         PtoA58bMgO1pf7BH4gjxihBZPSiMBgYIDJ1kYk7Og2fpdR4MTwCeZd21xHMwocj3A1q5
         NIqA==
X-Gm-Message-State: AOAM530ukyojTzAz4rofBfVigTMar/l+Vq5LPbiGmtS74aQK+clNIT0R
        2Bh7Mb9/AkXNsdFMrIv6chn1cQ==
X-Google-Smtp-Source: ABdhPJzQmPns0kBAA60ayRdmhDvciIE9lgEoYhfBVgerB6EDy1NMQs0Tx7MT1YRWXh23VK7AIUSXHQ==
X-Received: by 2002:a63:4c5d:: with SMTP id m29mr24117617pgl.368.1608713774304;
        Wed, 23 Dec 2020 00:56:14 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
        by smtp.gmail.com with ESMTPSA id c10sm23942098pfj.54.2020.12.23.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:56:13 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:56:08 +0900
From:   Tomasz Figa <tfiga@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
Message-ID: <X+MGKBYKdmPNz7VL@chromium.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216103607.23050-7-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
> In current iommu_unmap, this code is:
> 
> 	iommu_iotlb_gather_init(&iotlb_gather);
> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> 	iommu_iotlb_sync(domain, &iotlb_gather);
> 
> We could gather the whole iova range in __iommu_unmap, and then do tlb
> synchronization in the iommu_iotlb_sync.
> 
> This patch implement this, Gather the range in mtk_iommu_unmap.
> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> could be regardless of granule size.
> 
> In this way, gather->start is impossible ULONG_MAX, remove the checking.
> 
> This patch aims to do tlb synchronization *once* in the iommu_unmap.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index db7d43adb06b..89cec51405cd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>  			      struct iommu_iotlb_gather *gather)
>  {
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	unsigned long long end = iova + size;
>  
> +	if (gather->start > iova)
> +		gather->start = iova;
> +	if (gather->end < end)
> +		gather->end = end;

I don't know how common the case is, but what happens if
gather->start...gather->end is a disjoint range from iova...end? E.g.

 | gather      | ..XXX... | iova |
 |             |          |      |
 gather->start |          iova   |
               gather->end       end

We would also end up invalidating the TLB for the XXX area, which could
affect the performance.

Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
to call io_pgtable_tlb_add_page() already, so it should be batching the
flushes.

>  	return dom->iop->unmap(dom->iop, iova, size, gather);
>  }
>  
> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>  	size_t length = gather->end - gather->start;
>  
> -	if (gather->start == ULONG_MAX)
> -		return;
> -
>  	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>  				       dom->data);
>  }
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
