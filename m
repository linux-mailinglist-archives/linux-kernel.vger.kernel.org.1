Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B466E27376C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgIVAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:30:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:48505 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgIVAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:30:17 -0400
IronPort-SDR: HkTvl3XFN6KQhBrv3ZiV8NtnXFUy40CSzf8613kxVjXZggl2W6kOAM9ThRuz4EFVXBIVP8liCk
 7eX5AqYuUKdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224653523"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="224653523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 17:30:15 -0700
IronPort-SDR: XxmBwCkFQnBv7el7ENXABUajPFYQWDnkiPSjfIISmi1wsuEYzT/vrKmJd8cKOU0NRqZvl3x64S
 BLc+OSd3zBGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="412481384"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2020 17:30:13 -0700
Cc:     baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
To:     Logan Gunthorpe <logang@deltatee.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
 <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
 <e95a55ea-b03f-4b3c-327a-b48d364577e9@deltatee.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c8bde158-50f6-1656-4a7d-6323573ba501@linux.intel.com>
Date:   Tue, 22 Sep 2020 08:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e95a55ea-b03f-4b3c-327a-b48d364577e9@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On 9/21/20 11:48 PM, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-20 12:36 a.m., Lu Baolu wrote:
>> Hi Logan,
>>
>> On 2020/9/19 4:47, Logan Gunthorpe wrote:
>>> Hi Lu,
>>>
>>> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>>>> Tom Murphy has almost done all the work. His latest patch series was
>>>> posted here.
>>>>
>>>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>>>
>>>> Thanks a lot!
>>>>
>>>> This series is a follow-up with below changes:
>>>>
>>>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>>>> letter.
>>>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>>>> bounce buffers" to make the bounce buffer work for untrusted devices.
>>>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>>>
>>>
>>> I'm trying to test this on an old Sandy Bridge, but found that I get
>>> spammed with warnings on boot. I've put a sample of a few of them below.
>>> They all seem to be related to ioat.
>>>
>>> I had the same issue with Tom's v2 but never saw this on his v1.
>>
>> Have you verified whether this could be reproduced with the lasted
>> upstream kernel (without this patch series)?
> 
> Yes.

I am sorry. Just want to make sure I understand you correctly. :-) When
you say "yes", do you mean you could reproduce this with pure upstream
kernel (5.9-rc6)?

> Also, it's hitting a warning in the dma-iommu code which would not
> be hit without this patch set.

Without this series, DMA APIs don't go through dma-iommu. Do you mind
posting the warning message?

Best regards,
baolu
