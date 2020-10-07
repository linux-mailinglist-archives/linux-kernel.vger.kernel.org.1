Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CBB286846
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJGT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGT0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:26:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D5C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:26:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so3702875ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tjd2FzRXvdjs1WKpQFRW00T3taDPQywrERqY5y71pZ4=;
        b=Al+bibp7oYh345CTHrd4nbdpDAHpliRMHZtwgLBaWn9CEfnRzgAIZNvsVaOrnKxuSN
         79OOMXPqMZ7bnpi2pwopzqVFjUwMDbdTg4W56oXPe827HM7u78S67x/yhEdVtRFZFCvo
         2WRxzi3LjLEYswYtZOGBoAuQJm8MR416UnPi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjd2FzRXvdjs1WKpQFRW00T3taDPQywrERqY5y71pZ4=;
        b=UT11jLVGKjZi7hP2+7aDM89k48wCV9PxehS6u1qFlaF6eqpe0IoZ/0PhdwN9X1jwtg
         zCaZ0W2U4UwSRYP8eyMvzHa1cC5JLWNAqKi/cP7O4N92sWa/eSsintGK7N0ZVsqSXqit
         piOn5MD6Kg+aAqgnIoaBe6CHP4Z/kP07WNZtidtPfhg8zlaQAGbyUPGJUJVysyilXtkn
         wYh3TEOWh/QRBx9vYPhVpKuM3Y9oLHqkgNHo66Fo505S+WYg8FdjZOE26QUaDN7eXsh6
         lXAL+xxshkojfeX8ooB1IqKVmbWHbchtf0fN3cFgmL8tw1uo8C+XPCJWZx2/lnsIzylM
         KWwA==
X-Gm-Message-State: AOAM531+S25IbNiGZY8RPfBmi2zd3uBXz+46OWQCqk96kc68vWWuTcOS
        bG+giDEDmFmLxlfLj/EWrcAHaQ==
X-Google-Smtp-Source: ABdhPJz7KqUW6TmLWEnKhQtRWFETktvHzsaa3LpkV7U748cdpx3tiLwCGUvWmMn6NqV0RH/Fd5VdOw==
X-Received: by 2002:a5e:9e45:: with SMTP id j5mr3475296ioq.201.1602098814575;
        Wed, 07 Oct 2020 12:26:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n138sm1283415iod.40.2020.10.07.12.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 12:26:54 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] counters: Introduce counter_atomic* counters
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <cbace4e3f504359bd017a7fc2aab62178a1550ed.1602011710.git.skhan@linuxfoundation.org>
 <202010071056.E4804235E@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0939f9d-d60f-7a97-31bd-e527c79ce284@linuxfoundation.org>
Date:   Wed, 7 Oct 2020 13:26:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010071056.E4804235E@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 12:11 PM, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 02:44:32PM -0600, Shuah Khan wrote:
>> Introduce Simple atomic counters.
>>
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting and not for managing object lifetime. In
>> some cases, atomic_t might not even be needed.
>>
>> The purpose of these counters is to clearly differentiate atomic_t
>> counters from atomic_t usages that guard object lifetimes, hence prone
>> to overflow and underflow errors. It allows tools that scan for underflow
>> and overflow on atomic_t usages to detect overflow and underflows to scan
>> just the cases that are prone to errors.
>>
>> Simple atomic counters api provides interfaces for simple atomic counters
>> that just count, and don't guard resource lifetimes. Counter will wrap
>> around to 0 when it overflows and should not be used to guard resource
>> lifetimes, device usage and open counts that control state changes, and
>> pm states.
>>
>> Using counter_atomic* to guard lifetimes could lead to use-after free
>> when it overflows and undefined behavior when used to manage state
>> changes and device usage/open states.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   Documentation/core-api/counters.rst | 103 +++++++++++++++++
>>   MAINTAINERS                         |   7 ++
>>   include/linux/counters.h            | 173 ++++++++++++++++++++++++++++
>>   lib/Kconfig                         |  10 ++
>>   lib/Makefile                        |   1 +
>>   lib/test_counters.c                 | 157 +++++++++++++++++++++++++
>>   6 files changed, 451 insertions(+)
>>   create mode 100644 Documentation/core-api/counters.rst
>>   create mode 100644 include/linux/counters.h
>>   create mode 100644 lib/test_counters.c
>>
>> diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
>> new file mode 100644
>> index 000000000000..ba1ce325b639
>> --- /dev/null
>> +++ b/Documentation/core-api/counters.rst
>> @@ -0,0 +1,103 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================
>> +Simple atomic counters
>> +======================
>> +
>> +:Author: Shuah Khan
>> +
>> +There are a number of atomic_t usages in the kernel where atomic_t api
>> +is used strictly for counting and not for managing object lifetime. In
>> +some cases, atomic_t might not even be needed.
>> +
>> +The purpose of these counters is to clearly differentiate atomic_t counters
>> +from atomic_t usages that guard object lifetimes, hence prone to overflow
>> +and underflow errors. It allows tools that scan for underflow and overflow
>> +on atomic_t usages to detect overflow and underflows to scan just the cases
>> +that are prone to errors.
>> +
>> +Simple atomic counters api provides interfaces for simple atomic counters
>> +that just count, and don't guard resource lifetimes. Counter will wrap
>> +around to 0 when it overflows and should not be used to guard resource
>> +lifetimes, device usage and open counts that control state changes, and
>> +pm states.
>> +
>> +Using counter_atomic32_* to guard lifetimes could lead to use-after free
>> +when it overflows and undefined behavior when used to manage state
>> +changes and device usage/open states.
>> +
>> +Use refcount_t interfaces for guarding resources.
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
>> +counter_atomic32 and counter_atomic64 types use atomic_t and atomic64_t
>> +underneath to leverage atomic_t api,  providing a small subset of atomic_t
>> +interfaces necessary to support simple counters. ::
>> +
>> +        struct counter_atomic32 { atomic_t cnt; };
>> +        struct counter_atomic64 { atomic64_t cnt; };
>> +
>> +Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
>> +information on the Semantics and Behavior of Atomic operations.
>> +
>> +.. warning::
>> +        It is important to keep the ops to a very small subset to ensure
>> +        that the Counter API will never be used for guarding resource
>> +        lifetimes and state management.
>> +
>> +        inc_return() is added to support current atomic_inc_return()
>> +        usages and avoid forcing the use of _inc() followed by _read().
>> +
>> +Initializers
>> +------------
>> +
>> +Interfaces for initializing counters are write operations which in turn
>> +invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
>> +
>> +        #define COUNTER_ATOMIC_INIT(i)    { .cnt = ATOMIC_INIT(i) }
>> +        counter_atomic32_set() --> atomic_set()
>> +
>> +        static struct counter_atomic32 acnt = COUNTER_ATOMIC_INIT(0);
>> +        counter_atomic32_set(0);
>> +
>> +        static struct counter_atomic64 acnt = COUNTER_ATOMIC_INIT(0);
>> +        counter_atomic64_set(0);
>> +
>> +Increment interface
>> +-------------------
>> +
>> +Increments counter and doesn't return the new counter value. ::
>> +
>> +        counter_atomic32_inc() --> atomic_inc()
>> +        counter_atomic64_inc() --> atomic64_inc()
>> +
>> +Increment and return new counter value interface
>> +------------------------------------------------
>> +
>> +Increments counter and returns the new counter value. ::
>> +
>> +        counter_atomic32_inc_return() --> atomic_inc_return()
>> +        counter_atomic64_inc_return() --> atomic64_inc_return()
>> +
>> +Decrement interface
>> +-------------------
>> +
>> +Decrements counter and doesn't return the new counter value. ::
>> +
>> +        counter_atomic32_dec() --> atomic_dec()
>> +        counter_atomic64_dec() --> atomic64_dec()
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 33b27e62ce19..4e82d0ffcab0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15839,6 +15839,13 @@ S:	Maintained
>>   F:	Documentation/fb/sm712fb.rst
>>   F:	drivers/video/fbdev/sm712*
>>   
>> +SIMPLE ATOMIC and NON-ATOMIC COUNTERS
>> +M:	Shuah Khan <skhan@linuxfoundation.org>
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +F:	include/linux/counters.h
>> +F:	lib/test_counters.c
>> +
>>   SIMPLE FIRMWARE INTERFACE (SFI)
>>   S:	Obsolete
>>   W:	http://simplefirmware.org/
>> diff --git a/include/linux/counters.h b/include/linux/counters.h
>> new file mode 100644
>> index 000000000000..c0c26a13f768
>> --- /dev/null
>> +++ b/include/linux/counters.h
>> @@ -0,0 +1,173 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Interface for simple atomic counters that just count.
>> + *
>> + * Counter will wrap around to 0 when it overflows and should not be
>> + * used to guard resource lifetimes, device usage and open counts that
>> + * control state changes, and pm states. Using counter_atomic to guard
>> + * lifetimes could lead to use-after free when it overflows and undefined
>> + * behavior when used to manage state changes and device usage/open states.
>> + *
>> + * Use refcount_t interfaces for guarding resources.
>> + *
>> + * The interface provides:
>> + * atomic32 & atomic64 functions:
>> + *	increment and no return
>> + *	increment and return value
>> + *	decrement and no return
>> + *	read
>> + *	set
>> + *
>> + * counter_atomic32 unctions leverage/use atomic_t interfaces.
> 
> typo: functions

Thanks for the catch.

> 
>> + * counter_atomic64 functions leverage/use atomic64_t interfaces.
>> + * The counter will wrap around to 0 when it overflows.
>> + * These interfaces should not be used to guard resource lifetimes.
>> + *
>> + * Reference and API guide:
>> + *	Documentation/core-api/counters.rst for more information.
>> + *
>> + */
>> +
>> +#ifndef __LINUX_COUNTERS_H
>> +#define __LINUX_COUNTERS_H
>> +
>> +#include <linux/atomic.h>
>> +
>> +/**
>> + * struct counter_atomic32 - Simple atomic counter
>> + * @cnt: int
>> + *
>> + * The counter wraps around to 0, when it overflows. Should not
>> + * be used to guard object lifetimes.
>> + **/
>> +struct counter_atomic32 {
>> +	atomic_t cnt;
>> +};
>> +
>> +#define COUNTER_ATOMIC_INIT(i)		{ .cnt = ATOMIC_INIT(i) }
>> +
>> +/*
>> + * counter_atomic32_inc() - increment counter value
>> + * @cntr: struct counter_atomic32 pointer
>> + *
>> + */
>> +static inline void counter_atomic32_inc(struct counter_atomic32 *cntr)
>> +{
>> +	atomic_inc(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic32_inc_return() - increment counter value and return it
>> + * @cntr: struct counter_atomic32 pointer
>> + *
>> + * Return: returns the new counter value after incrementing it
>> + */
>> +static inline int counter_atomic32_inc_return(struct counter_atomic32 *cntr)
>> +{
>> +	return atomic_inc_return(&cntr->cnt);
>> +}
> 
> So, there's an issue here between the types and the documentation: while
> this will eventually wrap around to 0, it will first go through the
> negative value space (i.e. INT_MAX + 1 == INT_MIN, INT_MIN < 0).
> 

Right. It does go through INT_MIN state before it wraps around.

> Current users of atomic_t should already be expecting this, but does it
> make sense?
> 
> i.e. should the documentation be updated to "wraps around to negative
> values", or should the counter API be updated to force the unsigned
> value:
> 
> +static inline u32 counter_atomic32_inc_return(struct counter_atomic32 *cntr)
> +{
> +	return (u32)atomic_inc_return(&cntr->cnt);
> +}
> 
> I see many forcing the return type from atomic_*{read,return}*():
> 
> $ git grep -E '\((unsigned|unsigned int|u32)\).*\batomic.*(read|return)' | wc -l
> 67
> 
> My instinct is to say leave it "int" and adjust documentation, which is
> the least disruptive, but I am enticed by the desire to make sure a
> counter doesn't "misbehave" and go negative when the usage wants it
> always positive.
> 

I would recommend leaving it as "int". Changing the API to unsigned has
other ramifications and cascading changes.

My quick search shows me there are 612 atomic_inc_return usages and
14 out of them are forcing the return type from int to u32.

For atomic_read the numbers are 51 out of 5833 forcing u32. We have
couple of options:

1. Update the documentation since we have more cases where
    int is just fine.
2. Add counter_atomic32_inc_return_u32() variant to cover these few
    cases that are forcing the return.

I recommend going with option 1 with Documentation update and add
option 2 when we convert one of these 60+.

>> +static void test_counter_atomic32_overflow(void)
>> +{
>> +	static struct counter_atomic32 ucnt = COUNTER_ATOMIC_INIT(0);
>> +	static struct counter_atomic32 ocnt = COUNTER_ATOMIC_INIT(INT_MAX);
>> +	int start_val;
>> +	int end_val;
>> +
>> +	start_val = counter_atomic32_read(&ucnt);
>> +	counter_atomic32_dec(&ucnt);
>> +	end_val = counter_atomic32_read(&ucnt);
> 
> This is testing that counter operations match native int operations,
> which seems fine. I wonder if hard-coded values should be added too, to
> just more directly map the explicit expectations? E.g. adding a second
> test with each:
> 
> 	test_counter_result_print32("Test underflow (int)",
> 				    start_val, end_val, start_val-1);
> 	test_counter_result_print32("Test underflow (-1)",
> 				    start_val, end_val, -1);
> 
> 

Yeah. I can add that.

>> +
>> +	start_val = counter_atomic32_read(&ocnt);
>> +	end_val = counter_atomic32_inc_return(&ocnt);
> 
> and:
> 
> 	test_counter_result_print32("Test overflow (int)",
> 				    start_val, end_val, start_val+1);
> 	test_counter_result_print32("Test underflow (INT_MIN)",
> 				    start_val, end_val, INT_MIN);
> 

Sure.

> 
> Otherwise, yes, looks great; thank you!
> 

thanks,
-- Shuah
