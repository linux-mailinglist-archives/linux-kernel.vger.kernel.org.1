Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E79278A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgIYOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:11:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:11:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so1927457pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q08aEOVeEFIcbOVub2p7BVSdpIEBfXqJPk66Kzol7Ek=;
        b=B9iVuIIH3TYz9BMPhpD3a1bfdq5boPpLLU+4e9jJwFetvvfwUrsy1TwiBC2V8caeD1
         KQjWepGRZERKAFzv/tm88uLD+8BO9ZNGf6yjSluDtpbiBSzYvwMmXDfCGYkSVcC81Rmm
         hJc1/ajoke2Hggavt93yp87KRIiX8gXeqj6b2LqqBuZMwVEkQr/dn09D8kzBYDSbrZ2t
         6JaFvocHhZB54NbXjuFRE50HqVdB+2PwALiMuPgPC90X+VT5R4PmL3EG20GdHZ3agLCg
         v6+5uLZzKtiyi9sT7uR7LOkpSvXYtQUJD+LzZYE0UCJG+Gc4Ozbd0eHhwPfBYcPPgCjc
         s2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q08aEOVeEFIcbOVub2p7BVSdpIEBfXqJPk66Kzol7Ek=;
        b=G/Ulcuc7yfg5c7rMAClIXsgWstaK/rD1jJuGuh73bEBLDjEkUwDJUKh8KSrAzG4h3r
         AllOB11GUMUszPtwAL3ZiWSuaHNXiqmu8mNeYnO9QPZN15Ju95O1dJCpRQQiIu7I8KEp
         CM1o7Ely+B18wTWvSyZT3jzkd2H7bntmFJD1jwXj6reQywTvOjfnyjP6w/7VHEGyuxue
         n9TZoFc2/pGX+oo8Je0taul/ZKHlR7PS9zgRPeKL+cLunHT1rCknZho6w8P/ZKz6y1V/
         WrrZjH1OAdf9bfznSo7N8A7Qe4plPA8Zu+CxiUUQvbe/NpngFErKAa67PH1zQKcCCfrB
         8NSQ==
X-Gm-Message-State: AOAM530MscS5Fqf9a9xKyjV6u99LrJTpfzQdKbao8/pmTYNJWc0AH63U
        pHVxJynCjvEkETeFmUaHkJ/mMoQAFSL4F2vs
X-Google-Smtp-Source: ABdhPJzT6sXqjKAB73bAq8KZRHwwr+CQap8YXV/cCKxktgj12xrTfbNkL1PGBRW3RyMRygsVwxd83g==
X-Received: by 2002:a17:90a:8d05:: with SMTP id c5mr490557pjo.222.1601043096640;
        Fri, 25 Sep 2020 07:11:36 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id 1sm2508194pgm.4.2020.09.25.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:11:36 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 25 Sep 2020 22:11:25 +0800
To:     David Laight <David.Laight@aculab.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Message-ID: <20200925141125.vfm5sjnsfvxo2ras@Rk>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:54:50AM +0000, David Laight wrote:
>From: Coiby Xu
>> Sent: 24 September 2020 11:21
>> Use __8 to replace int and remove the unnecessary __bitwise type attribute.
>>
>> Found by sparse,
>...
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index 535a7229e1d9..8e71a95644ab 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>  	unsigned char components[128];	/* card components / fine identification, delimited with one
>> space (AC97 etc..) */
>>  };
>>
>> -typedef int __bitwise snd_ctl_elem_type_t;
>> +typedef __u8 snd_ctl_elem_type_t;
>>  #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
>>  #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
>>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
>
>WTF is all that about anyway??
>What is wrong with:
>#define	SNDRV_CTL_ELEM_TYPE_NONE	0u /* invalid */

I'm sorry I don't quite understand you. Are you suggesting SNDRV_CTL_ELEM_TYPE_NONE
isn't needed in the first place?
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>Registration No: 1397386 (Wales)
>

--
Best regards,
Coiby
