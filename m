Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A02D319E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgLHSBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:01:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:43924 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgLHSBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:01:33 -0500
IronPort-SDR: NhaJ2NeJ0vXRWo+v1Dzc6hJ7yGezUiaYZWTsmAymsW5FF6qULuMpMGyRIBo45x1ogTtkIJIMrB
 B3ZXJDArA8IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153749933"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="153749933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:59:46 -0800
IronPort-SDR: Ic1dU1pc5nJGZ/IrOU1CJKLfPu25Q93BX+BmxP1GDNI2LmP9lWhwG7gpmypHnT+CphH1N5AFkr
 27iEonVWxjAw==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="552315963"
Received: from jcboyle-mobl1.amr.corp.intel.com (HELO [10.209.152.139]) ([10.209.152.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:59:45 -0800
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for ARCHOS Cesium
 140
To:     Chris Chiu <chiu@endlessos.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org
References: <20201208060414.27646-1-chiu@endlessos.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <91469f2c-01b8-ec7d-8d78-497c66dcde96@linux.intel.com>
Date:   Tue, 8 Dec 2020 09:12:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208060414.27646-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/20 12:04 AM, Chris Chiu wrote:
> Tha ARCHOS Cesium 140 tablet has problem with the jack-sensing,
> thus the heaset functions are not working.
> 
> Add quirk for this model to select the correct input map, jack-detect
> options and channel map to enable jack sensing and headset microphone.
> This device uses IN1 for its internal MIC and JD2 for jack-detect.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index f790514a147d..cd6f7caa43c8 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -421,6 +421,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 140 CESIUM"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> 
