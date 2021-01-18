Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75252F9D36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbhARKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389857AbhARK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610965695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcioXB/UdMlsYBZivaxmZD1my4PTiLM/bF+IXbZJzro=;
        b=N1XNSgvkV0QSicFKjl4ecPCq1eJYfzEQcnf0OJvdKqiphSWVvZ88kUQWy0u9jPjiRmSFWZ
        YpXRGTxmLkolT7bfW7c9UUUEv1lktWk1bDFqXI3pJF/MKWOBm+hq7OeV96KTy2dUBGicWk
        dqeCdZP3+NbeFACRDDwSd4aDewck3ls=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-hLdX5rbUNLG_v22qFF_w9Q-1; Mon, 18 Jan 2021 05:28:12 -0500
X-MC-Unique: hLdX5rbUNLG_v22qFF_w9Q-1
Received: by mail-ej1-f71.google.com with SMTP id h4so5086943eja.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DcioXB/UdMlsYBZivaxmZD1my4PTiLM/bF+IXbZJzro=;
        b=kfpbgI0/9atp1AV+ytNyIDWS9j6L5k9VaSewAO6tLjvZsaRFACU8vamFrA0ELWDl/5
         0oJj/PXeGBATCrRCYcGeH8byOSFkfX3A+JZX9qzf6D63Gy/XjhNJEzWFFuqe7SjASjT7
         LaGpJ6lqegSI3Ryk0O0UV1BvbU7fBG4kboi+cG/N3jBwWbSFFsuvDnPxPsUv5IVL+FHm
         Me+vpr6HJAF5+yUQfPUxbgnPvRtlUqzINmPYQS+M/FAJrxOApWVhtY4CgV68WjXGp7uf
         eJI5EYtAm+6xw6xBw/toTaUGAVG7RJHG2ZotrdL1XGO6y+TlUwtoSREWgaK7TfosCEci
         aBBA==
X-Gm-Message-State: AOAM530ZovDtxH6doOz6Hr6jXUAu3zzNGBprre3enlfMq+bYTcXrDSI9
        m+kJhXpE9hA4xmOdFiIr/KrafS7iry09T8SY+DD+VWeCFAT+ScA3qtSUec0Lcmt0/rTpefPe3R/
        2RXkgWSAQ8uUQHE4N/EVEiAqK
X-Received: by 2002:a05:6402:30ac:: with SMTP id df12mr19641486edb.175.1610965691360;
        Mon, 18 Jan 2021 02:28:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKjZRu6y7Eez6K9LchcmhzoZWqgCU36cr2SlmBxQJtlWrydRl+v98Thet1XSfWUW/hCuozkQ==
X-Received: by 2002:a05:6402:30ac:: with SMTP id df12mr19641475edb.175.1610965691206;
        Mon, 18 Jan 2021 02:28:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id q9sm5667939ejd.113.2021.01.18.02.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 02:28:10 -0800 (PST)
Subject: Re: [PATCH v2 00/12] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210118095509.GA4903@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8905f9f2-1c1c-1b64-d70d-374f84568ccb@redhat.com>
Date:   Mon, 18 Jan 2021 11:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118095509.GA4903@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 10:55 AM, Lee Jones wrote:
> On Sun, 17 Jan 2021, Hans de Goede wrote:
> 
>> Hi All,
>>
>> This series reworks the arizona codec jack-detect support to use
>> the snd_soc_jack helpers instead of direct extcon reporting.
>>
>> This is done by reworking the extcon driver into an arizona-jackdet
>> library and then modifying the codec drivers to use that directly,
>> replacing the old separate extcon child-devices and extcon-driver.
>>
>> This brings the arizona-codec jack-detect handling inline with how
>> all other ASoC codec driver do this.
>>
>> This was developed and tested on a Lenovo Yoga Tablet 1051L with
>> a WM5102 codec.
>>
>> The MFD, ASoC and extcon parts can be merged independent from each-other
>> although that could lead to a case where both the extcon driver and
>> the new arizona-jackdet library will try to do jack-detection. If we
>> end up with a git tree in that state then one of the 2 will fail to
>> load because the other will already have claimed the IRQs, so this
>> is not a problem really.
>>
>> Or the entire series could be merged through the MFD tree if people
>> prefer that.
>>
>> Note that this series also paves the way for some further cleanups,
>> removing some jackdetect related variables like hp_ena and hp_clamp
>> from the arizona data struct shared between all the MFD child devices.
>> I've deliberately not done that cleanup as part of this patch-series,
>> since IMHO the series is big enough as is. These cleanups can be done
>> in a follow-up series once this series has landed.
> 
> Would you mind using `git format-patch` to create your cover-letters
> in the future please?  This one is missing useful information such as
> the diff-stat and patch list.

I never heard about that git feature until today, so I learn something
new every day :)

I just tested it and it seems useful. I will try to use it next time.

Regards,

Hans

