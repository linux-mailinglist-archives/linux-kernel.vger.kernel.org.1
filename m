Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE132D2CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgLHOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:21:17 -0500
Received: from foss.arm.com ([217.140.110.172]:49638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgLHOVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:21:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4401930E;
        Tue,  8 Dec 2020 06:20:31 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72C23F718;
        Tue,  8 Dec 2020 06:20:27 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Defer the early return in arm_(v7s/lpae)_map
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com
References: <20201207115758.9400-1-zhukeqian1@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ebf1f2cc-b6bf-90b2-8a1c-535fc242d6da@arm.com>
Date:   Tue, 8 Dec 2020 14:20:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207115758.9400-1-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 11:57, Keqian Zhu wrote:
> Although handling a mapping request with no permissions is a
> trivial no-op, defer the early return until after the size/range
> checks so that we are consistent with other mapping requests.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 8 ++++----
>   drivers/iommu/io-pgtable-arm.c     | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index a688f22cbe3b..359b96b0fa3e 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -522,14 +522,14 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	struct io_pgtable *iop = &data->iop;
>   	int ret;
>   
> -	/* If no access, then nothing to do */
> -	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> -
>   	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
>   		    paddr >= (1ULL << data->iop.cfg.oas)))
>   		return -ERANGE;
>   
> +	/* If no access, then nothing to do */
> +	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;
> +
>   	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
>   	/*
>   	 * Synchronise all PTE updates for the new mapping before there's
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..8ade72adab31 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	arm_lpae_iopte prot;
>   	long iaext = (s64)iova >> cfg->ias;
>   
> -	/* If no access, then nothing to do */
> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> -
>   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>   		return -EINVAL;
>   
> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>   	if (WARN_ON(iaext || paddr >> cfg->oas))
>   		return -ERANGE;
>   
> +	/* If no access, then nothing to do */
> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;
> +
>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
>   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
>   	/*
> 
