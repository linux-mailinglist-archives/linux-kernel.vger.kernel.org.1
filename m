Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9B2D9642
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406688AbgLNKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406050AbgLNKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:22:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D336C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 02:22:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c133so1188999wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=poBLlsG/xIm+IQFuVu3FupiEJDu22H8hOjYM+/czcUw=;
        b=But+ukETOvV5nJ7Ce6blrbC7kqHmll80avtnOYH+/+aLZ5KF5lOAo+Mth8nVcOnVTJ
         MAi1kJmqNL02g/VbZ773C8OJE19NkquP0RcIW/kV94PT6WrI6vmNVzusLeph2gspduWt
         I7UE+afpuwu1ZzVU3AzUy6LfUT35/QuKUda6B7I/toocb0K7WnCLrNVO+Jp9vF+8e0b4
         JnwgQqiwGbTjf/PBD0iTSieU7r/7MmfgLlaO9QMq6fOP37Ngjmbo1sxaG05gM15Q0QCs
         u8qWwcs2DOsyRSUihMwWW6i1ZxCmrHRyHQyBjAj2+xOxca5ltpy0s50hOWAiPpiDDWQV
         +3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=poBLlsG/xIm+IQFuVu3FupiEJDu22H8hOjYM+/czcUw=;
        b=iPCxl9If1UwTe4Ncj8HAspmR07l/EICUe5+6KSCfCcAdzBUkhpKL50XNP1OPhZFeSk
         6TAD1SQGKXkNGFAs1Bl46bI9ejdcGLn/otXp1+9+hDaeeXrnzwMcSje2X6rxSw4cfFoA
         jQxkTYZQmUv3JgbrOG0gSU6d3Hs+bUMAWdrsbrxJniYbL4ssLushBb3wNZXvGlPERqE4
         vszDjbG2Xl0pl81o2LgdbM4+kkW6wYmBsExXroBQjfAhJxZ3VX10yf7uOZakYTVe2Dul
         6dbGk16y3BWpMqy8gekLjrmUNGjyKii+U6rQ8o1YzmsGAYfXi8RTL5VfkwQ5oYlmAKhz
         5Nfw==
X-Gm-Message-State: AOAM531Zww84NHMlmgXLmscEmj4pbf9kQbQASm1uIzilH8LsXgKYTu+i
        bV+1mvI5zuQI9ys2mq8KZkiI+A==
X-Google-Smtp-Source: ABdhPJwksbJlQGQPSPL+S6YtD4uzEd0fKHMDnRWAoLVBvutX0OCEbiZNiZyo7rtkjnxMfSyUbikrJw==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr27087657wmi.35.1607941331786;
        Mon, 14 Dec 2020 02:22:11 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id m11sm14928386wmi.16.2020.12.14.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:22:10 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:22:05 +0100
From:   Marco Elver <elver@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-ID: <X9c8zefhH0dSh41L@elver.google.com>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czzeg5ep.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 09:01PM +0100, Thomas Gleixner wrote:
> On Sat, Dec 12 2020 at 13:26, Marco Elver wrote:
> > On Thu, Mar 07, 2019 at 10:14AM +0100, Arnd Bergmann wrote:
> >> -static void __init futex_detect_cmpxchg(void)
> >> +static noinline void futex_detect_cmpxchg(void)
> >>  {
> >>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >>  	u32 curval;
> >
> > What ever happened to this patch?
> 
> It obviously fell through the cracks. 
> 
> > I'm seeing this again with the attached config + next-20201211 (for
> > testing https://bugs.llvm.org/show_bug.cgi?id=48492). Had to apply this
> > patch to build the kernel.
> 
> What really bothers me is to remove the __init from a function which is
> clearly only used during init. And looking deeper it's simply a hack.
> 
> This function is only needed when an architecture has to runtime
> discover whether the CPU supports it or not. ARM has unconditional
> support for this, so the obvious thing to do is the below.
> 
> Thanks,
> 
>         tglx
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -86,6 +86,7 @@ config ARM
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>  	select HAVE_IDE if PCI || ISA || PCMCIA
> 
> 

This works, too. Thank you!

	Tested-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
