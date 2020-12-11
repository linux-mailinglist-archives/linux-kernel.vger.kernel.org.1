Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA82D6C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgLKAc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbgLKAch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:32:37 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9007AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:31:57 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id g1so7189017ilk.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yiQdoMf12SNG+ZW2M45uraLJUUvpcbUlT/pdENldQuk=;
        b=NOzXytw9rV0o+nt1jsY54EeUYWKilyIEweWh0TG7nJUVx6LuHfXmVkFK5WZcZyXjeM
         i1cochq1LtAR7f9NkETZYT8+nJy1/SE9/J1/0XLincXyxaAbeD1GXSW8loHW3xEjk2I5
         MDcOHGfsEkX4d7b/mt+dj0lk8Wyf7d6WF3Elk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yiQdoMf12SNG+ZW2M45uraLJUUvpcbUlT/pdENldQuk=;
        b=LYA/0ya3Q8SbV4+xN0A9eiGmIL5TxRPLAOcmJk8IOIubwNpi+ULK8eJ025rpQj5yb3
         ROHEtVi6gADpjV96bAomHZ8bd4KOIjcMLp5gn1J0aZpbLguJK4Fti9NJyitdOk3QweDc
         oHriH9jl4FbMgxKDOm3hjk4Ya3Ks0jxvZFv/qw/wd6x5YWm2n5iOBX74alpVLjNLoy/e
         OrizFrHNru/NmrFHTJVDGwx5eMvRW/21GWeyV7B33lFkwvYnkjns6Ai6YELjWrVHsKMj
         rzQlb5/VuYT7pvxS7BwcJ2xsixK8D84iqZye06XGAvzfuqf7U3GZ+oWnLwbhB9C1HdCr
         Jrgw==
X-Gm-Message-State: AOAM533MS/NVJSowbJxhgjarm8zoeLgC+YzvyfN/66NO6TZfXs+1+wgG
        mA+MoIUGaQydu/b4rRMzRJEbLw==
X-Google-Smtp-Source: ABdhPJx1/3vmncVRCjAKW3J2bHnvwcYzuWOZKTReo1KJXIzw1iQP1d06zqWGJA7p/oQJdblmqtgvTA==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr12793622ili.266.1607646716914;
        Thu, 10 Dec 2020 16:31:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d5sm4007163ilf.33.2020.12.10.16.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 16:31:56 -0800 (PST)
Subject: Re: [PATCH] selftests: propagate CC to selftest submakes
To:     Andrew Delgadillo <adelg@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201203221005.2813159-1-adelg@google.com>
 <CAKwvOdk6=TgL+f2-WvE7tsK0rN1XQ+NdXmeJfDkLsa8xPmgipA@mail.gmail.com>
 <CAEHm+vHtMQtMThgE_BwpiBS5v0a61L_TW9vgKLaFTtcgg9HSgA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e78c3b86-78ab-2b2e-d8be-e9118d7d2392@linuxfoundation.org>
Date:   Thu, 10 Dec 2020 17:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAEHm+vHtMQtMThgE_BwpiBS5v0a61L_TW9vgKLaFTtcgg9HSgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 5:10 PM, Andrew Delgadillo wrote:
> On Thu, Dec 10, 2020 at 3:08 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Thu, Dec 3, 2020 at 2:10 PM Andrew Delgadillo <adelg@google.com> wrote:
>>>
>>> lib.mk defaults to gcc when CC is not set. When building selftests
>>> as part of a kernel compilation, MAKEFLAGS is cleared to allow implicit
>>> build rules to be used. This has the side-effect of clearing the CC
>>> variable, which will cause selftests to be built with gcc regardless of
>>> if we are using gcc or clang. To remedy this, propagate the CC variable
>>> when clearing makeflags to ensure the correct compiler is used.
>>>
>>> Signed-off-by: Andrew Delgadillo <adelg@google.com>
>>
>> Hi Andrew, thanks for the patch. Can you walk me through how to build
>> the selftests?
>>
>> Documentation/dev-tools/kselftest.rst says:
>> $ make -C tools/testing/selftests
>>
>> And if I do:
>> $ make CC=clang defconfig
>> $ make CC=clang -C tools/testing/selftests -j
>>
>> I observe a spew of errors.  If I apply your patch and rerun the
>> above, I see what looks like the same spew of errors.  Am I "holding
>> it wrong" or could the docs use a refresh?
>>
> 
> Hi Nick, sure thing!
> 
> I also see a slew of errors when building with make -C
> tools/testing/selftests. However, that is not the problem I am trying
> to solve. I believe we are seeing errors building that way because it
> is missing some make variables that are normally set up when building
> from the kernel's top level makefile.
> 

Both options are supported and should work.

make -C tools/testing/selftests
make kselftest

That being said, I use gcc. Can you send the errors you are seeing?
It is possible, a few tests aren't building and need to be fixed
for clang and gcc.

thanks,
-- Shuah

