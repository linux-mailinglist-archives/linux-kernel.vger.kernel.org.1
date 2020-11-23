Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7B2C050A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgKWL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:57:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:27002 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgKWL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:57:04 -0500
IronPort-SDR: hxiFsbBspTLbtAxBx5gDo8kbF26WEZi/V8Mk40QGDS2Xpq8/mAnfAbYsmicL62vRwkjFCIg2Sj
 3e5vFHswATcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="158790913"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="158790913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:56:58 -0800
IronPort-SDR: uUAhuuDLymk4X95ffRIh+ONYkxifRwV2tVicLnk/PS+AlHXVaC4CQSGCTalMfaqxhe/zyR0GFA
 ZJLcTzPAivuQ==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="546385048"
Received: from kdinx-mobl.ccr.corp.intel.com (HELO [10.254.210.240]) ([10.254.210.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:56:55 -0800
Cc:     baolu.lu@linux.intel.com, Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce
 buffers
To:     Will Deacon <will@kernel.org>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <20201120101719.3172693-4-baolu.lu@linux.intel.com>
 <20201123100816.GA26619@infradead.org>
 <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
 <20201123114705.GA10233@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fe4bed62-b056-07ef-1a1f-b68e92305e26@linux.intel.com>
Date:   Mon, 23 Nov 2020 19:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123114705.GA10233@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/11/23 19:47, Will Deacon wrote:
> On Mon, Nov 23, 2020 at 07:40:57PM +0800, Lu Baolu wrote:
>> On 2020/11/23 18:08, Christoph Hellwig wrote:
>>>> +	/*
>>>> +	 * If both the physical buffer start address and size are
>>>> +	 * page aligned, we don't need to use a bounce page.
>>>> +	 */
>>>> +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
>>>> +	    iova_offset(iovad, phys | org_size)) {
>>>> +		aligned_size = iova_align(iovad, org_size);
>>>> +		phys = swiotlb_tbl_map_single(dev,
>>>> +				phys_to_dma(dev, io_tlb_start),
>>>> +				phys, org_size, aligned_size, dir, attrs);
>>>
>>> swiotlb_tbl_map_single takes one less argument in 5.10-rc now.
>>>
>>
>> Yes. But Will's iommu/next branch is based on 5.10-rc3. I synced with
>> him, we agreed to keep it 5.10-rc3 and resolve this conflict when
>> merging it.
> 
> That's right, although I failed to appreciate the conflict was due to a
> change in function prototype rather than just a context collision. So
> I've updated the vt-d branch to contain the stuff fron Konrad:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/iommu/vt-d
> 
> Sorry for messing you around!

It's okay. I will re-base the patch series later.

Best regards,
baolu


