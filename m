Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C722B727A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKQXcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:32:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:51171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQXcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:32:31 -0500
IronPort-SDR: S6lC9JeWep0S01W7DjuWhMandJhDKLd4iv7+2/iXQJ7JappZ1WdNgb/CRpEB8lTYmps9M73nli
 S1g5B/DnQGLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168461202"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168461202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:32:31 -0800
IronPort-SDR: 5382oeKWx+HYT1RMhyNPodt0b+9JjqrE65FbskKgyoQWOCiOkPDwmesPlkd4bELgNbAbYweNIN
 IIUaC5ZVD7Zw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="532413741"
Received: from jli128-mobl1.ccr.corp.intel.com (HELO [10.254.209.252]) ([10.254.209.252])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:32:28 -0800
Cc:     baolu.lu@linux.intel.com, ning.sun@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dwmw2@infradead.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail
 in tboot system
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <34e8f6c6-e9f7-634b-8f68-3645261fd882@linux.intel.com>
Date:   Wed, 18 Nov 2020 07:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Will

Please consider this patch for v5.10.

Best regards,
baolu

On 2020/11/10 15:19, Zhenzhong Duan wrote:
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
