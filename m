Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE12C7AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgK2Tcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Tck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:32:40 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73476C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:32:00 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so16395025lfj.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgnoT7WnvTnPKNiPZcY1NzA/PCJl5vGcOS+KU6IN0R4=;
        b=B3ELr7pTdO6OAWi129nTLKqKudRkDJES/x193QZF/DlDQvQNhW/sqCZkgznM/FKeum
         L03Q8xI3PaZCOsgMz/pZKHM55jTzXxKPlcq/90LJOzCd7kwIIXQCVjo8zFLoTnZEPQl4
         TuBQWGTuEorW6W4IUTrBxEoLNdMhmLe6MIemg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgnoT7WnvTnPKNiPZcY1NzA/PCJl5vGcOS+KU6IN0R4=;
        b=Idt4386YEiyfyNLjmnvcAp2ucKRnyWjb8LIAgne8XSVIUJl6r5RAD7MyQ/MTo/pe74
         6JSUX/FNQnVO3PfPpMpZl6uAkMqfNLVEo1Ww27gTEG5OocGWr6XfkFTMt5v5opasd1K8
         QLJpJKkdv5unkSid0SSWenILAKkzbSn1byZcHq/hUnF5HCtaJn+PlhwvothQQGlYCaPO
         gG5bAga18T0TNYhKgpVstYody5W6Ee5R3kI2+mFP3VVA5EOqtMtfIFSViQm75MYP1U3Y
         UDLi0MHuoZH8DCGofg/Yf7hkE2HQUaY7uX56fi3+W/SyvGufF0M4ofJH+RuINmMA9yLL
         t1Xg==
X-Gm-Message-State: AOAM530ojbz50dSnVWJnKu4xiwB89eSVcf0JW32zND/eCGe/0ZBFAJ23
        +7IVV52fQxw0Ui989nc8zt+NXRG3WrX70w==
X-Google-Smtp-Source: ABdhPJxV+RDqpDSoWZw4+WQzA03ZHshWGlN1Qy5nq91QrqCpreWmquUnhpgPigZ+7nPq7cIENu4sbw==
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr7313036lfk.222.1606678318473;
        Sun, 29 Nov 2020 11:31:58 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w11sm2190871lji.135.2020.11.29.11.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 11:31:57 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id d20so16353316lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:31:57 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr7645469lfd.603.1606678317015;
 Sun, 29 Nov 2020 11:31:57 -0800 (PST)
MIME-Version: 1.0
References: <160665707945.2808.5384034634184489471.tglx@nanos> <160665708065.2808.15317906761841446715.tglx@nanos>
In-Reply-To: <160665708065.2808.15317906761841446715.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Nov 2020 11:31:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
Message-ID: <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 5:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Yet two more places which invoke tracing from RCU disabled regions in the
> idle path. Similar to the entry path the low level idle functions have to
> be non-instrumentable.

This really seems less than optimal.

In particular, lookie here:

> @@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
>
>                 trace_cpu_idle(1, smp_processor_id());
>                 stop_critical_timings();
> +
> +               /*
> +                * arch_cpu_idle() is supposed to enable IRQs, however
> +                * we can't do that because of RCU and tracing.
> +                *
> +                * Trace IRQs enable here, then switch off RCU, and have
> +                * arch_cpu_idle() use raw_local_irq_enable(). Note that
> +                * rcu_idle_enter() relies on lockdep IRQ state, so switch that
> +                * last -- this is very similar to the entry code.
> +                */
> +               trace_hardirqs_on_prepare();
> +               lockdep_hardirqs_on_prepare(_THIS_IP_);
>                 rcu_idle_enter();
> +               lockdep_hardirqs_on(_THIS_IP_);
> +
>                 arch_cpu_idle();
> +
> +               /*
> +                * OK, so IRQs are enabled here, but RCU needs them disabled to
> +                * turn itself back on.. funny thing is that disabling IRQs
> +                * will cause tracing, which needs RCU. Jump through hoops to
> +                * make it 'work'.
> +                */
> +               raw_local_irq_disable();
> +               lockdep_hardirqs_off(_THIS_IP_);
>                 rcu_idle_exit();
> +               lockdep_hardirqs_on(_THIS_IP_);
> +               raw_local_irq_enable();
> +
>                 start_critical_timings();
>                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>         }

And look at what the code generation for the idle exit path is when
lockdep isn't even on.

It's *literally*

        cli
        call rcu_idle_exit
        sti

and guess what rcu_idle_exit does?

Yeah, that one does "pushf; cli; call rcu_eqs_exit; popf".

So here we are, in the somewhat critical "an interrupt woke us up"
section, and we're doing just ridiculously stupid things.

I've pulled this, because it solves a problem, but there's a deeper
problem here in how all this is done.

The idle path is actually quite important. I can point to real loads
where this is a big part of the CPU profile, because you end up having
lots of "go to sleep for very short times, because the thing we were
waiting for takes almost no time at all".

                 Linus
