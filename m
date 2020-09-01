Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EFA25863A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 05:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIADg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 23:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIADgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:36:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2634C0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:36:53 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d189so2949916oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bbR697W940r4qzYtPEkaaefcfDcXbIb27x0eRbQn1Q=;
        b=t88wyukFrGBP19mHYjYTWsz3cjpW6QpEg7Ltbz+G5xqv1PsMrwfuqtT+tsBMRaFiAe
         4gPWkDGMc/WT3t+OYUgDhDsySC1lQoBqPFXqCkKy/yNF7uKG0CBKbSLjEcYi8r99wzkD
         zJ1uKKejvBjXEpmdvoN6S1Kw1Lszf8WchWPjqE6kBvVrLaMFqaxCLB8jHPVd05sLjn5w
         Sn+IUjF1T8S8Vk2Gcxs12RcZw9Hv+7upag/QjiMCAT5OFVNyus4MjWThnyDI47KSEHer
         iinAg7zWc3pxEuBAlyWYMLY4fj4xuriYi3LKpZ+nfuCVl8br024gHoMVW+1TKqgidBXf
         4pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bbR697W940r4qzYtPEkaaefcfDcXbIb27x0eRbQn1Q=;
        b=gcK/d6cZEhJf5aSSW1/23DksdauLoEACoI9fkd+A+6A2VBTbfvHOUQgbu0wNRDp+/z
         adsM8fLo/7uWhltjCrP2Mlv4PgCga+yrhp5oLqvurGj32gZQ1M9aN2Uj7SIpeETlELkf
         FSAxpe8lqb6AY/mQ4P406LsBZP7CG44rS8/KL5f7MCjfpzFhOw9c+0tST8wlY5M7RaDi
         P1wmq5Ql26ATPykBlB68PpAvbOQn50pQPYznNEWT7P1YKIfq0pGI5FQ+uyfbTkBpn+UE
         W+dTLbaa5CGV4O3yCLqQyY108/KQd6sA/HLZNajYQGsk0UPbO3aIALnLyXwFUIJ7vo/E
         POug==
X-Gm-Message-State: AOAM531hnLfmRkM1SsrImm7v86Fsdem58Cy3TDf284on1XRjP8yDwNaf
        DVCSwSoNPuOLFtdQXsN5S7Ci3onzPPSfMg==
X-Google-Smtp-Source: ABdhPJzjeGy+/ZDGjjXngyiAJQe6e3aEgxmZgSoz2VhDdCQaWZ2XBv1SUodwsR+dKUEuJnH+tsgDPw==
X-Received: by 2002:aca:5413:: with SMTP id i19mr16131oib.105.1598931413164;
        Mon, 31 Aug 2020 20:36:53 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id w136sm2050529oif.14.2020.08.31.20.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 20:36:52 -0700 (PDT)
Date:   Mon, 31 Aug 2020 22:36:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/19] iommu/arm-smmu: Pass io-pgtable config to
 implementation specific function
Message-ID: <20200901033635.GK3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-3-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Aug 21:40 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Construct the io-pgtable config before calling the implementation specific
> init_context function and pass it so the implementation specific function
> can get a chance to change it before the io-pgtable is created.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  3 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 11 ++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  3 ++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index f4ff124a1967..a9861dcd0884 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> -static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
> +static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
> +		struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
>  					      struct cavium_smmu, smmu);
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 09c42af9f31e..37d8d49299b4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -795,11 +795,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->asid = cfg->cbndx;
>  
>  	smmu_domain->smmu = smmu;
> -	if (smmu->impl && smmu->impl->init_context) {
> -		ret = smmu->impl->init_context(smmu_domain);
> -		if (ret)
> -			goto out_unlock;
> -	}
>  
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> @@ -810,6 +805,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.iommu_dev	= smmu->dev,
>  	};
>  
> +	if (smmu->impl && smmu->impl->init_context) {
> +		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg);
> +		if (ret)
> +			goto out_clear_smmu;
> +	}
> +
>  	if (smmu_domain->non_strict)
>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index d890a4a968e8..83294516ac08 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -386,7 +386,8 @@ struct arm_smmu_impl {
>  			    u64 val);
>  	int (*cfg_probe)(struct arm_smmu_device *smmu);
>  	int (*reset)(struct arm_smmu_device *smmu);
> -	int (*init_context)(struct arm_smmu_domain *smmu_domain);
> +	int (*init_context)(struct arm_smmu_domain *smmu_domain,
> +			struct io_pgtable_cfg *cfg);
>  	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>  			 int status);
>  	int (*def_domain_type)(struct device *dev);
> -- 
> 2.26.2
> 
