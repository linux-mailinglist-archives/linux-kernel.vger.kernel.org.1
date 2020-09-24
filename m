Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EFB276F33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgIXLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:00:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841AA2396E;
        Thu, 24 Sep 2020 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600945241;
        bh=RCxHBE9X2KZ+55CTd1qLEdHD5TDMxFbwfTKYkPN3vWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHfvx8/gn3Fkn5GSoRdXkJQYcv7QfWRpROlDJ0nfMfOSmiB8l/IGCC6UDmcMy4/hv
         L500XpemRMRcdF7uMH+/qvu2Iti3sDTMt6TMn+InGaA9H8SdU2jAaqSXEfCc1Nw+Ln
         Ozjyf0FnVcgyiLkzEh0eQ8CLgy/rJqEoOEPKSlxM=
Date:   Thu, 24 Sep 2020 13:00:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Message-ID: <20200924110057.GA319713@kroah.com>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924102039.43895-3-coiby.xu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 06:20:39PM +0800, Coiby Xu wrote:
> Use __8 to replace int and remove the unnecessary __bitwise type attribute.
> 
> Found by sparse,
> 
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

I can't take a uapi sound header file patch along with a driver change,
these need to be independant.

And this is a userspace api, you just changed the size of an externally
facing variable, are you _SURE_ that is ok to do?

thanks,

greg k-h
