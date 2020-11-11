Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F72AF769
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKKReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:34:07 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FECC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:34:07 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r9so3101005ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x+ZPIkewGIyEZqSMZxkzFb7eDMb8iLSX2JxWgENS124=;
        b=RPGnXMovCFux6DPWtNZll3p5WD/5MIG0O1M0Ddi5GmAaZhBPkCQX3w+xN1lF9COB5E
         l23astO6NnwIHkEudqwKqfzveu2eHSQI1LYNabs2/VIapZ8M+htKlJWreJQ0U+xhS26X
         s3K4a/EVxmMeqy3bb6jJu0gYlk9B8DKvqJAfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+ZPIkewGIyEZqSMZxkzFb7eDMb8iLSX2JxWgENS124=;
        b=ovXeLBtfeFcNy+Si40EAmGwBW9yJ4aglL00vLbOZhagMUylPXjHlxXhI74Abb6JHA2
         cHROysWfFXhiEnXd/tDw8MFELZGrWBGdrrm4hiDH9dOXqs+w39Dtm+/lXvU8Nwlw4Vi/
         VIs0RF+LnVRB6mTbil271UcCup7bln3L/3q1944RhZzv7IZdrNaWbOnz0/h3q3rJGX5J
         c1eMw1JejXQ8L8ZVwXUdpAo/38D3gsTnwgqZKY4LdKDNNA11enB+XEVVDkPMo391pNOj
         nPxNw/S7LpoBUhLO9IZRGsPNJ/61iALr+DrO+JZJkch3bo48PZXxs5eBy0+D+/0Wajll
         KEbg==
X-Gm-Message-State: AOAM533wkUFgDAXrHQJmJvH05+D0aR0IL78rzsQlQ0M6DKr1BcjSQzwE
        XiO6E99RRK189WGlrgnQNrRdVA==
X-Google-Smtp-Source: ABdhPJwNf8L4kqcjShlFmCr/CVIXtDb2BUdeXRUd5wep5sqvAJ4Zu8Fu8DJir5l/g0orc03wtylz3A==
X-Received: by 2002:a05:6602:242e:: with SMTP id g14mr19440875iob.65.1605116046781;
        Wed, 11 Nov 2020 09:34:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u1sm1609915ili.55.2020.11.11.09.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:34:06 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
 <20201111160411.GF2628@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 10:34:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201111160411.GF2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 9:04 AM, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 08:56:49AM -0700, Shuah Khan wrote:
> 
>> Why would you say no to read and inc?
> 
> Because they don't guarantee uniqueness (bar wrapping), which is the
> only reason to use an atomic to begin with.
> 

Thanks for the explanation. I see what you are saying.

Not sure what to make of the 6080 atomic_read()s and 3413
atomic_inc()s, some of which might be assuming uniqueness
guarantee.

As far as the sequence number api is concerned, I am with you on
not exposing read() and inc().

inc()s can just map to inc_return().

For read():
In the context of up counters, there is a definitely a need for get
current value type interface that guarantees uniqueness - similar to
inc_return without actually incrementing.

I will work on v2 based on the discussion.

thanks,
-- Shuah

