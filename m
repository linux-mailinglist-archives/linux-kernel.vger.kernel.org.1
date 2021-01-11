Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849512F21C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbhAKV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbhAKV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610400299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TWvqrIVm+eS1cOB00SDFYgHatsARh3E9H2TndpfG6E=;
        b=euiG9JXd6lGt5XWbVo0ep18lqFyv8oVJZVUnStptmo72njN0Kt6bKibu0X0bNge0B6B5So
        maOfbKYlRGoDXzUgGYv3CrX89pYNmyoFSBjGI4oCdNKu8G2FfY47Dm3TZN9TYK/F7+kodl
        H96WeT/6qooc03uavN3wQ3Fft9B+6cI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-hZWTfXl7OdeSfTevb_IVGg-1; Mon, 11 Jan 2021 16:24:57 -0500
X-MC-Unique: hZWTfXl7OdeSfTevb_IVGg-1
Received: by mail-ej1-f71.google.com with SMTP id n17so129596eja.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TWvqrIVm+eS1cOB00SDFYgHatsARh3E9H2TndpfG6E=;
        b=EkRd2NzOGTxr+Xl1+TR+gWTfKoGhSQKgfOE1qip609ohpOxnLP/xC/COUWElvBkktk
         C4x3JoJDJxy8CJS4yeV7nvth5dJt0g4UCWbHXcYQ3A/DdjSgPkcDDCW2WP0Lr+AVvoX/
         eC5mCB5gmTkbpysH8kVWQ+w4idHke3OdGs4N/lfeoHADAY7uSPyf872BokMQpn5k2HlG
         7s2AV1gfRhNV+Q3F6/V6sKvVRg68J2g2dufaGH1xqhzj3NLXkf7FnLFumiJxcaxWVDcZ
         jt4SjU9XlmshOv7xEr3BYKLURidSF1iiCJI8mR37dHbGo+9VNdSix2zxu5QuSCaZp/UC
         IpwA==
X-Gm-Message-State: AOAM533ahxlEZXT5FDdGKuxyVMA7vkQA4dyc6kQhOQGtE+pC8/3UKhjp
        iVZeAuQV92k9rdFbwyK9IYqDg1jJ2W92QU/4yjEQ/6H7vQEw1yAFPV2LScTeL+3H5hVcebmOmnM
        SqU8H1EucJms8hlm6Y2MIIMeO
X-Received: by 2002:a17:906:8151:: with SMTP id z17mr978465ejw.48.1610400296191;
        Mon, 11 Jan 2021 13:24:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxXhXldBoE2+pr7QCaS5A+yMjdW8BmlmZyOL9jrU41uAREPuAsgEFGMQIXw8nX9gHpG66zKg==
X-Received: by 2002:a17:906:8151:: with SMTP id z17mr978453ejw.48.1610400296046;
        Mon, 11 Jan 2021 13:24:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id rs27sm349583ejb.21.2021.01.11.13.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 13:24:55 -0800 (PST)
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chris Chiu <chiu@endlessos.org>, cezary.rojewski@intel.com,
        yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
References: <20201216041601.5993-1-chiu@endlessos.org>
 <8d4f7c48-cb3e-a868-3d48-fe63a3113ea1@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <835f8b2e-5e9a-b8db-d126-d0cd5f0ec075@redhat.com>
Date:   Mon, 11 Jan 2021 22:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8d4f7c48-cb3e-a868-3d48-fe63a3113ea1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/21 6:05 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 12/15/20 10:16 PM, Chris Chiu wrote:
>> DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
>> quirks to select the correct input map, jack-detect options to enable
>> jack sensing and internal/headset microphones.
>>
>> Signed-off-by: Chris Chiu <chiu@endlessos.org>
> 
> You probably need to re-send and CC: maintainers (Mark Brown, Takashi Iwai) and Hans de Goede who's been supporting all those quirks.
> 
> I don't think the changes below are fully correct, most quirks start with       
> .driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
> 
> which e.g. enables the MCLK and overcurrent handling.
> 
> I wonder if what you need is
> 
> .driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS | BYT_RT5651_IN1_IN2_MAP)

Ack, BYT_RT5651_DEFAULT_QUIRKS is:

#define BYT_RT5651_DEFAULT_QUIRKS       (BYT_RT5651_MCLK_EN | \
                                         BYT_RT5651_JD1_1   | \
                                         BYT_RT5651_OVCD_TH_2000UA | \
                                         BYT_RT5651_OVCD_SF_0P75)

So compared to the quirk from the original patch that will add:

BYT_RT5651_MCLK_EN
BYT_RT5651_OVCD_TH_2000UA
BYT_RT5651_OVCD_SF_0P75

Since you have working jack-detect you will definitely want the latter 2
which will make headset vs headphones detection work and will add
button-press detection for headsets.

BYT_RT5651_MCLK_EN is also a quirk which you almost always want,
the sole exception is boards where the mclk is not connected which
are very rare. Boards where the mclk is not connected are easy to
spot, since they will not work at all when setting BYT_RT5651_MCLK_EN,
so if things work with BYT_RT5651_DEFAULT_QUIRKS then setting
BYT_RT5651_MCLK_EN is the right thing to do.

Tl;DR: use (BYT_RT5651_DEFAULT_QUIRKS | BYT_RT5651_IN1_IN2_MAP) as
Pierre-Louis suggests.

Regards,

Hans






> 
>> ---
>>   sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
>> index 688b5e0a49e3..9df09e26b05a 100644
>> --- a/sound/soc/intel/boards/bytcr_rt5651.c
>> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
>> @@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
>>                       BYT_RT5651_SSP0_AIF1 |
>>                       BYT_RT5651_MONO_SPEAKER),
>>       },
>> +    {
>> +        .callback = byt_rt5651_quirk_cb,
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
>> +        },
>> +        .driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
>> +    },
>>       {}
>>   };
>>  
> 

