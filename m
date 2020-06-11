Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306F1F6D48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgFKSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgFKSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:14:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6EC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:14:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so5301995qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RrEjUNrF+LcCoD0q18bBvOWgotZ/arY1E00Ez8SFuB4=;
        b=UzXvItjTl3Sefqh6cZiN+Ut11UgSR1b35+nr4uiV9gw8JqLFSyk5Qaxk51WS0lae6b
         EGo+sU1PaqEUFzZLA0N0uOqsZ11MlncQf2QBgc6SVRK8hPHuhywF1Jd+V4P6ZiAqrx5F
         LBgCrh9WBYtAYTsjfVyR8IAkb/M2WjuqXX9PyhaWe3UjKTT6GAxQknvGSEwf+5aziqbc
         VoHSXsHxF3GLKL5wQS1JbsXMCudYG5KoWybQLVbdOy72APLSYnzsf+dNJpvzZeLIrTXd
         ejXygMg9o2jUq7G3IIM8PYEZqXmu/Derhzc//dPwBbWp6135oXbL3IqqjkY0emf0C46g
         GujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RrEjUNrF+LcCoD0q18bBvOWgotZ/arY1E00Ez8SFuB4=;
        b=jE5ghZKCo82yHYd49qWvVfZTRvSkg4xOLja1QRtYAzapWaq4Z0Z3GlH79Zuq0kw4hO
         EXuSqzRYc3n5s0bkfJKjQ3eEI0Po61u4oFVI2H6XFHo0d21AWzBGeQ8Kbd33fp+U7z1+
         rR3Horez8QgkUGIBB1tsbl0rOTB6zVVC5JGhYxCVONkvXN6XrU4WqdbI3/tckfj6qCjt
         E0jmrK+OwbosmUhGba0wkXivBAAa1k6jeIRns+H1E+bjD8iOIpmzFlonioMHg6dR3Vx5
         6VpysUqu1KRG6epKGBa8lajX8OWrwlqwDeQ7KX90esZ3mdKmV27yF2iCMBxLPL7QQoCK
         XM/A==
X-Gm-Message-State: AOAM532VTZWEmRrSo58uJ+yVCw5CseD5iUGbIcNTxE8hn94OmZ3oniH6
        bmnfgEQzhUH76QeRCvznOMkaFw==
X-Google-Smtp-Source: ABdhPJwChoiZB30NjiO8RzdLTNVa5pI98NAl3sOJ9f5Y3i3mQwDQIBhUvM9Foy/EiU6QCoNYO2d2NA==
X-Received: by 2002:ac8:3551:: with SMTP id z17mr9696644qtb.139.1591899263236;
        Thu, 11 Jun 2020 11:14:23 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g5sm3196208qta.46.2020.06.11.11.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 11:14:22 -0700 (PDT)
Subject: Re: [PATCH 0/6] arm64: dts: qcom: smmu/USB nodes and HDK855/HDK865
 dts
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200604135221.GH16719@Mani-XPS-13-9360>
 <20200611180503.GA22890@Mani-XPS-13-9360>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <cf3ccc5f-cdc5-71f5-60e0-7ae44952c667@marek.ca>
Date:   Thu, 11 Jun 2020 14:14:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200611180503.GA22890@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 2:05 PM, Manivannan Sadhasivam wrote:
> On Thu, Jun 04, 2020 at 07:22:21PM +0530, Manivannan Sadhasivam wrote:
>> Hi,
>>
>> On Sat, May 23, 2020 at 10:38:06PM -0400, Jonathan Marek wrote:
>>> Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.
>>>
>>
>> I've tested this series on an SM8250 based board and able to get Type C (USB0)
>> working. There are also couple of Type A ports (USB1) on that board behind a
>> USB hub. It is probing fine but I don't see any activity while connecting a
>> USB device. Will continue to debug and once I get them working, I'll add my
>> Tested-by tag.
>>
> 
> So it turned out that I forgot to enable one regulator which kept the USB hub
> powered down. After enabling that, both Type A ports are working. Hence,
> 
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 

Thanks for testing it. Your Tested-by only applies to the relevant 
patches (patches 2 and 4 in this version) right? And can I also add your 
Tested-by tag to my other series 
(https://patchwork.kernel.org/cover/11567095/) which this depends on?

>> Thanks,
>> Mani
>>
>>> Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
>>> few changes. Notably, the HDK865 dts has regulator config changed a bit based
>>> on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).
>>>
>>> Jonathan Marek (6):
>>>    arm64: dts: qcom: sm8150: add apps_smmu node
>>>    arm64: dts: qcom: sm8250: add apps_smmu node
>>>    arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
>>>    arm64: dts: qcom: sm8250: Add USB and PHY device nodes
>>>    arm64: dts: qcom: add sm8150 hdk dts
>>>    arm64: dts: qcom: add sm8250 hdk dts
>>>
>>>   arch/arm64/boot/dts/qcom/Makefile       |   2 +
>>>   arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 461 ++++++++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/sm8150.dtsi    | 180 +++++++++
>>>   arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 454 +++++++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/sm8250.dtsi    | 287 +++++++++++++++
>>>   5 files changed, 1384 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8150-hdk.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-hdk.dts
>>>
>>> -- 
>>> 2.26.1
>>>
