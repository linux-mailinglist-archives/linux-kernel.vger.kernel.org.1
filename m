Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9F29E78C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgJ2JkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJ2JkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:40:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B71C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:40:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c16so1773197wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hur9K+EudzUclv9Q5MgCsUV5nXs9DJUDHPdJFsODeWM=;
        b=Uqz6RcxOD9iSU+l/mOial1rAIMeJOXKNmyvc2QEbl/w8pZk5YOIfProysAgwaK4biy
         jXyJ8u/BHnY4N6RDgPrtiwCQBRhG/Zh2a7/pA4d6R83nFseK01Y5ouFNAyeph4RmcMVl
         hBaBItva8mOBNRuVWgJNIufbfAKZhJ7TIteAVoQ9BqthW34CMURCtoERm9q4pQbRpuXj
         gq4QQAHY6B53q82PyVppwjwdUD7wZrKxXH2vfQP+Mr6PwTl/BbUxqzqyqX9oNP4dbu7Z
         D9d0M3zHNtS0BWRmTKktMSkAAN+AsSP35EybWymaWbT/8JTiv2myvfb/nzVfBU2N/i8w
         zpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hur9K+EudzUclv9Q5MgCsUV5nXs9DJUDHPdJFsODeWM=;
        b=AguOinYMNq6fc/wlhWTYRanJfbMEebNdv89ItD8mzoZ52Jp+uH60E23o2/9IglSMWj
         7e42fFpQGGXb5tK6GtE6e3X+hSDeAVtTcK/X9oA2iER4agM8nRwh9dtKU2CJKtvx/shG
         LRKvHM8x0kBdjApwV5gq4Bh26QtGb+HKmuc5dWZ79tST3ivEB92xfmhC1EmVwpzcJR9u
         I8CSaWnCcWmzx4qPQJFa3N3rpkg4b1UvlhTnz5gD5JpF3Fqs9kKgliQncad+gbWQO8sQ
         hyuFWeurBkOa4cU5HxY9lZVdPjSPlaQDy+pzNQab67mnDmJlUugYW2DQ7+jCi9PlJEdn
         CqHQ==
X-Gm-Message-State: AOAM530ZakQ2BoifWDjMdKN5eoKeIVLpthKlSNmSpsnBUbOADKPx46Mj
        mPD1nQ6udLqEEeF+gZ9fzgPMwg==
X-Google-Smtp-Source: ABdhPJwABc6anNpYjQu1A/0HOMid9JVr/Km6Tz3QWl+sUAYUXr9XM/TFmuG0c2bfemthkDakTGPdEw==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr3305664wmj.78.1603964402648;
        Thu, 29 Oct 2020 02:40:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p9sm3248589wma.12.2020.10.29.02.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 02:40:01 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Patrick Lai <plai@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
 <20201026170947.10567-2-srinivas.kandagatla@linaro.org>
 <20201028150135.GA4009047@bogus>
 <31981724-b260-e94d-ebc6-ccea21763531@linaro.org>
 <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d876d014-8342-e1b9-7773-86995d7d79f6@linaro.org>
Date:   Thu, 29 Oct 2020 09:40:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2020 18:24, Rob Herring wrote:
> On Wed, Oct 28, 2020 at 10:19 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 28/10/2020 15:01, Rob Herring wrote:
>>>> +        - const: qcom,sm8250
>>>
>>> This collides with the top level SoC compatible resulting in:
>>>
>>
>> I did run dt_binding_check before sending out this patch, I might have
>> missed it somehow because the make dt_binding_check did not
>> end/termnitate in any errors, however if I had scrolled 15-20 Page ups
>> it does have this error log!
> 
> make -sk

Thanks for the hint!

> 
> :)
> 
>> Documentation/devicetree/bindings/arm/qcom.yaml does have
>> qcom,qrb5165-rb5 entry under [qcom,sm8250]
>>
>> Can you help me understand why is this not a valid compatible?
> 
> Those compatibles are used at the top level for the SoC. You can't use
> the same compatible to mean 2 different things.
> 
Thanks for explaining this, This is now modified to
  "qcom,qrb5165-rb5-sndcard"
  "qcom,sm8250-sndcard"

I do not see any complains from dt_binding_check.

also makes it inline with other qcom soundcard compatible strings!

--srini
> Rob
> 
