Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB12A4EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgKCSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:35:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:4685 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCSfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:35:45 -0500
IronPort-SDR: buNiKJ7L0PwMRDGqaHyQccn7SSh/1LhTplWDQBZmyU418c09Po2RTmZJycDJrUe6PJEBeaEn1k
 Z6tfHhL7c7aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="233270443"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="233270443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:35:44 -0800
IronPort-SDR: bHNj/JoKRstYrDj0mgNWLSQhGnm+ZYTN8dj56MWswfjiAGkIfOhPdwmBvy/IdjjZwZ5fQ+DI4d
 ESd+Xk1fdcWg==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528591147"
Received: from ctanriov-mobl1.amr.corp.intel.com (HELO [10.212.114.78]) ([10.212.114.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:35:43 -0800
Subject: Re: [PATCH] ASoC: rt715:add Mic Mute LED control support
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
References: <20201103125859.8759-1-Perry_Yuan@Dell.com>
 <20201103131253.GA5545@sirena.org.uk>
 <5f2c1282-4401-276a-8dad-127fa1f449fd@linux.intel.com>
 <20201103175948.GF5545@sirena.org.uk>
 <DM6PR19MB26368B60076D049F009B75A3FA110@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <15ed949b-0313-168c-bfc5-3e71d9548e3f@linux.intel.com>
Date:   Tue, 3 Nov 2020 12:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26368B60076D049F009B75A3FA110@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think it came through in the commit message, but I wanted to mention
> in the system that prompted this software does not control the LED.  The LED
> is actually controlled by hardware, but has circuitry to delay the hardware
> mute until software mute is complete to avoid any "popping noises".
> 
> This patch along with the platform/x86 patch:
> https://patchwork.kernel.org/project/platform-driver-x86/patch/20201103125542.8572-1-Perry_Yuan@Dell.com/
> complete that loop.
> 
> The flow is:
> User presses mute key, dell-wmi receives event, passes to dell-privacy-wmi.
> This emits to userspace as KEY_MICMUTE.  Userspace processes it and via UCM
> switches get toggled.  The codec driver (or subsystem perhaps) will use LED
> trigger to notify to change LED.  This gets picked up by dell-privacy-acpi.
> 
> dell-privacy-acpi doesn't actually change LED, but notifies that SW mute was
> done.
> 
> If none of that flow was used the LED and mute function still work, but there
> might be the popping noise.

Side note that the existing UCM config for RT715 does not do what I 
suggested, it seems we are using an incorrect configuration for 
CaptureSwitch and CaptureVolume:

CaptureSwitch "PGA5.0 5 Master Capture Switch"
	      CaptureVolume "PGA5.0 5 Master Capture Volume"		 
CaptureVolume "PGA5.0 5 Master Capture Volume"

That should be an RT715 control, not an SOF one. This was brought to our 
attention this morning. Probably a copy-paste from the DMIC case, likely 
needs to be changed for both RT715 and RT715-sdca cases.

https://github.com/thesofproject/linux/issues/2544#issuecomment-721231103
