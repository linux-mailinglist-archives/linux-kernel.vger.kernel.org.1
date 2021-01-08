Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAD2EF3F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbhAHOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:32:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:16595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbhAHOcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:32:04 -0500
IronPort-SDR: XXiIH7coA04RCMjnUm71ePC7SCM/z+h/ukjmDcEQQIX/FEc3y4AXAoB3QP99I0W76TbINLO46X
 TRK+SZtFR4Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="262374022"
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="262374022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 06:30:19 -0800
IronPort-SDR: 0WcXinTtOqmXRH+ssqMVt7oInIC49n/2sVXMAKgO6YT0i/PfHb/l28llC0ZE7rmhvrWTSgCkYK
 Jt8+INlJngwg==
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="380136511"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.91]) ([10.249.173.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 06:30:16 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
To:     Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
 <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
 <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
 <20210108140932.GA4811@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <72be0717-80ea-b0c3-9118-da8559158839@linux.intel.com>
Date:   Fri, 8 Jan 2021 22:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108140932.GA4811@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021/1/8 22:09, Will Deacon wrote:
> Hi Lu,
> 
> On Fri, Jan 08, 2021 at 07:52:47AM +0800, Lu Baolu wrote:
>> On 2021/1/6 9:09, Lu Baolu wrote:
>>> On 2021/1/6 3:03, Will Deacon wrote:
>>>> On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
>>>>> @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev
>>>>> (struct intel_svm *svm, struct intel_svm_d
>>>>>        }
>>>>>    }
>>>>> +static void intel_flush_svm_range_dev(struct intel_svm *svm,
>>>>> +                      struct intel_svm_dev *sdev,
>>>>> +                      unsigned long address,
>>>>> +                      unsigned long pages, int ih)
>>>>> +{
>>>>> +    unsigned long shift = ilog2(__roundup_pow_of_two(pages));
>>>>> +    unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
>>>>> +    unsigned long start = ALIGN_DOWN(address, align);
>>>>> +    unsigned long end = ALIGN(address + (pages <<
>>>>> VTD_PAGE_SHIFT), align);
>>>>> +
>>>>> +    while (start < end) {
>>>>> +        __flush_svm_range_dev(svm, sdev, start, align >>
>>>>> VTD_PAGE_SHIFT, ih);
>>>>> +        start += align;
>>>>> +    }
>>>>> +}
>>>>
>>>> Given that this only seems to be called from
>>>> intel_invalidate_range(), which
>>>> has to compute 'pages' only to have it pulled apart again here,
>>>> perhaps it
>>>> would be cleaner for intel_flush_svm_range() to take something like an
>>>> 'order' argument instead?
>>>>
>>>> What do you think?
>>>
>>> We need to clean up here. It's duplicate with the qi_flush_piotlb()
>>> helper. I have a patch under testing for this. I will post it for review
>>> later.
>>
>> I'm sorry, above reply is a little vague.
>>
>> I meant to say, let's take 'pages' as the argument. We are going to use
>> qi_flush_piotlb() here to avoid duplicate QI interactions. The
>> qi_flush_piotlb() helper also takes 'pages', so keep 'pages' here will
>> make things easier.
>>
>> My cleanup patch is for v5.12. Can you please take this for v5.11?
> 
> Ah sorry, I didn't realise that was your plan. Please just include this
> patch in a series of 2 when you post a fixed version of the trace event
> removal and then I'll queue them up next week, as I've already prepared
> the pull for today.

Sure and sorry for my vague reply.

> 
> Apologies,

It's okay. :-)

> 
> Will
> 

Best regards,
baolu
