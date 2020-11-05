Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59FA2A8355
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgKEQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKEQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:18:31 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F507C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:18:30 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id u21so2337294iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cfVWFM0X2h66U3FA7MkM++MHUZA58QeZ8G3OYIHSp0E=;
        b=PCKDgkYmQypRP9diWoxiZzO2MW0sPX9TeRFjiKz0Du6qr0m7S9hF+yhRG6sB8AsdF2
         w6yrPsmWkW12gzbRV3FYzcnSvo5bbvd/ThHg4850jiGQmq7VUZti0BjcuJn0v6LBCLV4
         ENk/vmHXF7pKuFQktde3K9Zs4h7cjQTaP66Tu++3ta0LuuTCPudRwrwPxW0IG50tsfvj
         Xt2N1RwYKjlZeD7ICP2kxwwZtpL9XRX/+8F+9CulEg1tjtIStii8kWlaP2gUeb6SIVkr
         bvQTok/aiAOMMS0PtDPUMakzE+8v8IUIWEYPNpkcBN3Vg5KR4jQv73prSemiNPjNWWQ8
         hpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cfVWFM0X2h66U3FA7MkM++MHUZA58QeZ8G3OYIHSp0E=;
        b=iQePi79ok8HQJLqaClDLrHWbIM26IFcypVm5dXPEheUqw0uKwXhs0yFh9aOaxVd+s7
         j6fMaQMaznGINbRcy1YOohjuJMUZqXKgjwjXuawe+EYuISD1LxWkG/De9wv0kQ3EnXsa
         60WEFwJq4eHAHLSheZSQemSdo1Po0TFIs4yFrBpmkFeVyFqjl9dckUZpfjlAZZrF0m6h
         ujRe3xyPuLe2TIMy+1fpEjAQw6HOvt2CDZNETY0PTpJmoVW6R6VUWglCZGahi3VTkTwn
         lFkzUfnWsu5zrEzAVt1CRXrsMZy5nJCJniWDHglRA6DPhZMTBLW/6wrY56aVdcWWV5uA
         RuuQ==
X-Gm-Message-State: AOAM533iWsbLz2VkJkDPcfTsryNf+pnAte0bo495C8Euv/V619rItQDL
        q0F0jk6FleHLtv/OYP6+HH6N1CM75El0ww==
X-Google-Smtp-Source: ABdhPJx2vgNi6qSMfE4T6MgTCwBYut2ADIkTw3pbuDtQFuACSRuzdoeFdHDtaE+ss2BMtEq7MEr3mQ==
X-Received: by 2002:a6b:6a0b:: with SMTP id x11mr2217823iog.205.1604593106407;
        Thu, 05 Nov 2020 08:18:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a16sm1371242ilr.86.2020.11.05.08.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:18:25 -0800 (PST)
Subject: Re: [PATCH] nds32: add support for TIF_NOTIFY_SIGNAL
From:   Jens Axboe <axboe@kernel.dk>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4b195c6d-405d-cad8-f036-1bfc5876d528@kernel.dk>
Message-ID: <6cea6b7c-6372-002d-f158-57f85e72668e@kernel.dk>
Date:   Thu, 5 Nov 2020 09:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b195c6d-405d-cad8-f036-1bfc5876d528@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle nudge on this one.

On 10/29/20 10:17 AM, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for nds32.
> 
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
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
>  arch/nds32/include/asm/thread_info.h | 2 ++
>  arch/nds32/kernel/ex-exit.S          | 2 +-
>  arch/nds32/kernel/signal.c           | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
> index c135111ec44e..d3967ad184f0 100644
> --- a/arch/nds32/include/asm/thread_info.h
> +++ b/arch/nds32/include/asm/thread_info.h
> @@ -48,6 +48,7 @@ struct thread_info {
>  #define TIF_NEED_RESCHED	2
>  #define TIF_SINGLESTEP		3
>  #define TIF_NOTIFY_RESUME	4	/* callback before returning to user */
> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
>  #define TIF_SYSCALL_TRACE	8
>  #define TIF_POLLING_NRFLAG	17
>  #define TIF_MEMDIE		18
> @@ -57,6 +58,7 @@ struct thread_info {
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
> diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
> index 6a2966c2d8c8..b30699911b81 100644
> --- a/arch/nds32/kernel/ex-exit.S
> +++ b/arch/nds32/kernel/ex-exit.S
> @@ -120,7 +120,7 @@ work_pending:
>  	andi	$p1, $r1, #_TIF_NEED_RESCHED
>  	bnez	$p1, work_resched
>  
> -	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME
> +	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME|#_TIF_NOTIFY_SIGNAL
>  	beqz	$p1, no_work_pending
>  
>  	move	$r0, $sp			! 'regs'
> diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
> index 2acb94812af9..7e3ca430a223 100644
> --- a/arch/nds32/kernel/signal.c
> +++ b/arch/nds32/kernel/signal.c
> @@ -376,7 +376,7 @@ static void do_signal(struct pt_regs *regs)
>  asmlinkage void
>  do_notify_resume(struct pt_regs *regs, unsigned int thread_flags)
>  {
> -	if (thread_flags & _TIF_SIGPENDING)
> +	if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>  		do_signal(regs);
>  
>  	if (thread_flags & _TIF_NOTIFY_RESUME)
> 


-- 
Jens Axboe

