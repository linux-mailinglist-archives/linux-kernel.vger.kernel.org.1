Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EE42A185F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgJaPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgJaPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:01:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B10C0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ie6so245738pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IzdzW7HufeaWNcq+Kqm0Wpk1g85nxbZcO2U5e45enNI=;
        b=vu/3i/BP9eCcnXTJjhHOAFmdy2OsC058ht9JZa0i/iwnf9IV+D3eaQZNu0AGUqDBuW
         EEyhtz5fwAOxbg09p9KViAUHU0fuRdi/+H7X1xXSh4811GzEYCJhR7K9BuTjAyZS+/qX
         A+6pvLfjdb3NyezdZ7fKbAVZh1y2u3+9qHkRWFzgAmkpZhf0yq+jHGCIFXFfd+I0T+gb
         KQCI6Y+GMi63PMSs3kTS/AIZ9wwGlEm5DhQoRVV0zSefCmWJDnyjXiiYO+k7FVDZ0nKJ
         qLLEbpBxWtqpaZN/mvyuD3ILuJqw0ZdFVzRZ9xvzJBwrSs0en8ApBHP0l5FlaMLVl/Jz
         G//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IzdzW7HufeaWNcq+Kqm0Wpk1g85nxbZcO2U5e45enNI=;
        b=g5sa/3WLB8rGRmUzCaYeN/kebycNEInxPdU8KweduRtHhk28YCElbbrGD844n23HAd
         SQ/RxQUiqJmF+COPp4Xb28CuEaq5nFLT6sRhAKXxaEzzQhUy+O4dGlk4LsC7NfCIaulT
         vni4WsPsDU9hGETyd+z0iD9po+SxWnnDEBwXbWTXb4h3q+WvAv75MvnCwtXa4gU00UJp
         gILHi9n/QOIrgIKYX2tQNsEmSL9Tf3WiWEm1IvtGqPOw/eMCIBTJ8uE/Pfdqf4bv1fhq
         qjZpmb7gdICGYgE18yUz4OLklF4b385BwC3eVeq0zfKGzZIYdEFx5hh1GJkgNqRt0ORJ
         Q3zA==
X-Gm-Message-State: AOAM533vBKOHaezxbS16lsJFNVIHzZmX3qr4mk/MjCivFhCUGgSzTVeK
        AAQ7vy1l8aOI4HE6IFGXJ2uVQg==
X-Google-Smtp-Source: ABdhPJxggFNgHxmkwNg2huq2Nl54NCr+NcjcHDy6RCTiJuk2PhrAcd5HI3wIQpdeZwrt3+si9bK/Mg==
X-Received: by 2002:a17:90a:c7c1:: with SMTP id gf1mr920814pjb.87.1604156507517;
        Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z3sm9140176pfk.159.2020.10.31.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
From:   Jens Axboe <axboe@kernel.dk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Message-ID: <76005875-1cfd-fb35-07f4-d35877d58b90@kernel.dk>
Date:   Sat, 31 Oct 2020 09:01:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/20 9:00 AM, Jens Axboe wrote:
> On 10/31/20 4:41 AM, Sebastian Andrzej Siewior wrote:
>> On 2020-10-29 14:07:59 [-0700], Sagi Grimberg wrote:
>>>> in which context?
>>>
>>> Not sure what is the question.
>>
>> The question is in which context do you complete your requests. My guess
>> by now is "usually softirq/NAPI and context in rare error case".
> 
> There really aren't any rules for this, and it's perfectly legit to
> complete from process context. Maybe you're a kthread driven driver and
> that's how you handle completions. The block completion path has always
> been hard IRQ safe, but possible to call from anywhere.

A more recent example is polled IO, which will always complete from
process/task context and very much is fast path.

-- 
Jens Axboe

