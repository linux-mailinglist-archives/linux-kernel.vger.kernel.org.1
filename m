Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118432AE3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgKJW6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgKJW6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:58:50 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C9C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:58:49 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so169406ilt.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jmb/o79cv2bZ/x6XX14phanTrgenPgbAo9xKj20lQ+M=;
        b=WJi5tW8uGgd7ZtOqMWIb+RZ9EfkEd1Zbdp7Z3xhmkUmUTVidlzjWOOXiUqTOSHSb9N
         AX21ua0H4EF2nyiyLh7k3V2K3zyvM2dN/6ef5oNLLddJ6lE9E6YWC1KV0AzLMC3a+Ykp
         LiOmdYO0nsWMhWvc8oPpY8K1H08d3g93XoZwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jmb/o79cv2bZ/x6XX14phanTrgenPgbAo9xKj20lQ+M=;
        b=JLKDWZlmNb72Te52wpNzeiuooBsB5oJHFNIx5t+VggQ2x04OV0oLWxxhae0AZdV8yi
         aMlC7D0J5XtdQWW9v+kR2L9WE6jeLaBEmSwYDnWVAdMvJez0xi1ui3HUkO0Bhf6cDQLH
         S9/GPXH0OJCGSPiRutu6XAGUkVnbxAuLGmq0DjeNDAs57liMTW9pWL/+b59CRqGrHvmu
         3DKtHg2bv14PusdzRLmgm7Odg9e/5yaq/cFSko0dPq2D8AdJKRbwaGWw7ZwhHTpQpcEu
         UIRgs7LRdvQpvToOglJJ4XJ1t+a33OIX5II7zqVc1wmsxoRRIC3UKEArysUah3fW5h1Z
         lqmA==
X-Gm-Message-State: AOAM532K7KxrE2W1PylfsZIxqjsIUWMbxFKJ3wUt1PEmxanwN/Z44LA+
        aKoKqVwXtNP3FiOmkw72CcuH2g==
X-Google-Smtp-Source: ABdhPJz3wyTzSRzlVMZdQL8h4QSqHft28+nWbmp40Gv09GnNJNX+OL/bryYFrDSADelWkwq/sWDCjQ==
X-Received: by 2002:a05:6e02:ce:: with SMTP id r14mr16715967ilq.240.1605049129210;
        Tue, 10 Nov 2020 14:58:49 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g1sm52338ilk.84.2020.11.10.14.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:58:48 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201110210316.GO17076@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11b5153f-e092-d1c9-deb1-e81a171bb866@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 15:58:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201110210316.GO17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 2:03 PM, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
>> Sequence Numbers wrap around to INT_MIN when it overflows and should not
> 
> Why would sequence numbers be signed?  I know they're built on top of
> atomic_t, which is signed, but conceptually a sequence number is unsigned.

Yes we have some instances where unsigned is being used. I considered
going to unsigned. Changing the API to unsigned has other ramifications
and cascading changes to current atomic_t usages that are up counters.

git grep -E '\((unsigned|unsigned int|u32)\).*\batomic.*(read)' | wc -l
53

A total of 53 out of 6080 atomic_read() usages force return type to
unsigned.

git grep -E '\((unsigned|unsigned int|u32)\).*\batomic.*(inc_return)' | 
wc -l
11

A total of 11 out of 620 atomic_inc_return() usages force return type
to unsigned.

Changing the API to unsigned has other ramifications and cascading
changes to current atomic_t usages that are up counters.

We could add unsigned to seqnum_ops though.

> 
>> +++ b/Documentation/core-api/seqnum_ops.rst
>> @@ -0,0 +1,117 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +.. include:: <isonum.txt>
>> +
>> +.. _seqnum_ops:
>> +
>> +==========================
>> +Sequence Number Operations
>> +==========================
>> +
>> +:Author: Shuah Khan
>> +:Copyright: |copy| 2020, The Linux Foundation
>> +:Copyright: |copy| 2020, Shuah Khan <skhan@linuxfoundation.org>
>> +
>> +There are a number of atomic_t usages in the kernel where atomic_t api
>> +is used strictly for counting sequence numbers and other statistical
>> +counters and not for managing object lifetime.
> 
> You start by describing why this was introduced.  I think rather, you
> should start by describing what this is.  You can compare and contrast
> it with atomic_t later.  Also, I don't think it's necessary to describe
> its implementation in this document.  This document should explain to
> someone why they want to use this.
> 
>> +Read interface
>> +--------------
>> +
>> +Reads and returns the current value. ::
>> +
>> +        seqnum32_read() --> atomic_read()
>> +        seqnum64_read() --> atomic64_read()
>> +
>> +Increment interface
>> +-------------------
>> +
>> +Increments sequence number and doesn't return the new value. ::
>> +
>> +        seqnum32_inc() --> atomic_inc()
>> +        seqnum64_inc() --> atomic64_inc()
> 
> That seems odd to me.  For many things, I want to know what the
> sequence number was incremented to.  Obviously seqnum_inc(); followed
> by seqnum_read(); is racy.
> 
> Do we really want to be explicit about seqnum32 being 32-bit?
> I'd be inclined to have seqnum/seqnum64 instead of seqnum32/seqnum64.
> 
>> +static inline int seqnum32_read(const struct seqnum32 *seq)
>> +{
>> +	return atomic_read(&seq->seqnum);
>> +}
>> +
>> +/*
>> + * seqnum32_set() - set seqnum value
>> + * @seq: struct seqnum32 pointer
>> + * @val: new value to set
>> + *
>> + */
>> +static inline void
>> +seqnum32_set(struct seqnum32 *seq, int val)
>  > You have some odd formatting like the above line split.
> 
>> +static inline void seqnum64_dec(
>> +				struct seqnum64 *seq)
> 
> That one is particularly weird.
> 

Thanks for catching these. This code needed cleanup after the
rename from a looong names from previous version.

thanks,
-- Shuah
