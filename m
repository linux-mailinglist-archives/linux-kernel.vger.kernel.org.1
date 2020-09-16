Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2226CBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgIPUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:34:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:13195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgIPRMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:12:54 -0400
IronPort-SDR: NELNjm2oB/3DjuOVuB2RsN8JuY3VMR+jh9sLYCpyF36hxCKaSkPAr3JR7LBkEgbme/6KTGCVNM
 epvBW0vNRB/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="139466139"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="139466139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:12:17 -0700
IronPort-SDR: MVS8Hy5teS3hg1wO0idxtJ8DVPmkc0coiYjpFJO/ilmoKoFGp0/oIZtyk58SFaqekoLTdCuIH5
 y30DXIdCUMWg==
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="507163140"
Received: from gopikapa-mobl.amr.corp.intel.com (HELO [10.209.66.210]) ([10.209.66.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:12:16 -0700
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org,
        open list <linux-kernel@vger.kernel.org>, broonie@kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
 <20200909075555.GK77521@vkoul-mobl>
 <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
 <20200910062223.GQ77521@vkoul-mobl>
 <adf51127-2813-cdf0-e5a6-f5ec3b0d33fa@linux.intel.com>
 <20200911070649.GU77521@vkoul-mobl>
 <21606609-8aaf-c7b2-ffaf-c7d37de1fa3f@linux.intel.com>
 <20200914050825.GA2968@vkoul-mobl>
 <11feabb2-dc8b-7acc-6e4d-0903fc435b00@linux.intel.com>
 <20200916123545.GK2968@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d717f109-7ffd-11cb-f44d-f6c0b48d4985@linux.intel.com>
Date:   Wed, 16 Sep 2020 08:11:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916123545.GK2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/20 7:35 AM, Vinod Koul wrote:
> On 14-09-20, 09:44, Pierre-Louis Bossart wrote:
>>> For LSB bits, I dont think this is an issue. I expect it to work, for example:
>>> #define CONTROL_LSB_MASK  GENMASK(2, 0)
>>>           foo |= u32_encode_bits(control, CONTROL_LSB_MASK);
>>>
>>> would mask the control value and program that in specific bitfeild.
>>>
>>> But for MSB bits, I am not sure above will work so, you may need to extract
>>> the bits and then use, for example:
>>> #define CONTROL_MSB_BITS        GENMASK(5, 3)
>>> #define CONTROL_MSB_MASK        GENMASK(17, 15)
>>>
>>>           control = FIELD_GET(CONTROL_MSB_BITS, control);
>>>           foo |= u32_encode_bits(control, CONTROL_MSB_MASK);
>>>
>>>> If you have a better suggestion that the FIELD_PREP/FIELD_GET use, I am all
>>>> ears. At the end of the day, the mapping is pre-defined and we don't have
>>>> any degree of freedom. What I do want is that this macro/inline function is
>>>> shared by all codec drivers so that we don't have different interpretations
>>>> of how the address is constructed.
>>>
>>> Absolutely, this need to be defined here and used by everyone else.
>>
>> Compare:
>>
>> #define SDCA_CONTROL_MSB_BITS        GENMASK(5, 3)
>> #define SDCA_CONTROL_MSB_MASK        GENMASK(17, 15)
>> #define SDCA_CONTROL_LSB_MASK        GENMASK(2, 0)
>>
>> foo |= u32_encode_bits(control, SDCA_CONTROL_LSB_MASK);
>> control = FIELD_GET(SDCA_CONTROL_MSB_BITS, control);
>> foo |= u32_encode_bits(control, SDCA_CONTROL_MSB_MASK);
>>
>> with the original proposal:
>>
>> foo |= FIELD_GET(GENMASK(2, 0), control))	
>> foo |= FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), control))	
>>
>> it gets worse when the LSB positions don't match, you need another variable
>> and an additional mask.
>>
>> I don't see how this improves readability? I get that hard-coding magic
>> numbers is a bad thing in general, but in this case there are limited
>> benefits to the use of additional defines.
> 
> I think it would be prudent to define the masks and use them rather than
> magic values. Also it makes it future proof

I don't see your point at all. The values cannot be modified, a 
different macro would be needed for a standard change.

Anyways, I am not going to argue further, I'll use your code example as 
is and move on.
