Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBA2E6C42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgL1Wzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgL1UDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:03:30 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:02:50 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id j21so2430808oou.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cxo7+Eb/s8AmmVwBRb/+vzM4fAG6GPBf/uTK6nrLuq8=;
        b=dQ4r+++DXKxQy2wROU/IYHX4p0ppBhsfDJfoEcl2hdADUrlhr2yo3m+FZ87mFkU853
         sHJBI464+Q9j/VylomoFo5VkeG/EYFvZBp2YFclKbJNV+rxaCABqfcc2KxydiTHTZAOU
         JzLHjGQcLaT6yjGMVtnk78+5edOmPHPgdigm/QWhqWvv7PlBQZvW9PLecp/SJkNURzhs
         WduAJUPG19/BB+ZXxkXt5KUQ4SsNIef4cHIoY+scFeqr7q7mhZwP3wzlDbOd979lWNe2
         LYhi/Z9oQt6oEtNnUZkaVPddivnw0ixqM3FHNElrkVfNaGZmfqCasAcTDsu0hd1STwGs
         rNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cxo7+Eb/s8AmmVwBRb/+vzM4fAG6GPBf/uTK6nrLuq8=;
        b=CtOlhWa38gVzz6QkupawjIx/J4u3k35x5aLexD6Vn9W8KwP3q0zHoaYCwIyKLybamZ
         kAJViWQ+qv8YLDzv6WcYwA7l23zWK4FRS63/PkkaNKCe2/Wacyrx35flCA6t5f2D0+Ut
         jYGHiWayg1cqTJ8McpzXkhfgdn/b8YdkbSqolCkSfPMqZgdpCmqE2B8YfwvRXp/YEJKC
         3tCc8Ws/L0U4U/Njou3zlRee+QCf67HDMCfIAyjFqag155PbUxEbW36t0u7xqaXKatgT
         H4zXZfIId7ypy8ogViloU0esAn1Z892eAWY1f48qfqaBM/CVheqrLcLCN4+QJov2ZEZs
         Xjrw==
X-Gm-Message-State: AOAM530wR/CrYaiA9yi/J48tDtts8zjcNlFOW/0OZYuviqf4Xi36lYIZ
        r6rdg6UpLaTVjXQmLlewYfQ5tRIvpIk=
X-Google-Smtp-Source: ABdhPJx0HtPLtpEOFSrxMVPfLugX4OQPxmXe5tKFRg59FFxttu9R1+ovnZlgXStAuvSd31mzsHafkQ==
X-Received: by 2002:a4a:98a3:: with SMTP id a32mr31602138ooj.51.1609185769489;
        Mon, 28 Dec 2020 12:02:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 31sm9411530otd.24.2020.12.28.12.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 12:02:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Kalesh Singh <kaleshsingh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
 <20201228155149.GA197954@roeck-us.net>
 <CAHk-=whHbfec+vxjpCXhRdSwA7uw6m0hS9kGqqJv6Af0EMFVBw@mail.gmail.com>
 <CAC_TJvfpeRh322usynr2Ud3KVCd3HaNnviOmdhekXSnC-sq2sA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d90c77a4-df89-bc69-04e0-c8deaf365db3@roeck-us.net>
Date:   Mon, 28 Dec 2020 12:02:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAC_TJvfpeRh322usynr2Ud3KVCd3HaNnviOmdhekXSnC-sq2sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/20 11:37 AM, Kalesh Singh wrote:

[ ... ]

>>> parisc: Failed to execute /sbin/init (error -12)
>>>
>>> Caused by: c49dd3401802 ("mm: speedup mremap on 1GB or larger regions")
>>
>> Looks like Kalesh is looking at it.
>>
>> I don't think that was supposed to matter at all on parisc, but
>> clearly something bad happened.
>>
>> parsic doesn't even enable HAVE_MOVE_PMD, much less the new
>> HAVE_MOVE_PUD. Strange.
> 
> Hi Linus,
> 
> I had sent the fix for this issue which was taken into the -mm tree by
> Andrew. (https://ozlabs.org/~akpm/mmotm/broken-out/mm-mremap-fix-extent-calculation.patch)
> 

... and I even tested it. Sorry, I should have mentioned it. For some
reason it completely left my mind.

Guenter
