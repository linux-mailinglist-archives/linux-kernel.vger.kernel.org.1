Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A676526BDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIPH0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIPH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:26:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2AC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:26:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so5789987wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fnd1H7JWR0H2Ed0PevksPXMw8NbHRfcO8lkjwpN2/E=;
        b=LryN3IjtR9Z/niCTVz4RcZC/v679mEEOZVfLF/kJ1QH9y+hKN36URiG8+/hSflXbcX
         tSakH/dk15eNWGGZnYu0FXQLXWc7xFJxK1t95pgh+flnrLfGdOpjS2TyKJlJnJVR0Xd7
         G4fm+9mma0ZqK7hYm7pkYxPV5R7EmEUlrQmLttkAn7jsqbZIEc7xInD4aoYgOtBERbId
         Z2uAqVhXNuYlITJbLssgUDhTQOdR5n2BJ1quHGPj8zEZQONCuoFWSVcvODdiSnWChlTl
         XE0e/JNcCn9d2+jSj69L+v/FQ19BScLgDQ/MMv31ETqChNs6gOgsS/6jfDiYyVe1TQf+
         7nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fnd1H7JWR0H2Ed0PevksPXMw8NbHRfcO8lkjwpN2/E=;
        b=IMj4t10txYrWjxtUI7n93eTtJHWgX0PBf/VCi96oOxpAIrQ1hOjwOG+yCj34NDpEdB
         KyDkJs8N1vkDnIWqqHyr98qJCZx7WylBGfmUD9b2YPugHeoVeI2nmIaKfDoeJEFGaMqo
         h5HqFlXEqsHV5KyzB2SE10rcmN1fDC3IqeZv+9aik7zIspgTEgIZD6U8wygapcTx+f4t
         rpmMcIfNqk1f0ExYbQ8TB68MV8pkCT9EUkbP+nBPiRBQuFcMV//k6CA07xrXFzgTya9R
         gVA5j3M1vUGtH/AG7wXuD6pcyYSCXK88HJSQEKQzHIFcdseXApkjJyjDSSY73HL1YWOD
         X0ww==
X-Gm-Message-State: AOAM5331pegoReX1r8imliuAqEm4Av7/ZQJ6FY9UurXpURMDEZOZhOsj
        xOqtuOcfjqtgoOzjebSIzEM/1w==
X-Google-Smtp-Source: ABdhPJw/SzVNV/DTty8lHNTUmF68J0FX3tyEi7nWyRXPIJaq7XAjq2KEOUsDQuL94WSNYffK7IEARg==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr27142757wrn.81.1600241205735;
        Wed, 16 Sep 2020 00:26:45 -0700 (PDT)
Received: from [192.168.1.8] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id y6sm31567954wrn.41.2020.09.16.00.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 00:26:45 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] DVFS support for Venus
To:     Rajendra Nayak <rnayak@codeaurora.org>, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <1598970026-7199-1-git-send-email-rnayak@codeaurora.org>
 <34ed34bd-90fd-0e84-6020-c487d612ad2f@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <aec87de2-500d-763c-df01-c0daec56b1e2@linaro.org>
Date:   Wed, 16 Sep 2020 10:26:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34ed34bd-90fd-0e84-6020-c487d612ad2f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/20 8:33 AM, Rajendra Nayak wrote:
> 
> On 9/1/2020 7:50 PM, Rajendra Nayak wrote:
>> Rob, can you pick PATCH 1 since its already reviewed by you.
>> Stan, Patch 2 and 3 will need to be picked by you and they both have
>> your ACKs
> 
> Rob/Stan, any plans to get the patches merged for 5.10?

2/5 and 3/5 are queued up for v5.10 through media tree.

> 
>> Patch 4 and 5 will need to be merged via the qcom tree once we have
>> them reviewed.
>>
>> v6: No changes, rebased on 5.9-rc3
>>
>> v5: Fixed the opp-tables (patch 4/5) to avoid -ERANGE from
>> dev_pm_opp_set_rate
>>
>> v4: Moved code from probe/remove/runtime_suspend into
>> different pm_ops callbacks
>>
>> v3: Renamed the optional power domain as cx
>>
>> v2: Fixed up the labels of OPP nodes in patch 4
>>      Included the bindings update patch as part of this series,
>>      a resend of https://lore.kernel.org/patchwork/patch/1241077/
>>
>> These patches add DVFS support for Venus
>>
>> Rajendra Nayak (5):
>>    dt-bindings: media: venus: Add an optional power domain for perf
>>      voting
>>    media: venus: core: Fix error handling in probe
>>    media: venus: core: Add support for opp tables/perf voting
>>    arm64: dts: sdm845: Add OPP tables and power-domains for venus
>>    arm64: dts: sc7180: Add OPP tables and power-domains for venus
>>
>>   .../bindings/media/qcom,sc7180-venus.yaml          |  6 +-
>>   .../bindings/media/qcom,sdm845-venus-v2.yaml       |  6 +-
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi               | 35 +++++++-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 +++++++++-
>>   drivers/media/platform/qcom/venus/core.c           | 17 ++--
>>   drivers/media/platform/qcom/venus/core.h           |  5 ++
>>   drivers/media/platform/qcom/venus/pm_helpers.c     | 92
>> ++++++++++++++++++++--
>>   7 files changed, 183 insertions(+), 18 deletions(-)
>>
> 

-- 
regards,
Stan
