Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391329D691
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgJ1WQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgJ1WQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:16:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 184so789633lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxrzQX3BzJOYNo3ryQvKP9GXKFL7YZjWkWILZ8le+eE=;
        b=nOEA62LX8zuX3fjRZDQb47TSG2bsbdVQJiK3Wc2KnY+MiOncROWA/OS69XLWYuVSCN
         znHpWRURnyci9cZvWLBc09JevmMkYW8DmdW0pthtQTP53hUoABaB0U3CLdea2w9p5qYh
         05v/FxKVUKELY+HxH1pfTw8YCx9CzXoy1+5Z3II5viUnjNOdKLnt363gj34QMEGpGHj2
         39CGMwmA4scUpEVaR4fCmOyxuWhaI+nOQ1vRc6FIfbKZ/MDscKSzbdpu3LUnuAUpvEKE
         qqrYxHcavIKxtvFvs7lM9wk+/2+1gJAJ7pk56vD3JQXkWD6m5+h3S2O5l1DcfDcuA3X/
         L0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxrzQX3BzJOYNo3ryQvKP9GXKFL7YZjWkWILZ8le+eE=;
        b=ZGcNR50HDmJnHTCDqND/OqIjTrHSUA13D2/JRL11lONS+ZjiWxrT9AKlGYBrrMcFY6
         oybn7ief85agZywJqnWmu2elJ7peTbq9xptyeOQZaCvPbqDdYW2thqXaODiLtg/RxNI+
         SZYh3rDsmegqEIiBVUdAo3I1WVVBzxM48LfXBAi+54lOJy+Ysggrgehu+IuUNHvW5Dvl
         R2uoR4RBnXu4NTaiZF7XH0zSDwitUBE3YR5pg3ZHqz36pH0TYalr7E5gXpZiZbEBLEnZ
         0JZ1cd9wUSkYWXolrEcj6056DM2yqcry14hJIMgce29Tl+WvZOBlDv56MVoyO3jfGBKI
         3e6w==
X-Gm-Message-State: AOAM531dLkSSXw1vY+tAozNGZ2sMZL4hQnEn78U/5tvpLdpbnMIaRr5H
        hG/qK7OYYXR4hADfkkbb/KGkGrzZJlniIA==
X-Google-Smtp-Source: ABdhPJxmYxNUTo2Fwgp2nMPtc9QpYwPLn5MShu2QN0UiC8tH6b7M5njy4aWgP1GqIguNpetjw+gxsA==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr7275297wro.328.1603876456793;
        Wed, 28 Oct 2020 02:14:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id e5sm5709509wrw.93.2020.10.28.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 02:14:16 -0700 (PDT)
Date:   Wed, 28 Oct 2020 10:13:56 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iommu: Fix an issue in iommu_page_response()
 flags check
Message-ID: <20201028091356.GB2328726@myrica>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 09:36:57AM +0800, Yi Sun wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> original code fails when LAST_PAGE is set in flags.

LAST_PAGE is not documented to be a valid flags for page_response.
So isn't failing the right thing to do?

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c470f4..053cec3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1200,9 +1200,11 @@ int iommu_page_response(struct device *dev,
>  		return -EINVAL;
>  
>  	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
> -	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
> +		!(msg->flags & IOMMU_PAGE_RESP_PASID_VALID)) {

It should be OK not to have PASID_VALID set, we're just checking for
undefined flags here.

Thanks,
Jean

> +		dev_warn_ratelimited(dev, "%s:Invalid ver %x: flags %x\n",
> +				__func__, msg->version, msg->flags);
>  		return -EINVAL;
> -
> +	}
>  	/* Only send response if there is a fault report pending */
>  	mutex_lock(&param->fault_param->lock);
>  	if (list_empty(&param->fault_param->faults)) {
> -- 
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
