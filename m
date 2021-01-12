Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653322F3D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhALVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:16466 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437034AbhALVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:05:03 -0500
IronPort-SDR: jjBhJCd/RTeJo198OEj+y99xzu3sKWMhyau/71aap+G3YsftWI9XD7UICc8Hr91VurQOuCIT40
 +3qJGJHTPl9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178255684"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="178255684"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 13:03:09 -0800
IronPort-SDR: Hr2wj0qb4AnX3SeG5E+v960eRrN756QMpKgqbMmhAAfcIxmN+IgJOyx/zqEK9E8xFSDQNnJrMR
 jr6BgHo3XJfA==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="404604912"
Received: from clinton1-mobl1.amr.corp.intel.com (HELO [10.212.214.129]) ([10.212.214.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 13:03:06 -0800
Subject: Re: [PATCH 2/2] ASoC: intel: fix soundwire dependencies
To:     Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20210112203250.2576775-1-arnd@kernel.org>
 <20210112203250.2576775-2-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
Date:   Tue, 12 Jan 2021 15:03:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112203250.2576775-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/21 2:32 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Kconfig logic around SND_SOC_SOF_INTEL_SOUNDWIRE tries to
> ensure that all sound modules can be built with the minimal
> dependencies, but this fails in some configurations:
> 
> x86_64-linux-ld: sound/hda/intel-dsp-config.o: in function `snd_intel_dsp_driver_probe':
> intel-dsp-config.c:(.text+0x134): undefined reference to `sdw_intel_acpi_scan'
> 
> Specifically, this happens if the dsp-config driver is built-in but does
> not need to use soundwire, while CONFIG_SOUNDWIRE_INTEL is enabled as
> a loadable module.
> 
> An easier and more correct way to do this is to remove
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK and instead have
> the two drivers that can link against SOUNDWIRE_INTEL,
> i.e. DSP_CONFIG and SND_SOC_SOF_HDA, select that driver whenever
> SND_SOC_SOF_INTEL_SOUNDWIRE_LINK is set.
> 
> This however means that SND_SOC_SOF_INTEL_SOUNDWIRE cannot be selected
> by users when SOUNDWIRE is only usable by loadable modules and one or
> more drivers using SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE is built-in.

The problem is real, but the proposal isn't completely right, there is 
absolutely no logical link or functional dependency between 
INTEL_DSP_CONFIG and SOUNDWIRE.

We have a similar case with HDaudio, the two buses can be selected as 
tristates, but the SOF configuration needs to match.

In both cases, either we add a 'depends' and users need to make sure the 
configurations match on the two sides. Or we use select but one of the 
selections will be overridden and becomes meaningless.

Arnd, do you mind if I give it a try on my side?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/hda/Kconfig           |  1 +
>   sound/soc/sof/intel/Kconfig | 16 ++++++----------
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
> index 3bc9224d5e4f..ecab814d7698 100644
> --- a/sound/hda/Kconfig
> +++ b/sound/hda/Kconfig
> @@ -44,5 +44,6 @@ config SND_INTEL_NHLT
>   config SND_INTEL_DSP_CONFIG
>   	tristate
>   	select SND_INTEL_NHLT if ACPI
> +	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE
>   	# this config should be selected only for Intel DSP platforms.
>   	# A fallback is provided so that the code compiles in all cases.
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 67365ce0d86d..df8f9760870e 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -330,13 +330,17 @@ config SND_SOC_SOF_HDA
>   	tristate
>   	select SND_HDA_EXT_CORE if SND_SOC_SOF_HDA_LINK
>   	select SND_SOC_HDAC_HDA if SND_SOC_SOF_HDA_AUDIO_CODEC
> +	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level.
>   
> -config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
> +config SND_SOC_SOF_INTEL_SOUNDWIRE
>   	bool "SOF support for SoundWire"
> -	depends on SOUNDWIRE && ACPI
> +	depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
> +	depends on SOUNDWIRE
> +	depends on ACPI
> +	depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)
>   	help
>   	  This adds support for SoundWire with Sound Open Firmware
>   	  for Intel(R) platforms.
> @@ -345,14 +349,6 @@ config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
>   
>   config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
>   	tristate
> -	select SND_SOC_SOF_INTEL_SOUNDWIRE if SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
> -	help
> -	  This option is not user-selectable but automagically handled by
> -	  'select' statements at a higher level.
> -
> -config SND_SOC_SOF_INTEL_SOUNDWIRE
> -	tristate
> -	select SOUNDWIRE_INTEL
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level.
> 
