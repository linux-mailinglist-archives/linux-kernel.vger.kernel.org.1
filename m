Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E12A22E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgKBCHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:07:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:53668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbgKBCHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:07:23 -0500
IronPort-SDR: JgKmt9YfCEHCRuS/UgVgSqMp1UZSF7U56EcJu76MCbhtHl6Ntvjo98NeEjM5jNm3LfjIX6dDmU
 PMFVfDqEPiCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="168958749"
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="168958749"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 18:07:22 -0800
IronPort-SDR: O/lSjeHppVwIa8kesMLcYMknp+CrstaTpLi/t6DayECS/VYRvc9ZB0E5Bb5pyK4/f+FhUlFaKp
 SMosrengpVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="357184384"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2020 18:07:19 -0800
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
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
 <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3f5694f3-62f9-cc2b-1c2b-f9e99a4788c1@linux.intel.com>
Date:   Mon, 2 Nov 2020 10:00:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

On 10/12/20 4:44 PM, Tvrtko Ursulin wrote:
> 
> On 29/09/2020 01:11, Lu Baolu wrote:
>> Hi Tvrtko,
>>
>> On 9/28/20 5:44 PM, Tvrtko Ursulin wrote:
>>>
>>> On 27/09/2020 07:34, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> The previous post of this series could be found here.
>>>>
>>>> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/ 
>>>>
>>>>
>>>> This version introduce a new patch [4/7] to fix an issue reported here.
>>>>
>>>> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/ 
>>>>
>>>>
>>>> There aren't any other changes.
>>>>
>>>> Please help to test and review.
>>>>
>>>> Best regards,
>>>> baolu
>>>>
>>>> Lu Baolu (3):
>>>>    iommu: Add quirk for Intel graphic devices in map_sg
>>>
>>> Since I do have patches to fix i915 to handle this, do we want to 
>>> co-ordinate the two and avoid having to add this quirk and then later 
>>> remove it? Or you want to go the staged approach?
>>
>> I have no preference. It depends on which patch goes first. Let the
>> maintainers help here.
> 
> FYI we have merged the required i915 patches to out tree last week or 
> so. I *think* this means they will go into 5.11. So the i915 specific 
> workaround patch will not be needed in Intel IOMMU.

Do you mind telling me what's the status of this fix patch? I tried this
series on v5.10-rc1 with the graphic quirk patch dropped. I am still
seeing dma faults from graphic device.

Best regards,
baolu

> 
> Regards,
> 
> Tvrtko
