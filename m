Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5E28D7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgJNAt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:49:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:49779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgJNAt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:49:27 -0400
IronPort-SDR: L4L/8TrwuaXO6dUroP6MGz8xzXf6Gey0XuZ+UQkqnlXJPu4Zj6SRJGiQDGkdx9AlldcObc1rfD
 FzlXkezvMvKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="163373970"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="163373970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:49:27 -0700
IronPort-SDR: EQyEvoE5xNUocrAPDSycqv7YhanaNerWshx5/SaN1Q2YFJrB6woJaia/Rredc9yE3yjpN2hp1L
 Xr4uPZ/QyaWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="345457248"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 13 Oct 2020 17:49:25 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20201013073055.11262-1-brgl@bgdev.pl>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
Date:   Wed, 14 Oct 2020 08:42:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013073055.11262-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 3:30 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
> with no supported address widths") dmar.c needs struct iommu_device to
> be selected. We can drop this dependency by not dereferencing struct
> iommu_device if IOMMU_API is not selected and by reusing the information
> stored in iommu->drhd->ignored instead.
> 
> This fixes the following build error when IOMMU_API is not selected:
> 
> drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
> drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
>   1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
>                                                  ^
> 
> Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

With commit title adjusted to "iommu/vt-d: Don't dereference
iommu_device if IOMMU_API is not built",

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 2d70d56d8e0d..404b40af31cb 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1136,7 +1136,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   static void free_iommu(struct intel_iommu *iommu)
>   {
> -	if (intel_iommu_enabled && iommu->iommu.ops) {
> +	if (intel_iommu_enabled && !iommu->drhd->ignored) {
>   		iommu_device_unregister(&iommu->iommu);
>   		iommu_device_sysfs_remove(&iommu->iommu);
>   	}
> 
