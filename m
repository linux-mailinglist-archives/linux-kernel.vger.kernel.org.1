Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC128182C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgJBQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:42:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE622C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:42:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n16so1810987ilm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhjFNfnbCE2fgq1fxzPXaRjdBmMXk/MnPnFlaVTqIKk=;
        b=bOrjxhPOJLd7Dm6msR3QqW6hWHpEUcdr4Vybvo5bA+dHT2Gn9hVIerO6jVPp1tO342
         bBOsD59vegOm4Y+gLXdmd7Cl5KwKyOXMSzhMQrT/JgkST3q9gBlE8qqEe70TJrgCcCMi
         rAUD8r3sKLAdWqXTPSc8jMUj0k1OmbDnnCYhIr6FWASw0BUQhcpnObSDZNTrBpKD8M9n
         kZuWcKP/VxqjEiWPOkMKfUfhZNCKw1OX0oLzn4+m7JxeMzT4mkP6Azf/1mqzc5f6MSWG
         GbJyj34RwU7ym5lwEb0VL+BKXeILJVLrpOcQiNOedAt+xoW029Xjqujv2oHQNSVQh5G9
         Skfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhjFNfnbCE2fgq1fxzPXaRjdBmMXk/MnPnFlaVTqIKk=;
        b=JMvLKGiq4DTSJU/RRBa3X+FTJJUw9hG69p9yKu/KA6G14aPO/EE8NsrFRGkym3nWIH
         o4wY8ljOdw3i1xQpeApABxPfSt4PZFGPgLDG3gfiAsyDPXUWuLCQQd9pkIm5Tgjc6Qs0
         QFQF3hh5ifsost+vJ9grU7qV0o6iH84iHRR3rKG4/BeKac2uTgfx89nsxrFmlm1FQfwP
         FJ7TJrUxgWP8npxhplvmeuywSaD+iVBVGhxuhwB/mMG+hBnS/I1QhjDpI8hTkCg2T4+5
         vC2Bg+/R7Gt/D42NbpDH9Q3gs9LLqBGdD6uZsCThSjVsxwjGlH8k9TCCfX1+ntgV/QIR
         ZKmg==
X-Gm-Message-State: AOAM530pjzdBS/1PgdP4lthzmLmvEdvrEnwwe6XvbTixr7nWnjAjlNkp
        GpqNePh24ARzW+3RMp24U+UqRg==
X-Google-Smtp-Source: ABdhPJw6XIrTX2m6rvA6FidaORbS74bGUd9GpZc2hM9emP6kKZcI1yfCJ1/1rSx2snwrYaOTOps5fw==
X-Received: by 2002:a92:9a82:: with SMTP id c2mr2434591ill.285.1601656967169;
        Fri, 02 Oct 2020 09:42:47 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v17sm1009789ilj.58.2020.10.02.09.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:42:46 -0700 (PDT)
Subject: Re: [PATCH 3/3] task_work: use TIF_TASKWORK if available
From:   Jens Axboe <axboe@kernel.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org
References: <20201001194208.1153522-1-axboe@kernel.dk>
 <20201001194208.1153522-4-axboe@kernel.dk>
 <20201002151415.GA29066@redhat.com> <871rigejb8.fsf@nanos.tec.linutronix.de>
 <4c9dbcc4-cae7-c7ad-8066-31d49239750a@kernel.dk>
Message-ID: <5455ddd4-5257-f185-052b-ba0bb37ec5d8@kernel.dk>
Date:   Fri, 2 Oct 2020 10:42:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4c9dbcc4-cae7-c7ad-8066-31d49239750a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 9:52 AM, Jens Axboe wrote:
> On 10/2/20 9:31 AM, Thomas Gleixner wrote:
>> On Fri, Oct 02 2020 at 17:14, Oleg Nesterov wrote:
>>> Heh. To be honest I don't really like 1-2 ;)
>>
>> I do not like any of this :)
>>
>>> So I think that if we are going to add TIF_TASKWORK we should generalize
>>> this logic and turn it into TIF_NOTIFY_SIGNAL. Similar to TIF_NOTIFY_RESUME
>>> but implies signal_pending().
>>>
>>> IOW, something like
>>>
>>> 	void set_notify_signal(task)
>>> 	{
>>> 		if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL)) {
>>> 			if (!wake_up_state(task, TASK_INTERRUPTIBLE))
>>> 				kick_process(t);
>>> 		}
>>> 	}
>>>
>>> 	// called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL
>>> 	void tracehook_notify_signal(regs)
>>> 	{
>>> 		clear_thread_flag(TIF_NOTIFY_SIGNAL);
>>> 		smp_mb__after_atomic();
>>> 		if (unlikely(current->task_works))
>>> 			task_work_run();
>>> 	}
>>>
>>> This way task_work_run() doesn't need to clear TIF_NOTIFY_SIGNAL and it can
>>> have more users.
>>
>> I think it's fundamentaly wrong that we have several places and several
>> flags which handle task_work_run() instead of having exactly one place
>> and one flag.
> 
> I don't disagree with that. I know it's not happening in this series, but
> if we to the TIF_NOTIFY_SIGNAL route and get all archs supporting that,
> then we can kill the signal and notify resume part of running task_work.
> And that leaves us with exactly one place that runs it.
> 
> So we can potentially improve the current situation in that regard.

I re-spun (and re-tested) the series, now based on TIF_NOTIFY_SIGNAL
instead. I won't be sending this one out before we've discussed it
some more, but wanted to let you know what it currently looks like:

https://git.kernel.dk/cgit/linux-block/log/?h=tif-task_work

-- 
Jens Axboe

