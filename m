Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC82ABE70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgKIOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:17:28 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63547C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:17:27 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x7so8414630ili.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/BdThRd+LaDPQRGb7G8aV1wE5GDlBJVfU2h7aGrg3Io=;
        b=OtpRfNAStK0Bp+vbRO2rr9E2o0MW/MNiLkeJNGtTikEYbW1Py8zHSpYs9y92ModzLO
         FWYU6AS1h69Z9yAm3N1hXaSaYzGg8F3TaTyU9DDS4rG3C87A7EeGekKGt4kqAlWobA3M
         KZKN/LrfzKseCceZHy19Ici/X/9sL/ogk8VS4REhoh2PyvLsCJBJA7NiwpeiGF/LBvm4
         kK1tAlHGS0EkMwazy1janbshC47Rv2MIMRuocMXP4yQ8uaviN1Ic0bSPnALW0UP1DzKF
         /fu3DuIhx15AklTgerIpQc6uNrjpiC8bPyRLuTqrkunFKrb1j9gQh1QyzKwF76thnoEo
         oIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BdThRd+LaDPQRGb7G8aV1wE5GDlBJVfU2h7aGrg3Io=;
        b=bPuxL5ZxKiMtiOfMzDNYRXlxwRywO341QLaaLuyyDWBm6UjlTLiFUcCLb9Dz4AE9xL
         A4OIGzo27FaNZmIMcn1lMaslyB9mTahPBcEleLof5UPfmmIFGvr82sA0BP36ysdfvwF+
         7MDBuZlcM/6QZ7nSHPN6P3dlCn3fG4PHGaVuJVFtG9wUCkcv7Rzwe7Q+/a7zqxyKHpTt
         7Uk/43XtRG9GG5BN5TzhgP+23XAL1jTSR9rffY87tnuYmf9aiD+QSy+KdET/pghJFWYO
         9m15uPt29uaZ8ZoyjACp5fNWiJ7YLB2qqquacoSZk6QQyfhSBWNW2m14MzYUAZE9yYh/
         bkZA==
X-Gm-Message-State: AOAM5324g52FHjOS+IuGOgsEN9XPWoYfaXwJ5xo0f6nTjh8Bo4l9bTOR
        xSj3JdqtDwien32ft9W8JkpQ5gI6nQU4aA==
X-Google-Smtp-Source: ABdhPJxSF5EIXIi69eK0nd3rgw9euKLC7ZG1plQe4ZIkNkor96aJQAbi02Gi1n1MKtddoOR/IdTo8A==
X-Received: by 2002:a05:6e02:1388:: with SMTP id d8mr10145252ilo.272.1604931446357;
        Mon, 09 Nov 2020 06:17:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 10sm1788884iou.50.2020.11.09.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:17:25 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Michal Simek <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
 <894b3a46-4baa-f186-f6a1-4f818a5284e4@monstr.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1877a472-5fbe-5fa7-6ec4-a7bafc0790fd@kernel.dk>
Date:   Mon, 9 Nov 2020 07:17:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <894b3a46-4baa-f186-f6a1-4f818a5284e4@monstr.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 4:19 AM, Michal Simek wrote:
> 
> 
> On 29. 10. 20 17:16, Jens Axboe wrote:
>> Wire up TIF_NOTIFY_SIGNAL handling for microblaze.
>>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>
>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>> for details:
>>
>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>
>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>> as that will enable a set of cleanups once all of them support it. I'm
>> happy carrying this patch if need be, or it can be funelled through the
>> arch tree. Let me know.
>>
>>  arch/microblaze/include/asm/thread_info.h | 2 ++
>>  arch/microblaze/kernel/signal.c           | 3 ++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
>> index ad8e8fcb90d3..44f5ca331862 100644
>> --- a/arch/microblaze/include/asm/thread_info.h
>> +++ b/arch/microblaze/include/asm/thread_info.h
>> @@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
>>  #define TIF_NEED_RESCHED	3 /* rescheduling necessary */
>>  /* restore singlestep on return to user mode */
>>  #define TIF_SINGLESTEP		4
>> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
>>  #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
>>  #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
>>  #define TIF_SECCOMP		10      /* secure computing */
>> @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
>> index f11a0ccccabc..5a8d173d7b75 100644
>> --- a/arch/microblaze/kernel/signal.c
>> +++ b/arch/microblaze/kernel/signal.c
>> @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>>  
>>  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
>>  {
>> -	if (test_thread_flag(TIF_SIGPENDING))
>> +	if (test_thread_flag(TIF_SIGPENDING) ||
>> +	    test_thread_flag(TIF_NOTIFY_SIGNAL))
>>  		do_signal(regs, in_syscall);
>>  
>>  	if (test_thread_flag(TIF_NOTIFY_RESUME))
>>
> 
> Applied for 5.11.

Would you mind if I carry this patch with an ack? I've got further fixes
and cleanups that are enabled once all archs have added support.

-- 
Jens Axboe

