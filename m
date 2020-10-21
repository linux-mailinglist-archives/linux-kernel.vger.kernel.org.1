Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF646294E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442101AbgJUN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:57:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:6099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439905AbgJUN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:57:02 -0400
IronPort-SDR: Oq0sDMVrIudI8O93+H+ZrrhkPicZigtGmx5vmpr+twH3jwK3I2CyTMymCXagtYaZBK0XkOECCS
 d3SS/OOsaRNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="154321003"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="154321003"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 06:57:01 -0700
IronPort-SDR: +z4CzkPOiPBawPgQkw9gwBfe67D38Br9kiPriXxcYZHhPvrv2ncEb0lSuSJyM3vXi7Klfs94VJ
 pGVl9K7BzyGQ==
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="353681561"
Received: from gyelchur-mobl1.amr.corp.intel.com (HELO [10.252.136.114]) ([10.252.136.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 06:56:59 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: update quirk for cml boards
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20201021072646.7980-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ae005e9-4cd9-31ef-56cb-504edc4cd503@linux.intel.com>
Date:   Wed, 21 Oct 2020 08:56:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021072646.7980-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/20 2:26 AM, Brent Lu wrote:
> The default quirk data of sof_rt5682 is for tgl platform. For cml
> platforms to reuse this driver, the flag SOF_RT5682_MCLK_24MHZ is
> necessary to setup codec asrc correctly.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/sof_rt5682.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index ddbb9fe7cc06..fa2c226a444a 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -768,6 +768,11 @@ static int sof_audio_probe(struct platform_device *pdev)
>   		/* default number of HDMI DAI's */
>   		if (!hdmi_num)
>   			hdmi_num = 3;
> +
> +		if (soc_intel_is_cml()) {
> +			/* default quirk for sof_rt5682 is for tgl platform */
> +			sof_rt5682_quirk |= SOF_RT5682_MCLK_24MHZ;
> +		}

That setting is not wrong, but is it sufficient?

see e.g. what we set for existing platforms which need 24 Mhz in this 
driver:

DMI quirks:

	{
		.callback = sof_rt5682_quirk_cb,
		.matches = {
			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Hatch"),
		},
		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
					SOF_RT5682_MCLK_24MHZ |
					SOF_RT5682_SSP_CODEC(0) |
					SOF_SPEAKER_AMP_PRESENT |
					SOF_RT5682_SSP_AMP(1)),
	},

Board-id quirks:

	{
		.name = "jsl_rt5682_rt1015",
		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
					SOF_RT5682_MCLK_24MHZ |
					SOF_RT5682_SSP_CODEC(0) |
					SOF_SPEAKER_AMP_PRESENT |
					SOF_RT1015_SPEAKER_AMP_PRESENT |
					SOF_RT5682_SSP_AMP(1)),
	},

You probably need a board-id quirk dedicated to CML, rather than 
override the TGL one?
