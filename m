Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05142771A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgIXMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgIXMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:54:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35850C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:54:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so3103470iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O6qc5V6tfCA1Jw0Tr5d5kTXhGEVTE6N82d1Qd3A5Yhc=;
        b=Nle+JmIcHP0/Fe2F6JmdcyNj+CYk5TEak1DbAHElVeCkJzzdN+Xz9UvMCjrUgNDggC
         iKcB/lAz8697WZJ427vPIrOUU0u6XKO+zwODXXd9Xhx2hGIAr7D+nfuv6XwhH+IB19+Y
         Qc2P3LFixSfOhOtW0JPJDtdQUyhGJ/LF7B02I1uuasCYHCN1l4u4U6F4yCbVYna4YPAn
         bTy/oiwCaHIHNFhaxgSLAxU1W+C1Hc/qriW2SvNxmywHRr+WUR2CE/S4nOirtUO70yCz
         9FraFgKhtJQZd6mXgYegghvRbIRgMyYkpyLVS3PH9huTFLWq1PHzM0VR2svauFG78Ja2
         9h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O6qc5V6tfCA1Jw0Tr5d5kTXhGEVTE6N82d1Qd3A5Yhc=;
        b=WxkAKqAK8/6olcpI3JH5KYKBqw1JCS9pwcyWQphQc8KFiY8fGrfm+xhi8//hlkwNFc
         EWgPr52NA3fGwNnbt5eQkejJ5uVYzaI/7SHJNW+Msi/+hZTOHCzpq70Uc6eTA0iNfOQD
         7zkieJ2P2teU1wR0RbM8u9Y0oDgcfK87aPrxjD89mNQ52lK+3HSvC/WqphMMU6/OU3eu
         WqQmdJZXSTxIlXj+i6VCAbg9f3ZFyj6GTEWEB7SnP09ZSxMsThCgcHr2x/YRdpGDzmim
         55QWQhYCBYBMr0IaeuE3+IdcXdIiCrNsyQTmbE+fRC957IYqiw/MsQRel2x3dW8vbVNT
         c9gg==
X-Gm-Message-State: AOAM531vT4QlvjV0OWzLWgJC+YHZcfHSrLb1P9fhIn7eMMxYUmWRlbUO
        riEfrRdC4bhCtHiVxFI+PWdxegg3kFXU/w==
X-Google-Smtp-Source: ABdhPJw3O6MeQi0jSsnnLGvcmNgXVXHSenqXHcAAg9Pu4Fagrb5pmK5cHc+OeaOyuCYtb1j8aAir/w==
X-Received: by 2002:a05:6602:2013:: with SMTP id y19mr3154035iod.148.1600952054344;
        Thu, 24 Sep 2020 05:54:14 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i10sm1372395ioi.39.2020.09.24.05.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:54:11 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 2/3] staging: greybus: codecs: use
 SNDRV_PCM_FMTBIT_S16_LE for format bitmask
To:     Coiby Xu <coiby.xu@gmail.com>, devel@driverdev.osuosl.org
Cc:     Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-2-coiby.xu@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <c197ba96-0dfb-7bad-28b2-d225a9159e35@linaro.org>
Date:   Thu, 24 Sep 2020 07:54:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924102039.43895-2-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 5:20 AM, Coiby Xu wrote:
> snd_soc_pcm_stream.formats should use the bitmask SNDRV_PCM_FMTBIT_*
> instead of the sequential integers SNDRV_PCM_FORMAT_* as explained by
> commit e712bfca1ac1f63f622f87c2f33b57608f2a4d19
> ("ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask").
> 
> Found by sparse,

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> $ make C=2 drivers/staging/greybus/
> drivers/staging/greybus/audio_codec.c:691:36: warning: incorrect type in initializer (different base types)
> drivers/staging/greybus/audio_codec.c:691:36:    expected unsigned long long [usertype] formats
> drivers/staging/greybus/audio_codec.c:691:36:    got restricted snd_pcm_format_t [usertype]
> drivers/staging/greybus/audio_codec.c:701:36: warning: incorrect type in initializer (different base types)
> drivers/staging/greybus/audio_codec.c:701:36:    expected unsigned long long [usertype] formats
> drivers/staging/greybus/audio_codec.c:701:36:    got restricted snd_pcm_format_t [usertype]
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 74538f8c5fa4..494aa823e998 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -688,7 +688,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
>  		.playback = {
>  			.stream_name = "I2S 0 Playback",
>  			.rates = SNDRV_PCM_RATE_48000,
> -			.formats = SNDRV_PCM_FORMAT_S16_LE,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
>  			.rate_max = 48000,
>  			.rate_min = 48000,
>  			.channels_min = 1,
> @@ -698,7 +698,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
>  		.capture = {
>  			.stream_name = "I2S 0 Capture",
>  			.rates = SNDRV_PCM_RATE_48000,
> -			.formats = SNDRV_PCM_FORMAT_S16_LE,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
>  			.rate_max = 48000,
>  			.rate_min = 48000,
>  			.channels_min = 1,
> 

