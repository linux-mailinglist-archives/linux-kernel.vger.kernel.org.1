Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED35A2B03F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgKLLeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgKLLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:34:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9415C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:34:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so5641156wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8IcQ5dN+qIoB/87zjJ/veTyRM/TV9n4JzhwtTPqINgE=;
        b=n9pN8t2keRJdmcvRv8toZQGLOstc8D7l3KgaXn/I8iFBtpvIYtJvTNsrkGZB0kiJHg
         cQnZaWx7Ztnzl21hfTTcnMN8c3sdYHayOrcYvVvi8fnfTBfhrqXnrIgi5zNbJDc7d6s6
         TbGubdq1jt4LFKEI2guY2pOYKHVkPPusFhwJQ7YVhaNfu48QWsV8ATCTVS5bhVnBYvKy
         6wiKq12U2x79IugRiJlFhcEC6McsZpK5GFQwKKbDnPTsBSL3/HNEfsEsUHP7vh+NeddU
         UR/AE46uc5F1ydps2WYRqGiwpKgcHYT0dgEwQpmnA+flosQaRE6xLwiXL0pCl2onZC9W
         Cnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8IcQ5dN+qIoB/87zjJ/veTyRM/TV9n4JzhwtTPqINgE=;
        b=Kz/twbq5PBLT44KwHGZ28OER32HKMUd+JVVyjw7kSlVIrjnnujrSQs2w/T7NP1tFAm
         gxpt5RjfVUuAV+ic2cWBWvmcLzbjoP9nYwwTo48FI7SxEmTbZ3UllvwfaYGSZ09JSLdS
         KrOdF7l1Gi2qaGIpCD4sIckgFC4mIR0RGB7IJoApebsbM8Oi2kRttfQObpvgxL/7FCeW
         +wuqBataiOg3mRMjs8tS+k2Jlo6sX6xmqSjpVqh3/6I0/y4ZsQRHhS1KwQHIIx4ML8Jl
         LPw0U9kztAm3ymZPvCFcFHIc39bGd/KTVjIVBUnruA85Y5eB+dQVJUVtYEujWy7a7fjc
         Xrpg==
X-Gm-Message-State: AOAM531ySyu4SOi5hEyiFbMmH2TCYnShjy7pbr1pI+4Oqu8PijUR0Ka1
        qrP9myOEiz9HJ/0PDL12RqzGNJPCqgHYQg==
X-Google-Smtp-Source: ABdhPJwvs9o1xVMaj5BU81F+aQVl3mHIuJ3FT1+tXsmFoITlPauRve/uqEGAu8PlqS55wuAUihVQ5w==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr25558395wrm.403.1605180850011;
        Thu, 12 Nov 2020 03:34:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id g4sm5043800wrp.0.2020.11.12.03.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:34:09 -0800 (PST)
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
To:     Andres Freund <andres@anarazel.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200115184415.1726953-1-andres@anarazel.de>
 <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
 <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
 <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
 <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
Date:   Thu, 12 Nov 2020 12:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2020 21:21, Andres Freund wrote:
> Hi,
> 
> On 2020-01-16 11:41:34 -0800, Srinivas Pandruvada wrote:
>> On Thu, 2020-01-16 at 10:42 -0800, Andres Freund wrote:
>>> Hi,
>>>
>>> On 2020-01-16 05:53:13 -0800, Srinivas Pandruvada wrote:
>>>> On Wed, 2020-01-15 at 10:44 -0800, Andres Freund wrote:
>>>>> I noticed that I couldn't read the PCH temperature on my
>>>>> workstation
>>>>> (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but
>>>>> had to
>>>>> go
>>>>> through IPMI. Looking at the data sheet, it looks to me like the
>>>>> existing intel PCH thermal driver should work without changes for
>>>>> Lewisburg.
>>>> Does the temperature reading match with what you read via IPMI?
>>>
>>> It does:
>>>
>>> root@awork3:~# ipmitool sdr|grep ^PCH
>>> PCH Temp         | 58 degrees C      | ok
>>>
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/type
>>> pch_lewisburg
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
>>> 58000
>>>
>>> And if I generate some load, it rises for both:
>>> root@awork3:~# ipmitool sdr|grep ^PCH
>>> PCH Temp         | 60 degrees C      | ok
>>> andres@awork3:~$ cat /sys/class/thermal/thermal_zone0/temp
>>> 60000
>>>
>> Thanks for the test.
>>
>> Rui can add his ACK.
> 
> Ping? Looks like this got lost somewhere?

It does no longer apply, is it possible to do a respin ?

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
