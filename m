Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226FB2A0B01
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgJ3QVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:21:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:56316 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgJ3QU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:20:59 -0400
IronPort-SDR: H6qPlZr2aIW2KHaTQY1FcWJLEUFKR1337Vzv0fiZaCR0DCuns9EgKC1Lu/MWrKiLyARTXKjrbb
 bQUH8UoiPe8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="155605456"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="155605456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:18:57 -0700
IronPort-SDR: v7d++dT9BRThG0MG1InxV2OTTNixcD8NCJY7V1esU0gaTNU1hG5s3uil8latuNTB6EgBv6iowb
 /iR8hjJs+bjg==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="469569456"
Received: from rdchavez-mobl2.amr.corp.intel.com (HELO [10.212.91.180]) ([10.212.91.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:18:56 -0700
Subject: Re: [PATCH v3] soundwire: SDCA: add helper macro to access controls
To:     Takashi Iwai <tiwai@suse.de>, "Liao, Bard" <bard.liao@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "Lin, Mengdong" <mengdong.lin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "jank@cadence.com" <jank@cadence.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
References: <20201029204955.8568-1-yung-chuan.liao@linux.intel.com>
 <20201030093651.GA2080962@kroah.com>
 <DM6PR11MB40748AD8D57C73E4D79D4676FF150@DM6PR11MB4074.namprd11.prod.outlook.com>
 <s5hsg9wrlhc.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <880a22a2-49f6-fa1c-46ad-6388cbd26ee4@linux.intel.com>
Date:   Fri, 30 Oct 2020 10:52:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hsg9wrlhc.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |
>>> 		\
>>>> +						 (((fun) & 0x7) << 22) |	\
>>>> +						 (((ent) & 0x40) << 15) |	\
>>>> +						 (((ent) & 0x3f) << 7) |	\
>>>> +						 (((ctl) & 0x30) << 15) |	\
>>>> +						 (((ctl) & 0x0f) << 3) |	\
>>>> +						 (((ch) & 0x38) << 12) |	\
>>>> +						 ((ch) & 0x07))
>>>> +
>>>> +#define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
>>>> +#define SDW_SDCA_NEXT_CTL(reg)			((reg) | BIT(14))
>>>> +
>>>>   #endif /* __SDW_REGISTERS_H */
>>>
>>>
>>> No users of these macros?
>>
>> SDW_SDCA_CTL is used in sdca codec drivers which are not upstream yet.
>> SDW_SDCA_MBQ_CTL will be used in a new regmap method.
>> SDW_SDCA_NEXT_CTL can be used in sdca codec drivers, too.
> 
> Well, the point is that it's hard to review without seeing how the
> code of actual users are.

Agree, but our job is not made easy by the three-way dependency on 
regmap, SoundWire before we can submit ASoC codec drivers (developed by 
Realtek and tested by Intel).

If you prefer us to send all patches for SDCA codec support in one shot, 
that would be fine with us.
> BTW, the bit definitions can be simplified with GENMASK().
> I personally don't think GENMASK() necessarily good, but it may fit
> better in a case like this.

we use this macro in switch cases, e.g. for regmap properties to define 
read/volatile registers:

case SDW_SDCA_CTL(FUN_JACK_CODEC, RT711_SDCA_ENT_GE49, 
RT711_SDCA_CTL_SELECTED_MODE, 0):
	case SDW_SDCA_CTL(FUN_JACK_CODEC, RT711_SDCA_ENT_GE49, 
RT711_SDCA_CTL_DETECTED_MODE, 0):
	case SDW_SDCA_CTL(FUN_HID, RT711_SDCA_ENT_HID01, 
RT711_SDCA_CTL_HIDTX_CURRENT_OWNER, 0) ...
		SDW_SDCA_CTL(FUN_HID, RT711_SDCA_ENT_HID01, 
RT711_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
	case RT711_BUF_ADDR_HID1 ... RT711_BUF_ADDR_HID2:
		return true;

https://github.com/thesofproject/linux/blob/70fe32e776dafb4b03581d62a4569f65c2f13ada/sound/soc/codecs/rt711-sdca-sdw.c#L35

and unfortunately all our attempts to use FIELD_PREP, FIELD_GET, 
u32_encode, as suggested by Vinod, failed for this case due to 
compilation issues (can't use these macros outside of a function scope). 
The errors were shared with Vinod.

That's why we went back to the initial suggestion to deal with the 
shifts/masks by hand. For now we don't have a better solution that works 
in all cases were the macro is used.

Thanks
-Pierre

