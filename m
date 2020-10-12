Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827428AC31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJLCiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:38:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:7827 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJLCiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:38:14 -0400
IronPort-SDR: jVggHOxwgpvOAZ359mDrFAsmmTJG8jQOI+XXgbPu2h3h+7yjqEPkgGnx8BeLKuasYOS3RHeXtw
 m8CL7sUDoZcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145546330"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="145546330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:38:09 -0700
IronPort-SDR: 6SS+sDvmGGVHmqq3yHY5Cj2vODTAbxVolMjhokJy+QIAbUZFsPU0NmPOvo0ldjggmQeKu8M1eg
 6rd5lq/ch96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="344679529"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2020 19:38:05 -0700
Cc:     baolu.lu@linux.intel.com, CobeChen-oc@zhaoxin.com,
        RaymondPang-oc@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 0/2] Add support for ACPI device in RMRR
To:     FelixCuioc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
References: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <06de2814-36c9-bea4-d0e1-0b6dddd1006e@linux.intel.com>
Date:   Mon, 12 Oct 2020 10:31:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On 10/10/20 4:02 PM, FelixCuioc wrote:
> BIOS allocate reserved memory ranges that may be DMA targets.
> BIOS may report each such reserved memory region through the
> RMRR structures,along with the devices that requires access to
> the specified reserved memory region.
> 
> The purpose of this series is to achieve ACPI device in RMRR
> access reserved memory.Therefore,it is necessary to increase
> the analysis of acpi device in RMRR and establish a mapping
> for this device.
> 
> The first patch adds interfaces for detecting ACPI device
> in RMRR and in order to distinguish it from pci device,
> some interface functions are modified.
> 
> The second patch adds support for probing ACPI device in RMRR.
> In probe_acpi_namespace_devices(),add support for direct mapping
> of ACPI device and add support for physical node of acpi device
> to be NULL.

Thanks for your patches. As I explained in the previous reply, RMRRs
were added as work around for certain legacy device and we have been
working hard to fix those legacy devices so that RMRR are no longer
needed. Any new use case of RMRR is not encouraged.

By the way, I guess the problem you are facing can still be handled well
under current RMRR mechanism by simple putting the device in the
ACPI/ANDD table. It's worth trying.

Best regards,
baolu

> 
> v2->v3:
>     - Add the blank line between functions.
>     - Make dmar_acpi_insert_dev_scope() bool,change the 1/0 to true/false
>       and add a comment explaining.
>     - Delete unused initialization.
>     - if dmar_acpi_insert_dev_scope() always returns zero,will not
>       call dmar_rmrr_add_acpi_dev().
>     - Use a proper error code.
>     - Use if(!pdev).
>     - Use goto unlock instead of mutex_unlock().
> 
> 
> FelixCuioc (2):
>    iommu/vt-d:Add support for detecting ACPI device in RMRR
>    iommu/vt-d:Add support for probing ACPI device in RMRR
> 
>   drivers/iommu/intel/dmar.c  | 76 +++++++++++++++++++++----------------
>   drivers/iommu/intel/iommu.c | 52 ++++++++++++++++++++++++-
>   drivers/iommu/iommu.c       |  6 +++
>   include/linux/dmar.h        | 12 +++++-
>   include/linux/iommu.h       |  2 +
>   5 files changed, 113 insertions(+), 35 deletions(-)
> 
