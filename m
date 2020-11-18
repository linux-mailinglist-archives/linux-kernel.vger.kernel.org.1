Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9218D2B852D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKRT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgKRT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:58:21 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AFC061A48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:58:21 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so3043776qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VjaM+f+QFZwLQKDZ4ZTmgMDJ8f9Az2SK5T/knBnywXY=;
        b=jnFgYG5gVAJ2oms8z2m6ffdBRZV6U9odnUVxDlqLkvQyQKuTkBCManYKf5qOsmXaiZ
         ImN2Ps4AJtf/Twj313+ljstfydDjPN27wPf/9SXYD2XRPbdGRvYr+Im9fT0cfBHqI3wY
         cxx4b6qPUN4b9eE8RXxYkRkTD8BsO02dTTJkAbsJ7zkuD2RFDHXUjAPjkCNlYEaO1A16
         tAIITkoK+kceH+xz/NwU12Cje4zz7POeYTJJyrZ7NDVmlfLJH7naXO4jT8j6shlt2Dn5
         O+3oZcejWMrWsYbPkT/KCAXT6+UoUbADMXlpBhWHD//VTQ8EwzWlmJcOQDpLvhkoT06O
         1IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VjaM+f+QFZwLQKDZ4ZTmgMDJ8f9Az2SK5T/knBnywXY=;
        b=ZId4YpyflFqSEMF6TkxbAKPhm93NTqaHQ0rPNxTOyZBtFKI4TTrROzu5q5m9pO8rOy
         Nwb8Zr+sEnCDMiyUWT7FCpb/rkTbP24+kOO5gN6OTh3c3YzPZBwb6QvDvkXdWrshFreH
         xxVSo4KdZ+w7QuZ9dK3Altn3uiQ1oSmy+cN9mgkhGP/v33uBtTp/l8iqOEqbBFrP3Y8v
         fyAjyg5drsTKOHV6gBtCkQKX4I38VBr2T8Be60GQuizpNMmG/sHSnivtl1CWqwobL20k
         6RAK6uK8hFmSzIEqd/ppK7swNRwtZG2l61PSrHGb0uGzfmLRDQ4ZWg2mIfY4PiGNJJuK
         sfEw==
X-Gm-Message-State: AOAM532MwYmVSNqOQvl3J6obsfAz1+LlZt7IpnG/5hhMmZRieTMwVXqM
        mBKLBWB1cTsHAozSxKZt3ptKOg==
X-Google-Smtp-Source: ABdhPJzAyijtIgkU8ysmO8Yu8ExUdE14ZVR8R9jKKJNAARHrhWd4xaNIouNLKbqBAPiV4QUesrvZbQ==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr7020809qkv.229.1605729500701;
        Wed, 18 Nov 2020 11:58:20 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id m204sm7745048qke.117.2020.11.18.11.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 11:58:19 -0800 (PST)
Subject: Re: [PATCH 5/6] dts:qcom:sdm845: Add dt entries to support crypto
 engine.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20201117134714.3456446-1-thara.gopinath@linaro.org>
 <20201117134714.3456446-6-thara.gopinath@linaro.org>
 <20201118041051.GF8532@builder.lan>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <36532dfd-4e13-79b2-d29f-d7684f638b22@linaro.org>
Date:   Wed, 18 Nov 2020 14:58:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118041051.GF8532@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/20 11:10 PM, Bjorn Andersson wrote:
> On Tue 17 Nov 07:47 CST 2020, Thara Gopinath wrote:
> 
>> Add crypto engine (CE) and CE BAM related nodes and definitions to
>> "sdm845.dtsi".
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 30 ++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 40e8c11f23ab..b5b2ea97681f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -2138,6 +2138,36 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>>   			};
>>   		};
>>   
>> +		cryptobam: dma@1dc4000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0 0x01dc4000 0 0x24000>;
>> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&rpmhcc RPMH_CE_CLK>;
>> +			clock-names = "bam_clk";
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +			qcom,controlled-remotely = <1>;
>> +			iommus = <&apps_smmu 0x704 0x1>,
>> +				 <&apps_smmu 0x706 0x1>,
>> +				 <&apps_smmu 0x714 0x1>,
>> +				 <&apps_smmu 0x716 0x1>;
> 
> Can you confirm that this can't be written as:
> 
> iommus = <&apps_smmu 0x704 0x3>,
> 	 <&apps_smmu 0x714 0x3>;
> 
> (and same below).

Hi Bjorn,

Thanks for the reviews. Yes, I can confirm that the above does not work.
The tests hang. I will fix rest of your comments and post v2.

-- 
Warm Regards
Thara
