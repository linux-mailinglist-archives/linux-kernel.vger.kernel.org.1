Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254C226CFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 02:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIQAXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 20:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 20:23:00 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:23:00 EDT
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6DC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:13:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k14so288707pgi.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+L8r3i/llwp2Lmso2SJhe/RRr10LqwB0/nAV4JJW3s0=;
        b=JC1Ik0dTH25FUvJr+6hQ7ANFLhd84ikfThn/lnDI9H6v+KmSh8y0R5+6RDmpkXDNoS
         jrGyTNd/bMGzTyUALXM20m2tIv1i0eg2jUdFyK5P1SP0X1eKadn1e53/JCTcczHht8Z8
         3SgmdZ3PDrm1nhNNjoy0+mbFThR122+YFS83dknywKFKv9eft48bVcHo97iDUnvKjQzR
         9mhS4X/C3QT5FAPN8Vu0N7pwTZrrKxsQucrlMVaMsKXNWbHHWnymjZPby2YiyH2JGA1k
         GqL1mt9mdVOg/XNUiV/CMMVIOl0qCHSxIAn2tPIQLJ8fcW/pLs6o8WW1cpDbaV85nNVI
         Qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+L8r3i/llwp2Lmso2SJhe/RRr10LqwB0/nAV4JJW3s0=;
        b=Ix2To4M2Jj19dWj85AeLYD84ZCCKjyJ97gouqUtgjX/tQ1T2pQkfrrb7a6tw/x2gdo
         JwdrpmQ2fzTjuOaddB+wPe7/MxNdMq51+RJbs1Aqk51LOt2mUSuliF1Y7ejdYSAfJmY5
         q3xZMS/xt+nubGe4SzWMKomfccgZPODXGxP8iuJ54xPpafXZgaLzjgFPaOPsCDznV2ne
         o2sN5Cx99mLr776YGu/AqqkYmuVN18gC1sQ2aTsDEYnAtPXh12QsHuTGF8YhiJ27jVoD
         YEvhQB9prV9epFsmxr9D6Evr//7Uu6xqRuNGWKhmTDkI7+0Zu1YrzjtJwT/yZ2AiNZ0q
         aDIw==
X-Gm-Message-State: AOAM531AwJ23Fv8qyAElcBGiT3sCqpXRLY9mG8ifE5J/PrQNOckVKTv0
        KENNqaHoJsEGnnR3Aa/OprM=
X-Google-Smtp-Source: ABdhPJwyRANoUnW2/ZYlnK9c+pZ3xu+Veuc7MK+f2qzGVSCXe5EsIqJOkORlG6/DMUY0bn9nyBY02g==
X-Received: by 2002:a62:10a:0:b029:142:2501:39e1 with SMTP id 10-20020a62010a0000b0290142250139e1mr8640542pfb.48.1600301600950;
        Wed, 16 Sep 2020 17:13:20 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z4sm18491615pfr.197.2020.09.16.17.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 17:13:20 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:10:08 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_audmix: make clock and output src write only
Message-ID: <20200917001007.GA22566@Asurada-Nvidia>
References: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 08:24:34PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> "alsactl -f state.conf store/restore" sequence fails because setting
> "mixing clock source" and "output source" requires active TDM clock
> being started for configuration propagation. Make these two controls
> write only so that their values are not stored at "alsactl store".
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_audmix.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index a447baf..7ad5925 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -199,10 +199,18 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
>  
>  static const struct snd_kcontrol_new fsl_audmix_snd_controls[] = {
>  	/* FSL_AUDMIX_CTR controls */
> -	SOC_ENUM_EXT("Mixing Clock Source", fsl_audmix_enum[0],
> -		     snd_soc_get_enum_double, fsl_audmix_put_mix_clk_src),
> -	SOC_ENUM_EXT("Output Source", fsl_audmix_enum[1],
> -		     snd_soc_get_enum_double, fsl_audmix_put_out_src),
> +	{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.name = "Mixing Clock Source",
> +		.info = snd_soc_info_enum_double,
> +		.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
> +		.put = fsl_audmix_put_mix_clk_src,
> +		.private_value = (unsigned long)&fsl_audmix_enum[0] },
> +	{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.name = "Output Source",
> +		.info = snd_soc_info_enum_double,
> +		.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
> +		.put = fsl_audmix_put_out_src,
> +		.private_value = (unsigned long)&fsl_audmix_enum[1] },
>  	SOC_ENUM("Output Width", fsl_audmix_enum[2]),
>  	SOC_ENUM("Frame Rate Diff Error", fsl_audmix_enum[3]),
>  	SOC_ENUM("Clock Freq Diff Error", fsl_audmix_enum[4]),
> -- 
> 2.7.4
> 
