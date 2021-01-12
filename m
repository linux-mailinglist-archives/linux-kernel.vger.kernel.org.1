Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745612F3CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437470AbhALVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:13240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436839AbhALUSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:55 -0500
IronPort-SDR: u491VDRj4HXfcFgT8yXG92iAok2Br31hugqFxQgzKmFgo3d0cyOLb+BNAI0yQCa1UappsbfjT2
 jwnNzJjOsFrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178250782"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="178250782"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 12:17:10 -0800
IronPort-SDR: 29Hbz6FgfIXaFdwmqBXeJT+DW03oBkD+FjOq44WsfUZaY9DMsF/rZx4feKfuCJmvFQIxRlIBdF
 fVgvRuqyFHJg==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="404593879"
Received: from clinton1-mobl1.amr.corp.intel.com (HELO [10.212.214.129]) ([10.212.214.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 12:17:08 -0800
Subject: Re: [Sound-open-firmware] [PATCH] ASoC: SOF: Intel: avoid reverse
 module dependency
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
References: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
 <20210105190808.613050-1-arnd@kernel.org>
 <59a36212-2412-2dd3-62f2-69c6f65312b1@linux.intel.com>
 <s5hv9c2qmy4.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ed4b4b5b-0cde-3d08-bbbf-3f0d90ce46ea@linux.intel.com>
Date:   Tue, 12 Jan 2021 14:17:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hv9c2qmy4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Since this is going to be a really invasive change, and past
>> experience shows that mucking with Kconfigs will invariably raise a
>> number of broken corner cases, if there is support from
>> Mark/Takashi/Jaroslav on this idea, we should first test it in the SOF
>> tree so that we get a good test coverage and don't break too many eggs
>> in Mark's tree. We would also need to concurrently change our CI
>> scripts which are dependent on module names.
> 
> I'm in favor of the way Arnd proposed.  It's more straightforward and
> less code.

Thanks Takashi for the feedback.

Since yesterday I looked at another problem where we can have unmet 
dependencies between SoundWire (m) and SOF (y), so we probably need to 
rethink all this. We had similar issue with SOF and HDaudio before, it's 
time to revisit all this.

> 
> If you find the number of modules or the too much cutting out being
> problematic, you can create a module snd-sof-intel-acpi and
> snd-sof-intel-pci containing the driver table entries for all Intel
> devices, too.  In the case, you'll still need some conditional calls
> of intel-dsp-config there, but it's a good step for reducing the
> Kconfig complexity.
> 
>> Also maybe in a first pass we can remove the compilation error with
>> IS_REACHABLE and in a second pass do more invasive surgery?
> 
> Agreed, we'd like to keep less changes for 5.11 for now.

Ack, we'll send smaller changes first.

