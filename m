Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE529AA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898797AbgJ0K4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:56:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39049 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgJ0K4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:56:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id d3so942116wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o95UznsIXvrtNAHbiwH0VAgmFKpGNUfa3i03AXLJKRA=;
        b=F8qJRAmoYAvlvuoSU0RTOEd/yNJJjS8z/Ay6CKw0wtV3l3HG96/HDZX+NmFuyI5JrX
         Oim+WCTWxuA505uJ7woBZnZbMl8DX/Role875kIvXZPDhGbuVOMrm//IF/Ljw5DvECPE
         HoeiRCkB2HdYExBfxodUSb8dss5sZLRO8Pwds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o95UznsIXvrtNAHbiwH0VAgmFKpGNUfa3i03AXLJKRA=;
        b=C6JHkM4fgDAoG+kZJ19NcPIFxN44SV230dOUby9zJql7i64J1OHADFQu52gluqDh78
         pIgE0HmWLSEGlZO6TdwAhcDJqI44GT2YTEwBQwM3/ZP0z35lK1GPaSGm/BYb1SDmlJE2
         ton+T03qTNKFdXqAgGhZED9i/8OVX+GR6bth79E9NZTohhIgGmH4zrElw+hbuU6rTvLt
         REa93ZJ4YDuvAzGG7EcInfIJUGl+JDmroblM/x0S1InhBgsJch92kMLxGIYzWU06kJi+
         Hx2lFgJc1rigEKe4B9rgFHQ9sqkDA+hA8u9irKwXZTUh3oUoqhT1RwT4tD/8Y7hGs2fc
         46GQ==
X-Gm-Message-State: AOAM532vmRbBbb4lAGVYxxqdFZDx/CA49Pkf+1buSpzgsFFAolAQCnFl
        JYnl/LLOsNuRhfBLcWm74HPUfHvVvgMm6khcyvg=
X-Google-Smtp-Source: ABdhPJwouFVRaoebSOXb9EP5Qkm/giZoM8uTAyssLoAi8tWQ56Wt4KiuER5iQnF9ckMB9vAZNSlsXg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2170254wmg.38.1603796159522;
        Tue, 27 Oct 2020 03:55:59 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u9sm1557607wrp.65.2020.10.27.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:55:59 -0700 (PDT)
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
To:     Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201026215004.3893088-1-arnd@kernel.org>
 <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
 <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
 <20201027091218.GB31882@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <13d87c71-66b2-2abb-825d-6e8e2e47d22a@rasmusvillemoes.dk>
Date:   Tue, 27 Oct 2020 11:55:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027091218.GB31882@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 10.12, Petr Mladek wrote:
> On Tue 2020-10-27 09:46:28, Arnd Bergmann wrote:
>> On Tue, Oct 27, 2020 at 8:23 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>> On 26/10/2020 22.49, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> NAK. That would end up using the "EDEADLOCK" string for the value 35 on
>>> those architectures where they are the same, despite EDEADLK being the
>>> by far the most used symbol. See the comments and original commit log,
>>> the placement of these is deliberate.
> 
> Good point.
> 
>> Ok, I see.
>>
>>> How about we do this instead?
>>>
>>> when building with W=1. As the use of multiple initializers for the
>>> same entry here is quite deliberate, explicitly disable that warning
>>> for errname.o.
>>>
>>> diff --git a/lib/Makefile b/lib/Makefile
>>> index ce45af50983a2a5e3582..a98119519e100103818d 100644
>>> --- a/lib/Makefile
>>> +++ b/lib/Makefile
>>> @@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>>>
>>>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>>>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
>>> +CFLAGS_errname.o += $(call cc-disable-warning, override-init)
>>>
>>
>> This works, but it disables a potentially useful warning in case we
>> get another conflict in this file, so I'd prefer to find a way to
>> avoid the warning rather than force-disabling it.
> 
> Yeah, I think that it is better to explicitely disable the less used
> variant in the code than hiding the double initialization. It will
> be clear what is going on.
> 
> 
>> How about adding the #ifdef around the EDEADLOCK line
>> instead of the EDEADLK one? Something like
>>
>> diff --git a/lib/errname.c b/lib/errname.c
>> index 0c4d3e66170e..93043fb960cc 100644
>> --- a/lib/errname.c
>> +++ b/lib/errname.c
>> @@ -38,7 +38,10 @@ static const char *names_0[] = {
>>         E(ECOMM),
>>         E(ECONNABORTED),
>>         E(ECONNRESET),
>> +       E(EDEADLK), /* EDEADLOCK */
>> +#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
>>         E(EDEADLOCK),
>> +#endif
>>         E(EDESTADDRREQ),
>>         E(EDOM),
>>         E(EDOTDOT),
>> @@ -169,7 +172,6 @@ static const char *names_0[] = {
>>         E(ECANCELED), /* ECANCELLED */
>>         E(EAGAIN), /* EWOULDBLOCK */
>>         E(ECONNREFUSED), /* EREFUSED */
>> -       E(EDEADLK), /* EDEADLOCK */
> 
> This should stay :-)
> 

No, Arnd moved it next to EDEADLOCK, which is fine (it can lose the
comment /* EDEADLOCK */, though; the comment on the ifdef is
sufficient). Especially when:

> And we should remove the ECANCELLED definition. It is always the same
> as ECANCELED and replaced. We do not define EWOULDBLOCK and
> EREFUSED either.

Yes, I'm not sure why I elided EWOULDBLOCK and EREFUSED but not
ECANCELLED. So let's move EAGAIN, ECONNREFUSED and ECANCELED to their
proper alphabetic place. But I also want to add a check that the things
we've elided match some value that we do handle. So add something like

#ifdef EREFUSED /* parisc */
static_assert(EREFUSED == ECONNREFUSED);
#endif

#ifdef ECANCELLED /* parisc */
static_assert(ECANCELLED == ECANCELED);
#endif

static_assert(EAGAIN == EWOULDBLOCK); /* everywhere */

so that if we ever import some arch that defines EREFUSED to something
other than ECONNREFUSED, it would be caught. Essentially, errname.c
should mention every #define E* that appears in any errno*.h.

Rasmus
