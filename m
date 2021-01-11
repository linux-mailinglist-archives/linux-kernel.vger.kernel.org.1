Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE02F20D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbhAKUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:30:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:38642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbhAKUaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:30:22 -0500
IronPort-SDR: bkZ0VmR8qNu7HP2Xk+P0Z1rXzJ3zCU6EXl1YswDvgEfRPnrnOu1jzm11Xy06Gr9qBCDOf5B4JD
 3bfdr5h///GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157110616"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157110616"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:37 -0800
IronPort-SDR: Wk15VZMYLhTSRJe+wM8eN+4NsVkhDFIAzmHLW+rsMFHB/6IN88TOVK44+axPb81kMjUhRzbz9A
 VbzTZmXIqtAg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="344995380"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85]) ([10.212.87.85])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:35 -0800
Subject: Re: [PATCH 13/14] ASoC: Intel: bytcr_wm5102: Add machine driver for
 BYT/WM5102
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-14-hdegoede@redhat.com>
 <20201229135836.GO9673@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b1a1a056-8347-5b5b-fcdd-8a37c24ecef9@linux.intel.com>
Date:   Mon, 11 Jan 2021 11:54:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229135836.GO9673@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +		return ret;
>> +	}
>> +
>> +	ret = snd_soc_component_set_sysclk(codec_component, ARIZONA_CLK_OPCLK, 0,
>> +					   rate * sr_mult, SND_SOC_CLOCK_OUT);
>> +	if (ret) {
>> +		dev_err(codec_component->dev, "Error setting OPCLK: %d\n", ret);
>> +		return ret;
>> +	}
> 
> OPCLK is a clock that can be outputted on the CODECs GPIOs. Is
> that being used to clock some external component? If so it should
> be added to the DAPM graph, if not you might as well remove this
> call.

Thanks Charles for the feedback.

I have a vague recollection that the routing was supposed to be 
something like:

AP-----V
        WM5102----> BT HFP
Modem--^

with processing on WM5102.

But when I look at the initial Android code there are references to the 
HFP path being handled by the AP.

Probably better to remove this clock configuration if the need for it is 
unclear, the goal is only to enable speaker/headset for now.

