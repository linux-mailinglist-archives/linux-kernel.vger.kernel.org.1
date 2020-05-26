Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC88F1C5CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgEEP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:57:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:43147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbgEEP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:57:40 -0400
IronPort-SDR: pxVk6H4+g/DPi1API8PUDhb+n0YDmQ1z6s1oIYu59+ndSxn62jOGYeXbey4C6o1YxWdWdosD0h
 cgPVDsnT2wpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:57:39 -0700
IronPort-SDR: alrkhE+2C4qXPTodsAh59qKNIdgUTi4My5rtciJamlWkLe/Gs6yVOlSzDYbd6Bd6u+HzoFRuZW
 MicWtTkTw92Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="249494130"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.151.151]) ([10.249.151.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2020 08:57:33 -0700
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lech Betlej <Lech.Betlej@intel.com>,
        alsa-devel@alsa-project.org, Todd Broch <tbroch@google.com>,
        Harshapriya <harshapriya.n@intel.com>,
        John Hsu <KCHSU0@nuvoton.com>, linux-kernel@vger.kernel.org,
        "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Marcin Wojtas <mw@semihalf.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Alex Levin <levinale@google.com>
References: <20200501193141.30293-1-rad@semihalf.com>
 <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
 <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <efca85c3-7078-efaa-88b5-536c8debea3d@intel.com>
Date:   Tue, 5 May 2020 17:57:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
>>>      hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
>>>      patch reduces pop by letting nau8825 keep using its internal VCO clock
>>>      during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
>>>      MCLK/FS is available. Once device resumes, the system will only enable
>>>      power sequence for playback without doing hardware parameter, audio
>>>      format, and PLL configure. In the mean time, the jack detecion sequence
>>>      has changed PLL parameters and switched to internal clock. Thus, the
>>>      playback signal distorted without correct PLL parameters.  That is why
>>>      we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.
>>
>> IIRC the FS can be controlled with the clk_ api with the Skylake driver,
>> as done for some KBL platforms. Or is this not supported by the firmware
>> used by this machine?
> 
> According to Ben, SKL had limitations in FW for managing the clk's
> back in the days.
> Can you point to the other driver you mention so we can cross check?
> 

Skylake driver is found within:
	/sound/soc/intel/skylake
directory.

"SKL had limitations in FW" - that's misleading. This is neither FW 
issue nor HW 'limitation'. SKL is an older platform and its goals and 
design was different than say APL+. Basically, your needs do not align 
with what's present on SKL hw.

Czarek
