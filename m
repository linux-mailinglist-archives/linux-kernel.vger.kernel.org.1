Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C072C0C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgKWNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:54:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:47964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733086AbgKWNy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:54:56 -0500
IronPort-SDR: P5u1POPLGhOGC7LP3R1NL81LikzlBTvHKqs3M2ghLBPLl1FHszmNEjjKcKeBjGqmXGg4C4WkoB
 Skqlxs+nCLrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="151027269"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="151027269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:54:54 -0800
IronPort-SDR: ujcBQ6RvfszZYenJ8xid3jLrnvKfurOLfhNZE08oJqQlaw5VQnzKnrOUCgYi+g8M8VkawmKZFb
 jB9SXcg5o/dw==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="546420754"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.240]) ([10.254.210.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:54:51 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted
 device into core
To:     Will Deacon <will@kernel.org>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
 <20201121135620.3496419-2-baolu.lu@linux.intel.com>
 <20201123120449.GB10233@willie-the-truck>
 <5f6f0d5e-0cfc-2274-b186-180f50b8b1df@linux.intel.com>
 <20201123130335.GD10233@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c75c2981-11bd-74c0-289b-c2eb198bb5ab@linux.intel.com>
Date:   Mon, 23 Nov 2020 21:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123130335.GD10233@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/11/23 21:03, Will Deacon wrote:
> Hi Baolu,
> 
> On Mon, Nov 23, 2020 at 08:55:17PM +0800, Lu Baolu wrote:
>> On 2020/11/23 20:04, Will Deacon wrote:
>>> On Sat, Nov 21, 2020 at 09:56:17PM +0800, Lu Baolu wrote:
>>>> @@ -1645,13 +1655,10 @@ struct __group_domain_type {
>>>>    static int probe_get_default_domain_type(struct device *dev, void *data)
>>>>    {
>>>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>>>>    	struct __group_domain_type *gtype = data;
>>>>    	unsigned int type = 0;
>>>> -	if (ops->def_domain_type)
>>>> -		type = ops->def_domain_type(dev);
>>>> -
>>>> +	type = iommu_get_mandatory_def_domain_type(dev);
>>>
>>> afaict, this code is only called from probe_alloc_default_domain(), which
>>> has:
>>>
>>>           /* Ask for default domain requirements of all devices in the group */
>>>           __iommu_group_for_each_dev(group, &gtype,
>>>                                      probe_get_default_domain_type);
>>>
>>>           if (!gtype.type)
>>>                   gtype.type = iommu_def_domain_type;
>>>
>>> so is there actually a need to introduce the new
>>> iommu_get_mandatory_def_domain_type() function, given that a type of 0
>>> always ends up resolving to the default domain type?
>>
>> Another consumer of this helper is in the next patch:
>>
>> +	dev_def_dom = iommu_get_mandatory_def_domain_type(dev);
>> +
>> +	/* Check if user requested domain is supported by the device or not */
>> +	if (!type) {
>> +		/*
>> +		 * If the user hasn't requested any specific type of domain and
>> +		 * if the device supports both the domains, then default to the
>> +		 * domain the device was booted with
>> +		 */
>> +		type = iommu_get_def_domain_type(dev);
>> +	} else if (dev_def_dom && type != dev_def_dom) {
>> +		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
>> +				    iommu_domain_type_str(type));
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>>
>> I also added the untrusted device check in
>> iommu_get_mandatory_def_domain_type(), so that we don't need to care
>> about this in multiple places.
> 
> I see, but isn't this also setting the default domain type in the case that
> it gets back a type of 0? I think it would be nice to avoid having both
> iommu_get_mandatory_def_domain_type() and iommu_get_def_domain_type() of we
> can, as it's really not clear which one to use when and what is meant by
> "mandatory" imo.

Yes, agreed. I will remove iommu_get_mandatory_def_domain_type() and
keep iommu_get_def_domain_type() as the only helper in the next version.

Best regards,
baolu
