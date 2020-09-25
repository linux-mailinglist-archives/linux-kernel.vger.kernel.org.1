Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D97278A55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgIYOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:07:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB57C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:07:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so2699199pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbZ40RmWzDZY2MN4Ork5wDlaVNRCgcx/fsF2/0Lay7w=;
        b=hrGdvs0CwkvH9TIdzfqJJ6SdX4gHZiCDuHDDugpm8dZYotgRIvz0/IDNki4hl8LrYq
         BHMXNzumARfeOCbziCRJUiBaTGTL1fxKFMBbQKVUrntrTrBf1djN21qVkUSFY3wq376d
         ZpM1xSz3np+9OkAUPs5NGQVqWVi8wkn/dtLF89FP+7OlOFMzTYkNWI6gLS0a2jqtOlFT
         hmSMoegXYr/ujRwWRjtRiwxix6mKLeiglp6OZnVfwteh8cqCr0RJkcWr2kT1080mEa6t
         sXAolttfuXYzkvpneiUcIYTv7cOznjV7v90f/bl7syUc5X20OCVXlDjdeR0frYtARBlq
         FgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbZ40RmWzDZY2MN4Ork5wDlaVNRCgcx/fsF2/0Lay7w=;
        b=BlTRZQC5d31Dc7rC9yhIGBckhIfckeLp+nIhBRWCJxn+SZKBNvSC+j3CDd+O+fNs4Y
         ZRk7CYcRrQyQzTro/P0maFQOfUMpn9o8Rd21GluYnjF5+vyKFmmeJMo2Mk+0dj8Ya6aW
         3hp0NoxEnjy1kdHC5JNvsucOymv1E9S1Oa9LlfiDgwwyhnAMU9pj92Ij2U5dC/KC4glZ
         lDrzk++AmRdg5jYy0+tRYfodhLhh692c0JQ/sdOAqm9yEDr1oT18f7m5B4+uuk+nMEJO
         seA7IUtM5VS8hdTbSTFwavm33urunFoS+HxV5UsE603ZA772FXKz2JG5AlJIidMAbHz/
         yG4A==
X-Gm-Message-State: AOAM532ASTp1/FZwBPvBBBTq6HWhNGauXbUCbaCrtPMRUE4lCUdMJ4PO
        h7Vdl8uVJWUy7y1o7PPqiUpbZ3+/qu7smDef
X-Google-Smtp-Source: ABdhPJx/+87hxTSMWz8FG9ToLtNr3OV0qTkSvt3J1vb6yjRGK9J40ML8dZ5hZ0epLMgn3QvRL86tAA==
X-Received: by 2002:a63:f90d:: with SMTP id h13mr172844pgi.227.1601042865340;
        Fri, 25 Sep 2020 07:07:45 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id y7sm2396925pgk.73.2020.09.25.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:07:44 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 25 Sep 2020 22:07:32 +0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@linaro.org>
Cc:     devel@driverdev.osuosl.org,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Message-ID: <20200925140732.lqkxa3rb3beg5lm3@Rk>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <20200924110057.GA319713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200924110057.GA319713@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:00:57PM +0200, Greg Kroah-Hartman wrote:
>On Thu, Sep 24, 2020 at 06:20:39PM +0800, Coiby Xu wrote:
>> Use __8 to replace int and remove the unnecessary __bitwise type attribute.
>>
>> Found by sparse,
>>
>> $ make C=2 drivers/staging/greybus/
>> drivers/staging/greybus/audio_topology.c:185:24: warning: cast to restricted snd_ctl_elem_type_t
>> drivers/staging/greybus/audio_topology.c:679:14: warning: restricted snd_ctl_elem_iface_t degrades to integer
>> drivers/staging/greybus/audio_topology.c:906:14: warning: restricted snd_ctl_elem_iface_t degrades to integer
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  drivers/staging/greybus/audio_topology.c | 2 +-
>>  include/uapi/sound/asound.h              | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
>> index 56bf1a4f95ad..f6023ff390c2 100644
>> --- a/drivers/staging/greybus/audio_topology.c
>> +++ b/drivers/staging/greybus/audio_topology.c
>> @@ -182,7 +182,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
>>  	/* update uinfo */
>>  	uinfo->access = data->access;
>>  	uinfo->count = data->vcount;
>> -	uinfo->type = (snd_ctl_elem_type_t)info->type;
>> +	uinfo->type = info->type;
>>
>>  	switch (info->type) {
>>  	case GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN:
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index 535a7229e1d9..8e71a95644ab 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>  	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
>>  };
>>
>> -typedef int __bitwise snd_ctl_elem_type_t;
>> +typedef __u8 snd_ctl_elem_type_t;
>>  #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
>>  #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
>>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
>> @@ -960,7 +960,7 @@ typedef int __bitwise snd_ctl_elem_type_t;
>>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
>>  #define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
>>
>> -typedef int __bitwise snd_ctl_elem_iface_t;
>> +typedef __u8 snd_ctl_elem_iface_t;
>>  #define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
>>  #define	SNDRV_CTL_ELEM_IFACE_HWDEP	((__force snd_ctl_elem_iface_t) 1) /* hardware dependent device */
>>  #define	SNDRV_CTL_ELEM_IFACE_MIXER	((__force snd_ctl_elem_iface_t) 2) /* virtual mixer device */
>
>I can't take a uapi sound header file patch along with a driver change,
>these need to be independant.

Thank you and Alex for reminding me this is a change of public header!
>
>And this is a userspace api, you just changed the size of an externally
>facing variable, are you _SURE_ that is ok to do?

The reasons I make this change are, 1) using int to represent 7 enumeration
values seems to be overkill; 2) using one type could avoid worries
about byte order.

I examine one userspace example (libalsa-intf/alsa_mixer.c [1]). This
change won't cause compiling breakage. But I don't the experience to
imagine any other bad consequence.

Another way to avoid userspace API change is to let
"struct gb_audio_ctl_elem_info" use snd_ctl_elem_iface_t type which may
be more elegant than using "__force" as suggested by Alex,

$ git diff
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index aeb8f9243545..7f6753ec7ef7 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -8,6 +8,7 @@
  #define __GREYBUS_PROTOCOLS_H

  #include <linux/types.h>
+#include <sound/asound.h>

  /* Fixed IDs for control/svc protocols */

@@ -1997,7 +1998,7 @@ struct gb_audio_enumerated {
  } __packed;

  struct gb_audio_ctl_elem_info { /* See snd_ctl_elem_info in Linux source */
-       __u8            type;           /* GB_AUDIO_CTL_ELEM_TYPE_* */
+       snd_ctl_elem_type_t             type;           /* GB_AUDIO_CTL_ELEM_TYPE_* */
         __le16          dimen[4];
         union {
                 struct gb_audio_integer         integer

My only concern is if greybus authors have any special reason to not include
sound/asound.h in the first place and re-define things like SNDRV_CTL_ELEM_TYPE_*,

/* See SNDRV_CTL_ELEM_TYPE_* in Linux source */
#define GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN		0x01
#define GB_AUDIO_CTL_ELEM_TYPE_INTEGER		0x02

/* See SNDRV_CTL_ELEM_IFACE_* in Linux source */
#define GB_AUDIO_CTL_ELEM_IFACE_CARD		0x00
...

/* SNDRV_CTL_ELEM_ACCESS_* in Linux source */
#define GB_AUDIO_ACCESS_READ			BIT(0)
...

[1] https://gitlab.com/Codeaurora/platform_hardware_qcom_audio/-/blob/aee6032826ec7c8b6edda404422fda0ef40ec2db/libalsa-intf/alsa_mixer.c
  alsa_mixer.c
>
>thanks,
>
>greg k-h

--
Best regards,
Coiby
