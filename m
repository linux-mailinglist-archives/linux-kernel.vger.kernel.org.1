Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8529EDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgJ2ORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2ORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:17:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41402C0613CF;
        Thu, 29 Oct 2020 07:17:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so2452702pfp.5;
        Thu, 29 Oct 2020 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ytuRxNZdgkLGRPxJF2rw5mbT3gFpajw5TIm3gHQqiJo=;
        b=XdeWbCINGEdba7uOVNQRHfMZTA/odLv9Vz2tMDkoYRg31MmAn/59gMfJ3zt0/Dlnsk
         HUO+H5HxfA7KTbKcDiY5peD/9jK7g4dx4oeoeKUtyCMaHyDlHOyYawSc9fRSXxu+NLqg
         de/v9oWgrEf42xpQ21vUklfHPw36NDNZU18c1/3apPOEwObLF5GyHq5n6HDWwULxV6q4
         wTXCUKFL5MhxZEAMibi4dc4fKwT99bg498D6xq+lUqAlHQaZsu5psNSdD8dhJ81txKZs
         /7u5A3nPojhTQV7s3MS0sBn6QVCZBCF1YLTnsh686Wegi8SssUuAaJgXKNFCMZv5zYap
         whAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ytuRxNZdgkLGRPxJF2rw5mbT3gFpajw5TIm3gHQqiJo=;
        b=NY7JHLXa/a3fkB7BUCzb1gr6kwPtbRqxzaJrXfZxC+AEEIde46VEL36VmdpxljcMPS
         Uv+lk2PGTqKK45LvRF6Vhx2Ncs8A+yT+X67N3p8K5xPaFn+UE4/EZBfm4BHFZHCxkhzk
         rIixr5+47LVItKpzeBG09bXEq7q9XGI51Fj5n/lltcB3AesaEKmf0XGiXAJt6TUJFyIn
         sHAjKOamX6TkOrK8GdxysNAPZjrUgxsVo+Rwaa+HDzFejSSCYilPtFQn5gY9/cyUnUwL
         vMeobHwXmUg3wK2QOzUMoyUcmj8tz1+JgGvIWVsfk5idtMqjwZewiyRMJOrf2tGtyBQz
         TxLg==
X-Gm-Message-State: AOAM532eQUHgsyPluGVBsBRBaDkXsOhWogyO52JM61ZIiO5A9aqRTjJo
        qnqtEdRJS2CMa5CEPI9xNN8=
X-Google-Smtp-Source: ABdhPJwCGILq8MQ3I5UteyhOUkF5GConTgqZyol3WJBV6tL1ZERZzAWxHE6rJdTdiYqFECUGvLPTBA==
X-Received: by 2002:a62:585:0:b029:163:b618:92c1 with SMTP id 127-20020a6205850000b0290163b61892c1mr4622866pff.41.1603981032659;
        Thu, 29 Oct 2020 07:17:12 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id a11sm3153820pfn.125.2020.10.29.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:17:12 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 22:16:46 +0800
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH] power: supply: olpc_battery: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201029141646.sijo6iuj44ekytg7@Rk>
References: <20201029074100.225806-1-coiby.xu@gmail.com>
 <5350ef53-cf70-c4b6-cdf8-5738e9d4b10a@redhat.com>
 <20201029105941.i2kr2424wnrgtvz5@Rk>
 <2c09e34a-3312-628e-c9cd-518e9f58efb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c09e34a-3312-628e-c9cd-518e9f58efb4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:09:23PM +0100, Hans de Goede wrote:
>Hi,
>
>On 10/29/20 11:59 AM, Coiby Xu wrote:
>> Hi Hans,
>>
>> Thank you for reviewing this patch!
>>
>> On Thu, Oct 29, 2020 at 11:04:36AM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/29/20 8:41 AM, Coiby Xu wrote:
>>>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>>>
>>> No it does not, when CONFIG_PM_SLEEP is not set then the
>>> SET_SYSTEM_SLEEP_PM_OPS macro which SIMPLE_DEV_PM_OPS uses
>>> is a no-op, so nothing will reference xo15_sci_resume leading to
>>> a compiler warning when CONFIG_PM_SLEEP is not set.
>>>
>>> You could drop the ifdef and add __maybe_unused to the definition
>>> of xo15_sci_resume, but that feels like needless churn, best to
>>> just keep this as is IMHO.
>>>
>>
>> Actually, this is a tree-wide change by some semi-automation scripts.
>> Thank you for pointing out the issue to prevent me from releasing
>> another ~150 emails to flood other mailing lists.
>>
>> Currently there are 929 drivers has device PM callbacks,
>>
>> $ grep -rI "\.pm = &" --include=*.c  ./|wc -l
>> 929
>>
>> I put all files having device PM callbacks into four categories
>> based on weather a file has CONFIG_PM_SLEEP or PM macro like
>> SET_SYSTEM_SLEEP_PM_OPS, here are the statistics,
>>   1. have both CONFIG_PM_SLEEP and PM_OPS macro: 213
>>   2. have CONFIG_PM_SLEEP but no PM_OPS macro: 19
>>   3. have PM macro but not CONFIG_PM_SLEEP: 347
>>   4. no PM macro or CONFIG_PM_SLEEP: 302
>>
>> Some drivers which have PM macro but not CONFIG_PM_SLEEP like
>> sound/x86/intel_hdmi_audio.c indeed use __maybe_unused to eliminate
>> the compiling warning. In 2011, there's a patch proposing to remove
>> ONFIG_PM altogether but an objection was turning CONFIG_PM on would
>> increase the kernel size [1]. So __maybe_unused also have this issue.
>
>I would expect the compiler to remove the unused function, it knows
>it is unused, that is why __maybe_unused is necessary to suppress
>the warning and compilers are pretty smart and agressive wrt remove
>unnecessary code these days.
>
Then __maybe_unused is a good solution and there's also convincing
reason to prefer __maybe_unused over CONFIG_PM_SLEEP according to
Arnd Bergmann [2],

> > By and large, drivers handle this by using a CONFIG_PM_SLEEP ifdef.
> >
> > Unless you can make an extremely convincing argument why not to do
> > so here, I'd like you to handle it that way instead.
>
> [adding linux-pm to Cc]
>
> The main reason is that everyone gets the #ifdef wrong, I run into
> half a dozen new build regressions with linux-next every week on
> average, the typical problems being:
>
> - testing CONFIG_PM_SLEEP instead of CONFIG_PM, leading to an unused
>   function warning
> - testing CONFIG_PM instead of CONFIG_PM_SLEEP, leading to a build
>   failure
> - calling a function outside of the #ifdef only from inside an
>   otherwise correct #ifdef, again leading to an unused function
>   warning
> - causing a warning inside of the #ifdef but only testing if that
>   is disabled, leading to a problem if the macro is set (this is
>   rare these days for CONFIG_PM as that is normally enabled)
>
> Using __maybe_unused avoids all of the above.

>Regards,
>
>Hans
>

[2] https://lore.kernel.org/patchwork/comment/919944/

--
Best regards,
Coiby
