Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2382ABED3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgKIOhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgKIOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:37:37 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD13C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:37:37 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o11so9974617ioo.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d09b1ADHL/JH+8+K49o7Q/jINXDmntPFP7b8S7Ycyu4=;
        b=weqiptLzWqmTQfwOUSZ76idO6Z9KjoFcYi2tBsUPV2d/rLzqCYmy8vdvY4Zyu8SsN2
         2fWj0fkPO8pnYZ2ueScQvEOFzvdJpgQmRgHgoZ+kbUQy+UmJR0BUCIMaYp/qwSlu8MKr
         rtdOP/PvU/eR+7TWevNemMoAjjdXibqCaiujx293jF0HvLlUE97LVSO9OGOuCauPPjXr
         DbOt9gn7LZxkq57Mx+Z3igZg0A2XTyjrnxEwgDvb8iXOqovlRm7g+EG76gVB48zBbDcs
         Liz9hfd930piS6VqLhmwoHBZ2JO1glintBVg0MVAveb2ikz1dEGqfE7ie1Q7vjgdMGkf
         VsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d09b1ADHL/JH+8+K49o7Q/jINXDmntPFP7b8S7Ycyu4=;
        b=hjj1I4MqNF8Wr698UHV1O0WneTQIGpj43c67hxM3JWJD3bht7U8eRU7F85r/GxscsO
         Z0Hpb7nqFhMhuVqd+4EiHEEqtEVHXWyqguGlOBVfmoMT/MTyOFobacOMQJKXMcM6dnuJ
         7rjc+TqgYKiz4Bmjj+81CwjfSbbUGUboyg7q7K2ijppwhx3B8iM3IGjZNaI4gPg1nuOZ
         /5NODhE2VTdQUFs4c6CLdNjrRLKXmvANQWX7SoHhhcvJxbKnDOuM+CwMyKc9Wwmm2LnO
         HGRTN4mPK2svEnChyOdpeX+hxtIFcXOyNX8K8F1sSh/sTls7N2qg49mWmL3L3qkw8J4N
         tIhg==
X-Gm-Message-State: AOAM530Qxn8OEtIg7lC9n8KQWZN15l1ELUWu9kXdO5TmxnsSWTstNOcz
        eOyqEsKgJQkfPXegveEt2k+l3fSb1PMJ4Q==
X-Google-Smtp-Source: ABdhPJyzHOna40mJMcrLOxi43dJ/EQyu/ltzw1AZIBcoEqhgpnyltOANDxgUexB4i9h8jixl3gSCxg==
X-Received: by 2002:a6b:cd0a:: with SMTP id d10mr6680475iog.58.1604932656673;
        Mon, 09 Nov 2020 06:37:36 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u8sm6912861ilm.36.2020.11.09.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:37:36 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Michal Simek <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
 <894b3a46-4baa-f186-f6a1-4f818a5284e4@monstr.eu>
 <1877a472-5fbe-5fa7-6ec4-a7bafc0790fd@kernel.dk>
 <e944eb20-4cb6-f138-48da-cad82975d976@monstr.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00bc4cbd-3346-59ad-c2ef-b035c5865146@kernel.dk>
Date:   Mon, 9 Nov 2020 07:37:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e944eb20-4cb6-f138-48da-cad82975d976@monstr.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 7:18 AM, Michal Simek wrote:
> 
> 
> On 09. 11. 20 15:17, Jens Axboe wrote:
>> On 11/9/20 4:19 AM, Michal Simek wrote:
>>>
>>>
>>> On 29. 10. 20 17:16, Jens Axboe wrote:
>>>> Wire up TIF_NOTIFY_SIGNAL handling for microblaze.
>>>>
>>>> Cc: Michal Simek <monstr@monstr.eu>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>
>>>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>>>> for details:
>>>>
>>>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>>>
>>>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>>>> as that will enable a set of cleanups once all of them support it. I'm
>>>> happy carrying this patch if need be, or it can be funelled through the
>>>> arch tree. Let me know.
>>>>
>>>>  arch/microblaze/include/asm/thread_info.h | 2 ++
>>>>  arch/microblaze/kernel/signal.c           | 3 ++-
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
>>>> index ad8e8fcb90d3..44f5ca331862 100644
>>>> --- a/arch/microblaze/include/asm/thread_info.h
>>>> +++ b/arch/microblaze/include/asm/thread_info.h
>>>> @@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
>>>>  #define TIF_NEED_RESCHED	3 /* rescheduling necessary */
>>>>  /* restore singlestep on return to user mode */
>>>>  #define TIF_SINGLESTEP		4
>>>> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
>>>>  #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
>>>>  #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
>>>>  #define TIF_SECCOMP		10      /* secure computing */
>>>> @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
>>>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>>>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>>>> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>>>>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>>>>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>>>>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>>>> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
>>>> index f11a0ccccabc..5a8d173d7b75 100644
>>>> --- a/arch/microblaze/kernel/signal.c
>>>> +++ b/arch/microblaze/kernel/signal.c
>>>> @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>>>>  
>>>>  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
>>>>  {
>>>> -	if (test_thread_flag(TIF_SIGPENDING))
>>>> +	if (test_thread_flag(TIF_SIGPENDING) ||
>>>> +	    test_thread_flag(TIF_NOTIFY_SIGNAL))
>>>>  		do_signal(regs, in_syscall);
>>>>  
>>>>  	if (test_thread_flag(TIF_NOTIFY_RESUME))
>>>>
>>>
>>> Applied for 5.11.
>>
>> Would you mind if I carry this patch with an ack? I've got further fixes
>> and cleanups that are enabled once all archs have added support.
>>
> 
> ok. Not a problem. Will drop it from my queue and feel free to add my
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Great, thank you!

-- 
Jens Axboe

