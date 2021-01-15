Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870D2F825A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbhAORaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAORaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:30:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D0C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:29:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so4846887wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uIkWoB5mOFykHVopbzOZu1sXj6MxvqQl4exdxzvaweA=;
        b=KJ+1WBAxKa6FjIqnoJZohhCZMdsCY/TmntKVKYloe6IiqVDTLJuxSmXaZrbPus9Zph
         whZnuYhg7UQcel3uliQ01ZsWL5S/kq4R2TP2q4VLwPnQDvOzzsfuifbzSrABkNRJdOPU
         tZ4PEBrrQQNF2Mw7ZRi0ij2pY7HzTGYiRCiEbKxxzZO5+2PUEEfAZNwfSCYlcOALQGMS
         LDjcYgXLUjj0QN/VF/UDZFlLoNz/GID9U4tRO8vUvn/LI4Vg2KRSZ35JWAthqMz8WoTC
         Ygebubahl005n786Ro7AnjX+sSJBwlYPUHbqCY/XmE5pXUXUj9KGvzuoil8WDtw8QCgj
         JgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uIkWoB5mOFykHVopbzOZu1sXj6MxvqQl4exdxzvaweA=;
        b=G5nTw4GBt4NAG6HjgTSpo5f9YuPZL/L0CvmOrjnLlXfMi3pXnNqSezuY+pNa7i0Hpu
         1dK6eP+9yUNXkb7wEiKoeRzShb2JnRe13qsj3xV5j19Qv/rZNS40FUjtpgTEt6XS7CJl
         1q9Hv0LdzrNxRTUqSoAp2R8uw9EWk7zW14EN4G1NFNGLiW+JSF6fWa7tS/YddkW/umiX
         P7lOuJ+a7KFJS2Cdn/9SBChjSBW5VDJGEnMBkLuFh0djom4I3ncWjE6yCPUNo6N5EW5z
         H5WvzDJn3cCpFcI/ivzvEMabsSlBPztWaWs3ROkbmfB8erBfVoHPNKDbw8owD5483ikO
         p8SQ==
X-Gm-Message-State: AOAM533Rym5L+MD+4PTr/by4fX1LysVOkcDudvNH/ImD8OW4kCWxuQ4V
        qgarbcv09xHBxuTfq+a2OMBr3A==
X-Google-Smtp-Source: ABdhPJwkoN9VVliDkw63cO3Iaadkl4who0jVULRu6HU1KSOLepUdkdF/+oXeNBOmgdAhxyAGf7U1JQ==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr14400655wrg.183.1610731772271;
        Fri, 15 Jan 2021 09:29:32 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
        by smtp.gmail.com with ESMTPSA id r20sm17992991wrg.66.2021.01.15.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:29:31 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:30:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
Message-ID: <YAHRKCkcHAEUdRNT@larix.localdomain>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607538189-237944-3-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 02:23:08AM +0800, John Garry wrote:
> A similar crash to the following could be observed if initial CPU rcache
> magazine allocations fail in init_iova_rcaches():

Any idea why that's happening?  This fix seems ok but if we're expecting
allocation failures for the loaded magazine then we could easily get it
for cpu_rcaches too, and get a similar abort at runtime.

Thanks,
Jean

> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
> 
>   free_iova_fast+0xfc/0x280
>   iommu_dma_free_iova+0x64/0x70
>   __iommu_dma_unmap+0x9c/0xf8
>   iommu_dma_unmap_sg+0xa8/0xc8
>   dma_unmap_sg_attrs+0x28/0x50
>   cq_thread_v3_hw+0x2dc/0x528
>   irq_thread_fn+0x2c/0xa0
>   irq_thread+0x130/0x1e0
>   kthread+0x154/0x158
>   ret_from_fork+0x10/0x34
> 
> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
> falls over in __iova_rcache_insert() when we attempt to cache a mag and
> cpu_rcache->loaded == NULL:
> 
> if (!iova_magazine_full(cpu_rcache->loaded)) {
> 	can_insert = true;
> ...
> 
> if (can_insert)
> 	iova_magazine_push(cpu_rcache->loaded, iova_pfn);
> 
> As above, can_insert is evaluated true, which it shouldn't be, and we try
> to insert pfns in a NULL mag, which is not safe.
> 
> To avoid this, stop using double-negatives, like !iova_magazine_full() and
> !iova_magazine_empty(), and use positive tests, like
> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
> can safely deal with cpu_rcache->{loaded, prev} = NULL.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> ---
>  drivers/iommu/iova.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index cf1aacda2fe4..732ee687e0e2 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -767,14 +767,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  	mag->size = 0;
>  }
>  
> -static bool iova_magazine_full(struct iova_magazine *mag)
> +static bool iova_magazine_has_space(struct iova_magazine *mag)
>  {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	if (!mag)
> +		return false;
> +	return mag->size < IOVA_MAG_SIZE;
>  }
>  
> -static bool iova_magazine_empty(struct iova_magazine *mag)
> +static bool iova_magazine_has_pfns(struct iova_magazine *mag)
>  {
> -	return (!mag || mag->size == 0);
> +	if (!mag)
> +		return false;
> +	return mag->size;
>  }
>  
>  static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> @@ -783,7 +787,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  	int i;
>  	unsigned long pfn;
>  
> -	BUG_ON(iova_magazine_empty(mag));
> +	BUG_ON(!iova_magazine_has_pfns(mag));
>  
>  	/* Only fall back to the rbtree if we have no suitable pfns at all */
>  	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
> @@ -799,7 +803,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  
>  static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>  {
> -	BUG_ON(iova_magazine_full(mag));
> +	BUG_ON(!iova_magazine_has_space(mag));
>  
>  	mag->pfns[mag->size++] = pfn;
>  }
> @@ -845,9 +849,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>  	spin_lock_irqsave(&cpu_rcache->lock, flags);
>  
> -	if (!iova_magazine_full(cpu_rcache->loaded)) {
> +	if (iova_magazine_has_space(cpu_rcache->loaded)) {
>  		can_insert = true;
> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
> +	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
>  		swap(cpu_rcache->prev, cpu_rcache->loaded);
>  		can_insert = true;
>  	} else {
> @@ -856,8 +860,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  		if (new_mag) {
>  			spin_lock(&rcache->lock);
>  			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> +				if (cpu_rcache->loaded)
> +					rcache->depot[rcache->depot_size++] =
> +							cpu_rcache->loaded;
>  			} else {
>  				mag_to_free = cpu_rcache->loaded;
>  			}
> @@ -908,9 +913,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>  	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>  	spin_lock_irqsave(&cpu_rcache->lock, flags);
>  
> -	if (!iova_magazine_empty(cpu_rcache->loaded)) {
> +	if (iova_magazine_has_pfns(cpu_rcache->loaded)) {
>  		has_pfn = true;
> -	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
> +	} else if (iova_magazine_has_pfns(cpu_rcache->prev)) {
>  		swap(cpu_rcache->prev, cpu_rcache->loaded);
>  		has_pfn = true;
>  	} else {
> -- 
> 2.26.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
