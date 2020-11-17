Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A12B6A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKQQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgKQQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:34:29 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A82C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:34:29 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so19151899ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RqplN2MiH2RjrN8xmsMKxzO1axkoRnoqOLkoBb/frOA=;
        b=VFL2449HKDpbkT2SJgPuvTAvv3Cqpu1i8x/oHlk9UGYPr2pCkqDpashemizpuoBxLT
         UkTLFs5Lkn9jzbTTDQnKHWomHDRI3U3xEbwB6A5UjqGPkNzJMwPgWLwmRKYbgRUfoLd/
         2m3jnnW4g2b9Vl5Dkv631xzB0zy6fTk4acBjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RqplN2MiH2RjrN8xmsMKxzO1axkoRnoqOLkoBb/frOA=;
        b=IoLQYeyCznd3FfitFOLJHUTgGjOxOaslAkDU34inUna0ttEh2bY6zPvLcuFGTsF6Ec
         Mucc8AXTRq+fV2XchP+7sv+DXZdwjSM/KHzViZc+pTyP9oItrYT6Ih/D4mdvktn9WkPi
         pnXKlnBQcmj2rrK1N2I3tRWeF+n9fCM9Zdz8+xfH6ZvzJJdOL499Sz7/mD+DftBVtYRl
         HAORWBJM81dOIGCdIxPXTCU9VqYkEInsPTqdz4i4DlT3hq6heSKzATRjALVUz97F8oBY
         PQXNzOQg/0OewPXTxp6pxlZFB+wxGCnnpMo0+J/4jwWf16rkZPZWhvCS3Jm2OUDjmGWP
         Gn4A==
X-Gm-Message-State: AOAM533mSVzGC1GRA9VUyQghSJMt2ipP4ntdie2mZuRGsy/wn3hJi/KF
        UI7x6VGSP1copcdLm0ohgqx2MHCIvO+Pyw==
X-Google-Smtp-Source: ABdhPJw/mA/iYQQSv4k/JHfC31cbAasPx1/IXtRaSmWLoORQI1uHOTMDjYnK1igIhgEr3YUPsnjFjw==
X-Received: by 2002:a92:5b8c:: with SMTP id c12mr13558561ilg.293.1605630867532;
        Tue, 17 Nov 2020 08:34:27 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x25sm9425546ioa.23.2020.11.17.08.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 08:34:26 -0800 (PST)
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <13467f88-7e22-ce3e-60b6-44e7c3dfa7dc@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 09:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201113210327.GJ17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 2:03 PM, Matthew Wilcox wrote:
>> +==========================
>> +Sequence Number Operations
>> +==========================
>> +
>> +:Author: Shuah Khan
>> +:Copyright: |copy| 2020, The Linux Foundation
>> +:Copyright: |copy| 2020, Shuah Khan <skhan@linuxfoundation.org>
>> +
>> +Sequence Number api provides interfaces for unsigned up counters
>> +leveraging atomic_t and atomic64_t ops underneath.
> 
> As I said last time you posted this, the documentation is all
> back-to-front.  You're describing what it isn't, not what it is.
>

I will rephrase it to read better.

>> +There are a number of atomic_t usages in the kernel where atomic_t api
>> +is used for counting sequence numbers and other statistical counters.
>> +Several of these usages, convert atomic_read() and atomic_inc_return()
>> +return values to unsigned. Introducing sequence number ops supports
>> +these use-cases with a standard core-api.
>> +
>> +The atomic_t api provides a wide range of atomic operations as a base
>> +api to implement atomic counters, bitops, spinlock interfaces. The usages
>> +also evolved into being used for resource lifetimes and state management.
>> +The refcount_t api was introduced to address resource lifetime problems
>> +related to atomic_t wrapping. There is a large overlap between the
>> +atomic_t api used for resource lifetimes and just counters, stats, and
>> +sequence numbers. It has become difficult to differentiate between the
>> +atomic_t usages that should be converted to refcount_t and the ones that
>> +can be left alone. Introducing seqnum_ops to wrap the usages that are
>> +stats, counters, sequence numbers makes it easier for tools that scan
>> +for underflow and overflow on atomic_t usages to detect overflow and
>> +underflows to scan just the cases that are prone to errors.
>> +
>> +In addition, to supporting sequence number use-cases, Sequence Number Ops
>> +helps differentiate atomic_t counter usages from atomic_t usages that guard
>> +object lifetimes, hence prone to overflow and underflow errors from up
>> +counting use-cases.
> 
> I think almost all of this information should go into atomic_ops.rst
> pushing people towards using the other APIs instead of atomic_t.
> Someone who already landed here doesn't want to read about refcount_t.
> They want to know what a seqnum_t is and how to use it.
> 

Looks like this is resolved with atomic_ops.rst is now gone.

>> +Sequence Number Ops
>> +===================
>> +
>> +seqnum32 and seqnum64 types use atomic_t and atomic64_t underneath to
> 
> Don't talk about the implementation.
> 
>> +leverage atomic_t api, to provide increment by 1 and return new value
>> +and fetch current value interfaces necessary to support unsigned up
>> +counters. ::
>> +
>> +        struct seqnum32 { atomic_t seqnum; };
>> +        struct seqnum64 { atomic64_t seqnum; };
>> +
>> +Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
>> +information on the Semantics and Behavior of Atomic operations.
>> +
>> +Initializers
>> +------------
>> +
>> +Interfaces for initializing sequence numbers are write operations which
>> +in turn invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
>> +
>> +        #define SEQNUM_INIT(i)    { .seqnum = ATOMIC_INIT(i) }
>> +        seqnum32_init() --> atomic_set() to 0
>> +        seqnum64_init() --> atomic64_set() to 0
>> +
>> +Increment interface
>> +-------------------
>> +
>> +Increments sequence number and returns the new value. ::
>> +
>> +        seqnum32_inc_return() --> (u32) atomic_inc_return(seqnum)
>> +        seqnum64_inc_return() --> (u64) atomic64_inc_return(seqnum)
> 
> seqnum_inc() should just return the new value -- seqnum_inc_return is
> too verbose.  And do we not need a seqnum_add()?
> 

I had the patch series with seqnum_inc() all ready to go and then
revisited the choice. My thinking is that matching the current atomic
api that has _inc() and inc_return() might be less confusing. That
being said, I have no problems with making just _inc(). The reason
for 32 and 64 appended is based on comments that it including size
in the api makes it very clear.

No need for atomic_add() - inc_return() is sufficient for this use-case.

> Also, this would be a good point to talk about behaviour on overflow.
> 

I can add some overflow information.

thanks,
-- Shuah

