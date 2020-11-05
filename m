Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D712A8499
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgKERPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgKERPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:15:46 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B030C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:15:45 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u62so2550355iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=swFd78c7c5KUbV9VBPdPZozLWsj3Sepm+50VsHu9Lz0=;
        b=GKu6h2G343yUbQgVtBKIViwMX9dFS8QhOq2SK6SaHj8jQqScSezeSZsrABkZ7j2P+R
         ZLo05FDyHVforVhHpSg/GdcZAt1F6nwVATFLdM618DPtAS0kdNRiDbnpLZaMqVlPzPSx
         ami8+ukEWt+a3r5W3q4oVsoeGUCZCuUQOrRV49mDqsrhuIg+ev8f5awEPl0MMtEoqrLc
         jiBTVVzwvegPdQiyCnMFe5hpXwe0U3jWxjSZnxmBS0Ynm5k0Dd3Y77KLvh5aKtQm8OG4
         s5NydKQVcKX6cDc6Fw9oTaKpxwj1Z8Y0ToqnYyFz5ociKT0jtwvHamkWK6+k809bp9xh
         2lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=swFd78c7c5KUbV9VBPdPZozLWsj3Sepm+50VsHu9Lz0=;
        b=hcg3LyhAzv+yzvCKi2psEDIEZBqZZ9nspTq0VyuY33HElaxwQHdfEC0LvuCYpW2qRO
         vte90/C6ay38GVXsM+Asii5JGRnZtpCdzfXtCJZCiMnG2f9h9ueIyddxSMV5oICZP5dS
         NX8WvYzmouNUB2Qda9oLLM6iih4B/GhEWXS64op9JZVtd6biQsmnyVtUA64n1Q1cnzd5
         xyl7k6E/Tbar2nUh5vtWwnuKmb3N27dIFpbAQsTO74Y3xAjhiR2ImtlIF2yEoRbDS+4v
         XYOhlOZIJu5Q7OO9dHId+q/VQuZ2omobZy730mazCUWu19VYRa0ZJr/jUTjzLbeni9n9
         lJ9g==
X-Gm-Message-State: AOAM531qwwAkIdELojY0nF4luEmiAIrmP7l78noneesBA1lD1TYmiFVy
        wqd7P4Vnxipxt5JZ5jGmcEDtZ6dLBPV+Dw==
X-Google-Smtp-Source: ABdhPJxKU8+BQ3ngvWSwyr1tY9v1S++xz4+VSPQG2PvyzqCB3R0fnM04fQszMQ6IEoKH344GCLluEg==
X-Received: by 2002:a05:6638:18e:: with SMTP id a14mr2764117jaq.46.1604596544119;
        Thu, 05 Nov 2020 09:15:44 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x7sm1494409ile.34.2020.11.05.09.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:15:43 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Michal Simek <monstr@monstr.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
 <d32523a5-a9c4-28a9-0286-9cd4a01b122d@kernel.dk>
 <CAHTX3dK_VbvKEho5vxOkY6BAnUWj8+HJZ6ESsLOmW5TMM3=bCg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <490b7b38-3ec0-8c7e-33c7-ad6bb44a671f@kernel.dk>
Date:   Thu, 5 Nov 2020 10:15:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHTX3dK_VbvKEho5vxOkY6BAnUWj8+HJZ6ESsLOmW5TMM3=bCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 9:42 AM, Michal Simek wrote:
> Hi,
> 
> čt 5. 11. 2020 v 17:18 odesílatel Jens Axboe <axboe@kernel.dk> napsal:
>>
>> Gentle nudge on this one.
>>
>> On 10/29/20 10:16 AM, Jens Axboe wrote:
>>> Wire up TIF_NOTIFY_SIGNAL handling for microblaze.
>>>
>>> Cc: Michal Simek <monstr@monstr.eu>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>
>>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>>> for details:
>>>
>>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>>
>>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>>> as that will enable a set of cleanups once all of them support it. I'm
>>> happy carrying this patch if need be, or it can be funelled through the
>>> arch tree. Let me know.
>>>
>>>  arch/microblaze/include/asm/thread_info.h | 2 ++
>>>  arch/microblaze/kernel/signal.c           | 3 ++-
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
>>> index ad8e8fcb90d3..44f5ca331862 100644
>>> --- a/arch/microblaze/include/asm/thread_info.h
>>> +++ b/arch/microblaze/include/asm/thread_info.h
>>> @@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
>>>  #define TIF_NEED_RESCHED     3 /* rescheduling necessary */
>>>  /* restore singlestep on return to user mode */
>>>  #define TIF_SINGLESTEP               4
>>> +#define TIF_NOTIFY_SIGNAL    5       /* signal notifications exist */
>>>  #define TIF_MEMDIE           6       /* is terminating due to OOM killer */
>>>  #define TIF_SYSCALL_AUDIT    9       /* syscall auditing active */
>>>  #define TIF_SECCOMP          10      /* secure computing */
>>> @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
>>>  #define _TIF_SIGPENDING              (1 << TIF_SIGPENDING)
>>>  #define _TIF_NEED_RESCHED    (1 << TIF_NEED_RESCHED)
>>>  #define _TIF_SINGLESTEP              (1 << TIF_SINGLESTEP)
>>> +#define _TIF_NOTIFY_SIGNAL   (1 << TIF_NOTIFY_SIGNAL)
>>>  #define _TIF_POLLING_NRFLAG  (1 << TIF_POLLING_NRFLAG)
>>>  #define _TIF_SYSCALL_AUDIT   (1 << TIF_SYSCALL_AUDIT)
>>>  #define _TIF_SECCOMP         (1 << TIF_SECCOMP)
>>> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
>>> index f11a0ccccabc..5a8d173d7b75 100644
>>> --- a/arch/microblaze/kernel/signal.c
>>> +++ b/arch/microblaze/kernel/signal.c
>>> @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>>>
>>>  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
>>>  {
>>> -     if (test_thread_flag(TIF_SIGPENDING))
>>> +     if (test_thread_flag(TIF_SIGPENDING) ||
>>> +         test_thread_flag(TIF_NOTIFY_SIGNAL))
>>>               do_signal(regs, in_syscall);
>>>
>>>       if (test_thread_flag(TIF_NOTIFY_RESUME))
>>>
>>
>>
>> --
>> Jens Axboe
>>
> 
> Give me some time. I have it on my todo list.

Great, thanks!

-- 
Jens Axboe

