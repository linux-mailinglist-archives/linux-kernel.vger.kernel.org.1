Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0AD2C04C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgKWLlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:41:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:25882 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgKWLlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:41:04 -0500
IronPort-SDR: YTCq6leAI94X6SnVX5bxU19SMGCuE9HmxA/11O9gA5RlKrDhflyY+fJua2Wh+z2d5sfr23TaDk
 Ju0AjWwmbQwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="158789395"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="158789395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:41:02 -0800
IronPort-SDR: VM/Y/pys1hbw4jESWb6trfxWGDg15evZIVcv6B6nIWzChUGTnNsgfRJ5QhDy4cm3U5MicLBemf
 4ILc9qY8NHZQ==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="546380585"
Received: from kdinx-mobl.ccr.corp.intel.com (HELO [10.254.210.240]) ([10.254.210.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:40:59 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@infradead.org>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <20201120101719.3172693-4-baolu.lu@linux.intel.com>
 <20201123100816.GA26619@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce
 buffers
Message-ID: <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
Date:   Mon, 23 Nov 2020 19:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123100816.GA26619@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2020/11/23 18:08, Christoph Hellwig wrote:
>> +	/*
>> +	 * If both the physical buffer start address and size are
>> +	 * page aligned, we don't need to use a bounce page.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
>> +	    iova_offset(iovad, phys | org_size)) {
>> +		aligned_size = iova_align(iovad, org_size);
>> +		phys = swiotlb_tbl_map_single(dev,
>> +				phys_to_dma(dev, io_tlb_start),
>> +				phys, org_size, aligned_size, dir, attrs);
> 
> swiotlb_tbl_map_single takes one less argument in 5.10-rc now.
> 

Yes. But Will's iommu/next branch is based on 5.10-rc3. I synced with
him, we agreed to keep it 5.10-rc3 and resolve this conflict when
merging it.

Best regards,
baolu
