Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7629728051E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgJAR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:27:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25EC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:27:06 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z25so7591830iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+RJYPu41mwLqfoRk1xkYq/KaTqNR1uDzCPQN4v6bBs=;
        b=Plg8tsdRI/R7o709XKJTsq2pR+nwvNuRFyBcClgYjSYL4BRmFSM7AixIqO+5Jmsb2y
         rHPrvtQlRkqpBUC5y6bMhv8RaSi3s95fii7B2Rf9BbaGoGuuh1mwJCOBMvZhBpePMpA2
         +eBz54opKH24XqOVuX6tI2HTwKBdfHHB58CXKpGJh0ulyRu0ANTn8izynha7gdn3vmA8
         WJfFqh5VbdWfJbyR3mhBY4TamQFoCwSxdpQshXrtrvHr1fRacAd8Gy1xwxlyw9lz0TFM
         FhWC8UYLAgM3Eg8OAScGFYYUfxxdyv3lhCuA1DDgi54oE5exb9mLWdYidJkr5ISn5u0M
         cjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+RJYPu41mwLqfoRk1xkYq/KaTqNR1uDzCPQN4v6bBs=;
        b=FMTlRS38QZwECSR4CiqDYZNwIIq7wt2v3yb02vAQ84JeLMEZlcuTrIeujGdPFPcgqR
         RliqymmG7Dw3gHObcRvo8cJ93mdqxTFvXYIcvCp83T8AyCUvXOlvbj4ih9koiaPv8vuZ
         fjbWXUfKhxW3UlbckD+UuBl7JLNep6Xu9CWxo4rBRAIXqikuHqhow7JGI6b44W8Q76Mb
         nptUVL81En1L7TDUb7A5hc64I/MF0EAVtULAziMMSucO0HyEEUNTtnLLZ5uxEK3dXoGa
         zc1YRss2DfrP1iwEKVFIgScYbvL5M9keDENgYJOwJUBLJGe6FfU3XN9hqeWHzCIJXwSX
         pSHw==
X-Gm-Message-State: AOAM530wAiy4PTntN8mF8llA5MzwHxieAuT8dCsq218D+iKLHfDgcHDs
        c423Jkv7neOhyUIfZLbmH4Aw6TW2fz0Bxg==
X-Google-Smtp-Source: ABdhPJwFAsd2S+ePNELhoAW6SNZFg9nm3/YXTTQWfx/z+qPLhvZQqQDOz0rECSAO+PqVgWSN36M6Kg==
X-Received: by 2002:a05:6602:2d0c:: with SMTP id c12mr2879062iow.117.1601573225976;
        Thu, 01 Oct 2020 10:27:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e4sm2295271iom.14.2020.10.01.10.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 10:27:05 -0700 (PDT)
Subject: Re: [PATCH RFC v2] kernel: decouple TASK_WORK TWA_SIGNAL handling
 from signals
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <3ce9e205-aad0-c9ce-86a7-b281f1c0237a@kernel.dk>
 <20201001162719.GD13633@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93d57ae4-7445-31bd-6491-78ae965a8ef6@kernel.dk>
Date:   Thu, 1 Oct 2020 11:27:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001162719.GD13633@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 10:27 AM, Oleg Nesterov wrote:
> Jens,
> 
> I'll read this version tomorrow, but:
> 
> On 10/01, Jens Axboe wrote:
>>
>>  static inline int signal_pending(struct task_struct *p)
>>  {
>> -	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
>> +#ifdef TIF_TASKWORK
>> +	/*
>> +	 * TIF_TASKWORK isn't really a signal, but it requires the same
>> +	 * behavior of restarting the system call to force a kernel/user
>> +	 * transition.
>> +	 */
>> +	return unlikely(test_tsk_thread_flag(p, TIF_SIGPENDING) ||
>> +			test_tsk_thread_flag(p, TIF_TASKWORK));
>> +#else
>> +	return unlikely(test_tsk_thread_flag(p, TIF_SIGPENDING));
>> +#endif
> 
> This change alone is already very wrong.
> 
> signal_pending(task) == T means that this task will do get_signal() as
> soon as it can, and this basically means you can't "divorce" SIGPENDING
> and TASKWORK.
> 
> Simple example. Suppose we have a single-threaded task T.
> 
> Someone does task_work_add(T, TWA_SIGNAL). This makes signal_pending()==T
> and this is what we need.
> 
> Now suppose that another task sends a signal to T before T calls
> task_work_run() and clears TIF_TASKWORK. In this case SIGPENDING won't
> be set because signal_pending() is already set (see wants_signal), and
> this means that T won't notice this signal.

That's a good point, and I have been thinking along those lines. The
"problem" is the two different use cases:

1) The "should I return from schedule() or break out of schedule() loops
   kind of use cases".

2) Internal signal delivery use cases.

The former wants one that factors in TIF_TASKWORK, while the latter
should of course only look at TIF_SIGPENDING.

Now, my gut reaction would be to have __signal_pending() that purely
checks for TIF_SIGPENDING, and make sure we use that on the signal
delivery side of things. Or something with a better name than that, but
functionally the same. Ala:

static inline int __signal_pending(struct task_struct *p)
{
	return unlikely(test_tsk_thread_flag(p, TIF_SIGPENDING));
}

static inline int signal_pending(struct task_struct *p)
{
#ifdef TIF_TASKWORK
	return unlikely(test_tsk_thread_flag(p, TIF_TASKWORK)||
			__signal_pending(p));
#else
	return __signal_pending(p));
#endif
}

and then use __signal_pending() on the signal delivery side.

It's still not great in the sense that renaming signal_pending() would
be a better choice, but that's a whole lot of churn...

-- 
Jens Axboe

