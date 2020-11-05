Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF61C2A750B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgKEBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:47:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:14818 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgKEBre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:47:34 -0500
IronPort-SDR: F82zatuDj4jMtREpt6hcPkMGB3c17Icfk7PbC+gQ25/JISYVExlEW4NGPd36QbkOoh26dOiGer
 GJHL9lXn7RcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="156301772"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="156301772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 17:47:32 -0800
IronPort-SDR: /dnO9v06xkWam6UrXoGlF/a/lC9EVW6p+asIKYYtQRW2QqAda0Ae+uOC1lmXLRK8YZLMgPP4Hd
 iyZ2uyOB5zAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="426853938"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2020 17:47:30 -0800
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/vt-d: remove redundant variable no_platform_optin
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <67fd98a2-23a9-b69a-4d60-a0698e243a85@linux.intel.com>
Date:   Thu, 5 Nov 2020 09:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenzhong,

On 11/4/20 4:19 PM, Zhenzhong Duan wrote:
> no_platform_optin is redundant with dmar_disabled and it's only used in
> platform_optin_force_iommu(), remove it and use dmar_disabled instead.

It's actually not.

If CONFIG_INTEL_IOMMU_DEFAULT_ON is not set, we will get "dmar_disable =
1" and "no_platform_optin = 0". In this case, we must force the iommu on
and set dmar_disable = 0.

The real use case: if a kernel built with [CONFIG_INTEL_IOMMU_DEFAULT_ON
= n] running on a platform with thunderbolt ports, we must force IOMMU
on so that the system could be protected from possible malicious
peripherals.

Best regards,
baolu


> 
> Meanwhile remove all the dead code in platform_optin_force_iommu().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>   drivers/iommu/intel/iommu.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8651f6d4dfa0..a011d1ed63ef 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -180,7 +180,6 @@ static int rwbf_quirk;
>    */
>   static int force_on = 0;
>   int intel_iommu_tboot_noforce;
> -static int no_platform_optin;
>   
>   #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
>   
> @@ -440,7 +439,6 @@ static int __init intel_iommu_setup(char *str)
>   			pr_info("IOMMU enabled\n");
>   		} else if (!strncmp(str, "off", 3)) {
>   			dmar_disabled = 1;
> -			no_platform_optin = 1;
>   			pr_info("IOMMU disabled\n");
>   		} else if (!strncmp(str, "igfx_off", 8)) {
>   			dmar_map_gfx = 0;
> @@ -4810,20 +4808,12 @@ static inline bool has_external_pci(void)
>   
>   static int __init platform_optin_force_iommu(void)
>   {
> -	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
> +	if (!dmar_platform_optin() || dmar_disabled || !has_external_pci())
>   		return 0;
>   
> -	if (no_iommu || dmar_disabled)
> +	if (no_iommu)
>   		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
>   
> -	/*
> -	 * If Intel-IOMMU is disabled by default, we will apply identity
> -	 * map for all devices except those marked as being untrusted.
> -	 */
> -	if (dmar_disabled)
> -		iommu_set_default_passthrough(false);
> -
> -	dmar_disabled = 0;
>   	no_iommu = 0;
>   
>   	return 1;
> 
