Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF107269077
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgINPoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:44:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:49561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgINPm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:42:58 -0400
IronPort-SDR: hbB1R4quZqJ1wKfP4ISqcLcDIZoMU78AVupRDVb0lrniwspfYk7a2x7fne/9DmIJe85Guk6kp+
 TdriESj4sGyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156537031"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="156537031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 08:42:55 -0700
IronPort-SDR: PJW7bs0i3dSNhSmViT/GRcRHTeCds7hgHgmSdl79tx4Vm+dJyhAgL6TAup0YjwMj2y7H2M/cMX
 jOPyLp9mBI5Q==
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="330788739"
Received: from flaurent-mobl3.amr.corp.intel.com (HELO [10.212.243.224]) ([10.212.243.224])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 08:42:54 -0700
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
 <20200909075555.GK77521@vkoul-mobl>
 <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
 <20200910062223.GQ77521@vkoul-mobl>
 <adf51127-2813-cdf0-e5a6-f5ec3b0d33fa@linux.intel.com>
 <20200911070649.GU77521@vkoul-mobl>
 <21606609-8aaf-c7b2-ffaf-c7d37de1fa3f@linux.intel.com>
 <20200914050825.GA2968@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <11feabb2-dc8b-7acc-6e4d-0903fc435b00@linux.intel.com>
Date:   Mon, 14 Sep 2020 09:44:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914050825.GA2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> For LSB bits, I dont think this is an issue. I expect it to work, for example:
> #define CONTROL_LSB_MASK  GENMASK(2, 0)
>          foo |= u32_encode_bits(control, CONTROL_LSB_MASK);
> 
> would mask the control value and program that in specific bitfeild.
> 
> But for MSB bits, I am not sure above will work so, you may need to extract
> the bits and then use, for example:
> #define CONTROL_MSB_BITS        GENMASK(5, 3)
> #define CONTROL_MSB_MASK        GENMASK(17, 15)
> 
>          control = FIELD_GET(CONTROL_MSB_BITS, control);
>          foo |= u32_encode_bits(control, CONTROL_MSB_MASK);
> 
>> If you have a better suggestion that the FIELD_PREP/FIELD_GET use, I am all
>> ears. At the end of the day, the mapping is pre-defined and we don't have
>> any degree of freedom. What I do want is that this macro/inline function is
>> shared by all codec drivers so that we don't have different interpretations
>> of how the address is constructed.
> 
> Absolutely, this need to be defined here and used by everyone else.

Compare:

#define SDCA_CONTROL_MSB_BITS        GENMASK(5, 3)
#define SDCA_CONTROL_MSB_MASK        GENMASK(17, 15)
#define SDCA_CONTROL_LSB_MASK        GENMASK(2, 0)

foo |= u32_encode_bits(control, SDCA_CONTROL_LSB_MASK);
control = FIELD_GET(SDCA_CONTROL_MSB_BITS, control);
foo |= u32_encode_bits(control, SDCA_CONTROL_MSB_MASK);

with the original proposal:

foo |= FIELD_GET(GENMASK(2, 0), control))	
foo |= FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), control))	

it gets worse when the LSB positions don't match, you need another 
variable and an additional mask.

I don't see how this improves readability? I get that hard-coding magic 
numbers is a bad thing in general, but in this case there are limited 
benefits to the use of additional defines.
