Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA622CB96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGXRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGXRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:00:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFFC0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:00:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so3846807wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVn0XE1npVfMcheHUb+P8nScOwE9YNtoOrv0SrU7C6k=;
        b=LWnkkFCyH4G+4whOm/GLvE3rIRX+ith86RYBTw6a6RbeuYjCHpaZrnNOSWWamNMoOB
         4r37fGz6LjbkYQp3O8Cbtcl5EcwtRGHq/5ysdzXV93eU6Z4TKthDV+ZofSLhcfFt90SW
         sWvc7toEFfDm+V4UyaNKD3VQy5xIqrToXQVEwH2lBRA/DZArKou+VctaXqGsqX+moKEb
         rIDRGj3MddETxAtjC7QAF1C0FU4Bp2R/+8xUB/vbaE2AmcL0FC0MO5tOnGGW7vjxFhYl
         zXuQt47JR3EQ9SX56RIdSle/YHmxZR0CNTLvln25ex5F+rdEU0deaDqsxq5FNQD28vb/
         9wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVn0XE1npVfMcheHUb+P8nScOwE9YNtoOrv0SrU7C6k=;
        b=gHrf9AxQKibqvx2FcA1x+2qp7EosJ6TZQwKpwRSksRafOCdnpYAkpuKhOJ48vJgnur
         pn0gJeK+aJAr1gvRdHH6/tx6l8jrmAlIzzoAGhDF+37c+t1dsaUW8aofGK4LzlrzEW12
         Ve0J7fCQXBqLc6MFAwceOK0Jkm6tr4JWC22A62EA/p3HNGDtojZOalZIeNBD+bQY9XU7
         8/l2mp5+yblenHg3oC4IoGI0Yot1cSLdkRpjdXRXWsg5QQG2tkJdm+0jtlqWlmCAY4Is
         FlkggRPWGtkD5tcV5s7gw6ElwPtL1GSiZFOhjL3UEETnyDXXQpGvGXWecEYa/VV7LMYo
         kD1g==
X-Gm-Message-State: AOAM530/0MU+aHyq3/u6gr26SbJdsGlehQU6ipVdSa9W8WkjAFfuEn1S
        6WOVcgLK49yc6m8nRm5izqn5Lg==
X-Google-Smtp-Source: ABdhPJx08BKvgkrkQDZ7tzxJdOszCdutDDRkrtncNdcGXVFzfxfS5ykjVZ0O4lF9mxQ7Vn+5hDOKfQ==
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr9722660wrn.340.1595610030767;
        Fri, 24 Jul 2020 10:00:30 -0700 (PDT)
Received: from [192.168.1.4] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id o21sm7536640wmh.18.2020.07.24.10.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:00:30 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] arm64: dts: sdm845: Add OPP tables and
 power-domains for venus
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-5-git-send-email-rnayak@codeaurora.org>
 <e68ff810-362a-5b99-206b-f676b204101d@linaro.org>
 <654e0fcb-ae4d-c151-fa8a-4d029fc823fb@codeaurora.org>
 <20200724162825.GH9185@codeaurora.org>
 <d3fe38de-2f79-713f-eb9e-f72f4b9f6dc0@linaro.org>
Message-ID: <3a5cc26b-7a77-33df-d8d2-edb46a72968a@linaro.org>
Date:   Fri, 24 Jul 2020 20:00:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3fe38de-2f79-713f-eb9e-f72f4b9f6dc0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/20 7:52 PM, Stanimir Varbanov wrote:
> Hi Lina,
> 
> On 7/24/20 7:28 PM, Lina Iyer wrote:
>> On Fri, Jul 24 2020 at 03:03 -0600, Rajendra Nayak wrote:
>>> Hi Maulik/Lina,
>>>
>>> On 7/23/2020 11:36 PM, Stanimir Varbanov wrote:
>>>> Hi Rajendra,
>>>>
>>>> After applying 2,3 and 4/5 patches on linaro-integration v5.8-rc2 I see
>>>> below messages on db845:
>>>>
>>>> qcom-venus aa00000.video-codec: dev_pm_opp_set_rate: failed to find
>>>> current OPP for freq 533000097 (-34)
>>>>
>>>> ^^^ This one is new.
>>>>
>>>> qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x30000
>>>>
>>>> ^^^ and this message is annoying, can we make it pr_debug in rpmh?
>>>
>> How annoyingly often do you see this message?
> 
> I haven't gig deeply but on every driver pm_runtime_suspend (after
> applying Rajendra's patches). And I guess it comes after a call to
> dev_pm_opp_set_rate(dev, 0).

Or it might be when the driver is switching off opp_pmdomain.

> 
> IMO this is too often.
> 
>> Usually, this is an indication of bad system state either on remote
>> processors in the SoC or in Linux itself. On a smooth sailing build you
>> should not see this 'warning'.
>>
>>> Would you be fine with moving this message to a pr_debug? Its currently
>>> a pr_info_ratelimited()
>> I would rather not, moving this out of sight will mask a lot serious
>> issues that otherwise bring attention to the developers.
>>
>> --Lina
> 

-- 
regards,
Stan
