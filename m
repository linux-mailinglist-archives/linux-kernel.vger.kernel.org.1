Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268251F4790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgFITwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgFITwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:52:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365EC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:52:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c14so22071106qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJVzflu3n0uAFQ+8fe+/LB9PjLnVhJPcHxR1Rq6fzmQ=;
        b=i6YB8Qz988IiKK3aivE1cmhvyGVwPo82sEs4IqmBUcpVUf+K6dMCKKO2FKuT1B1XtT
         laQrON3xYLZBOKA/v79TwV6Pdap89oIeGs7xMCUAEu+VxmAXCAUeFXl6Im9jV4CwRFHL
         a0L1bnuyZgnyJoS0Zj3+LHnF/RPm+h13m1T9wpjTcVk7UOXXfdvIEfr38e80A8FcvqCC
         te3m2UGli64Qg6SVog4icTymbN2vngxlkzZmqVJlhk7poXdnrz/NJ52WHY7oVmqi3u+7
         V86N0wpSXtv/69KQ5soyepbiVyxZiq/MrxI4EvyQvqhWIJzOmd/5EsICg1v8qBoK/Y8V
         qp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJVzflu3n0uAFQ+8fe+/LB9PjLnVhJPcHxR1Rq6fzmQ=;
        b=XuIDUsZGMeV2E4hfHUN2qIZIOPQQ0VaIJJyAtvldHdg/lJoJ/F6K9WHc5Ho1sBZsLa
         eg1yd4LI87j8yA4R6VcK4xYqGWrRwx6dS7dKdILMw7x2QdarpyDMRwbgLhvVOiKqW8tw
         VYsqJC9MnxED13Jx5rocCk2eiWr6uNzcdAV+SAK5G+E1lyz5YiPw8WZWg3no5pZsatMR
         OQ9DP4vaxXa0B7dEmyyzkU+PfM4fxMg2bRc8OpBQNaGw7ByGC7ldnnIov2tcCacS6+Wj
         852UH4FEF3oVIdEfGJbzGGH+JqRpFjAbTIBeOXc83gjcB+nwOwXjca0Wb8uqyYIvkpDF
         itVw==
X-Gm-Message-State: AOAM533UlRYT+aZj5wgvXfdsMX3eLQxySw8iSdCnGAvAgtldhfsM3Ux9
        3XSPbeZ096dnOnthU3KBOEHUXLKihJiJOw==
X-Google-Smtp-Source: ABdhPJzTu4J+zNTT+apFn02pIcjAV1cLOi8wPlDl8Mt++CEUwZ+BUKZ8CcU+YKAZttH1le37hFXHjQ==
X-Received: by 2002:ae9:dcc2:: with SMTP id q185mr29173384qkf.104.1591732334838;
        Tue, 09 Jun 2020 12:52:14 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id w94sm10850306qte.19.2020.06.09.12.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:52:14 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8150: add apps_smmu node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-2-jonathan@marek.ca>
 <20200529025246.GV279327@builder.lan>
 <d0908f34-a698-3449-35b9-7a98e9641295@marek.ca>
 <20200529031520.GA1799770@builder.lan>
 <00b8f010-1ae1-45b2-8dd0-a1b582861a2e@marek.ca>
 <20200529034231.GB1799770@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <8d7cca83-43e4-8889-ac7c-ce3393dc1f70@marek.ca>
Date:   Tue, 9 Jun 2020 15:52:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200529034231.GB1799770@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:42 PM, Bjorn Andersson wrote:
> On Thu 28 May 20:34 PDT 2020, Jonathan Marek wrote:
> 
>> On 5/28/20 11:15 PM, Bjorn Andersson wrote:
>>> On Thu 28 May 20:02 PDT 2020, Jonathan Marek wrote:
>>>
>>>>
>>>>
>>>> On 5/28/20 10:52 PM, Bjorn Andersson wrote:
>>>>> On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:
>>>>>
>>>>>> Add the apps_smmu node for sm8150. Note that adding the iommus field for
>>>>>> UFS is required because initializing the iommu removes the bypass mapping
>>>>>> that created by the bootloader.
>>>>>>
>>>>>
>>>>> Unrelated to the patch itself; how do you disable the splash screen on
>>>>> 8150? "fastboot oem select-display-panel none" doesn't seem to work for
>>>>> me on the MTP - and hence this would prevent my device from booting.
>>>>>
>>>>> Thanks,
>>>>> Bjorn
>>>>>
>>>>
>>>> I don't have a MTP, but on HDK855, "fastboot oem select-display-panel none"
>>>> combined with setting the physical switch to HDMI mode (which switches off
>>>> the 1440x2560 panel) gets it to not setup the display at all (just the
>>>> fastboot command isn't enough).
>>>>
>>>
>>> Okay, I don't think we have anything equivalent on the MTP, but good to
>>> know.
>>>
>>>> With HDK865 though that doesn't work and I have a hack to work around it
>>>> (writing 0 to INTF_TIMING_ENGINE_EN early on in boot will stop video mode
>>>> scanout and it won't crash).
>>>>
>>>
>>> Then we need to sort this out in the arm-smmu driver before we can
>>> enable the apps_smmu node on 8250. I did receive some guidance from Will
>>> on the subject and have started looking into this.
>>>
>>
>> That's annoying because a lot depends on apps_mmu. GPU is an exception with
>> its own MMU but pretty much everything else uses apps_smmu (does it make
>> sense to add USB nodes if it won't work without apps_smmu?) Is this
>> something that will get resolved soon?
>>
> 
> We have a number of boards where this is becoming a critical issue, so
> we better find an acceptable solution to this very soon.
> 

I kept the sm8250 apps_smmu patch in V2:

I am now using a modified xbl with my HDK865, with a hack to make it use 
"none" for the display override string, and that allows me to use these 
patches without any kernel hack.

The "fastboot oem select-display-panel none" not working to disable 
bootloader enabled display definitely seems like a bug (I have not tried 
to debug it, but everything I've seen indicates that it should be 
disabling it). I don't think we should be holding this back based on a 
bootloader bug.

> Regards,
> Bjorn
> 
>> FWIW, I have another sm8250 board which does not need the workaround (its
>> bootloader does not set up the display). AFAIK modifying the bootloader to
>> not set up any display is a trivial modification (assuming that's an
>> option).
>>
>>> Thanks,
>>> Bjorn
>>>
>>>>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/sm8150.dtsi | 91 ++++++++++++++++++++++++++++
>>>>>>     1 file changed, 91 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>>>> index a36512d1f6a1..acb839427b12 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>>>> @@ -442,6 +442,8 @@ ufs_mem_hc: ufshc@1d84000 {
>>>>>>     			resets = <&gcc GCC_UFS_PHY_BCR>;
>>>>>>     			reset-names = "rst";
>>>>>> +			iommus = <&apps_smmu 0x300 0>;
>>>>>> +
>>>>>>     			clock-names =
>>>>>>     				"core_clk",
>>>>>>     				"bus_aggr_clk",
>>>>>> @@ -706,6 +708,7 @@ usb_1_dwc3: dwc3@a600000 {
>>>>>>     				compatible = "snps,dwc3";
>>>>>>     				reg = <0 0x0a600000 0 0xcd00>;
>>>>>>     				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +				iommus = <&apps_smmu 0x140 0>;
>>>>>>     				snps,dis_u2_susphy_quirk;
>>>>>>     				snps,dis_enblslpm_quirk;
>>>>>>     				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>>>>>> @@ -742,6 +745,94 @@ spmi_bus: spmi@c440000 {
>>>>>>     			cell-index = <0>;
>>>>>>     		};
>>>>>> +		apps_smmu: iommu@15000000 {
>>>>>> +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>>>>>> +			reg = <0 0x15000000 0 0x100000>;
>>>>>> +			#iommu-cells = <2>;
>>>>>> +			#global-interrupts = <1>;
>>>>>> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +		};
>>>>>> +
>>>>>>     		remoteproc_adsp: remoteproc@17300000 {
>>>>>>     			compatible = "qcom,sm8150-adsp-pas";
>>>>>>     			reg = <0x0 0x17300000 0x0 0x4040>;
>>>>>> -- 
>>>>>> 2.26.1
>>>>>>
