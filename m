Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2C2F20CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbhAKUaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:30:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:38637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbhAKUaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:30:16 -0500
IronPort-SDR: NqykV0rOAJis/slsVNdbOni8rdhAa/+3pxBJ68WRpgL3m3H20bKPYWgVrHpQuREDvN/MuRbmsV
 Srze6L0DuaOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157110597"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157110597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:30 -0800
IronPort-SDR: 9S9XolgBjucu9vRfXyakHknNVCatDK7ijQBmAYxPGl4PCVhsF/gfBoPH3c+Y7SViNUeBpfU+IB
 T11ts5sM+UAw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="344995363"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85]) ([10.212.87.85])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:28:29 -0800
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
To:     Chris Chiu <chiu@endlessos.org>, cezary.rojewski@intel.com,
        yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20201216041601.5993-1-chiu@endlessos.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8d4f7c48-cb3e-a868-3d48-fe63a3113ea1@linux.intel.com>
Date:   Mon, 11 Jan 2021 11:05:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216041601.5993-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/20 10:16 PM, Chris Chiu wrote:
> DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
> quirks to select the correct input map, jack-detect options to enable
> jack sensing and internal/headset microphones.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

You probably need to re-send and CC: maintainers (Mark Brown, Takashi 
Iwai) and Hans de Goede who's been supporting all those quirks.

I don't think the changes below are fully correct, most quirks start with		
.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |

which e.g. enables the MCLK and overcurrent handling.

I wonder if what you need is

.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS | BYT_RT5651_IN1_IN2_MAP)

> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 688b5e0a49e3..9df09e26b05a 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
>   					BYT_RT5651_SSP0_AIF1 |
>   					BYT_RT5651_MONO_SPEAKER),
>   	},
> +	{
> +		.callback = byt_rt5651_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
> +		},
> +		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
> +	},
>   	{}
>   };
>   
> 
