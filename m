Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4803829C803
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371324AbgJ0S73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:59:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:40774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901077AbgJ0S71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:59:27 -0400
IronPort-SDR: liaQlFBgOCToAWDxOOPOmfwfpOp+OKBafkBziGDKtL3l5JsFJuDL2VpemmfyLLqy96wnAi/h8z
 2P848vQCJ1qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="252843333"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="252843333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 11:59:24 -0700
IronPort-SDR: SFyqsuloCpBFPe0fRFFSk+S/ZWCe/xFa/AgewmFcVG01vyQXYbZBjj8wJdmMZ1FKJRtIfSVo2Z
 xg1dmHdYpzSA==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="524844162"
Received: from nakabir-mobl.amr.corp.intel.com (HELO [10.212.164.122]) ([10.212.164.122])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 11:59:22 -0700
Subject: Re: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
References: <20201027183149.145165-1-peron.clem@gmail.com>
 <20201027183149.145165-2-peron.clem@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com>
Date:   Tue, 27 Oct 2020 13:58:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027183149.145165-2-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>   	case SND_SOC_DAIFMT_DSP_B:
>   	case SND_SOC_DAIFMT_LEFT_J:
>   	case SND_SOC_DAIFMT_RIGHT_J:
> -		lrck_period = params_physical_width(params) * slots;
> +		lrck_period = slot_width * slots;
>   		break;
>   
>   	case SND_SOC_DAIFMT_I2S:
> -		lrck_period = params_physical_width(params);
> +		lrck_period = slot_width;
>   		break;

Aren't I2S, LEFT_J and RIGHT_J pretty much the same in terms of lrclk 
rate/period? the only thing that can change is the polarity, no?

Not sure why it's handled differently here?
