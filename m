Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63827B8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgI2ARu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:17:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgI2ARu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:17:50 -0400
IronPort-SDR: RbVH6Bc6DLDNbfZBUS24tpwE26LDNf7cIcCHNMF54hRrq3ZtsuhX8gXl1WYElpX1Tuny/jVVQc
 uKx+Xs/VeuUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="180241687"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="180241687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 17:17:49 -0700
IronPort-SDR: vBRBwymd2PTiWX2JYPy/kVamnLH16EZO03swENsMtJAUXMzMi//4+COfuiuFAY5Az4SbuQygQB
 dsW9T/Fk2OZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="415182150"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2020 17:17:47 -0700
Cc:     baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
Date:   Tue, 29 Sep 2020 08:11:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

On 9/28/20 5:44 PM, Tvrtko Ursulin wrote:
> 
> On 27/09/2020 07:34, Lu Baolu wrote:
>> Hi,
>>
>> The previous post of this series could be found here.
>>
>> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/ 
>>
>>
>> This version introduce a new patch [4/7] to fix an issue reported here.
>>
>> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/ 
>>
>>
>> There aren't any other changes.
>>
>> Please help to test and review.
>>
>> Best regards,
>> baolu
>>
>> Lu Baolu (3):
>>    iommu: Add quirk for Intel graphic devices in map_sg
> 
> Since I do have patches to fix i915 to handle this, do we want to 
> co-ordinate the two and avoid having to add this quirk and then later 
> remove it? Or you want to go the staged approach?

I have no preference. It depends on which patch goes first. Let the
maintainers help here.

Best regards,
baolu

> 
> Regards,
> 
> Tvrtko
> 
>>    iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>>    iommu/vt-d: Cleanup after converting to dma-iommu ops
>>
>> Tom Murphy (4):
>>    iommu: Handle freelists when using deferred flushing in iommu drivers
>>    iommu: Add iommu_dma_free_cpu_cached_iovas()
>>    iommu: Allow the dma-iommu api to use bounce buffers
>>    iommu/vt-d: Convert intel iommu driver to the iommu ops
>>
>>   .../admin-guide/kernel-parameters.txt         |   5 -
>>   drivers/iommu/dma-iommu.c                     | 228 ++++-
>>   drivers/iommu/intel/Kconfig                   |   1 +
>>   drivers/iommu/intel/iommu.c                   | 901 +++---------------
>>   include/linux/dma-iommu.h                     |   8 +
>>   include/linux/iommu.h                         |   1 +
>>   6 files changed, 336 insertions(+), 808 deletions(-)
>>
