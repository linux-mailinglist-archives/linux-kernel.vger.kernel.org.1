Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEB2F20DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbhAKUbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:31:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:38637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731050AbhAKUbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:31:38 -0500
IronPort-SDR: LhpIy6rZdfNdQuwhnElWmxuLObsJCQ9PCggrA+362RJcovh6t74xSJD3mQ2/L4CNfHkFro//+p
 721vc45rvuVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157110623"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157110623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:39 -0800
IronPort-SDR: v9xqixeOBz2f8oC/DhiwiKLZhaoneHTa9DPlR/LcDCVlgenEO/nzD/c1u5c6muexJAQwe9xvY9
 fGYHtIf781LQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="344995381"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85]) ([10.212.87.85])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:37 -0800
Subject: Re: [PATCH v2 2/2] ASoC: rt715:add Mic Mute LED control support
To:     Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org,
        Limonciello Mario <Mario.Limonciello@dell.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org
References: <20201228133831.17464-1-Perry_Yuan@Dell.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a12075b1-09f3-a993-eace-008224ca5f52@linux.intel.com>
Date:   Mon, 11 Jan 2021 12:07:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228133831.17464-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> @@ -268,6 +269,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>   	unsigned int reg2 = mc->rreg;
>   	unsigned int reg = mc->reg;
>   	unsigned int max = mc->max;
> +	unsigned int val0, val1;
>   	int err;
>   
>   	val = ucontrol->value.integer.value[0];
> @@ -286,7 +288,22 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>   		if (err < 0)
>   			return err;
>   	}
> -
> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +	/* Privacy LED Trigger State Changed by muted/unmute switch */
> +	if (mc->invert) {
> +		val0 = ucontrol->value.integer.value[0];
> +		val1 = ucontrol->value.integer.value[1];
> +		if (val0 == 1 && val1 == 1) {
> +			rt715->micmute_led = LED_OFF;
> +			ledtrig_audio_set(LED_AUDIO_MICMUTE,
> +					rt715->micmute_led ? LED_ON : LED_OFF);
> +		} else if (val0 == 0 && val1 == 0) {
> +			rt715->micmute_led = LED_ON;
> +			ledtrig_audio_set(LED_AUDIO_MICMUTE,
> +					rt715->micmute_led ? LED_ON : LED_OFF);
> +		}
> +	}
> +#endif

Should this be activated for specific DMI quirks? This driver is used in 
non-Dell platforms (I am thinking of Intel RVPs or Realtek 
daughterboards), I am not sure if a build-time behavior change makes sense.

Or conversely could we just set the LEDs unconditionally if doing so is 
harmless?
