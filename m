Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E312ABE74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgKIOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:18:43 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5667C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:18:42 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cq7so8705339edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QEqCNCbYI/FS9sGU6DBcuvEaYrMiNw0AaG40of2AUaQ=;
        b=UD4RpwdQkyj0CK1Gix3ixzv9YgI+2aCX/9C5uU1Dj/eEuKyuF2CNBo7NtEardH/vsS
         G7ajDFyO3rGb2PPfQ4ba4EaSrB1LlsF3x7uabCa9CzxWKgcNZYlrHgWg7S7mAJGMJt0Z
         8y3kilPu5pAQfOisaMgabqwe67dI6BMt0tTviMTmvABV+pxoHOTOgbFwp9GG1mzCZ0zc
         J4zKxN2GW9OjhvWHekXfYmgfQPxD52QPvfvfDoVap6Hya+8gUqChd3Z+Gs33qaDX7C3i
         TrxvPhZj8uftf2jpxlh79iJzyjriY+2ScuAmiOvH6RrCKAytZ8W/rrmYtxraJLV3Hupa
         aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEqCNCbYI/FS9sGU6DBcuvEaYrMiNw0AaG40of2AUaQ=;
        b=FGzBc8QJokZT5wWwxfrRO4aLvPyLG/kFAdRmjyUEbWZj0DPCgyVi6Oe/1uF3fHTXx6
         yww6JmCHdftMtfAFO9q5bChl2z3VWkq8Ie2jA69uZTUQlb+oCXGiDzjBgnvPAW8OkEb8
         Ju9/y3my7KJn8uSUXUidqZHZPgO2qxwZK8sqSVMsidFdawrRVOCYeM3240xtMlGf4zfz
         B03zh/EN7MWqK7TWlPJPbqJeT/XGsKnm9rzAazmRwxvVLSoSAw0Nwo5rLRApS4Sm2IzS
         qiTQPqCp12k8dRSDU9fb/DaNZ/SYJxt+vlDnL2DrtDeYu9COTxvTOYKbRqfv6EXkEuvP
         7wNg==
X-Gm-Message-State: AOAM531PKWFNHJ9u1xuQp/6Tx1tXvamu3hlJ+4tks8V6C3v6uAUub159
        bk2jiqgROblDBxiK5MKMTglc/1xxHP1RifHV
X-Google-Smtp-Source: ABdhPJy1/LBr1sQ2ChE69myElbMbSUySgJ40Mkpe5Oj0YQSaYu24E7Fl6OYT4YLLoxdFMTGnRhuKOA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr15100390eds.360.1604931521267;
        Mon, 09 Nov 2020 06:18:41 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y1sm9137405edj.76.2020.11.09.06.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:18:40 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
 <894b3a46-4baa-f186-f6a1-4f818a5284e4@monstr.eu>
 <1877a472-5fbe-5fa7-6ec4-a7bafc0790fd@kernel.dk>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <e944eb20-4cb6-f138-48da-cad82975d976@monstr.eu>
Date:   Mon, 9 Nov 2020 15:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1877a472-5fbe-5fa7-6ec4-a7bafc0790fd@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09. 11. 20 15:17, Jens Axboe wrote:
> On 11/9/20 4:19 AM, Michal Simek wrote:
>>
>>
>> On 29. 10. 20 17:16, Jens Axboe wrote:
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
>>>  #define TIF_NEED_RESCHED	3 /* rescheduling necessary */
>>>  /* restore singlestep on return to user mode */
>>>  #define TIF_SINGLESTEP		4
>>> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
>>>  #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
>>>  #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
>>>  #define TIF_SECCOMP		10      /* secure computing */
>>> @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
>>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>>> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>>>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>>>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>>>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>>> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
>>> index f11a0ccccabc..5a8d173d7b75 100644
>>> --- a/arch/microblaze/kernel/signal.c
>>> +++ b/arch/microblaze/kernel/signal.c
>>> @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>>>  
>>>  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
>>>  {
>>> -	if (test_thread_flag(TIF_SIGPENDING))
>>> +	if (test_thread_flag(TIF_SIGPENDING) ||
>>> +	    test_thread_flag(TIF_NOTIFY_SIGNAL))
>>>  		do_signal(regs, in_syscall);
>>>  
>>>  	if (test_thread_flag(TIF_NOTIFY_RESUME))
>>>
>>
>> Applied for 5.11.
> 
> Would you mind if I carry this patch with an ack? I've got further fixes
> and cleanups that are enabled once all archs have added support.
> 

ok. Not a problem. Will drop it from my queue and feel free to add my

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

