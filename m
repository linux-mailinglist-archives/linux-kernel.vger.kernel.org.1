Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419EE2AB68D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgKILUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKILUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:20:03 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:20:01 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so5043847ejk.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=er2eQUAEHWpBLaEOsg7fH11+Tbr2OS39gTFwUEQ7HGc=;
        b=nkp3ey59D2+7XZdZIj/P0OhqvoTL/FYjhcGmq6xxj0jUAB1AK4nEOkhQlgU9k51HYt
         OaD6GXUDSVjWzbKKnsuz1ueFlFfAh1YBeKKG5iMw2qRi5rDD1nB5wRiQm3FMmTwpIDgb
         ze9K3El9Ac/dTvB3oBM9lY8Kw0DpWkQIA5NyG1SrjbZqdSKrqu4tCY/AexwyUUz3oLm4
         EBB59NAQzB5OhL5iY+ajJ+rgNe4IP7jvDSWV73eYm2qrF+KNpO/lihwejPS0W0Km8NVZ
         BOKZ9yzXLDqAgEEb9zE9/MMeItOUWMwgCzHS2Z3oX0IIqktlv/gKTM1TWjRchh4jj/mw
         Mwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=er2eQUAEHWpBLaEOsg7fH11+Tbr2OS39gTFwUEQ7HGc=;
        b=p+41GeQVWE/ZA0LHeLWlVLwpAU8Yy5TmUHXgfenMVYZPyIfDScW6mF91xRod5kUDiq
         3xTSfwxvqZo7Um9aSRxlx+OqpjGhD30wz+BOJArQ1JnR9gn9Nl8MGNPoQoPLtTp2fdGg
         YTyedYfH1T2V2I5zwLv+/vgLwJqcudvRQusQoep2qFPf1jbMNrinCOHXoqMbjvIwP51B
         PDNZHN08GqhyEMnMOa1o5j7kNWR4bOx+EaTyuvvHbciidXrAD5C9+i71hRc74vg7Fkki
         4ksruJXm7kUtw13UJjiMOAMeAK1UkBqTDa2xhlZ4ET4aSEicUQ7t5tSCueqh28X9/WLY
         5FmQ==
X-Gm-Message-State: AOAM530+8FMjiILh36n8Dk2rXIqJ00Djq0un69lqf79xbxSEmpAG0vHu
        0etR2DEosSA7v4MbbN5sxd2swVOtS/Ea+B1g
X-Google-Smtp-Source: ABdhPJxGDJD1ZviTVvkcuhDUu6WLAotPW5q5QaQp2hvj2ORrK/gJ26DY/2FJhn293EuT48k2TYlRXA==
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr15297687ejb.537.1604920799747;
        Mon, 09 Nov 2020 03:19:59 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b1sm8472430ejg.60.2020.11.09.03.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:19:59 -0800 (PST)
Subject: Re: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <894b3a46-4baa-f186-f6a1-4f818a5284e4@monstr.eu>
Date:   Mon, 9 Nov 2020 12:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29. 10. 20 17:16, Jens Axboe wrote:
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

Applied for 5.11.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

