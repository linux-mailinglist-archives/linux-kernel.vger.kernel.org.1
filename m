Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915202A060E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJ3M6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgJ3M6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:58:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8649C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:58:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so7764722lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNc4aZmCV+V66ek4n0vGZyiabsnlsPVrA/E+N6Pxy2w=;
        b=LeCwheLxnLSKQ0afV1Zx/F0R0vdGaODFv+ShILQ1t99lDmCgZXhHgnsxb2XVZ+y75H
         PC5Y6abOYPnX1IlhLrUphlEpSxVHu0Q8Rx7lu3oIRqDXAFXipeU12yM6ByjjGSQYfsYT
         RRM8IA98Kyq//zkbpAYkpV+s2yFVOGGyf3GNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNc4aZmCV+V66ek4n0vGZyiabsnlsPVrA/E+N6Pxy2w=;
        b=UXpBiQjxwmKmYwIZws47MWcburRjL6F2fDNvh8oeCXWA7ruCoTHKLQK0Mcdqi9PjWO
         54dJ2lazMLG20jtL29W4eGnTUtTdac2q/Jfj1NgogcarSBOhWkD9UBEtjGcC8cagdORR
         Hwc0UvlwQVbyF88Gj2AZzj88Jbsd2pSLxTR0fw4AsmCRUEMrzMvocWeKpXAEs/HjhfVl
         YaYDXAhVWG9nzNEJN4/KIMaAeyh0kOr10wIhF5/0neddaw+10KLiELUkGLj/RqwWpPh4
         Z9eVBChmg8T1sNFzFrQV55BCqbilWF6tT/d2RKbbgoDZW7++3FJJrGrMljY+9LHdSN1C
         K2QQ==
X-Gm-Message-State: AOAM531cXQLp9A6sMGm69Iiv0Fd/vjedoe/jGTSy0WwM+jdxJx0LxLP6
        VrsH4TqA3mV0FFqEJDg1DHhTaA==
X-Google-Smtp-Source: ABdhPJzY3CJVQ93L6hUMcAs1mWQGITL9zUbrGBXT9azIo9XmUImab/GfczuRGjf7PGl+41B3aWjVUA==
X-Received: by 2002:a19:7e56:: with SMTP id z83mr813191lfc.98.1604062724149;
        Fri, 30 Oct 2020 05:58:44 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n18sm616110lfq.255.2020.10.30.05.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 05:58:43 -0700 (PDT)
Subject: Re: [PATCH 0/4] deterministic random testing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
 <20201026105927.GC4077@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <24397a58-17cd-7238-488c-7a3346465ab8@rasmusvillemoes.dk>
Date:   Fri, 30 Oct 2020 13:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026105927.GC4077@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 11.59, Andy Shevchenko wrote:
> On Sun, Oct 25, 2020 at 10:48:38PM +0100, Rasmus Villemoes wrote:
>> This is a bit of a mixed bag.
>>
>> The background is that I have some sort() and list_sort() rework
>> planned, but as part of that series I want to extend their their test
>> suites somewhat to make sure I don't goof up - and I want to use lots
>> of random list lengths with random contents to increase the chance of
>> somebody eventually hitting "hey, sort() is broken when the length is
>> 3 less than a power of 2 and only the last two elements are out of
>> order". But when such a case is hit, it's vitally important that the
>> developer can reproduce the exact same test case, which means using a
>> deterministic sequence of random numbers.
>>
>> Since Petr noticed [1] the non-determinism in test_printf in
>> connection with Arpitha's work on rewriting it to kunit, this prompted
>> me to use test_printf as a first place to apply that principle, and
>> get the infrastructure in place that will avoid repeating the "module
>> parameter/seed the rnd_state/report the seed used" boilerplate in each
>> module.
>>
>> Shuah, assuming the kselftest_module.h changes are ok, I think it's
>> most natural if you carry these patches, though I'd be happy with any
>> other route as well.
> 
> Completely in favour of this.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks.

> One note though. AFAIU the global variables are always being used in the
> modules that include the corresponding header. Otherwise we might have an extra
> warning(s). I believe you have compiled with W=1 to exclude other cases.

Yes, I unconditionally define the two new variables. gcc doesn't warn
about them being unused, since they are referenced from inside a

  if (0) {}

block. And when those references are the only ones, gcc is smart enough
to elide the static variables completely, so they don't even take up
space in .data (or .init.data) - you can verify by running nm on
test_printf.o and test_bitmap.o - the former has 'seed' and 'rnd_state'
symbols, the latter does not.

I did it that way to reduce the need for explicit preprocessor
conditionals inside C functions.

Rasmus
