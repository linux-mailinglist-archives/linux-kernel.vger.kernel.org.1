Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00476279678
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgIZEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgIZEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:01:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37670C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:01:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k13so5051397pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 21:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TCLpBq4jyMG77GP2R933Y/gRiD3JyJMcxFQYJsXV3Gk=;
        b=OsyEZXaTKb7OV2/NqNW/x7EvHET4jO1Hhn1E1qG3wTA3LhsYpgsvqCU56G5e3WC5Vy
         9BYtAPuc3AATW93F4KxW/1UxkGdKXyrzMydl3hu4aZXk8rDztd6D0QIJfInzLXtU1tXM
         K1kyD2Fv/qmyLngIPnFqwD+wuEidtDmBPUt+CnTHKQQUdcN/G4mCGd5Z2M9m6z5ztzx0
         eshGzW1mynZGTNcJN2C4+oNyKIxlz1uHRmaGrq2RVv9glx98+/g+8FtrNcbvcC7qtg1B
         DGQpc/eU94nQHpvBHcHn3lgL4n37Cf+dLX+aeG9pr96GU9BF/J050++myPFo1Vf46OKZ
         1DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TCLpBq4jyMG77GP2R933Y/gRiD3JyJMcxFQYJsXV3Gk=;
        b=brnK+SgvjsYM3jGnXnQ3x3oRo1/8N505pJwf4Iz58Yr6AKWurITElf58RVcbjeoO1j
         nmJ45xuJefcTey4unocS4ev4AR1gmAvP42M5wNNnAyNAte9k9kupbg/0KXCbEMxJBTKR
         9K3JwdEa7hl7KAJWXcVQ0broquGAQr715IaCAJ+nrs/a8cN8cqlS2HLnERWnofyzOs19
         zLp4XlIX5SgxgwDIG1c9pvG3TEif8t2oJEOYIn3hBdyCnvlGZIFCiaWjUiTm3sRewGXR
         WRQHnXdsqzriG8YQKhzW5gawYeKwVKsattfOEYLsYRWW/kAYtaBH6mk3bvCA0Wuakcr5
         zCKw==
X-Gm-Message-State: AOAM5326mv07jr+e+H4o0NxW5lRZ+Vys13+MrrgiMEKQT8b9uLu9RJCY
        1vr25xyOs/00kdOKu57E3aI=
X-Google-Smtp-Source: ABdhPJyZrrVz7fzpSvWglCTbLHQ0w97YfNqd4GdFHcJReA+jLRXGgmNHT1uIfS8ry/R1pdlYaI/cqA==
X-Received: by 2002:a63:2246:: with SMTP id t6mr1657520pgm.120.1601092878577;
        Fri, 25 Sep 2020 21:01:18 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id y3sm3480520pgh.40.2020.09.25.21.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 21:01:17 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Sat, 26 Sep 2020 12:01:08 +0800
To:     Alex Elder <elder@linaro.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Alex Elder <elder@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Johan Hovold <johan@kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [greybus-dev] [PATCH 3/3] [PATCH] staging: greybus: __u8 is
 sufficient for snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Message-ID: <20200926040108.otqei3k74gipotk6@Rk>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
 <20200925141125.vfm5sjnsfvxo2ras@Rk>
 <160c222d-79e4-c5f0-344f-1a69821db039@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <160c222d-79e4-c5f0-344f-1a69821db039@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:02:23AM -0500, Alex Elder wrote:
>On 9/25/20 9:11 AM, Coiby Xu wrote:
>>On Thu, Sep 24, 2020 at 10:54:50AM +0000, David Laight wrote:
>>>From: Coiby Xu
>>>>Sent: 24 September 2020 11:21
>>>>Use __8 to replace int and remove the unnecessary __bitwise type
>>>>attribute.
>>>>
>>>>Found by sparse,
>>>...
>>>>diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>>>>index 535a7229e1d9..8e71a95644ab 100644
>>>>--- a/include/uapi/sound/asound.h
>>>>+++ b/include/uapi/sound/asound.h
>>>>@@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>>>     unsigned char components[128];    /* card components / fine
>>>>identification, delimited with one
>>>>space (AC97 etc..) */
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
>>>
>>>WTF is all that about anyway??
>>>What is wrong with:
>>>#define    SNDRV_CTL_ELEM_TYPE_NONE    0u /* invalid */
>>
>>I'm sorry I don't quite understand you. Are you suggesting
>>SNDRV_CTL_ELEM_TYPE_NONE
>>isn't needed in the first place?
>
>I think David is asking why it's defined the way it is,
>and I'd guess it's to have the compiler issue an error
>if you attempt to assign one of these values to a variable
>or field of the wrong type.
>
>No, you should not attempt to change this.

Thank you for the explanation!

>
>					-Alex
>>>    David
>>>
>>>-
>>>Registered Address Lakeside, Bramley Road, Mount Farm, Milton
>>>Keynes, MK1 1PT, UK
>>>Registration No: 1397386 (Wales)
>>>
>>
>>--
>>Best regards,
>>Coiby
>>_______________________________________________
>>greybus-dev mailing list
>>greybus-dev@lists.linaro.org
>>https://lists.linaro.org/mailman/listinfo/greybus-dev
>

--
Best regards,
Coiby
