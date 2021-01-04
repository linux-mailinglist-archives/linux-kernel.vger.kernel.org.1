Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE62E8F64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhADCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 21:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbhADCTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:19:31 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3FC061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 18:18:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z5so23705206iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T3zwU8+9vJsSFH0cocgNEnbGtFiXyYPpUvK1pfeu9Jc=;
        b=WqeDyl/nli5DAewksl0V1NW/pGU3lRo+D2PFuR8B4T46KzPamegn4w0VyATtDlnd+V
         Yno8V/2kcHk0h04rwg1P2ctdu6+0h7/1PVGuPhok0wdl8ZzaNKWBNjH02ZM4T1H9pUer
         43zEdlo5kU7hg9kdZYx4wZn4lPEXFXLxygeto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3zwU8+9vJsSFH0cocgNEnbGtFiXyYPpUvK1pfeu9Jc=;
        b=aLJ+OYef6DKFprl0XETmQuSp+an/0xUYhjTCrMJbbE6/xIGrMP0U7Xhf+2iJjdcP2r
         bW7a2/HpNsRY4pP3dpediZloNaT5DunhkEEMj6Lr2dNzL1xHD9xy4xFxo2qT68jRm4w9
         N+KXixGrwYlDlz10fD+bBEhxicO1FJLW9Cgm68pqjMZk/JkGidfyZ7JUlcMLMJH0WfWE
         G7eSP1EPOgSPvzWVS6MMcut07DTZW5617E19S8AHB3i07GxgTq4vdXXBFM8n3tn4eljJ
         IGo+DvSYT86IDMOyIEO2afVIJdq2gY6ayIh0oun0id6G2/+PRpy6+b9quI/e+/i+LZiy
         l13g==
X-Gm-Message-State: AOAM530XfNoY4xAsurztzJImHrNnWq/7rrDz6NlcMoade6o7tFDRibi9
        vkrBeQtRDb6wBVoH1VIQZ7mH7g==
X-Google-Smtp-Source: ABdhPJwg0Hrrg9PhM5yO6+Fu8jRBIBmLhEazmMJKlBF2BhnkB9zwbcgdNmjZP04ZahA7xnDp0HgZLg==
X-Received: by 2002:a6b:7d42:: with SMTP id d2mr57793459ioq.176.1609726729750;
        Sun, 03 Jan 2021 18:18:49 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y12sm42527985ilk.32.2021.01.03.18.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 18:18:49 -0800 (PST)
Subject: Re: [PATCH] staging: greybus: fix stack size warning with UBSAN
To:     Arnd Bergmann <arnd@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Coiby Xu <coiby.xu@gmail.com>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210103223541.2790855-1-arnd@kernel.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <d9c341c9-9005-b425-9dd8-e797869bbcb0@ieee.org>
Date:   Sun, 3 Jan 2021 20:18:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210103223541.2790855-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 4:35 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about excessive stack usage in this driver when
> UBSAN is enabled:
> 
> drivers/staging/greybus/audio_topology.c:977:12: error: stack frame size of 1836 bytes in function 'gbaudio_tplg_create_widget' [-Werror,-Wframe-larger-than=]
> 
> Rework this code to no longer use compound literals for
> initializing the structure in each case, but instead keep
> the common bits in a preallocated constant array and copy
> them as needed.

This is good, but I have a few comments.

You took out the default case, and it seems you are using
a w->type value bigger than the initialization array to
determine validity.  But there are more values defined in
the snd_soc_dapm_type enumerated type than are explicitly
listed as cases in the switch statement.  So the switch
statement no longer treats some types as invalid (such
as snd_soc_dapm_demux).  Am I missing something?

You are setting explicit names, such as "spk", "hp",
"mic", etc. in the initialization array.  But you
update the name after (struct) assigning from the
array.  I have no real objection I guess, but why
bother?  Why not just use null pointers in the
initialization array?

You change a semicolon to a comma in one spot, and you
should not have.  I'll point that out below.

I like that you got rid of the type casts, which were
apparently unnecessary.

You dropped the break in the final case in the switch
statement, but in an earlier discussion I think we
concluded that wasn't a problem.

I guess the main thing is the first thing mentioned.


Thanks.

					-Alex

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/staging/greybus/audio_topology.c | 106 ++++++++++-------------
>   1 file changed, 47 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 96b8b29fe899..c03873915c20 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -974,6 +974,44 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
>   	return ret;
>   }
>   
> +static const struct snd_soc_dapm_widget gbaudio_widgets[] = {
> +	[snd_soc_dapm_spk]	= SND_SOC_DAPM_SPK("spk", gbcodec_event_spk),
> +	[snd_soc_dapm_hp]	= SND_SOC_DAPM_HP("hp", gbcodec_event_hp),
> +	[snd_soc_dapm_mic]	= SND_SOC_DAPM_MIC("mic", gbcodec_event_int_mic),

. . .

> @@ -1050,78 +1088,28 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>   	strlcpy(temp_name, w->name, NAME_SIZE);
>   	snprintf(w->name, NAME_SIZE, "GB %d %s", module->dev_id, temp_name);
>   
> +	if (w->type > ARRAY_SIZE(gbaudio_widgets)) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +	*dw = gbaudio_widgets[w->type];
> +	dw->name = w->name;
> +
>   	switch (w->type) {
>   	case snd_soc_dapm_spk:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_SPK(w->name, gbcodec_event_spk);
>   		module->op_devices |= GBAUDIO_DEVICE_OUT_SPEAKER;
>   		break;
>   	case snd_soc_dapm_hp:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_HP(w->name, gbcodec_event_hp);
>   		module->op_devices |= (GBAUDIO_DEVICE_OUT_WIRED_HEADSET
> -					| GBAUDIO_DEVICE_OUT_WIRED_HEADPHONE);
> +					| GBAUDIO_DEVICE_OUT_WIRED_HEADPHONE),

Please fix this (above) to preserve the original semicolon.

>   		module->ip_devices |= GBAUDIO_DEVICE_IN_WIRED_HEADSET;
>   		break;
>   	case snd_soc_dapm_mic:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_MIC(w->name, gbcodec_event_int_mic);
>   		module->ip_devices |= GBAUDIO_DEVICE_IN_BUILTIN_MIC;
>   		break;

. . .
