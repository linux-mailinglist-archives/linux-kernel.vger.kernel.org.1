Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8B2802B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgJAP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgJAP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:26:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE0CC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 08:26:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so4275831pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=82/y/EA0i/ZQ1jv6DOY04vrVUfswwsbrs8WBgai2GAY=;
        b=gtCO34hSLIQqoNY1P7QQWfBR+Q5eAD1qrQ9eXgfPZtQjcuIR+9Co7RYnNR04xqrHmh
         JIggxwK42lGRf+h0vY4rhXov07f+ao6/SRV+uksffiAltRfCYnbq3UHscyninZ05W6pt
         VSEDIoRlnSUk4xXNw2DHtIUAGJR/lGNrsjqX/FDE77QQZNEbAZXKkt0Q02/wZg5TbvO9
         atI232xA0xD28nfqyOFx09aGwqsm4M+Gk4XuPUGjGOSULxGpwXpThXKsdXsKXc9yagIS
         N4cmdPcfLcugCpPyx6ZebjdPNcbRPluuHl6O4yzAwAMHLflQaV6CajITFy3QHxYI634i
         QFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=82/y/EA0i/ZQ1jv6DOY04vrVUfswwsbrs8WBgai2GAY=;
        b=hYcgXUksvrPpI0mSDd2EOh8/8fpk9srb3eDl9sTBAzu/LIgHaKdUJlmwtQSCA/CtRG
         pwxaJNmO2jFm0rqdVX/k919b3vUqpGm0eQCqM5luNzZfnPZjbgcNDCQMrsX2WuxoOmC0
         8Tf6rR7X+/NJxyIXLTku4ZeTY1AYJlAoOoZ3N9sd1ib/ippdmJQbQOmUXgIuJwODbtKW
         rIYwIS6IKP7P7kGNF0Y0IlcvFNB6zbZULxZHJ0ncjBmkCfkBN9Yu7m4sBJcBhIpSk6Ci
         owciVJUNvJVm6fVQJqiKMGA+eoooF1njo41UM8J1EWKWsd3qBw5iiiVIQLQh/YUxiHbL
         lkjg==
X-Gm-Message-State: AOAM533ileKvmaUMulRGPToS6UrVc2a6M26x16y/KxNs2NCTubfKFjxd
        RgxHOZ2b2MgH/KAxdvREnkHH0w==
X-Google-Smtp-Source: ABdhPJw2kP0BDAN83PD86XWFMgfg6lye6MlMzA/NrVpqDQz9VRQyingDUhLdE7XhIylYp3CEwYwtVA==
X-Received: by 2002:a63:cc42:: with SMTP id q2mr6831143pgi.216.1601565999385;
        Thu, 01 Oct 2020 08:26:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::1290? ([2620:10d:c090:400::5:5718])
        by smtp.gmail.com with ESMTPSA id q4sm262425pjl.28.2020.10.01.08.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 08:26:38 -0700 (PDT)
Subject: Re: [PATCH RFC] kernel: decouple TASK_WORK TWA_SIGNAL handling from
 signals
To:     Thomas Gleixner <tglx@linutronix.de>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <0b5336a7-c975-a8f8-e988-e983e2340d99@kernel.dk>
 <875z7uezys.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3eafe8ec-7d31-bd46-8641-2d26aca5420d@kernel.dk>
Date:   Thu, 1 Oct 2020 09:26:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z7uezys.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 9:19 AM, Thomas Gleixner wrote:
> On Thu, Oct 01 2020 at 08:29, Jens Axboe wrote:
>> This adds TIF_TASKWORK for x86, which if set, will return true on
>> checking for pending signals. That in turn causes tasks to restart the
>> system call, which will run the added task_work.
> 
> Huch? The syscall restart does not cause the task work to run.

Yeah that's poorly worded, I'll make that more accurate.

>> If TIF_TASKWORK is available, we'll use that for notification when
>> TWA_SIGNAL is specified.  If it isn't available, the existing
>> TIF_SIGPENDING path is used.
> 
> Bah. Yet another TIF flag just because.

...

>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -1767,7 +1767,7 @@ static int io_req_task_work_add(struct io_kiocb *req, struct callback_head *cb,
>>  		notify = TWA_SIGNAL;
>>  
>>  	ret = task_work_add(tsk, cb, notify);
>> -	if (!ret)
>> +	if (!ret && !notify)
> 
> !notify assumes that TWA_RESUME == 0. Fun to debug if that ever changes.

Agree, I'll make that

	if (!ret && notify != TWA_SIGNAL)

instead, that's more sane.

>>  		wake_up_process(tsk);
>> --- a/kernel/task_work.c
>> +++ b/kernel/task_work.c
>> @@ -28,7 +28,6 @@ int
>>  task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>>  {
>>  	struct callback_head *head;
>> -	unsigned long flags;
>>  
>>  	do {
>>  		head = READ_ONCE(task->task_works);
>> @@ -41,7 +40,10 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>>  	case TWA_RESUME:
>>  		set_notify_resume(task);
>>  		break;
>> -	case TWA_SIGNAL:
>> +	case TWA_SIGNAL: {
>> +#ifndef TIF_TASKWORK
>> +		unsigned long flags;
>> +
>>  		/*
>>  		 * Only grab the sighand lock if we don't already have some
>>  		 * task_work pending. This pairs with the smp_store_mb()
>> @@ -53,7 +55,12 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>>  			signal_wake_up(task, 0);
>>  			unlock_task_sighand(task, &flags);
>>  		}
>> +#else
>> +		set_tsk_thread_flag(task, TIF_TASKWORK);
>> +		wake_up_process(task);
>> +#endif
> 
> This is really a hack. TWA_SIGNAL is a misnomer with the new
> functionality and combined with the above
> 
>          if (!ret && !notify)
>   		wake_up_process(tsk);
> 
> there is not really a big difference between TWA_RESUME and TWA_SIGNAL
> anymore. Just the delivery mode and the syscall restart magic.

Agree, maybe it'd make more sense to rename TWA_SIGNAL to TWA_RESTART or
something like that. The only user of this is io_uring, so it's not like
it's a lot of churn to do so.

>>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  					    unsigned long ti_work)
>>  {
>> +	bool restart_sys = false;
>> +
>>  	/*
>>  	 * Before returning to user space ensure that all pending work
>>  	 * items have been completed.
>> @@ -157,8 +159,13 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  		if (ti_work & _TIF_PATCH_PENDING)
>>  			klp_update_patch_state(current);
>>  
>> +		if (ti_work & _TIF_TASKWORK) {
>> +			task_work_run();
>> +			restart_sys = true;
>> +		}
>> +
>>  		if (ti_work & _TIF_SIGPENDING)
>> -			arch_do_signal(regs);
>> +			restart_sys |= !arch_do_signal(regs);
>>  
>>  		if (ti_work & _TIF_NOTIFY_RESUME) {
>>  			clear_thread_flag(TIF_NOTIFY_RESUME);
>> @@ -178,6 +185,9 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  		ti_work = READ_ONCE(current_thread_info()->flags);
>>  	}
>>  
>> +	if (restart_sys)
>> +		arch_restart_syscall(regs);
>> +
> 
> How is that supposed to work?
> 
> Assume that both TIF_TASKWORK and TIF_SIGPENDING are set, i.e. after
> running task work and requesting syscall restart there is an actual
> signal to be delivered.

(Also see v2 for the restart change)

> This needs a lot more thoughts.

Definitely, which is why I'm posting it as an RFC. It fixes a real
performance regression, and there's no reliable way to use TWA_RESUME
that I can tell.

What kind of restart behavior do we need? Before this change, everytime
_TIF_SIGPENDING is set and we don't deliver a signal in the loop, we go
through the syscall restart code. After this change, we only do so at
the end. I'm assuming that's your objection?

For _TIF_TASKWORK, we'll always want to restat the system call, if we
were currently doing one. For signals, only if we didn't deliver a
signal. So we'll want to retain the restart inside signal delivery?

-- 
Jens Axboe

