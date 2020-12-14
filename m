Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174EC2D9D46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408279AbgLNRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:09:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:38182 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408235AbgLNRJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:09:16 -0500
IronPort-SDR: pWgMowJQYB/q8Q89Ecs8LkkqNjzkdF3ZzfNb/xL0jvbDtEcJn2AjmC+BMc315A/wRrqjsIZgni
 V58U43h530QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="154549550"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="154549550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 09:07:29 -0800
IronPort-SDR: 8yjtT0xbS8RvlMcwve5C1sPoi/a8XF4j0g6A3k8YPrgt+POPcD0akXzGr/YS+gxGekZlv9IkIj
 3lK82lpjalzQ==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="449089701"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.213.21.123]) ([10.213.21.123])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 09:07:25 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib
 skl_tplg_complete
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201211170629.871085-1-ribalda@chromium.org>
From:   "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <6b933ad0-2b54-33de-4d74-c176efd4d110@linux.intel.com>
Date:   Mon, 14 Dec 2020 18:07:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211170629.871085-1-ribalda@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If dobj->control is not initialized we end up in an OOPs during
> skl_tplg_complete:
>
> [   26.553358] BUG: kernel NULL pointer dereference, address:
> 0000000000000078
> [   26.561151] #PF: supervisor read access in kernel mode
> [   26.566897] #PF: error_code(0x0000) - not-present page
> [   26.572642] PGD 0 P4D 0
> [   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
> [   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
> 5.4.81 #4
> [   26.588232] Hardware name: HP Soraka/Soraka, BIOS
> Google_Soraka.10431.106.0 12/03/2019
> [   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]
>
> Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>   sound/soc/intel/skylake/skl-topology.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 40bee10b0c65..0955cbb4e918 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3619,19 +3619,20 @@ static void skl_tplg_complete(struct snd_soc_component *component)
>   
>   	list_for_each_entry(dobj, &component->dobj_list, list) {
>   		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
> -		struct soc_enum *se =
> -			(struct soc_enum *)kcontrol->private_value;
> -		char **texts = dobj->control.dtexts;
> +		struct soc_enum *se;
> +		char **texts;
>   		char chan_text[4];
>   
> -		if (dobj->type != SND_SOC_DOBJ_ENUM ||
> -		    dobj->control.kcontrol->put !=
> -		    skl_tplg_multi_config_set_dmic)
> +		if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
> +		    kcontrol->put != skl_tplg_multi_config_set_dmic)
>   			continue;
> +
> +		se = (struct soc_enum *)kcontrol->private_value;
> +		texts = dobj->control.dtexts;
>   		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>   
>   		for (i = 0; i < se->items; i++) {
> -			struct snd_ctl_elem_value val;
> +			struct snd_ctl_elem_value val = {};
>   
>   			if (strstr(texts[i], chan_text)) {
>   				val.value.enumerated.item[0] = i;


Hi Ricardo,

there is another thread regarding this issue (with fix provided by 
Lukasz Majczak), you can find it here:

     https://www.spinics.net/lists/stable/msg431524.html


Thanks,
Mateusz

