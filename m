Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898932F824E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbhAOR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbhAOR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:28:31 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF3C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:27:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so6408204wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNAkXsuzFF5uut41Z4Aj5p+/hR3E7tQupuXO85WbsYI=;
        b=Gzc9V3KMdOG0TLt/WQd+qg2yIxaor24Z/ET2XQ+PjxqPsc68YpjDXOtMw6MJ6L3mxC
         Uyqtc0qzTanMeUhynfnJlEDScXW6y9Wwl6sBzJFlE+heusxBbwmxwuM9wqQ5JDG2F4wq
         WQ1+1CvTHA5btS9lISrbM7df7BQbGYKYMYpKi84jYSvNvUiTd3ZqhkMMdSPwmJuJTUAK
         lxLjWrIsmXaFUGdWxUU+6Vbpm+xe1+BEMsFTSB8GebmQk156sbLT49Fyoae0a9ZEQA63
         Db30WsCColfTMi07dDeIkRE49u6gTgc2zrc5Wsu3yE2c/6Ol9X1poy/8xX9aeU0i2gXb
         iGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNAkXsuzFF5uut41Z4Aj5p+/hR3E7tQupuXO85WbsYI=;
        b=cM3x29Pbx8A/4/qcESD2dYRnNac4rhfZc6hF26zSwhwK3JgW2UnL1F2Q5WuhCPon9r
         iEQoZPOcguSX+LGgE9Je0JuWE9CDYFBNKYt7vDpwP3sA/NXa6ZyIlHZAsXOfhL3UKjAI
         GYdjG/Qbi8uGKKWmoTeRiq0y38whvPtsqu3ng/s3e1AoI8bXRXytxRLRn6YFcWm6nKNz
         MKKL9Nrv26osOyWQVd80PX0PRl2bFCeiEICbxKNyksL3wd5u16lPGf1fMKxyyjP3JV2i
         Ed3DxUnAtbLnYVqQGs/6mVClWNUXiD0++m1r6SAz30nGiSNmK3PUk7ehkQE8epSwyoUZ
         eyUQ==
X-Gm-Message-State: AOAM533fZKzihjb6q0ioEsvVeOqS1YI2vajLZnI3h8bkxrEyo2i27AMe
        YNfjdNzEysVn5gUeBzZoWwfwTwtb+6XtmQ==
X-Google-Smtp-Source: ABdhPJzEtFsQ+XAOEoNdK8tNswM+5vBs932md5l/dTGp3QPXgJciQJcUotO0dV0614UGWgr+4n6aQw==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr14060273wru.398.1610731669622;
        Fri, 15 Jan 2021 09:27:49 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
        by smtp.gmail.com with ESMTPSA id c11sm13888786wmd.36.2021.01.15.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:27:48 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:28:33 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 1/3] iommu/iova: Add free_all_cpu_cached_iovas()
Message-ID: <YAHQwT/chwlO4fYv@larix.localdomain>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607538189-237944-2-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 02:23:07AM +0800, John Garry wrote:
> Add a helper function to free the CPU rcache for all online CPUs.
> 
> There also exists a function of the same name in
> drivers/iommu/intel/iommu.c, but the parameters are different, and there
> should be no conflict.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

(unless we find a better solution for patch 3)

> ---
>  drivers/iommu/iova.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index f9c35852018d..cf1aacda2fe4 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -238,6 +238,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	return -ENOMEM;
>  }
>  
> +static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		free_cpu_cached_iovas(cpu, iovad);
> +}
> +
>  static struct kmem_cache *iova_cache;
>  static unsigned int iova_cache_users;
>  static DEFINE_MUTEX(iova_cache_mutex);
> @@ -435,15 +443,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  retry:
>  	new_iova = alloc_iova(iovad, size, limit_pfn, true);
>  	if (!new_iova) {
> -		unsigned int cpu;
> -
>  		if (!flush_rcache)
>  			return 0;
>  
>  		/* Try replenishing IOVAs by flushing rcache. */
>  		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> +		free_all_cpu_cached_iovas(iovad);
>  		free_global_cached_iovas(iovad);
>  		goto retry;
>  	}
> -- 
> 2.26.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
