Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C9F2A8356
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgKEQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKEQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:18:46 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:18:44 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a20so1847857ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f/l2gBRMCj+RdaxWVkuTQXJwYFFqFOOCVlfhz42MrM0=;
        b=G2+egfY2XlxAf+PTEHp4QiPFwIOpSbqGdaOH2bDXpTl62J3l4XaYdJoKtxTpb2Qg7z
         8KEBTDw38lgj9QuJXsUseN1m68cVHdt8up8QC0V57UN0Oac1Oq+a2rZe/RraWIjYaQhh
         4qN7D6H8XvIFnJ/zGXxFm1WdEAqx0EFLk2fWHfMii8Idhj+yKuRDxA/Zz3U7Qvh+zmGS
         YW33x9ruzuBv/XB11jcW456XF5riAUZPc18aNy30upvZ3ypHNJ1JpiGCuh1s/rW7PUrV
         tpSyjmzVDY9VJPqlhoYrrLtPHV4xFXKqub/+ZCr74mlG4i0oUiMgOhvvYVxcVO3OjwA/
         W+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/l2gBRMCj+RdaxWVkuTQXJwYFFqFOOCVlfhz42MrM0=;
        b=m9lGvGYJvbP/LBHhPIhydFTJ6ry1DbqjrUEvEQO5HcQaz5boAaqywq75jBD9qqafgl
         m74oIqRqF2Y57xws7k56UAaFJhAF8uuN4Sq8Y/4bPqrt/4aoMjp3q4hh4IsA3eob5Jy4
         mo7ocHGojOqECug4iE0vcqnfi9sgP8SlcJ7lrozwF9br7ZtVLz+TgFJujJ+UDDngViZc
         O8OD4Je62lY02xqjeWuESVHtKfPWH09G4F3dllBrVvQTmPLnKYdTbMiSwuJaMPoxvkz3
         6G94b499PUUgrQ7MQkdxE1/ySn3pOmXyILqHlQhRbqQpOI2sbwCedw1cczDScoJGoRY7
         30hA==
X-Gm-Message-State: AOAM53203YSq2Ms9XrPBnfgz1ffCqBZtN8+jK8HFNPugpV6d0CS+WITd
        S+kUPDWseLYj0fQXENeS4sS/XpcwsyXw6Q==
X-Google-Smtp-Source: ABdhPJxyAl646XCVhBiFn4OHfa/7HqUGx9uPh/zqa7Cx4Hq03ZjcFqP/7a5HJrc0s1JRuaNZqj/RpA==
X-Received: by 2002:a92:ca90:: with SMTP id t16mr2182158ilo.33.1604593124031;
        Thu, 05 Nov 2020 08:18:44 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t12sm1315276ios.12.2020.11.05.08.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:18:43 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
From:   Jens Axboe <axboe@kernel.dk>
To:     Michal Simek <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
Message-ID: <d32523a5-a9c4-28a9-0286-9cd4a01b122d@kernel.dk>
Date:   Thu, 5 Nov 2020 09:18:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle nudge on this one.

On 10/29/20 10:16 AM, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for microblaze.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
> 
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> 
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.
> 
>  arch/microblaze/include/asm/thread_info.h | 2 ++
>  arch/microblaze/kernel/signal.c           | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
> index ad8e8fcb90d3..44f5ca331862 100644
> --- a/arch/microblaze/include/asm/thread_info.h
> +++ b/arch/microblaze/include/asm/thread_info.h
> @@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_NEED_RESCHED	3 /* rescheduling necessary */
>  /* restore singlestep on return to user mode */
>  #define TIF_SINGLESTEP		4
> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
>  #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
>  #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
>  #define TIF_SECCOMP		10      /* secure computing */
> @@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
> index f11a0ccccabc..5a8d173d7b75 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>  
>  asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
>  {
> -	if (test_thread_flag(TIF_SIGPENDING))
> +	if (test_thread_flag(TIF_SIGPENDING) ||
> +	    test_thread_flag(TIF_NOTIFY_SIGNAL))
>  		do_signal(regs, in_syscall);
>  
>  	if (test_thread_flag(TIF_NOTIFY_RESUME))
> 


-- 
Jens Axboe

