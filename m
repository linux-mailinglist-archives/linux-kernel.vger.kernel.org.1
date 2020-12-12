Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C22D8744
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439255AbgLLP0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 10:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbgLLPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 10:25:59 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769EFC061793
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 07:25:19 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f14so8736628qto.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dd5IDMk6HdEREYAjvJvG5jiNGlnVzol4x0feAnkRhko=;
        b=KHc7AYqhfFVLFwrn+eDW5521F5NUnXutf1Ope0Jsb1IBwZTIuBiIOQRFxjEP2TkSJt
         wLRhwVXNI6i/ylMShHXMJSp5N8YwROF6m/vLotUy/6PzCoVV1lzjg4L9ODgpbOzIBQgY
         Uvgn+t/c1+ZgjKHisaL+DkFa5APpmleSHPjAaIBQOjAdCLP1JxwtbNeW3TDVnQtMS7Ff
         Qc7nR/6t+We9nhAq3rFRnXQ8FX/64uJZITvq4hIiIVxtMhwTsiFtoxSbCArly5us+7wW
         lvYEhGynIEtS+/1qvajonUNnZx0p8YGDpjQ1J5cosU4LTxKO3Z8u08Bc8LQqxHEW/sMv
         OTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dd5IDMk6HdEREYAjvJvG5jiNGlnVzol4x0feAnkRhko=;
        b=KVhWKptMqtyGyZa4uqSWp/f2Zlq5E4fMDTKvqIdWQx111c7+LoAMBdCR8Cfu24xiV8
         OlpYMbKDeUZzsi+kqQt/DhgLiQPqFGxvyONPAW1N7fIkGVnMQtf8/g4Up+7Q4aTDc+6s
         k67nFP8oaaXYAJysP9tzJIplBF8j6S0QEwX/s/9q9KTjDDnxuC1Q4rYJhoVusgaw7Eb/
         jkCTPd/khH0UbNLBpyCJEhW645SV4LAek9/jZk4BSJBrClnisicGtUwB2F9JMpASywGQ
         vgBaaCTfCTs6c2wO94lfGHAB2Cdaby5l2+arE23xEGMGi1PXXAGd1Cv5OJ/26tGh8vKv
         Vslw==
X-Gm-Message-State: AOAM531WZrulwiszHXzsslO/BgTqXvpHlqJJZ5l0A/c1JTMaibjwxMEH
        JmdDX+DNtlmd8XJcCuVXtOkd0g==
X-Google-Smtp-Source: ABdhPJz4Xc1cCp3qMWuscQSL/Y19MJx0C5m1nmu4gAsk5Tm5+LxeTXzhqTZGG49VCiqpruutfweJhA==
X-Received: by 2002:ac8:5286:: with SMTP id s6mr22799733qtn.22.1607786718459;
        Sat, 12 Dec 2020 07:25:18 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id z10sm9925448qtm.54.2020.12.12.07.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 07:25:17 -0800 (PST)
Subject: Re: [Patch v2 6/6] dt-bindings: crypto: qcom-qce: Add v5.4 to binding
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, sboyd@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20201119155233.3974286-1-thara.gopinath@linaro.org>
 <20201119155233.3974286-7-thara.gopinath@linaro.org>
 <20201207220909.GA918596@robh.at.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <f1babcb8-6017-dd3b-cbb6-9b4334037069@linaro.org>
Date:   Sat, 12 Dec 2020 10:25:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207220909.GA918596@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/20 5:09 PM, Rob Herring wrote:
> On Thu, Nov 19, 2020 at 10:52:33AM -0500, Thara Gopinath wrote:
>> Add compatible string to support v5.4 crypto engine.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/crypto/qcom-qce.txt | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
>> index fdd53b184ba8..ed1ede9c0acc 100644
>> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
>> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
>> @@ -2,7 +2,9 @@ Qualcomm crypto engine driver
>>   
>>   Required properties:
>>   
>> -- compatible  : should be "qcom,crypto-v5.1"
>> +- compatible  : should be
>> +		"qcom,crypto-v5.1" for ipq6018
>> +		"qcom,crypto-v5.4" for sdm845
> 
> An outstanding example of why to use SoC specific compatibles rather
> than versions. Keep v5.1, but use SoC compatibles going forward.

Hi Rob,

Thanks for the review. We have different Soc's using the same version of
the ip. Is it okay to have "qcom,sdm845-crypto", "qcom,crypto-v5.4" amd 
have only "qcom,crypto-<version>" in the driver ?

> 
>>   - reg         : specifies base physical address and size of the registers map
>>   - clocks      : phandle to clock-controller plus clock-specifier pair
>>   - clock-names : "iface" clocks register interface
>> -- 
>> 2.25.1
>>

-- 
Warm Regards
Thara
