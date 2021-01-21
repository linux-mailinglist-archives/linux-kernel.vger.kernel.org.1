Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0595E2FF26E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbhAURvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:51:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:3683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389148AbhAURsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:48:05 -0500
IronPort-SDR: pnHjQ20/ASKcM/oNKPao6H511oJQfF9k/IUh5lcbopSghaffaZSDFtYGFw6egMLuiFTRvnDLzB
 6mjvKoELwWyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240849797"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="240849797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:46:20 -0800
IronPort-SDR: S8I3SKCOdNxCtAanMLbnazamcZPP2+1r1NdLYAt0c3poCPSyo2ymCYY6ZXQ5dnZBE7VOZBNO5f
 5juMlkBFMyFg==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="427447489"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:46:16 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2e3D-007oOc-4n; Thu, 21 Jan 2021 19:47:19 +0200
Date:   Thu, 21 Jan 2021 19:47:19 +0200
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
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
Message-ID: <YAm+JxMdvhmKBWQt@smile.fi.intel.com>
References: <20210121171644.131059-1-ribalda@chromium.org>
 <20210121171644.131059-2-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121171644.131059-2-ribalda@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:16:44PM +0100, Ricardo Ribalda wrote:
> Clear struct snd_ctl_elem_value before calling ->put() to avoid any data
> leak.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  sound/soc/intel/skylake/skl-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 1ef30ca45410..b824086203b9 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3632,7 +3632,7 @@ static void skl_tplg_complete(struct snd_soc_component *component)
>  		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>  
>  		for (i = 0; i < se->items; i++) {
> -			struct snd_ctl_elem_value val;
> +			struct snd_ctl_elem_value val = {};
>  
>  			if (strstr(texts[i], chan_text)) {
>  				val.value.enumerated.item[0] = i;
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 
With Best Regards,
Andy Shevchenko


