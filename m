Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB9300EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbhAVVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729865AbhAVUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611348453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bt8jsoC8w4pX7n1okX/YWWxr8+fNbZirJrt6Rmv6/KE=;
        b=fHctJGqvwjd1Q6VyJ5o8tnA1c5uLnEvCOEQV2hVIPknfoJCxqBL9CN7EbhNMhh6xt53qvS
        n4hrtn+WfPl+BVvt2ZQ7cW38c6pIvKx0ujBNnpskfMgie2tTwyvGfwsz+Q5uuV3H1OQ3vi
        BzHV6ILQrVFRHTwBNiZzGluCnorSkyk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-THzM5P_9MiC1A__lLjuc_w-1; Fri, 22 Jan 2021 15:47:31 -0500
X-MC-Unique: THzM5P_9MiC1A__lLjuc_w-1
Received: by mail-ej1-f72.google.com with SMTP id p1so2679413ejo.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bt8jsoC8w4pX7n1okX/YWWxr8+fNbZirJrt6Rmv6/KE=;
        b=o1RLaUNfC7TRFZP8iu2NSHU8wL67wWB0TG1SNvhwQrbceJmdoHvt0fFCxzb3uwdfNz
         niTsnfWPzPgsLcNd+fhuY4zZWNhoOyEqLqdPFLOA/6xN3VEKIEYfMvkTOdGQd2sFQn1A
         VVzd0LTrbZLy5oS1KPVl01YqHbKSCgNL3OvKkE6196qQdc8Zzrb7C1tsLKAiIzdxDYIo
         Gfz4yjam6dXowBz5VEOi4SSoYfZWPQiaKSyvE3WZLD4BWlB54sI2qT48HLtvEW/S2/6c
         yrooMhpXrG0IoVc/5uiQF/euu+2QxM2eq8hXUo/Y824v9HppXPrxa1Ol0bJt9PQIsaOh
         2MHQ==
X-Gm-Message-State: AOAM533695/csvtEwkOmAzDja8q+5lvW2cVy0Z2NuI8bP6fj6r1czaZA
        WJvwvnwDta7BPch5IJD8MovAHniZQyWpg88FfgtLOGnk1mNKeGuBVSesOg1ViYoosc6akkpSaua
        bXcSYnOsVz5IjEfFS76gPCcxU
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr4226780ejd.374.1611348450770;
        Fri, 22 Jan 2021 12:47:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwo163a+f8F/EOwisq+gJafad5l/6GVGT0dTmP8QFP5yGh0Mq6mKUNkt7IGPgMbDROQFsSGmg==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr4226768ejd.374.1611348450595;
        Fri, 22 Jan 2021 12:47:30 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id m8sm2769649eds.70.2021.01.22.12.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 12:47:30 -0800 (PST)
Subject: Re: [PATCH v3 05/13] extcon: arizona: Always use
 pm_runtime_get_sync() when we need the device to be awake
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210122164107.361939-1-hdegoede@redhat.com>
 <20210122164107.361939-6-hdegoede@redhat.com>
 <CAHp75VdPVNMvQnkOr2YOL_VirwS7QxKfG5A9P-P8q2suK=J9dw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8209882c-ae98-ecf1-3e76-1bce34017b41@redhat.com>
Date:   Fri, 22 Jan 2021 21:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdPVNMvQnkOr2YOL_VirwS7QxKfG5A9P-P8q2suK=J9dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/21 9:38 PM, Andy Shevchenko wrote:
> On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Before this commit the extcon-arizona code was mixing pm_runtime_get()
>> and pm_runtime_get_sync() in different places.
>>
>> In all places where pm_runtime_get[_sync]() is called, the code
>> makes use of the device immediately after the call.
>> This means that we should always use pm_runtime_get_sync().
> 
> I think it implies the non-atomic (may sleep) context in the below functions.

Right, but there were always called with the info->lock mutex held anyways,
so no change there.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you.

Regards,

Hans



> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - This is a new patch in v3 of this patch-set
>> ---
>>  drivers/extcon/extcon-arizona.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
>> index 72d23b15108c..56d2ce05de50 100644
>> --- a/drivers/extcon/extcon-arizona.c
>> +++ b/drivers/extcon/extcon-arizona.c
>> @@ -290,7 +290,7 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
>>         unsigned int mode;
>>
>>         /* Microphone detection can't use idle mode */
>> -       pm_runtime_get(info->dev);
>> +       pm_runtime_get_sync(info->dev);
>>
>>         if (info->detecting) {
>>                 ret = regulator_allow_bypass(info->micvdd, false);
>> @@ -695,7 +695,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>>         dev_dbg(arizona->dev, "Starting HPDET\n");
>>
>>         /* Make sure we keep the device enabled during the measurement */
>> -       pm_runtime_get(info->dev);
>> +       pm_runtime_get_sync(info->dev);
>>
>>         info->hpdet_active = true;
>>
>> --
>> 2.28.0
>>
> 
> 

