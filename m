Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033902B3AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 00:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgKOXsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 18:48:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:49230 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgKOXsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:48:25 -0500
IronPort-SDR: G0IzlSGXZ/YLjGvgCL/wa3FBzOk5qPJUUqfdF9XZdkW2ADssQcgKJSmcqgRXGj9v8tm+WFk9/i
 K16BslmkaiQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="170787072"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="170787072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 15:48:24 -0800
IronPort-SDR: QFsXTK8yVJAJVshqFuARa27KZZ7lQvmrMDwIx7oqw5NiZ71abynlHnruwa681+tBsBtddcg0E6
 mVNxTG+UtNqQ==
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="358279683"
Received: from chenyudo-mobl.ccr.corp.intel.com (HELO [10.254.215.59]) ([10.254.215.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 15:48:21 -0800
Cc:     baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: include conditionally on
 CONFIG_INTEL_IOMMU_SVM
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <188313a2-ec53-28ef-2349-66594e116a2e@linux.intel.com>
Date:   Mon, 16 Nov 2020 07:47:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/16 4:59, Lukas Bulwahn wrote:
> Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
> This function uses the dedicated static variable inv_type_granu_table
> and functions to_vtd_granularity() and to_vtd_size().
> 
> These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
> make CC=clang W=1 warns with an -Wunused-function warning.
> 
> Include these parts conditionally on CONFIG_INTEL_IOMMU_SVM.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> applies cleanly on current master and next-20201113
> 
> Liu Yi L, Jakob Pan, Lu Baolu, please ack.
> 
> Joerg, please pick this minor non-urgent clean-up patch.
> 
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c6622011d493..7b32703c0b47 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5386,6 +5386,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>   	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>   }
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM
>   /*
>    * 2D array for converting and sanitizing IOMMU generic TLB granularity to
>    * VT-d granularity. Invalidation is typically included in the unmap operation
> @@ -5432,7 +5433,6 @@ static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
>   	return order_base_2(nr_pages);
>   }
>   
> -#ifdef CONFIG_INTEL_IOMMU_SVM
>   static int
>   intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   			   struct iommu_cache_invalidate_info *inv_info)
> 
