Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4B2BAB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKTNjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:39:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:55383 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgKTNjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:39:41 -0500
IronPort-SDR: pM3rVf0c6LKISPsBQDn09QzOaTvUIXOe1L8QO709Q6Y8SSZUc4yyeAldRi/VgnNybB/XCl4z8d
 XdyzM7GW5fcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171639314"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="171639314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 05:39:40 -0800
IronPort-SDR: zcG5jgBnh2cMRVml9SIPx982RrslX9yNsB54Wl4V064d/Q6eIpva3+ifWf9WrQEC7BZslaVb/d
 ov8mxQPySJwQ==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="360447085"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.97]) ([10.254.215.97])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 05:39:38 -0800
Cc:     baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        Will Deacon <will@kernel.org>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <160587504147.19364.17448380121292539865@build.alporthouse.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/7] Convert the intel iommu driver to the dma-iommu
 api
Message-ID: <2ff7be9f-75e8-03a2-8030-92cb734faa61@linux.intel.com>
Date:   Fri, 20 Nov 2020 21:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160587504147.19364.17448380121292539865@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2020/11/20 20:24, Chris Wilson wrote:
> Quoting Lu Baolu (2020-11-20 10:17:12)
>> Lu Baolu (3):
>>    iommu: Add quirk for Intel graphic devices in map_sg
>>    iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>>    iommu/vt-d: Cleanup after converting to dma-iommu ops
>>
>> Tom Murphy (4):
>>    iommu: Handle freelists when using deferred flushing in iommu drivers
>>    iommu: Add iommu_dma_free_cpu_cached_iovas()
>>    iommu: Allow the dma-iommu api to use bounce buffers
>>    iommu/vt-d: Convert intel iommu driver to the iommu ops
> 
> Something that may be of interest is that we encounter problems with
> using intel-iommu across a PCI remove event. All HW generations fail
> with faults like:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff fault addr 4b822000 [fault reason 02] Present bit in context entry is clear
> 
> i.e. they all report missing present bit after re-adding the device to the
> iommu group. Forcing an identity map (or disabling iommu) works fine.
> 
> I applied this series just on the off-chance it changed the symptoms; it
> does not. If you have any ideas on how to chase down this fault, that
> would be very useful. We have a few other DMAR faults visible on many
> platforms, all "[fault reason 07] Next page table ptr is invalid" that
> are again not affected by this series, that we also need to resolve.

This series only replaces the previous vt-d self-made dma api's with the
generic one (which has already been used by some other vendor iommu
drivers). It shouldn't solve the problem you're having.

How about reporting them in https://bugzilla.kernel.org/? I have
interests to help to figure out possible fixes.

> -Chris
> 

Best regards,
baolu
