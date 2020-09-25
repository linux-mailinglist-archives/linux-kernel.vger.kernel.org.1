Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF74D278D83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgIYQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:02:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61930C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:02:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r25so3352538ioj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KKM36HMFNo7IvqfCBLe5UvX13jWEuh671Vjt/sAVWGU=;
        b=sVLJdXvNc4vI/tTRzJH1n5umDfoQzc0lsxFSySSDfM9g8sfMF5bGtV3YOz+Mq/yTg4
         mYfcO/hDl7+K7I1RppX5dH3wOKDaTFqUPdQKU1USHqHhuZvVZbj3nhzZazC7ljqr4AlM
         GdlaWb5cSbBxU6iq0y28UrZceThjvQPmG7di6bcrCYiIIAFjPeOHRGTrcggy82+Br2qc
         pO9SSfO2nxkYF86cfQ3NVBcx6W+y8z2+LeCKIg2IjlcHcpesTx4STeu9RltEEOvgaG4h
         oNdbnMlPqiqt4flmlon3yktUtP8FabrmBXTYKLGv3bQWD+UpGzCfP4/D6QMEp89fwKBC
         i4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KKM36HMFNo7IvqfCBLe5UvX13jWEuh671Vjt/sAVWGU=;
        b=GwW/GCfRDNQgRpWdO1X5L0JDlt2FQ4hD8e34iq2D4fsgV76AmtvbciZuceh2TQ1Wiu
         KTafByaEndq1HoQSiIHgH5fn2/pKoYpmBBCumMixvCOic7rr8ovhiv8q777GF4aFdf+m
         1Id8lnd7+IOJJUL598gGoCmBQBuMhQrFppST/EOX/Rz9DPHPXQg5eNbV8I8qz8Ghvuxd
         N1pA/xyUnEewzDBEpf4QlUnD0bH6OKrDy83uRm4pkI8M9hcyS31crdatZ8JH1q4bPZ9g
         XUCoWPJYwUyfkCO5vsAJOT0ZxfJap9JKyKUcyWVqTIiHI6vt6Ir/CpqElvZk3OcawmbT
         XUWg==
X-Gm-Message-State: AOAM530VZwZWlJ9+0tJapoxxpM5MzNDv2uX7tHai0AhsT7z98R8U2lgq
        34r7oCZed1K5OfU5VlhnFgcYvkGKbksg6Q==
X-Google-Smtp-Source: ABdhPJw116LnPqm4dNs1MVsCzNLg8V45rQtN1gWgLkN5mnf5844SsTjgU2eBKcngEh17i/akpuiSGA==
X-Received: by 2002:a02:1004:: with SMTP id 4mr411804jay.127.1601049745262;
        Fri, 25 Sep 2020 09:02:25 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c12sm1720817ili.48.2020.09.25.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:02:24 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 3/3] [PATCH] staging: greybus: __u8 is
 sufficient for snd_ctl_elem_type_t and snd_ctl_elem_iface_t
To:     Coiby Xu <coiby.xu@gmail.com>,
        David Laight <David.Laight@aculab.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Alex Elder <elder@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Johan Hovold <johan@kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
 <20200925141125.vfm5sjnsfvxo2ras@Rk>
From:   Alex Elder <elder@linaro.org>
Message-ID: <160c222d-79e4-c5f0-344f-1a69821db039@linaro.org>
Date:   Fri, 25 Sep 2020 11:02:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925141125.vfm5sjnsfvxo2ras@Rk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 9:11 AM, Coiby Xu wrote:
> On Thu, Sep 24, 2020 at 10:54:50AM +0000, David Laight wrote:
>> From: Coiby Xu
>>> Sent: 24 September 2020 11:21
>>> Use __8 to replace int and remove the unnecessary __bitwise type 
>>> attribute.
>>>
>>> Found by sparse,
>> ...
>>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>>> index 535a7229e1d9..8e71a95644ab 100644
>>> --- a/include/uapi/sound/asound.h
>>> +++ b/include/uapi/sound/asound.h
>>> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>>      unsigned char components[128];    /* card components / fine 
>>> identification, delimited with one
>>> space (AC97 etc..) */
>>>  };
>>>
>>> -typedef int __bitwise snd_ctl_elem_type_t;
>>> +typedef __u8 snd_ctl_elem_type_t;
>>>  #define    SNDRV_CTL_ELEM_TYPE_NONE    ((__force 
>>> snd_ctl_elem_type_t) 0) /* invalid */
>>>  #define    SNDRV_CTL_ELEM_TYPE_BOOLEAN    ((__force 
>>> snd_ctl_elem_type_t) 1) /* boolean type */
>>>  #define    SNDRV_CTL_ELEM_TYPE_INTEGER    ((__force 
>>> snd_ctl_elem_type_t) 2) /* integer type */
>>
>> WTF is all that about anyway??
>> What is wrong with:
>> #define    SNDRV_CTL_ELEM_TYPE_NONE    0u /* invalid */
> 
> I'm sorry I don't quite understand you. Are you suggesting 
> SNDRV_CTL_ELEM_TYPE_NONE
> isn't needed in the first place?

I think David is asking why it's defined the way it is,
and I'd guess it's to have the compiler issue an error
if you attempt to assign one of these values to a variable
or field of the wrong type.

No, you should not attempt to change this.

					-Alex
>>     David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
>> MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>
> 
> -- 
> Best regards,
> Coiby
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev

