Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B4F28B080
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJLIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:45:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:64772 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgJLIpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:45:18 -0400
IronPort-SDR: Z59PLv9H4LP2olv+udnMbFR2xitxw/S3uQDEyM+m1E38T04Gjq86FqR0/i3xlX3azxi0deycz5
 1SfQt+8MKjrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145573271"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="145573271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:45:17 -0700
IronPort-SDR: dRqT+ZMfCQGeam5bOf0lovKBjTKZDVf3sJIcKcMjl1w0YRl6x9nU3ddhqLbiHDWO03k4U53lr/
 YOCXdKC8ds6w==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529872823"
Received: from ereuven9-mobl1.ger.corp.intel.com (HELO [10.252.38.175]) ([10.252.38.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:45:15 -0700
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu
 api
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Intel-gfx@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
Date:   Mon, 12 Oct 2020 09:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/09/2020 01:11, Lu Baolu wrote:
> Hi Tvrtko,
> 
> On 9/28/20 5:44 PM, Tvrtko Ursulin wrote:
>>
>> On 27/09/2020 07:34, Lu Baolu wrote:
>>> Hi,
>>>
>>> The previous post of this series could be found here.
>>>
>>> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/ 
>>>
>>>
>>> This version introduce a new patch [4/7] to fix an issue reported here.
>>>
>>> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/ 
>>>
>>>
>>> There aren't any other changes.
>>>
>>> Please help to test and review.
>>>
>>> Best regards,
>>> baolu
>>>
>>> Lu Baolu (3):
>>>    iommu: Add quirk for Intel graphic devices in map_sg
>>
>> Since I do have patches to fix i915 to handle this, do we want to 
>> co-ordinate the two and avoid having to add this quirk and then later 
>> remove it? Or you want to go the staged approach?
> 
> I have no preference. It depends on which patch goes first. Let the
> maintainers help here.

FYI we have merged the required i915 patches to out tree last week or 
so. I *think* this means they will go into 5.11. So the i915 specific 
workaround patch will not be needed in Intel IOMMU.

Regards,

Tvrtko
