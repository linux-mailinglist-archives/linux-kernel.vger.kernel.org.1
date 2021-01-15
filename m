Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431FB2F8298
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbhAORct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAORcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:32:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CAC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:32:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so8114241wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqv7QfAT5DV1oDIfe2USMaVgNotzEPUcDQhlXDEIEFM=;
        b=tA0U7STuqJQUC6bVDAU+1tXQBPtKRxaDrnrV3RiBkr1xjjQvghZpIegxyTvyC+ZHo2
         D+aTy3/XYFVj9yALy8tD/4DBZO3733PxQGULqpcEfDdldLum+Yr3SqUpqdkQMG7C4hp+
         T1aBMK3dTnsyvWALdO2zK9LNISK3VBs5+KSCpi5+a50mKLKe5E2MbVzOXt6Y7JbKHRpE
         ix5xhGzoYzO/BM28Vp1UrRcNJBIRJRXxAlZXCRBtE551CteQg0wasrQajVM5gdY9DHvH
         Vt7f6mxi7cuco9irVMI3aU0CKAili3fvSzOJQdBNCsIRQSjzVyitWvG/kmUJQf9pr3q4
         SCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqv7QfAT5DV1oDIfe2USMaVgNotzEPUcDQhlXDEIEFM=;
        b=SqYrmQnHENSnhyyaa/EBBPnPSlTS6dUPOFMBNKHfwE5TAGZGdPb5GURy50L0aeeSVd
         T/Gy/fq8MA8U1xtb+2dp26HRp2NYiWlMPfZOs0B6rdejz1qI8ceTdWKP44RuhRS4PtAB
         n/ybqQHqHsBMsiH07DYyYbDOjnYFc0n5j9I/2r73+iRkUDMKf9WEYBwDmXSupNz9tNFM
         Dg8HeYQUNrgglmD4+uC6uWqMcRsv/OdrZPtHmX+wnkt2CnMLdi3QdpoNfkSCTiGr3Mk0
         dyltQUMnV1/frIM1UcH3mRtA/fnBJ9NdZWrew2udvPZlFrQkynNJiOhkHdxa+xxHzvQk
         nNNw==
X-Gm-Message-State: AOAM531VTHzQDTdfbtxHGXLau7ZcATZRQDDHd1i44KBSJ9ToP79Pr3ce
        NWOXlF+zxUvmouDURohou7X3gg==
X-Google-Smtp-Source: ABdhPJwMBg+tI2QTs3jPXfHCQqY9HkrW2RbjXihxLuD3aDagCLJVMbSLR90NBqXSVgL1B+J6Tdv19Q==
X-Received: by 2002:a05:600c:2158:: with SMTP id v24mr9484177wml.129.1610731924845;
        Fri, 15 Jan 2021 09:32:04 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
        by smtp.gmail.com with ESMTPSA id v7sm13689605wma.26.2021.01.15.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:32:04 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:32:49 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 3/3] iommu/iova: Flush CPU rcache for when a depot
 fills
Message-ID: <YAHRwZXoRZFJkgE8@larix.localdomain>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607538189-237944-4-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 02:23:09AM +0800, John Garry wrote:
> Leizhen reported some time ago that IOVA performance may degrade over time
> [0], but unfortunately his solution to fix this problem was not given
> attention.
> 
> To summarize, the issue is that as time goes by, the CPU rcache and depot
> rcache continue to grow. As such, IOVA RB tree access time also continues
> to grow.
> 
> At a certain point, a depot may become full, and also some CPU rcaches may
> also be full when inserting another IOVA is attempted. For this scenario,
> currently the "loaded" CPU rcache is freed and a new one is created. This
> freeing means that many IOVAs in the RB tree need to be freed, which
> makes IO throughput performance fall off a cliff in some storage scenarios:
> 
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]
> 
> And continue in this fashion, without recovering. Note that in this
> example it was required to wait 16 hours for this to occur. Also note that
> IO throughput also becomes gradually becomes more unstable leading up to
> this point.
> 
> This problem is only seen for non-strict mode. For strict mode, the rcaches
> stay quite compact.

It would be good to understand why the rcache doesn't stabilize. Could be
a bug, or just need some tuning

In strict mode, if a driver does Alloc-Free-Alloc and the first alloc
misses the rcache, the second allocation hits it. The same sequence in
non-strict mode misses the cache twice, because the IOVA is added to the
flush queue on Free. 

So rather than AFAFAF.. we get AAA..FFF.., only once the fq_timer triggers
or the FQ is full. Interestingly the FQ size is 2x IOVA_MAG_SIZE, so we
could allocate 2 magazines worth of fresh IOVAs before alloc starts
hitting the cache. If a job allocates more than that, some magazines are
going to the depot, and with multi-CPU jobs those will get used on other
CPUs during the next alloc bursts, causing the progressive increase in
rcache consumption. I wonder if setting IOVA_MAG_SIZE > IOVA_FQ_SIZE helps
reuse of IOVAs?

Then again I haven't worked out the details, might be entirely wrong. I'll
have another look next week.

Thanks,
Jean

> As a solution to this issue, judge that the IOVA caches have grown too big
> when cached magazines need to be free, and just flush all the CPUs rcaches
> instead.
> 
> The depot rcaches, however, are not flushed, as they can be used to
> immediately replenish active CPUs.
> 
> In future, some IOVA compaction could be implemented to solve the
> instability issue, which I figure could be quite complex to implement.
> 
> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
> 
> Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/iova.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 732ee687e0e2..39b7488de8bb 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -841,7 +841,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				 struct iova_rcache *rcache,
>  				 unsigned long iova_pfn)
>  {
> -	struct iova_magazine *mag_to_free = NULL;
>  	struct iova_cpu_rcache *cpu_rcache;
>  	bool can_insert = false;
>  	unsigned long flags;
> @@ -863,13 +862,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  				if (cpu_rcache->loaded)
>  					rcache->depot[rcache->depot_size++] =
>  							cpu_rcache->loaded;
> -			} else {
> -				mag_to_free = cpu_rcache->loaded;
> +				can_insert = true;
> +				cpu_rcache->loaded = new_mag;
>  			}
>  			spin_unlock(&rcache->lock);
> -
> -			cpu_rcache->loaded = new_mag;
> -			can_insert = true;
> +			if (!can_insert)
> +				iova_magazine_free(new_mag);
>  		}
>  	}
>  
> @@ -878,10 +876,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>  
>  	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>  
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> -	}
> +	if (!can_insert)
> +		free_all_cpu_cached_iovas(iovad);
>  
>  	return can_insert;
>  }
> -- 
> 2.26.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
