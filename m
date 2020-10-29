Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8331729EA22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgJ2LJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbgJ2LJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603969768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulPrPIim///GD383DoMCDOW+6QLsQhCgTfUq3eBfgQQ=;
        b=WCZ1bIbN309DE7mVahBlXKBdvdXgAgilnEDBLazm8JA7NNCEtOSZ31f9cqR1RY73Q6p3RX
        wy6gYd2XCFwuqnlAdnUbhxRWLZOrrrlwB/JLGG3vXS6mfvWwWcgfdj149J3RkJ4CedItjy
        4AeS6rll3ICrwC2lAThmIch5KRtjpWU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Mlw7jyosMWmf_4SXHXggiQ-1; Thu, 29 Oct 2020 07:09:27 -0400
X-MC-Unique: Mlw7jyosMWmf_4SXHXggiQ-1
Received: by mail-ed1-f69.google.com with SMTP id ay19so1008022edb.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulPrPIim///GD383DoMCDOW+6QLsQhCgTfUq3eBfgQQ=;
        b=Eo6zy/IeEeAny6E09PGhO/8pWFTeLe5FZ9iMGSpPyMsXmvIoLxiylIJA9Ns0+rveqQ
         ve/XDaEgjC9o7OYif6MV5dSMN8lbFvP2UVINkyW9PUNb74urbBnGXT3+254g9O4eqUzM
         wbX63ZyiGIhZ9W5kMHwxOxNzkJqWfahpxK0sZeTA+4F/39yvrJaU5lr4Ymqjtv4WsLas
         Cid835su53exz/J8enwHwrihzkMHEwj/2vOF5crAgTsFNG8hXzLm+NiJgpLq6fWLmxsm
         shkoJmKJWuIonycK4odfelttofI2z3NQGr6qT0hN1f/+RqzbtN6rNeQhWawaXscpqzuT
         3OiA==
X-Gm-Message-State: AOAM5300IPFvVrHKRur1ACv4MyR+CBU3V3IJfeeXz0csvQrHcv92IbA1
        KRaDSirl1zHn0oiqY1uytNj45X9lIVzTdmvY4iICZgzSjFvVzAT07dHqJoQs3PtWxB2hN1a748I
        B5dTqhU1Ht/xOn4+Elppqn/kT
X-Received: by 2002:aa7:cad6:: with SMTP id l22mr3373639edt.229.1603969765762;
        Thu, 29 Oct 2020 04:09:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwptOG11t2XxeOqWH7+pGgqpz2Wq37U+PJWlG3uxcg9bfNS61ETmLr1yNHXWpkFr9D1Jo67/w==
X-Received: by 2002:aa7:cad6:: with SMTP id l22mr3373613edt.229.1603969765485;
        Thu, 29 Oct 2020 04:09:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id oz18sm1303970ejb.55.2020.10.29.04.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 04:09:24 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2c09e34a-3312-628e-c9cd-518e9f58efb4@redhat.com>
Date:   Thu, 29 Oct 2020 12:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029105941.i2kr2424wnrgtvz5@Rk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/20 11:59 AM, Coiby Xu wrote:
> Hi Hans,
> 
> Thank you for reviewing this patch!
> 
> On Thu, Oct 29, 2020 at 11:04:36AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 10/29/20 8:41 AM, Coiby Xu wrote:
>>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>>
>> No it does not, when CONFIG_PM_SLEEP is not set then the
>> SET_SYSTEM_SLEEP_PM_OPS macro which SIMPLE_DEV_PM_OPS uses
>> is a no-op, so nothing will reference xo15_sci_resume leading to
>> a compiler warning when CONFIG_PM_SLEEP is not set.
>>
>> You could drop the ifdef and add __maybe_unused to the definition
>> of xo15_sci_resume, but that feels like needless churn, best to
>> just keep this as is IMHO.
>>
> 
> Actually, this is a tree-wide change by some semi-automation scripts.
> Thank you for pointing out the issue to prevent me from releasing
> another ~150 emails to flood other mailing lists.
> 
> Currently there are 929 drivers has device PM callbacks,
> 
> $ grep -rI "\.pm = &" --include=*.c  ./|wc -l
> 929
> 
> I put all files having device PM callbacks into four categories
> based on weather a file has CONFIG_PM_SLEEP or PM macro like
> SET_SYSTEM_SLEEP_PM_OPS, here are the statistics,
>   1. have both CONFIG_PM_SLEEP and PM_OPS macro: 213
>   2. have CONFIG_PM_SLEEP but no PM_OPS macro: 19
>   3. have PM macro but not CONFIG_PM_SLEEP: 347
>   4. no PM macro or CONFIG_PM_SLEEP: 302
> 
> Some drivers which have PM macro but not CONFIG_PM_SLEEP like
> sound/x86/intel_hdmi_audio.c indeed use __maybe_unused to eliminate
> the compiling warning. In 2011, there's a patch proposing to remove
> ONFIG_PM altogether but an objection was turning CONFIG_PM on would
> increase the kernel size [1]. So __maybe_unused also have this issue.

I would expect the compiler to remove the unused function, it knows
it is unused, that is why __maybe_unused is necessary to suppress
the warning and compilers are pretty smart and agressive wrt remove
unnecessary code these days.

Regards,

Hans




>>> ---
>>>  arch/x86/platform/olpc/olpc-xo15-sci.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
>>> index 85f4638764d6..716eefd735a4 100644
>>> --- a/arch/x86/platform/olpc/olpc-xo15-sci.c
>>> +++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
>>> @@ -192,7 +192,6 @@ static int xo15_sci_remove(struct acpi_device *device)
>>>      return 0;
>>>  }
>>>
>>> -#ifdef CONFIG_PM_SLEEP
>>>  static int xo15_sci_resume(struct device *dev)
>>>  {
>>>      /* Enable all EC events */
>>> @@ -204,7 +203,6 @@ static int xo15_sci_resume(struct device *dev)
>>>
>>>      return 0;
>>>  }
>>> -#endif
>>>
>>>  static SIMPLE_DEV_PM_OPS(xo15_sci_pm, NULL, xo15_sci_resume);
>>>
>>>
>>
> 
> -- 
> Best regards,
> Coiby
> 

