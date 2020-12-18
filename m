Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6C2DE2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgLRMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:39:25 -0500
Received: from foss.arm.com ([217.140.110.172]:34940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgLRMjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:39:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AABBF1FB;
        Fri, 18 Dec 2020 04:38:38 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A12B3F66E;
        Fri, 18 Dec 2020 04:38:37 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Prepare for modularization
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, joro@8bytes.org, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
 <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <309ff39d-5fc5-83c6-d423-2d66f503c60c@arm.com>
Date:   Fri, 18 Dec 2020 12:38:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-18 08:38, Isaac J. Manjarres wrote:
> The io-pgtable-arm and io-pgtable-arm-v7s source files will
> be compiled as separate modules, along with the io-pgtable
> source. Export the symbols for the io-pgtable init function
> structures for the io-pgtable module to use.

In my current build tree, the io-pgtable glue itself is a whopping 379 
bytes of code and data - is there really any benefit to all the 
additional overhead of making that modular? Given the number of 
different users (including AMD now), I think at this point we should 
start considering this as part of the IOMMU core, and just tweak the 
interface such that formats can register their own init_fns dynamically 
instead of the static array that's always horrible.

Robin.

> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
>   drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 1d92ac9..f062c1c 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -28,6 +28,7 @@
>   #include <linux/iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/kmemleak.h>
> +#include <linux/module.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -839,6 +840,7 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
>   	.alloc	= arm_v7s_alloc_pgtable,
>   	.free	= arm_v7s_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_v7s_init_fns);
>   
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>   
> @@ -984,3 +986,5 @@ static int __init arm_v7s_do_selftests(void)
>   }
>   subsys_initcall(arm_v7s_do_selftests);
>   #endif
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58..2623d57 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -13,6 +13,7 @@
>   #include <linux/bitops.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/kernel.h>
> +#include <linux/module.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -1047,26 +1048,31 @@ struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
>   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s1_init_fns);
>   
>   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
>   	.alloc	= arm_64_lpae_alloc_pgtable_s2,
>   	.free	= arm_lpae_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s2_init_fns);
>   
>   struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
>   	.alloc	= arm_32_lpae_alloc_pgtable_s1,
>   	.free	= arm_lpae_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s1_init_fns);
>   
>   struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
>   	.alloc	= arm_32_lpae_alloc_pgtable_s2,
>   	.free	= arm_lpae_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s2_init_fns);
>   
>   struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>   	.alloc	= arm_mali_lpae_alloc_pgtable,
>   	.free	= arm_lpae_free_pgtable,
>   };
> +EXPORT_SYMBOL_GPL(io_pgtable_arm_mali_lpae_init_fns);
>   
>   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
>   
> @@ -1252,3 +1258,5 @@ static int __init arm_lpae_do_selftests(void)
>   }
>   subsys_initcall(arm_lpae_do_selftests);
>   #endif
> +
> +MODULE_LICENSE("GPL v2");
> 
