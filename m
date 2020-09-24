Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AFF2771B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgIXNBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgIXNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:01:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4155C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:01:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q5so3054807ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zPB7jULHIg1msvTaEkWc/XGqvJfOwCy594X3DY/QjvE=;
        b=E9iKMC1wzBPaarlgtDzjwt1puGwye2dLf3QCw5dE87ph22iQOTFPvbj0p71swE/7Ym
         6GAB/CqYTvqJT5J6Uy810Q+tUnL8PR1GHu3p63aM1gkgjpjxQIlNCiu5n8quNn7oRNSO
         j4AReEHo5TFvAIZagxSwDwEvQjMw41VKGxpy3akkBwFrY4/xC3NBuWKNrAbqYoRed7dC
         7AX2cp0VdRivFRYyECmTKZCDYNbyHKHXsXpt8YL9r36IQMuVAwsSn/MfRCSDjvAP+5Ii
         qZPORrIG9elIZ3xbc1Towl/EgD28MtYgrx1GA2KG3916r/9WPu+rLFIdOaWdUCjuRqoc
         7u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPB7jULHIg1msvTaEkWc/XGqvJfOwCy594X3DY/QjvE=;
        b=q4AXLsSQ1dSmIFz4Kt7NgS0D0vVaKI6DKQOAqfbHEkV1Zp/xvYHXLK2IDShQhgS+af
         HGz3aJMLaXDKH8ux07NKsO7S7vVGgr4t9T83pS548yQIQl0ZFcpkeOTV4oPlhB228SsS
         TQoqdYTo9y+kFRlkV+N6dHRFCViojK75KghYZutydGN5ykCCP4H/K30GeVI1sbXuIwxv
         huL+NPdMe1WRLV6Db7ofEgcnsh3R4rbfv+iL7LiOn1eSlirCJ1j2oOhPYW+vVUSzB8VG
         jGS2B8cmFZwvmxZHPqNGD0POxaLNcsEKFVD385GnQHb1KlVrD687O3Bp30bOzvJzJj7l
         s05w==
X-Gm-Message-State: AOAM531RQgumXcpDHWqg2chbvoZjuNGchx9ZONK9NgVrHaCRJfoCj9Ff
        JTWAlT1eiW6ykRPcKVdKI/23LwJHT8I7qw==
X-Google-Smtp-Source: ABdhPJwKytinnF4jKyr8BsEenwtoJNaAp3EfRWwKAmJYb8V3sOg5GraVPWm16zthU56b8nazxGYZsQ==
X-Received: by 2002:a92:9e0f:: with SMTP id q15mr4093943ili.286.1600952471522;
        Thu, 24 Sep 2020 06:01:11 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q5sm1613477ile.63.2020.09.24.06.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:01:10 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 3/3] [PATCH] staging: greybus: __u8 is
 sufficient for snd_ctl_elem_type_t and snd_ctl_elem_iface_t
To:     Coiby Xu <coiby.xu@gmail.com>, devel@driverdev.osuosl.org
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Alex Elder <elder@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Johan Hovold <johan@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <772d78de-630f-4b0f-16cc-4e67b8f98907@linaro.org>
Date:   Thu, 24 Sep 2020 08:01:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924102039.43895-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 5:20 AM, Coiby Xu wrote:
> Use __8 to replace int and remove the unnecessary __bitwise type attribute.
> 
> Found by sparse,

Greg's right, don't change the public header.

You could try this in the Greybus code to eliminate the warning,
but I haven't tried it (and for all I know it's not a good idea):

	uinfo->type = (__force snd_ctl_elem_type_t)info->type;

					-Alex

> $ make C=2 drivers/staging/greybus/
> drivers/staging/greybus/audio_topology.c:185:24: warning: cast to restricted snd_ctl_elem_type_t
> drivers/staging/greybus/audio_topology.c:679:14: warning: restricted snd_ctl_elem_iface_t degrades to integer
> drivers/staging/greybus/audio_topology.c:906:14: warning: restricted snd_ctl_elem_iface_t degrades to integer
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/staging/greybus/audio_topology.c | 2 +-
>  include/uapi/sound/asound.h              | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 56bf1a4f95ad..f6023ff390c2 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -182,7 +182,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
>  	/* update uinfo */
>  	uinfo->access = data->access;
>  	uinfo->count = data->vcount;
> -	uinfo->type = (snd_ctl_elem_type_t)info->type;
> +	uinfo->type = info->type;
>  
>  	switch (info->type) {
>  	case GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN:
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 535a7229e1d9..8e71a95644ab 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>  	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
>  };
>  
> -typedef int __bitwise snd_ctl_elem_type_t;
> +typedef __u8 snd_ctl_elem_type_t;
>  #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
>  #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
> @@ -960,7 +960,7 @@ typedef int __bitwise snd_ctl_elem_type_t;
>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
>  #define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
>  
> -typedef int __bitwise snd_ctl_elem_iface_t;
> +typedef __u8 snd_ctl_elem_iface_t;
>  #define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
>  #define	SNDRV_CTL_ELEM_IFACE_HWDEP	((__force snd_ctl_elem_iface_t) 1) /* hardware dependent device */
>  #define	SNDRV_CTL_ELEM_IFACE_MIXER	((__force snd_ctl_elem_iface_t) 2) /* virtual mixer device */
> 

