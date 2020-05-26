Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAE1BA1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgD0K6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 06:58:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:54245 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0K6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:58:41 -0400
IronPort-SDR: B/7y5oaIuV/K9sWhjMBi5HbAyTjljjH+jWTfqhBYj+oEp3YpdYrAvsU09/lB/UjiaJxhtKXxuT
 /d5fZ5tb5kfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 03:58:41 -0700
IronPort-SDR: Jm7kYCpTJilbEHRsM4X79DMVvU07SGwRuHq1p4q9LGYrtNNvdmk5o8QGvcxkTqW1Dp46yTl3x8
 1vWdyzlSWQlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="302340844"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127]) ([10.213.7.127])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 03:58:38 -0700
Subject: Re: [PATCH 1/3] ASoC: bdw-rt5677: channel constraint support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
 <1587976638-29806-2-git-send-email-brent.lu@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <6795eb5d-2208-e83f-77e8-c3aaf15ea50d@intel.com>
Date:   Mon, 27 Apr 2020 12:58:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-2-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 10:37, Brent Lu wrote:
> BDW boards using this machine driver supports only stereo capture and
> playback. Implement a constraint to enforce it.
> 

Title for the overall series fits better than the one chosen for actual 
patches. "channel constraint support" is misleading. Constraints are 
added or removed but certainly not supported.

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
> index cc41a34..7963cae 100644
> --- a/sound/soc/intel/boards/bdw-rt5677.c
> +++ b/sound/soc/intel/boards/bdw-rt5677.c
> @@ -22,6 +22,8 @@
>   
>   #include "../../codecs/rt5677.h"
>   
> +#define DUAL_CHANNEL 2
> +

Remove, we need not additional too-obvious macro. One could argue 
'STEREO' is a better choice too.

>   struct bdw_rt5677_priv {
>   	struct gpio_desc *gpio_hp_en;
>   	struct snd_soc_component *component;
> @@ -222,6 +224,36 @@ static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
>   }
>   #endif
>   
> +static const unsigned int channels[] = {
> +	DUAL_CHANNEL,

Inline as stated above.

> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int bdw_fe_startup(struct snd_pcm_substream *substream)

Entire file uses 'bdw_rt5677_' naming convention. Let's not stray away 
from that path now.

> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * stereo audio
> +	 */

Sometimes you add a newline add and before, while other times just one, 
before the comment. Please streamline the format across all patches in 
the series. Comment can be more strict too
	/* Board supports stereo configuration only */
> +
> +	runtime->hw.channels_max = DUAL_CHANNEL;

Inline. If you really want to avoid using 2, make use of 0-entry of 
constrains_channels array.

> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops bdw_rt5677_fe_ops = {
> +	.startup = bdw_fe_startup,
> +};
> +
>   static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct bdw_rt5677_priv *bdw_rt5677 =
> @@ -321,6 +353,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
>   		},
>   		.dpcm_capture = 1,
>   		.dpcm_playback = 1,
> +		.ops = &bdw_rt5677_fe_ops,
>   		SND_SOC_DAILINK_REG(fe, dummy, platform),
>   	},
>   
> 
