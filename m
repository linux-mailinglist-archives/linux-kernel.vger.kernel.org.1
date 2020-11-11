Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7368E2AF7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKKS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKKS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:28:15 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF0C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:28:15 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so2845386ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qP0MFJQneS6o093B0Yu5YM9hNevkDE0K7N59r8X3Qgk=;
        b=NdWu3R/qDj3xIk1uD8EGdw74GeMEZbhHrtP7L0W1UogKdu5CnXplA+z6KCyeoSeFfD
         LwqFxBIz/32jJUHw7DI2JbEUfwzaOvj9inf7YQymSN9dM2zpwtKRBIgj3ASRcIhHKVQQ
         gYOrYR0mDDpOFIbqL+Y9DUJ2+8XTWQJkASUAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qP0MFJQneS6o093B0Yu5YM9hNevkDE0K7N59r8X3Qgk=;
        b=F9VxMNRM5ezXZd2CgmDzLUwPc/Q8+E+XB/ZwfO32p0mfACegiHqK6HfqJJOdRkTtkN
         TmToyBa3clobyuF+Dpw8LJscODeko0bSFXswsY/rNF0ITIWAm4YNLmsLQLhou6jsxBe3
         cOF8Jm56ZlIh1Xy8xtayK5wDHdxcUUyNHXcXcueNq86e/dQ29NTiglir5igM1aym/iYr
         Q1QymH54hoK/TJBWbxJpxwnWlxTB0LbVWbmtdfiWnMSvBbHVtRedswse0P5s6wBhexcL
         cXY6RX3WQTKmZEf0x5yJKw8OHdB6eL2iLZZQJWJ0vCj0cnhuRK2kHR3QhX2j18VbNkZP
         IV4A==
X-Gm-Message-State: AOAM532HVIaPHLQ5uufNR1UsSCQcz/vdY+jttA3hyLhHuFFL4gP9G+Er
        gDI2hrXexeA0sf43bXsTlh5GzQ==
X-Google-Smtp-Source: ABdhPJzozMlBWriwx1fqAHsI5fF36/jcoQtAa9L8fGDGnYBPwHzc/1bxV/EvkmSNQ43tbU0f9kbGlA==
X-Received: by 2002:a92:c88c:: with SMTP id w12mr20906915ilo.204.1605119295155;
        Wed, 11 Nov 2020 10:28:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o124sm1655462ila.62.2020.11.11.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 10:28:14 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
 <20201111160411.GF2628@hirez.programming.kicks-ass.net>
 <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
 <20201111175031.GI2628@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0aed620f-911d-4715-bd41-a6b9a37862b4@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 11:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201111175031.GI2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 10:50 AM, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 10:34:05AM -0700, Shuah Khan wrote:
> 
>> Not sure what to make of the 6080 atomic_read()s and 3413
>> atomic_inc()s, some of which might be assuming uniqueness
>> guarantee.
> 
> Well, clearly you just did: git grep atimic_{read,inc}() | wc -l and
> didn't look at the usage. Equally clearly there can be bugs. Also
> evidently much of those are not in fact sequence numbers.
> 

Looking at the usage and classifying which usages are sequence
numbers is part of may audit and we are covered. Your explanation
and this discussion helps with do a better audit of these usages.

> All I'm saying is that if you want a sequence number, inc_return (or
> fetch_inc) is the only sane option.
> 

Cool.

thanks,
-- Shuah
