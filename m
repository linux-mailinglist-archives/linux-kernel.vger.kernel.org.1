Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7528C6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgJMBdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 21:33:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:14882 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgJMBdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:33:36 -0400
IronPort-SDR: uzhI/4IuOCbPpiqwJz2M8xiAmbjPusjAM9Gjz+oL5i/7AOe4TzHd3ZDcVEpqjuYJL2WDsiSW3m
 KaV8z0ydXcmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="230008612"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="230008612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:33:34 -0700
IronPort-SDR: Y6yiBB3WfuSZvQ7Y0hQ4ROweobdg0z9sw5yFkMPE7W3vzIAe7DMevaTuqdKlB0DWfjuiUiaZsZ
 /m5zaXYPGGgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="345095782"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 18:33:31 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH next] iommu: intel: make DMAR_TABLE select IOMMU_API
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20201012123105.32652-1-brgl@bgdev.pl>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0071e295-51c7-3496-df59-c5712cef93a2@linux.intel.com>
Date:   Tue, 13 Oct 2020 09:27:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012123105.32652-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/20 8:31 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
> with no supported address widths") dmar.c needs struct iommu_device to
> be defined. We need to unconditionally select IOMMU_API when DMAR_TABLE
> is selected. This fixes the following build error when IOMMU_API is not
> selected:
> 
> drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
> drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
>   1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {

Thanks!

How about making it symmetric with the registration code?

	if (intel_iommu_enabled && !iommu->drhd->ignored)

Best regards,
baolu

>                                                  ^
> 
> Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/iommu/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 5337ee1584b0..f814b7585ba8 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -1,13 +1,13 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   # Intel IOMMU support
>   config DMAR_TABLE
> +	select IOMMU_API
>   	bool
>   
>   config INTEL_IOMMU
>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
>   	depends on PCI_MSI && ACPI && (X86 || IA64)
>   	select DMA_OPS
> -	select IOMMU_API
>   	select IOMMU_IOVA
>   	select NEED_DMA_MAP_STATE
>   	select DMAR_TABLE
> 
