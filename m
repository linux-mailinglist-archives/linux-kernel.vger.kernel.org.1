Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BB2B69AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKQQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgKQQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:37 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09840C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:15:37 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id m9so21694039iox.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xs5k6YmbTpMovlIFJB8mdshUmOv20DI0EOKiJyCm2p8=;
        b=RqPHXFKC0r07EUj3VDcH44zvE4ccrWVVfCttCRK9UoI2TgwDNQBdZdboesMHvSaobF
         j3xKWyla3OTvIL3oWpC/u07BBWaqSRKc1aKdihR5KaniKEhFtrFRTsxIVDeVza93G12C
         Nc4ZAWQPtwO1+lCH+Tu9yc+kZnCSKCadNtqV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xs5k6YmbTpMovlIFJB8mdshUmOv20DI0EOKiJyCm2p8=;
        b=l0q7am7PVvEb5tjnA5tUs0Ga8IZAPwxZwGWz4bAh1cHF+Yhj6OWUXB04OasCgOtN9L
         7GFMJTm/+iJAfPuVgEx5i/0gG+EIt2Wq5HAEo88Z172HBg8UK2SINiSRLzcqtVArLZms
         3i5CydC7IxaEbeka+Pr0ccStfboGNX7BO5GCANCMolHRoOekKbRVJ9fhLPEZWOOJP75R
         9OvHzvXhPiOmGZenn8Tq/vkU/6h3TMz8o9Up0aNwGRi1PbUixhbvBQYqAD0cuvjgdxj0
         OggGjUN+r+GQGudMIxTKWcpyLhG3aP+iB4T/rgzD44Uy6peE5GRC+a8ulZGWWo7s2/Zj
         YKGg==
X-Gm-Message-State: AOAM5309XI8Jdk8L5BE37FhL1r/lIELI/S/P5g0/ztBAJeNZnjPyJnNA
        wAGFSwGgVJlc+XYM5JxpNcrXaMdD20fM1A==
X-Google-Smtp-Source: ABdhPJzPxtjW4UEbWguV0tGH3zB08KjlVyyfqkpm6Q82roW+c92WTHp3RBzgnBHcoeKGOPtNlA9tXg==
X-Received: by 2002:a6b:fb07:: with SMTP id h7mr12048193iog.163.1605629736300;
        Tue, 17 Nov 2020 08:15:36 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y3sm10847573ioq.18.2020.11.17.08.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 08:15:35 -0800 (PST)
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201116145309.GF3121378@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <105a8806-7a44-1b1e-f77c-4471cc9e1f17@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 09:15:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201116145309.GF3121378@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 7:53 AM, Peter Zijlstra wrote:
> On Fri, Nov 13, 2020 at 10:46:03AM -0700, Shuah Khan wrote:
> 
>> +Increment interface
>> +-------------------
>> +
>> +Increments sequence number and returns the new value. ::
>> +
>> +        seqnum32_inc_return() --> (u32) atomic_inc_return(seqnum)
>> +        seqnum64_inc_return() --> (u64) atomic64_inc_return(seqnum)
> 
> Did you think about the ordering?
> 

Looking at atomic_t.txt _inc_return() can be fully ordered without
loosing or making the intermediate state visible. This is good for
this sequence number use-case. Is there something I am overlooking?

>> +Fetch interface
>> +---------------
>> +
>> +Fetched and returns current sequence number value. ::
>> +
>> +        seqnum32_fetch() --> (u32) atomic_add_return(0, seqnum)
>> +        seqnum64_fetch() --> (u64) atomic64_add_return(0, seqnum)
> 
> That's horrible. Please explain how that is not broken garbage.
> 
> Per the fact that it is atomic, nothing prevents the counter being
> incremented concurrently. There is no such thing as a 'current' sequence
> number.
> 

Correct. Some usages of this _fecth() in this patch series are for
printing sequence numbers in debug message and others are stats.

I will review the patches in this series and drop the ones that use
read/fetch - the reason being sequence numbers are strictly up counters
and don't need read/fetch.

thanks,
-- Shuah





