Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4552FF25A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbhAURsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:48:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:30940 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389104AbhAURrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:47:16 -0500
IronPort-SDR: ROO8cuwcpUha8mo+hwjLipvN32FSQD90VdNH57mCELSdodjEWCeXU25Q+j8q1wah1ro2Iigd+B
 CjHYiKxblr7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243384025"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="243384025"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:45:24 -0800
IronPort-SDR: FGDfNZ5uVSfF+AG8jkgOhNj4k+ISYc+3flz+AUhyvW2Xz7k42lbQWl8DPt88RyTfFGD7vJvvL8
 eSjdS52jpIiQ==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="351532590"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:45:21 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2e2J-007oKb-28; Thu, 21 Jan 2021 19:46:23 +0200
Date:   Thu, 21 Jan 2021 19:46:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib
 skl_tplg_complete
Message-ID: <YAm977TOZBgaQChA@smile.fi.intel.com>
References: <20210121171644.131059-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121171644.131059-1-ribalda@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:16:43PM +0100, Ricardo Ribalda wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  sound/soc/intel/skylake/skl-topology.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index ae466cd59292..1ef30ca45410 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3619,15 +3619,16 @@ static void skl_tplg_complete(struct snd_soc_component *component)
>  
>  	list_for_each_entry(dobj, &component->dobj_list, list) {
>  		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
> -		struct soc_enum *se =
> -			(struct soc_enum *)kcontrol->private_value;
> -		char **texts = dobj->control.dtexts;
> +		struct soc_enum *se;

> +		char **texts;

A nit-pick: Can we place this after below line?

>  		char chan_text[4];
>  
> -		if (dobj->type != SND_SOC_DOBJ_ENUM ||
> -		    dobj->control.kcontrol->put !=
> -		    skl_tplg_multi_config_set_dmic)
> +		if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
> +		    kcontrol->put != skl_tplg_multi_config_set_dmic)
>  			continue;
> +
> +		se = (struct soc_enum *)kcontrol->private_value;
> +		texts = dobj->control.dtexts;
>  		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>  
>  		for (i = 0; i < se->items; i++) {
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 
With Best Regards,
Andy Shevchenko


