Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1B2F336A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbhALO6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbhALO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:58:08 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D699C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:57:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w18so4661544iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8cAC6W8EP8v2kz4Pqmyj0XUUN1a4NamLvxdd/3zGXE=;
        b=uPsGugOd/r/XLDFP7bKybOAeOBHVUUlGZD4F7spjrWcMsRPAXgLYNxbyb9lhieGNfL
         8uQP+9A47ZGXl3xenI8QSTm54+B/JbJgk1GeXoNNbafCwtgMG1MtpWZ9+z2JZTRbNMW5
         0c3/2iiPYddKPWhiuOxX3+dK5BnW604IPRd8nsrn6PURj3nD3a7u3U5xcgeGAmBmUcHq
         3oqA47kB5YPvvnADcFTGXFGlhPBAFaGd1FOFnSQP27zSO/+EV1FFaLex8L+ry7+SkzDj
         PfB5bT2izfxNh68ovJTZNvGvzKCYKvxbBMR6ZOIJRY7szgDDnRV5bzAd0MdcDW0fqcU1
         ZTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8cAC6W8EP8v2kz4Pqmyj0XUUN1a4NamLvxdd/3zGXE=;
        b=S27/PFl60COXfK1ZXJqoX78IYsKraivMy0V5KWzvcfgvbhJEtIUGEzgaYisWx1/lFx
         phFP/LrlXbLDpFirHr33gLvaU2OgXaVcENnVPxjKIkK0jHzPWsmAZzcGCseVrO0uLIXx
         47dZyiTcYdE9j4WlUwq6NaGAcjVOr44yPdAT/YF+sMibv4E1ihQHOFOMmCCQwXu8+AP6
         njsFsjqec+g+4W4qvyXh1jY/76XyCfthM229vBqdXj2RRnydL+gRukEk2S0OB8Z+8V3w
         G2u88p7JWyTyQkljuEzH6awIHmp8MUuckVJhCA1g/l3DnXwb9px+3+EUwNz1zef6scjX
         Q+GA==
X-Gm-Message-State: AOAM532AREaH5ablFaKpJ9JjeTDl0hwwWLa3NmCbCx6VUmOyRB5a4TRA
        SIwt7tHVMCd/aa8nowr9hsfo2Q==
X-Google-Smtp-Source: ABdhPJwzQTc7uNYxdzeUSw4X1PHAwo+zkoyC9wVKHyV1W5qXznUwTwkO6rGoRGIcwtt7OijLQK+QFA==
X-Received: by 2002:a5e:a614:: with SMTP id q20mr3587305ioi.198.1610463447562;
        Tue, 12 Jan 2021 06:57:27 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n11sm2040414ioh.37.2021.01.12.06.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 06:57:27 -0800 (PST)
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5b0f650-5dc1-c67d-f548-340e7ca54d41@kernel.dk>
Date:   Tue, 12 Jan 2021 07:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhj7doj1dr1.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 12:21 PM, Valentin Schneider wrote:
> On 11/01/21 18:16, Peter Zijlstra wrote:
>> Sadly it appears like io_uring() uses kthread_create_on_cpu() without
>> then having any hotplug crud on, so that needs additinoal frobbing.
>>
> 
> I noticed that as well sometime ago, and I believed then (still do) this
> usage is broken. I don't think usage of kthread_create_on_cpu() outside
> of smpboot makes sense, because without any hotplug step to park the
> thread, its affinity can end up being reset after its dedicated CPU gets
> offlined.
> 
> I'm clueless about io_uring, but if it *actually* has a good reason to
> use some pcpu kthreads (it seems it doesn't have to be on all CPUs?),
> then it needs to register some hotplug step to park them / do something
> sensible on hotplug.

For io_uring, it's purely used by the SQPOLL mode, which sets aside a
kernel thread for submissions so the application doesn't have to do
anything but write new SQE entries to submit. The thread then notices
these, and submits them. There's an option to affinitize that thread
to a single CPU, which often makes sense for setups like that. Think
of it like a strong hint.

Things aren't going to break if this CPU goes away and we end up being
affinitized to some other CPU, though it is suboptimal. So I guess we
might need some notifiers to ensure that we reset the CPU back again
if it's gone offline+online again? I can take a look at that.

-- 
Jens Axboe

