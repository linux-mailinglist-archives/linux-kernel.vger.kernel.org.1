Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3F28AEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgJLHPD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 03:15:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:19379 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgJLHPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:15:02 -0400
IronPort-SDR: XK4sys7FpZJ8GjNyi99V7wB7Ad6LUMNUdaV3+uQbGgIej9I078S5px7mJJW204ocxALMlFMTVG
 wxCSsz16oLxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="250394545"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="250394545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 00:14:57 -0700
IronPort-SDR: 02b3OiT4NsNcwblaPkSL0d50e7vaPF+PjVTxTVYfkcvDdRyjtVQAtZ8N9tcRfZaUZAlUDMYW//
 QeP7Pler8jEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="344762801"
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 00:14:55 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 08:14:54 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 12 Oct 2020 08:14:54 +0100
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     =?windows-1257?Q?Valdis_Kl=E7tnieks?= <valdis.kletnieks@vt.edu>,
        "Joe Perches" <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/8] ASoC: Intel: bytcr_rt5651: use semicolons rather than
 commas to separate statements
Thread-Topic: [PATCH 3/8] ASoC: Intel: bytcr_rt5651: use semicolons rather
 than commas to separate statements
Thread-Index: AQHWn7WtURzHk5OWlUiMvlX21d63/KmTjtkw
Date:   Mon, 12 Oct 2020 07:14:54 +0000
Message-ID: <225ad3480553428bbf50e34322c8688a@intel.com>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
 <1602407979-29038-4-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1602407979-29038-4-git-send-email-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="windows-1257"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-11 11:19 AM, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks,
Czarek

> ---
>   sound/soc/intel/boards/bytcr_rt5651.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 688b5e0a49e3..64d3fc4a3225 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -143,7 +143,7 @@ static int byt_rt5651_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
>   
>   	/* Configure the PLL before selecting it */
>   	if (!(byt_rt5651_quirk & BYT_RT5651_MCLK_EN)) {
> -		clk_id = RT5651_PLL1_S_BCLK1,
> +		clk_id = RT5651_PLL1_S_BCLK1;
>   		clk_freq = rate * bclk_ratio;
>   	} else {
>   		clk_id = RT5651_PLL1_S_MCLK;
>
