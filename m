Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061A42832F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJEJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:15:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C08C0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:15:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z22so1301865wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fWlKMXcFZV3qTTTvDHRLs9xOZHTLn5G/jh1t4G1iOZc=;
        b=Q9+Uao4VA5SEkHf5jRu9Bp3Z6aC1UN8jZGM4QVcDZPWCP7iLz5Cjnn6Hl0FLi7PC0K
         eo47WFZv+1KW1SNYUtvtWjZtLgkBg9TGHbFpMHW+gVH/9/3Kr2Io2beUu92EgkZtMBQs
         yaCtdVuBqusjgw5TGLKr+9j9hPtCLHsbvmrlXgyWknU9R+w3I8Zc0dWt4FM5m5Hqeu4e
         4a2vO5XmA5W5qqWKx3RLRsBky6I60k1FgUOECoRihmwx4MROeZMQZjuvUacxwEkjUhhZ
         wl+5rUCyOTxsIyGylcfsdMoC6INtK9KHsfUfKH2pcuqWSQLs8PKvqgfZDjw95MVbe99m
         a9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWlKMXcFZV3qTTTvDHRLs9xOZHTLn5G/jh1t4G1iOZc=;
        b=EsgmV4xx2ITuVdAb4xS+Qp83cj8RyFrfiTBB/NznKek1DGvDBr5RpzUrFaHnp83Jlt
         M6UsXHyv8zIb7mHLIfEggqfJHYiEr/Ba/AFczXxFHM8wdFsjM38j3Pa9UGY7VYIExFHZ
         UwkYd5yy7GpEsgk+0ObGDt5tjptMPu3hTKk5L3TnnfGbPB9YnWh1+D7OnMuiwfp4tYh8
         LDRCsSJ6laZrpUUxaLLQh4c4gS7k3TABkeggBbyM7KbpwgpUd1wGB8gKP0O2zl8sj5zG
         VM3tzVAafNerQ245jOJoMKROQLoycxjT8CBUsO2vSHTAS4c2F0lGjLwG11caBQEAp6za
         Z/mw==
X-Gm-Message-State: AOAM5310UFVcdo/Th9sytkQQA3RFYUfeZnMwhmkk24RXM9q9ohOu5BYN
        LYuC8AXjbGRSwsX2K1w/4o5RdZIy8zARgQ==
X-Google-Smtp-Source: ABdhPJwp6GJmyaXxzC/PhjI7YXLfOhuby/I0er6VONP0Inh6P7+osbWNoJZ7ReqXZwKOGZkDacY2Rw==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr6812612wmb.160.1601889355135;
        Mon, 05 Oct 2020 02:15:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q9sm9299569wrd.57.2020.10.05.02.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 02:15:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Add qcom,sc7180-qfprom compatible
 string
To:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid>
 <CAD=FV=V3+V0uBiC_whvWEnv1TSkXt-MfnK+34Kir_kfTymejSA@mail.gmail.com>
 <CAE=gft6GAYePE6eCPi4PxNoJvc1K=KYCN5U_PvTRNnLdpKmLyg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7486a297-e47d-5366-3eb2-5f1787c9d1dc@linaro.org>
Date:   Mon, 5 Oct 2020 10:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft6GAYePE6eCPi4PxNoJvc1K=KYCN5U_PvTRNnLdpKmLyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2020 00:14, Evan Green wrote:
>> You don't want either/or.  You want both.  At the time Srinivas didn't
>> see the point of having the SoC-specific compatible string here, but
>> now that we have a reason for it maybe he'll be convinced?  IMO you
>> essentially want:
>>
>>      items:
>>        - enum:
>>            - qcom,apq8064-qfprom
>>            - qcom,apq8084-qfprom
>>            - qcom,msm8974-qfprom
>>            - qcom,msm8916-qfprom
>>            - qcom,msm8996-qfprom
>>            - qcom,msm8998-qfprom
>>            - qcom,qcs404-qfprom
>>            - qcom,sc7180-qfprom
>>            - qcom,sdm845-qfprom
>>        - const: qcom,qfprom
>>
>> For some context:
>> <https://lore.kernel.org/r/CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com/>
> That makes sense, thanks Doug.
> 
> Srini, do you want me to go fix up all the various device trees to add
> the soc-compatible string, or just sc7180? (Also, don't forget about
> my other question about whether you still want the keepout stuff in
> the core at the cost of added complexity).

Lets keep the existing users as it for now! and we can still list 
compatibles in the bindings so that any new users (including sc7180) can 
start using them when needed!

thanks,
srini


> 
> -Evan
> 
