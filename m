Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9E2664EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgIKQsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:48:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:11836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgIKPHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:07:49 -0400
IronPort-SDR: bKHopU7epsl1YDVPUUxC7cjPNg0tZAofEr/+Ckvk0PqZKiUYVB0T8+zk2xHDAQYuod2LWItiRr
 +D3p3BclEo1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="156169574"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="156169574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 08:07:25 -0700
IronPort-SDR: 4KNDny10BFkK+iQr+jUnPuRNxmW38V+91ARLv0S5o0x27rJZE6uaJy/wazA7H7JwpmBuamyGOO
 UV+MIBei0Lcg==
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="481354710"
Received: from basudipt-mobl1.gar.corp.intel.com (HELO [10.212.223.238]) ([10.212.223.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 08:07:24 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <21606609-8aaf-c7b2-ffaf-c7d37de1fa3f@linux.intel.com>
Date:   Fri, 11 Sep 2020 09:50:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911070649.GU77521@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

>>>>>>>> + *	25		0 (Reserved)
>>>>>>>> + *	24:22		Function Number [2:0]
>>>>>>>> + *	21		Entity[6]
>>>>>>>> + *	20:19		Control Selector[5:4]
>>>>>>>> + *	18		0 (Reserved)
>>>>>>>> + *	17:15		Control Number[5:3]
>>>>>>>> + *	14		Next
>>>>>>>> + *	13		MBQ
>>>>>>>> + *	12:7		Entity[5:0]
>>>>>>>> + *	6:3		Control Selector[3:0]
>>>>>>>> + *	2:0		Control Number[2:0]

[...]

>>>>
>>>> #define SDCA_CONTROL_DEST_MASK1 GENMASK(20, 19)
>>>> #define SDCA_CONTROL_ORIG_MASK1 GENMASK(5, 4)
>>>> #define SDCA_CONTROL_DEST_MASK2 GENMASK(6, 3)
>>>> #define SDCA_CONTROL_ORIG_MASK2 GENMASK(3, 0)
> 
> I think I missed ORIG and DEST stuff, what does this mean here?

If you missed this, it means my explanations are not good enough and I 
need to make it clearer in the commit log/documentation. Point taken, 
I'll improve this for the next version.

> Relooking at the bit definition, for example 'Control Number' is defined
> in both 17:15 as well as 2:0, why is that. Is it split?
> 
> How does one program a control number into this?

A Control Number is represented on 6 bits.

See the documentation above.

	17:15		Control Selector[5:3]
	2:0		Control Selector[2:0]

The 3 MSBs for into bits 17:15 of the address, and the 3 LSBs into bits 
2:0 of the address. The second part is simpler for Control Number but 
for entities and control selectors the LSB positions don't match.

Yes it's convoluted but it was well-intended: in most cases, there is a 
limited number of entities, control selectors, channel numbers, and 
putting the LSBs together in the 16-LSB of the address helps avoid 
reprogramming paging registers: all the addresses for a given function 
typically map into the same page.

That said, I am not sure the optimization is that great in the end, 
because we end-up having to play with bits for each address. Fewer 
changes of the paging registers but tons of operations in the core.

I wasn't around when this mapping was defined, and it is what is is now. 
There's hardware built based on this formula so we have to make it work.

Does this clarify the usage?

If you have a better suggestion that the FIELD_PREP/FIELD_GET use, I am 
all ears. At the end of the day, the mapping is pre-defined and we don't 
have any degree of freedom. What I do want is that this macro/inline 
function is shared by all codec drivers so that we don't have different 
interpretations of how the address is constructed.

Thanks,
-Pierre

