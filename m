Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A427626D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWUsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:48:24 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8170C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:48:24 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id b12so209139oop.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJTll+5qmwvzugKjnqEDOGM/u8Q3ptEr/+CUXO1yFV8=;
        b=cQh6h2pABmrqmAp2MlHEWPXY3TiTUycxbtrwrU9fZAPJ7TseOdYnbrjMtUhwEZKfYl
         KPgoJrJSvFrSGFphSBkpUDR6YNW7etto5ao5O/6c5APQe4m56C/oKbK8hwVfBVVclrRX
         v92szi/ev5ENJ2wwRVF0omqP05aTod4NUhasU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJTll+5qmwvzugKjnqEDOGM/u8Q3ptEr/+CUXO1yFV8=;
        b=FmukolIaIV0rwLCZ91Q62TnChKVZpM/3oWAG3DFXW57vJ2pMN5eJX6pEtToKIbj2u3
         1NKf3ZDGqcCMEQMyxQABC3ppQrnxSeEq+8Pn/NvbhSgL+2qPws17gVFiWs+a8Zq9k74Y
         mT8uSQ0AfAY80lW2sUw9Rn4IgEpjIuXyCJ9BMUQlRgATdqt0G1dM3GwDEdl0pj1X+z4m
         s3MDdAiqiwb92H+wldPg8c56lbR8C31Zy5jThncAM3QC67lCLsUgLVd/0AwVlqhZPkYb
         n/tT2I4eBIFEzyBXoDE4YEdy9V+az50YGE/CwsnLQL2n2wO2FdJw//PWVVd/ZgrEsDgs
         TgZw==
X-Gm-Message-State: AOAM531muQrZVBBKoJxtL38YH+zljAZ+hEnH6hPmJQOD/+gnBC4B1Rzy
        ++Elu+yC8bcQRbcsdod6/t/yTp7+Y/+j1A==
X-Google-Smtp-Source: ABdhPJxx7ZByX2zs74ayc27B4BArC4rnhdm8yTY/kMHWGzici9Sj8A7ttmzcG/iSm2G82yOvM0vnvw==
X-Received: by 2002:a4a:7055:: with SMTP id b21mr1091159oof.26.1600894103959;
        Wed, 23 Sep 2020 13:48:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l25sm291674otb.4.2020.09.23.13.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 13:48:23 -0700 (PDT)
Subject: Re: [RFC PATCH 01/11] counters: Introduce counter and counter_atomic
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <e57eb89132000b255b5a7952cb82725ec2f3e4e0.1600816121.git.skhan@linuxfoundation.org>
 <202009231152.5023C4656F@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <599e3faa-4228-f867-46f1-66566297256b@linuxfoundation.org>
Date:   Wed, 23 Sep 2020 14:48:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009231152.5023C4656F@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 1:04 PM, Kees Cook wrote:
> On Tue, Sep 22, 2020 at 07:43:30PM -0600, Shuah Khan wrote:
>> Introduce Simple atomic and non-atomic counters.
>>
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting and not for managing object lifetime. In
>> some cases, atomic_t might not even be needed.
> 
> Thank you for working on a counter API! I'm glad to see work here,
> though I have some pretty significant changes to request; see below...
> 

Thanks for the review.

>>
>> The purpose of these counters is twofold: 1. clearly differentiate
>> atomic_t counters from atomic_t usages that guard object lifetimes,
>> hence prone to overflow and underflow errors. It allows tools that scan
>> for underflow and overflow on atomic_t usages to detect overflow and
>> underflows to scan just the cases that are prone to errors. 2. provides
>> non-atomic counters for cases where atomic isn't necessary.
>>
>> Simple atomic and non-atomic counters api provides interfaces for simple
>> atomic and non-atomic counters that just count, and don't guard resource
>> lifetimes. Counters will wrap around to 0 when it overflows and should
>> not be used to guard resource lifetimes, device usage and open counts
>> that control state changes, and pm states.
>>
>> Using counter_atomic to guard lifetimes could lead to use-after free
>> when it overflows and undefined behavior when used to manage state
>> changes and device usage/open states.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> I would really like these APIs to be _impossible_ to use for object
> lifetime management. To that end, I would like to have all of the
> *_return() functions removed. It should be strictly init, inc, dec,
> read.
> 

Yes. I am with you on making this API as small as possible so it won't
be used for lifetime mgmt. That means no support for:

*_test, add_negative etc.

I started out with just init, inc, dec, read. As I started looking
for candidates that can be converted to counters, I found inc_return()
usages. I think we need inc_return() for sure. I haven't come across
atomic_dec_return() yet.

I would say we will need at least inc_return() for being able to convert
all counter atomic_t usages.

>> +There are a number of atomic_t usages in the kernel where atomic_t api
>> +is used strictly for counting and not for managing object lifetime. In
>> +some cases, atomic_t might not even be needed.
> 
> Why even force the distinction? I think all the counters should be
> atomic and then there is no chance they will get accidentally used in
> places where someone *thinks* it's safe to use a non-atomic. So,
> "_atomic" can be removed from the name and the non-atomic implementation
> can get removed. Anyone already using non-atomic counters is just using
> "int" and "long" anyway. Let's please only create APIs that are always
> safe to use, and provide some benefit over a native time.
> 

I am with Greg on this. I think we will find several atomic_t usages
that don't need atomicity.

>> +Simple atomic and non-atomic counters api provides interfaces for simple
>> +atomic and non-atomic counters that just count, and don't guard resource
>> +lifetimes. Counters will wrap around to 0 when it overflows and should
>> +not be used to guard resource lifetimes, device usage and open counts
>> +that control state changes, and pm states.
>> +
>> +Using counter_atomic to guard lifetimes could lead to use-after free
>> +when it overflows and undefined behavior when used to manage state
>> +changes and device usage/open states.
>> +
>> +Use refcnt_t interfaces for guarding resources.
>  > typo: refcount_t (this typo is repeated in a few places)
> 

Thanks for the catch. Will fit it.

>> +
>> +.. warning::
>> +        Counter will wrap around to 0 when it overflows.
>> +        Should not be used to guard resource lifetimes.
>> +        Should not be used to manage device state and pm state.
>> +
>> +Test Counters Module and selftest
>> +---------------------------------
>> +
>> +Please see :ref:`lib/test_counters.c <Test Counters Module>` for how to
>> +use these interfaces and also test them.
>> +
>> +Selftest for testing:
>> +:ref:`testing/selftests/lib/test_counters.sh <selftest for counters>`
>> +
>> +Atomic counter interfaces
>> +=========================
>> +
>> +counter_atomic and counter_atomic_long types use atomic_t and atomic_long_t
>> +underneath to leverage atomic_t api,  providing a small subset of atomic_t
>> +interfaces necessary to support simple counters. ::
>> +
>> +        struct counter_atomic { atomic_t cnt; };
>> +        struct counter_atomic_long { atomic_long_t cnt; };
> 
> "Unsized" and "Long" are both unhelpful here. If it's unsized, that
> tells nothing about the counter size. And "long" changes with word size.
> I think counters should either _all_ be 64-bit, or they should be
> explicitly sized in their name. Either:
> 
> struct counter;  /* unsigned 64-bit, wraps back around to 0 */
> 
> or
> 
> struct counter32; /* unsigned 32-bit, wraps back around to 0 */
> struct counter64; /* unsigned 64-bit, wraps back around to 0 */
> 

Will do.

>> --- /dev/null
>> +++ b/lib/test_counters.c
>> @@ -0,0 +1,283 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Kernel module for testing Counters
>> + *
>> + * Authors:
>> + *	Shuah Khan	<skhan@linuxfoundation.org>
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/counters.h>
>> +
>> +void test_counter_atomic(void)
>> +{
>> +	static struct counter_atomic acnt = COUNTER_ATOMIC_INIT(0);
>> +	int start_val = counter_atomic_read(&acnt);
>> +	int end_val;
> 
> Please build this test using KUnit.
> 

Sounds good.

>> +	start_val = counter_long_read(&acnt);
>> +	end_val = counter_long_dec_return(&acnt);
>> +	pr_info("Test read decrement and return: %ld to %ld - %s\n",
>> +		start_val, end_val,
>> +		((start_val-1 == end_val) ? "PASS" : "FAIL"));
> 
> I also see a lot of copy/paste patterns here. These should all use a
> common helper.

I knew you would ask for helpers. :)

Yeah will do.

thanks,
-- Shuah
