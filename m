Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59902C5288
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgKZLBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:01:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:17403 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgKZLBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:01:41 -0500
IronPort-SDR: Um3fYwmFz6BgIkd2hBKNeCv3eyQpqs0Vej8tfnD/OUS2eRo8ybHpyG/5zG2JivJC6lN0u6z4r6
 K+DSDGGe49TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172369014"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="172369014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:01:41 -0800
IronPort-SDR: Om6vgDtmXzckxRMzuk+Reuc8HaZOQeNd/UuAAr+/lzBarbHv1aFMn7wMMR+U5lfqjz5W2e1drU
 iMnYzAvzUePg==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="479317121"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.39]) ([10.254.208.39])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 03:01:39 -0800
Cc:     baolu.lu@linux.intel.com
Subject: Re: Question about domain_init (v5.3-v5.7)
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@kernel.vger.org
References: <87h7pd6v2k.fsf@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
Date:   Thu, 26 Nov 2020 19:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87h7pd6v2k.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On 2020/11/26 4:27, Jerry Snitselaar wrote:
> 
> Is there a reason we check the requested guest address width against the
> iommu's mgaw, instead of the agaw that we already know for the iommu?
> I've run into a case with a new system where the mgaw reported is 57,
> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
> the highest supported agaw is 48 and the domain_init code fails here. In

Isn't this a platform bug? If it's too late to fix it in the BIOS, you
maybe have to add a platform specific quirk to set mgaw to the highest
supported agaw?

Best regards,
baolu

> other places like prepare_domain_attach_device, the dmar domain agaw
> gets adjusted down to the iommu agaw. The agaw of the iommu gets
> determined based off what is reported for sagaw. I'm wondering if it
> can't instead do:
> 
> ---
>   drivers/iommu/intel-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6ca5c92ef2e5..a8e41ec36d9e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>   	domain_reserve_special_ranges(domain);
> 
>   	/* calculate AGAW */
> -	if (guest_width > cap_mgaw(iommu->cap))
> -	        guest_width = cap_mgaw(iommu->cap);
> +	if (guest_width > agaw_to_width(iommu->agaw))
> +	        guest_width = agaw_to_width(iommu->agaw);
>   	domain->gaw = guest_width;
>   	adjust_width = guestwidth_to_adjustwidth(guest_width);
>   	agaw = width_to_agaw(adjust_width);
> --
> 2.27.0
> 
> 
> Thoughts? With the former code the ehci device for the ilo fails when
> trying to get a private domain.
> 
> Thanks,
> Jerry
> 
