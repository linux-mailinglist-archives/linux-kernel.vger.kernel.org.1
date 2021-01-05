Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111082EAB61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbhAENCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:02:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:20960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbhAENCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:02:17 -0500
IronPort-SDR: CXVMdRY+prz70H6xyBg17va6QOykrI0uyei8wACsGw/kMKebEspzGFWNQt/1Rah5OfRPDqRHOB
 CUkJAnIESeEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176317452"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="176317452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:00:31 -0800
IronPort-SDR: kXyPxD3/i3+kNgTomQl+sswUl8Rflu/3/SRDgEEtE1Ld9v2Wray4IHsfXB2hJkeiC5YkBmUol3
 alzeW5ytCncw==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="378861333"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:00:19 -0800
Date:   Tue, 5 Jan 2021 14:57:19 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack
 detection
In-Reply-To: <20210104140853.228448-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101051425560.864696@eliteleevi.tm.intel.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Jan 2021, Kai-Heng Feng wrote:

> Instead of queueing jackpoll_work, runtime resume the codec to let it
> use different jack detection methods based on jackpoll_interval.

hmm, but jackpoll_work() does the same thing, right? So end result should 
be the same.

> This matches SOF driver's behavior with commit a6e7d0a4bdb0 ("ALSA: hda:
> fix jack detection with Realtek codecs when in D3"). Since SOF only uses
> Realtek codec, we don't need any additional check for the resume.

This is not quite correct. First, SOF does support any HDA codec, not just 
Realteks (see e.g. https://github.com/thesofproject/linux/issues/1807), 
and second, this doesn't really match the hda_intel.c patch you mention. 
SOF implements a more conservative approach where we basicly assume 
codec->forced_resume=1 to always apply, and do not implement support for 
codec->relaxed_resume. So the above patch doesn't fully apply to SOF as 
the design is not same.

> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index 6875fa570c2c..df59c79cfdfc 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -93,8 +93,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
>  		 * has been recorded in STATESTS
>  		 */
>  		if (codec->jacktbl.used)
> -			schedule_delayed_work(&codec->jackpoll_work,
> -					      codec->jackpoll_interval);
> +			pm_request_resume(&codec->core.dev);

I think this change is still good. Just drop the but about Realtek 
codecs from commit message and maybe s/matches/aligns/.

Br, Kai
