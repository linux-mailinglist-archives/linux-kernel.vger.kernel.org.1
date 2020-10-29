Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B229F0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgJ2QDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725824AbgJ2QDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603987403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOasBam5gXvdPPyM9scWn8lcoOXB0UukZC1GOkaCgrA=;
        b=XoEoMxKHG6JkNAn9mJOnJIbX5PwDN+BGYiGejMC+1hYrfhngMakCvbU1sXSNh1zyjxXAfB
        yvQVzyoLIWaC5mL/d5yEkROkozz1vJajgEn2o9+nNmaTdiczLOQQ96vilSGOghf6fdLEgM
        jzy+V1WJBjgxop2D7zERVsnAERqDspc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-rg5Gb23gNO2hn6XbMECMaw-1; Thu, 29 Oct 2020 12:03:21 -0400
X-MC-Unique: rg5Gb23gNO2hn6XbMECMaw-1
Received: by mail-ed1-f69.google.com with SMTP id u12so1350812edi.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uOasBam5gXvdPPyM9scWn8lcoOXB0UukZC1GOkaCgrA=;
        b=gwwUyNHQW8iHTItjxqOMDgSNGKXYuxbXBK5SGvewQHA9RWW391vjdv6Ix1P13U8wce
         aq82hT0qD19emiIWmhdL0u2vt0VuQz2qAOM+Wbr2uZ9Yc83gGYciKjShw0rG19My9B4c
         Sx/ESCTYNpNFaxPHRWviU+N09uI43uGZ5Lu9PQmlCJ+tuzsqJSly4DpnJUbz2b+lXJnt
         jxN9FAu6+rSN0hGKrSaCPke/3XuKwIJ+ETDD8szBYXlqZsoKU6H362sAtcbhiUHpO9UT
         03qOvOUjP+os/F5/E7NDkHTuPh2ycmV7UR12XOvxoB+mnrYkrh2Np2AYFeXNLmfuKMGC
         BXNg==
X-Gm-Message-State: AOAM533DhQZ//qSJdPkxqGGFVc2TQ8gJ7JVWwoj4b/axj5yU1+Orb7LM
        mqL4C8iE7dZ/26CS+2BFXq1XVZNQKwEXXVD8yPeXNbh4gHKcQq6qNTK4SBU5l+s7x1L1KeHzalH
        Febl8aMaURKf1UbOk5H9NLCuv
X-Received: by 2002:a50:f190:: with SMTP id x16mr3457797edl.292.1603987399721;
        Thu, 29 Oct 2020 09:03:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFUhd3qUcLDQTPQgyVyZlDEFRb12fWwjdMuW58utoTfR7ZjAeL6gRI9dXv6/xZdlYXP0Mf5w==
X-Received: by 2002:a50:f190:: with SMTP id x16mr3457780edl.292.1603987399513;
        Thu, 29 Oct 2020 09:03:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id pw17sm1711891ejb.116.2020.10.29.09.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:03:18 -0700 (PDT)
Subject: Re: [PATCH] power: supply: olpc_battery: remove unnecessary
 CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 PLATFORM DRIVERS - ARCH" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20201029074100.225806-1-coiby.xu@gmail.com>
 <5350ef53-cf70-c4b6-cdf8-5738e9d4b10a@redhat.com>
 <20201029105941.i2kr2424wnrgtvz5@Rk>
 <2c09e34a-3312-628e-c9cd-518e9f58efb4@redhat.com>
 <20201029141646.sijo6iuj44ekytg7@Rk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e615dc68-31ea-6469-8017-a9886fcc6f6e@redhat.com>
Date:   Thu, 29 Oct 2020 17:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029141646.sijo6iuj44ekytg7@Rk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/20 3:16 PM, Coiby Xu wrote:
> On Thu, Oct 29, 2020 at 12:09:23PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 10/29/20 11:59 AM, Coiby Xu wrote:
>>> Hi Hans,
>>>
>>> Thank you for reviewing this patch!
>>>
>>> On Thu, Oct 29, 2020 at 11:04:36AM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 10/29/20 8:41 AM, Coiby Xu wrote:
>>>>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>>>>
>>>> No it does not, when CONFIG_PM_SLEEP is not set then the
>>>> SET_SYSTEM_SLEEP_PM_OPS macro which SIMPLE_DEV_PM_OPS uses
>>>> is a no-op, so nothing will reference xo15_sci_resume leading to
>>>> a compiler warning when CONFIG_PM_SLEEP is not set.
>>>>
>>>> You could drop the ifdef and add __maybe_unused to the definition
>>>> of xo15_sci_resume, but that feels like needless churn, best to
>>>> just keep this as is IMHO.
>>>>
>>>
>>> Actually, this is a tree-wide change by some semi-automation scripts.
>>> Thank you for pointing out the issue to prevent me from releasing
>>> another ~150 emails to flood other mailing lists.
>>>
>>> Currently there are 929 drivers has device PM callbacks,
>>>
>>> $ grep -rI "\.pm = &" --include=*.cÃ‚Â  ./|wc -l
>>> 929
>>>
>>> I put all files having device PM callbacks into four categories
>>> based on weather a file has CONFIG_PM_SLEEP or PM macro like
>>> SET_SYSTEM_SLEEP_PM_OPS, here are the statistics,
>>> Ã‚Â  1. have both CONFIG_PM_SLEEP and PM_OPS macro: 213
>>> Ã‚Â  2. have CONFIG_PM_SLEEP but no PM_OPS macro: 19
>>> Ã‚Â  3. have PM macro but not CONFIG_PM_SLEEP: 347
>>> Ã‚Â  4. no PM macro or CONFIG_PM_SLEEP: 302
>>>
>>> Some drivers which have PM macro but not CONFIG_PM_SLEEP like
>>> sound/x86/intel_hdmi_audio.c indeed use __maybe_unused to eliminate
>>> the compiling warning. In 2011, there's a patch proposing to remove
>>> ONFIG_PM altogether but an objection was turning CONFIG_PM on would
>>> increase the kernel size [1]. So __maybe_unused also have this issue.
>>
>> I would expect the compiler to remove the unused function, it knows
>> it is unused, that is why __maybe_unused is necessary to suppress
>> the warning and compilers are pretty smart and agressive wrt remove
>> unnecessary code these days.
>>
> Then __maybe_unused is a good solution and there's also convincing
> reason to prefer __maybe_unused over CONFIG_PM_SLEEP according to
> Arnd Bergmann [2],

Ok, I would be happy to merge a patch for this which drops the #ifdef-s
and adds a __maybe_unused.

Regards,

Hans

