Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1F287ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgJHRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgJHRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:18:35 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE40C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:18:35 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x62so7058753oix.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7G3aLixKo74imwc/depBVrOLbkm1RKiElqNFEhTayvk=;
        b=Svc2AaKIG9yAPPScP1gUHgiS4fYEY9/Y/P3i19b13IM8GRUU7Ne6rWlC8mdZAQksSn
         XSruWE+RDCf4x45E0VtdFU9d9QB1//rcc/ZvooxhGQombvCG54EAoUNgSxoki41xMtrl
         D3VY3l1Qa5Hzqne2Cew/IlPPZHthlf/PweEKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7G3aLixKo74imwc/depBVrOLbkm1RKiElqNFEhTayvk=;
        b=p3/I7+2COeYWOZyQpAQn/NP9VrbnAt6dXRjiExiJO+0gTth6QSTLlV6cNGTHn+rk53
         Z+5lc+EX+uJ8V2abd7Ddd4oY6WuIabivpYaOoE7h6ddIWe9yJIZl7Uw0vL6f1j2zSQMF
         ufWzL7bvGTZ3f1mewKI6yhfByE5Ln2JAEuvhpTXlQxL7SoatijAPTx4SrRcztyN79OP/
         vwZYgCUYllAnchIP4D/6t2XjpU46WDKqKosHvtjZOfg5CC7eco52ZT7j7BLttXgOSKQu
         IJN/CTRLyAkX5Gfkyu1u5re1y3z1rpjmJ5wuA2GV/UgDIlh42N5Y1g/n0Fw31JRwJzFi
         is7g==
X-Gm-Message-State: AOAM531ZXaolKDXPVK3CAWPfyQN8pG6NAQxp/8inp+GHY2n8c94VtsKF
        Rl+0LUCnQ6fH/s95W0YUhHbnJw==
X-Google-Smtp-Source: ABdhPJzN766mbXnnVMOJVRyod7eLW0TxcCw7PIw7cWI5bA5oW+wcPWGruO47icO4O1Bac0+9QwKvJw==
X-Received: by 2002:aca:a810:: with SMTP id r16mr6053860oie.114.1602177514384;
        Thu, 08 Oct 2020 10:18:34 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 92sm4567088otl.1.2020.10.08.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:18:33 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] counters: Introduce counter_atomic* counters
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <cbace4e3f504359bd017a7fc2aab62178a1550ed.1602011710.git.skhan@linuxfoundation.org>
 <20201007090451.GD547609@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4a5b08be-2693-9d4e-729f-931205ff4f0c@linuxfoundation.org>
Date:   Thu, 8 Oct 2020 11:18:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007090451.GD547609@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 3:04 AM, Greg KH wrote:
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
>> +
>> +/*
>> + * counter_atomic32_dec() - decrement counter value
>> + * @cntr: struct counter_atomic32 pointer
>> + *
>> + */
>> +static inline void counter_atomic32_dec(struct counter_atomic32 *cntr)
>> +{
>> +	atomic_dec(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic32_read() - read counter value
>> + * @cntr: struct counter_atomic32 pointer
>> + *
>> + * Return: return the counter value
>> + */
>> +static inline int counter_atomic32_read(const struct counter_atomic32 *cntr)
>> +{
>> +	return atomic_read(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic32_set() - set counter value
>> + * @cntr: struct counter_atomic32 pointer
>> + * @val:  new counter value to set
>> + *
>> + */
>> +static inline void
>> +counter_atomic32_set(struct counter_atomic32 *cntr, int val)
>> +{
>> +	atomic_set(&cntr->cnt, val);
>> +}
>> +
>> +#ifdef CONFIG_64BIT
>> +/*
>> + * struct counter_atomic64 - Simple atomic counter
>> + * @cnt: atomic64_t
>> + *
>> + * The counter wraps around to 0, when it overflows. Should not
>> + * be used to guard object lifetimes.
>> + */
>> +struct counter_atomic64 {
>> +	atomic64_t cnt;
>> +};
>> +
>> +/*
>> + * counter_atomic64_inc() - increment counter value
>> + * @cntr: struct counter_atomic64 pointer
>> + *
>> + */
>> +static inline void counter_atomic64_inc(struct counter_atomic64 *cntr)
>> +{
>> +	atomic64_inc(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic64_inc_return() - increment counter value and return it
>> + * @cntr: struct counter_atomic64 pointer
>> + *
>> + * Return: return the new counter value after incrementing it
>> + */
>> +static inline s64
>> +counter_atomic64_inc_return(struct counter_atomic64 *cntr)
>> +{
>> +	return atomic64_inc_return(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic64_dec() - decrement counter value
>> + * @cntr: struct counter_atomic64 pointer
>> + *
>> + */
>> +static inline void counter_atomic64_dec(
>> +				struct counter_atomic64 *cntr)
>> +{
>> +	atomic64_dec(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic64_read() - read counter value
>> + * @cntr: struct counter_atomic64 pointer
>> + *
>> + * Return: return the counter value
>> + */
>> +static inline s64
>> +counter_atomic64_read(const struct counter_atomic64 *cntr)
>> +{
>> +	return atomic64_read(&cntr->cnt);
>> +}
>> +
>> +/*
>> + * counter_atomic64_set() - set counter value
>> + * @cntr: struct counter_atomic64 pointer
>> + * &val:  new counter value to set
>> + *
>> + */
>> +static inline void
>> +counter_atomic64_set(struct counter_atomic64 *cntr, s64 val)
>> +{
>> +	atomic64_set(&cntr->cnt, val);
>> +}
>> +
>> +#endif /* CONFIG_64BIT */
>> +#endif /* __LINUX_COUNTERS_H */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index b4b98a03ff98..00cb4264bd8b 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -658,6 +658,16 @@ config OBJAGG
>>   config STRING_SELFTEST
>>   	tristate "Test string functions"
>>   
>> +config TEST_COUNTERS
>> +	tristate "Test Simple Atomic counter functions"
>> +	default n
> 
> Nit, if you end up doing another version, this "default n" isn't needed,
> it's the default already :)
> 

Looks like I am generating v3 and will fix this one as well.

> Other than that tiny thing, still looks good to me, thanks for doing
> this work.
> 

thanks,
-- Shuah

