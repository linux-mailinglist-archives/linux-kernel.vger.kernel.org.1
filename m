Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2E2AE661
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKKCY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:24:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:55150 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgKKCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:24:59 -0500
IronPort-SDR: /BVfZ9/NUZGnBjG3Ja29OnQI4bQ3xiigfIpuHcXawdQHNZASyxl27T6TceMiT8AoSnj+Y5htHf
 FRNXvf4poW/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170191813"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170191813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 18:24:58 -0800
IronPort-SDR: 8rD9KYDd9c9o09kFAFh7gnes01OWReGVvpAsRgAj2qvld/255rxlpJb7v6lemXrgQ/N5Mjtw+n
 gQJt8W2it05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="365763534"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2020 18:24:55 -0800
Cc:     baolu.lu@linux.intel.com, ning.sun@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dwmw2@infradead.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail
 in tboot system
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f98ff370-a3a0-2dea-9cb0-6465243a5d97@linux.intel.com>
Date:   Wed, 11 Nov 2020 10:17:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenzhong,

On 11/10/20 3:19 PM, Zhenzhong Duan wrote:
> "intel_iommu=off" command line is used to disable iommu but iommu is force
> enabled in a tboot system for security reason.
> 
> However for better performance on high speed network device, a new option
> "intel_iommu=tboot_noforce" is introduced to disable the force on.
> 
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> 
> Fix the code setting force_on and move intel_iommu_tboot_noforce
> from tboot code to intel iommu code.
> 
> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

Thanks for the patch.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.
> 
>   arch/x86/kernel/tboot.c     | 3 ---
>   drivers/iommu/intel/iommu.c | 5 +++--
>   include/linux/intel-iommu.h | 1 -
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 992fb14..420be87 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -514,9 +514,6 @@ int tboot_force_iommu(void)
>   	if (!tboot_enabled())
>   		return 0;
>   
> -	if (intel_iommu_tboot_noforce)
> -		return 1;
> -
>   	if (no_iommu || swiotlb || dmar_disabled)
>   		pr_warn("Forcing Intel-IOMMU to enabled\n");
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1b1ca63..4d9b298 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -179,7 +179,7 @@ static inline unsigned long virt_to_dma_pfn(void *p)
>    * (used when kernel is launched w/ TXT)
>    */
>   static int force_on = 0;
> -int intel_iommu_tboot_noforce;
> +static int intel_iommu_tboot_noforce;
>   static int no_platform_optin;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> @@ -4885,7 +4885,8 @@ int __init intel_iommu_init(void)
>   	 * Intel IOMMU is required for a TXT/tboot launch or platform
>   	 * opt in, so enforce that.
>   	 */
> -	force_on = tboot_force_iommu() || platform_optin_force_iommu();
> +	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
> +		    platform_optin_force_iommu();
>   
>   	if (iommu_init_mempool()) {
>   		if (force_on)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index fbf5b3e..d956987 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -798,7 +798,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
> -extern int intel_iommu_tboot_noforce;
>   extern int intel_iommu_gfx_mapped;
>   #else
>   static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
> 
