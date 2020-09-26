Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7727970F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgIZFKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 01:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZFKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 01:10:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82007C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 22:10:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so524411pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 22:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xt022cqBI2ZK57zyxOOIE27Q2UzWkMYDwMCiPr4Z6RU=;
        b=Z3uFCKsXqsq/NKVPx3It6LKGNVaEhhCP8W0E4X1eRuEiFLqmZUCn7IeYnYOZjhj5A2
         S//xzCQZ2YaBp7b7NS2KUVaEUU0uNlBBA3bHSQ7x5O8votcIjwv6CTIRSJGtAwyN8aca
         fc6fjwPXu9B2uIZ/iel7XqIQyS8SVwbUilQkrjAKiAa2oqR5HTBu5s684iEMK3UF5p6m
         Ab2bWVJV1+tlGMn3jgzCY8ASKgb0EskvK6WVYNlSXTYuqrnI4k68ycnCSciwIuxu6G9M
         spH57UAk4v6gnOHDFLXLaRkMjDR3V87htbcIUoWlAORDRHihPU/uJLY4Fx+UeIy4xRxS
         MCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xt022cqBI2ZK57zyxOOIE27Q2UzWkMYDwMCiPr4Z6RU=;
        b=k9Cyqrk+WEYXhSWmNECMSLAXQgX2WlVcpR8CPo1Y0IECTLKtqG1vLh+EmGGyBk4E3C
         PAB9hFISDl00UAJ5WoyG/XL5xU0ENtAf/ViAWWtz3hX6pgWsDLV+nwPjO3plLM98SmQF
         0960G+H/wN1ShB9F/vD+/s0dLmb0XTgCrG/u+REffBC0InhWN3bu8WAcyeMFmGAtFBmf
         179oKSXBVL2My7Ewa319IRXIBeWj+LGT5pTtUqXcaUgPmqM8sxWK9Gf9mWxHKwN2b+PE
         zDB1lVGdqTsIHzUQdX/xp5B1z8B1nc06JfWsTkapynRFpt6hZuDkyhB1cWFErC+RwBzm
         tzAQ==
X-Gm-Message-State: AOAM530fh5A0c755rXuwnulu8ObL9Q01ad0SjYQKy0a4PSNwiXPf/Dzo
        Q01aVR6aeWK+ZQ5CBapVcEs=
X-Google-Smtp-Source: ABdhPJwPjsopCGo4lmqXwnMRo6a0R45YdfOBnanymm9O53rmuoGpVUi19jrv60TmKmZfdDgrXNeXpA==
X-Received: by 2002:a17:90a:1ce:: with SMTP id 14mr781878pjd.209.1601097009008;
        Fri, 25 Sep 2020 22:10:09 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id m20sm4147306pfa.115.2020.09.25.22.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 22:10:08 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Sat, 26 Sep 2020 13:09:58 +0800
To:     Alex Elder <elder@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Message-ID: <20200926050958.7lz2otowjz2oqnpt@Rk>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <20200924110057.GA319713@kroah.com>
 <20200925140732.lqkxa3rb3beg5lm3@Rk>
 <8e613bb6-6093-cb81-3fa1-e6583837c843@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e613bb6-6093-cb81-3fa1-e6583837c843@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:57:27AM -0500, Alex Elder wrote:
>On 9/25/20 9:07 AM, Coiby Xu wrote:
>>On Thu, Sep 24, 2020 at 01:00:57PM +0200, Greg Kroah-Hartman wrote:
>>>On Thu, Sep 24, 2020 at 06:20:39PM +0800, Coiby Xu wrote:
>>>>Use __8 to replace int and remove the unnecessary __bitwise type
>>>>attribute.
>>>>
>>>>Found by sparse,
>
>. . .
>
>>>>diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>>>>index 535a7229e1d9..8e71a95644ab 100644
>>>>--- a/include/uapi/sound/asound.h
>>>>+++ b/include/uapi/sound/asound.h
>>>>@@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>>>     unsigned char components[128];    /* card components / fine
>>>>identification, delimited with one space (AC97 etc..) */
>>>> };
>>>>
>>>>-typedef int __bitwise snd_ctl_elem_type_t;
>>>>+typedef __u8 snd_ctl_elem_type_t;
>>>> #define    SNDRV_CTL_ELEM_TYPE_NONE    ((__force
>>>>snd_ctl_elem_type_t) 0) /* invalid */
>>>> #define    SNDRV_CTL_ELEM_TYPE_BOOLEAN    ((__force
>>>>snd_ctl_elem_type_t) 1) /* boolean type */
>>>> #define    SNDRV_CTL_ELEM_TYPE_INTEGER    ((__force
>>>>snd_ctl_elem_type_t) 2) /* integer type */
>>>>@@ -960,7 +960,7 @@ typedef int __bitwise snd_ctl_elem_type_t;
>>>> #define    SNDRV_CTL_ELEM_TYPE_INTEGER64    ((__force
>>>>snd_ctl_elem_type_t) 6) /* 64-bit integer type */
>>>> #define    SNDRV_CTL_ELEM_TYPE_LAST    SNDRV_CTL_ELEM_TYPE_INTEGER64
>>>>
>>>>-typedef int __bitwise snd_ctl_elem_iface_t;
>>>>+typedef __u8 snd_ctl_elem_iface_t;
>>>> #define    SNDRV_CTL_ELEM_IFACE_CARD    ((__force
>>>>snd_ctl_elem_iface_t) 0) /* global control */
>>>> #define    SNDRV_CTL_ELEM_IFACE_HWDEP    ((__force
>>>>snd_ctl_elem_iface_t) 1) /* hardware dependent device */
>>>> #define    SNDRV_CTL_ELEM_IFACE_MIXER    ((__force
>>>>snd_ctl_elem_iface_t) 2) /* virtual mixer device */
>>>
>>>I can't take a uapi sound header file patch along with a driver change,
>>>these need to be independant.
>>
>>Thank you and Alex for reminding me this is a change of public header!
>>>
>>>And this is a userspace api, you just changed the size of an externally
>>>facing variable, are you _SURE_ that is ok to do?
>>
>>The reasons I make this change are, 1) using int to represent 7 enumeration
>>values seems to be overkill; 2) using one type could avoid worries
>>about byte order.
>
>(1) might be a valid suggestion, but the file you suggest
>changing is part of the Linux user space API, which you
>basically can't change.
>
>I'm fairly certain the user space API is defined to have
>CPU-local byte order (unless specified explicitly otherwise)
>so that is not a concern.

Thank you for sharing me about the byte order of user space API which
prompts me to examine where "info->type" comes from,

	uinfo->type = (snd_ctl_elem_type_t)info->type;

Eventually it comes from the parsed topology data which is obtained via
gb_audio_gb_get_topology(gbmodule->mgmt_connection, &topology). But
since (struct gb_audio_ctl_elem_info*)->type has __u8 type, there is no
endianness concern. Then based on the principles of userspace API
shouldn't be modified and greybus is operating system independent, your
previous suggestion to use __force which means "I know what I'm doing"
is actually a good idea,

         uinfo->type = (__force snd_ctl_elem_type_t)info->type;


>>I examine one userspace example (libalsa-intf/alsa_mixer.c [1]). This
>>change won't cause compiling breakage. But I don't the experience to
>>imagine any other bad consequence.
>
>As a rule, once the user space API has been established, it
>stays with us forever.  You can add to it, but modifying
>(or removing) an existing interface is essentially forbidden.
>
>>Another way to avoid userspace API change is to let
>>"struct gb_audio_ctl_elem_info" use snd_ctl_elem_iface_t type which may
>>be more elegant than using "__force" as suggested by Alex,
>
>The Greybus definitions were explicitly defined to be
>operating system independent.  For that reason there are
>(admittedly cumbersome) definitions of certain types and
>values that essentially mimic those defined by Linux
>exactly  That way Linux (or another system using Greybus)
>can change its internal values without changing the
>Greybus API definition.  (This addresses the concern you
>mention below.)
>
>What you are suggesting is not consistent with that
>principle.
>
>					-Alex
>
>
>>$ git diff
>>diff --git a/include/linux/greybus/greybus_protocols.h
>>b/include/linux/greybus/greybus_protocols.h
>>index aeb8f9243545..7f6753ec7ef7 100644
>>--- a/include/linux/greybus/greybus_protocols.h
>>+++ b/include/linux/greybus/greybus_protocols.h
>>@@ -8,6 +8,7 @@
>>  #define __GREYBUS_PROTOCOLS_H
>>
>>  #include <linux/types.h>
>>+#include <sound/asound.h>
>>
>>  /* Fixed IDs for control/svc protocols */
>>
>>@@ -1997,7 +1998,7 @@ struct gb_audio_enumerated {
>>  } __packed;
>>
>>  struct gb_audio_ctl_elem_info { /* See snd_ctl_elem_info in Linux
>>source */
>>-       __u8            type;           /* GB_AUDIO_CTL_ELEM_TYPE_* */
>>+       snd_ctl_elem_type_t             type;           /*
>>GB_AUDIO_CTL_ELEM_TYPE_* */
>>         __le16          dimen[4];
>>         union {
>>                 struct gb_audio_integer         integer
>>
>>My only concern is if greybus authors have any special reason to not
>>include
>>sound/asound.h in the first place and re-define things like
>>SNDRV_CTL_ELEM_TYPE_*,
>>
>>/* See SNDRV_CTL_ELEM_TYPE_* in Linux source */
>>#define GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN        0x01
>>#define GB_AUDIO_CTL_ELEM_TYPE_INTEGER        0x02
>>
>>/* See SNDRV_CTL_ELEM_IFACE_* in Linux source */
>>#define GB_AUDIO_CTL_ELEM_IFACE_CARD        0x00
>>...
>>
>>/* SNDRV_CTL_ELEM_ACCESS_* in Linux source */
>>#define GB_AUDIO_ACCESS_READ            BIT(0)
>>...
>>
>>[1] https://gitlab.com/Codeaurora/platform_hardware_qcom_audio/-/blob/aee6032826ec7c8b6edda404422fda0ef40ec2db/libalsa-intf/alsa_mixer.c
>>
>>  alsa_mixer.c
>>>
>>>thanks,
>>>
>>>greg k-h
>>
>>--
>>Best regards,
>>Coiby
>

--
Best regards,
Coiby
