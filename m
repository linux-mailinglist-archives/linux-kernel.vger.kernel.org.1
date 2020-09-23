Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60A276129
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIWThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:37:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61536C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:37:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c8so970777edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhTN/zF31S3H73HPCKb3e4Pv+khCuz2VHHdotx6ZYSw=;
        b=iFiGFu8pbys6JAjMMTxyy3sCwG8u9tjCXd6yHSAr/BFnm4SczX1ZtKNU8EpLTnclh+
         qtBVU0EzenOZeE38AMHXxsn8wueskp6zXjl6DOQRIB+TbJWVgrFZ34NHwKGdYZQRo9gW
         /M1YXAcnj9s10s5JbQEH7tYpOS4DpS2BwWtSOGY5A7mbqFIJKHlw8tzmy6H12Czqta/O
         KfOqcY2lWd1PeGX2MMYNXsArcrreL/VPpr7UfyPRUFChSleQICkD8BPE9FJVE6l6lxoM
         h4pbj7N5ppKI4VmUiwMiPHz3iUWFY/rDz+jRqRoVMUuZfYEvBHhOSmNaagAZelJZgksQ
         CAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhTN/zF31S3H73HPCKb3e4Pv+khCuz2VHHdotx6ZYSw=;
        b=Vzu3VDk13RkTeW/mcR2ViQDeVl/RdLa9gJUMPPk2OaYDpqmFA56jnF6/00Pj8WELH4
         wDk/VhHZBRlTqjuaUa+836MIDhjUAT3YWyAJVBSOB4Nh57lXzYodjmpd7ymfPo3aa0Ys
         taoQnTh3k/1TJ3MXLGj+e5N2e4edF43JgjJS/QqEoOeGWTtUZj4dlgKVxdKcsWF1uCuw
         ehaR5vMC/9SecyHwLzzmeThx+1AalARTNjS2B0PK43z84gR9JwmxF/MBZbhrYoftRFva
         1Dlw7bcPsGMbH2eWCrv6u2CvQQj0cVplod9JrH5dbLs7RLoHcOqOiKz4oTSfU1+Ohkxn
         ScGQ==
X-Gm-Message-State: AOAM531s1KqnMFRcXfiIOF2TNpBYAMdBOZ77R9nbQRGJPSr9W5euQEJW
        ip9AtpSHRx/DrOjoBHQuwy6NUCdp3m+hzFj/5ae0BA==
X-Google-Smtp-Source: ABdhPJwxL8t/f0IlrUIgV2vLNSjsEAdBJedhsaj4BZRksV352WWXQOg4cG9Xbvn9QloFbST5xfIyt+EYDNLvM/9Hrko=
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr951357edb.230.1600889822817;
 Wed, 23 Sep 2020 12:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <87pn6eb5tv.fsf@nanos.tec.linutronix.de> <202009231209.F5F3999D@keescook>
In-Reply-To: <202009231209.F5F3999D@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 23 Sep 2020 21:36:36 +0200
Message-ID: <CAG48ez0mvWm0TZbeSuXhcST-0HR8=psG_Bk0HeOtxF-RQnEGPg@mail.gmail.com>
Subject: Re: x86/irq: Make run_on_irqstack_cond() typesafe
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 9:20 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Sep 22, 2020 at 09:58:52AM +0200, Thomas Gleixner wrote:
> > -void asm_call_on_stack(void *sp, void *func, void *arg);
> > +void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
> > +void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
> > +                           struct pt_regs *regs);
> > +void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
> > +                        struct irq_desc *desc);
>
> Eeeh, err. So, this is nice for the CFI case, but can we instead just
> inline asm_call_on_stack() instead? Having any of these as distinct
> functions in the kernel is really not safe: it provides a trivial
> global stack-pivot[1] function for use in ROP attacks, which is one
> of the central requirements for mounting such attacks. This allows a
> completely arbitrary sp argument, function, and first argument. :(
>
> Much better would be to keep asm_call_on_stack() as an inline so the
> stack pointer is always coming from percpu variables, and to have the
> irq_count actually checked (i.e. freak out if it falls below zero to
> catch jumps into the middle of a function when an attempt to bypass the
> load from the percpu area happens). I would expect this form to be much
> robust:
>
> inc
> load sp from per-cpu
> pivot sp
> make call
> restore sp
> WARN(dec_and_test)

I don't see the point. If you can already jump to arbitrary kernel
instructions, I would be extremely surprised if you could't find some
other way to get full kernel read/write. Even just jumping to the
epilogue of some function that increments the stack pointer and then
tries to return (maybe even after loading RBP from that spot on the
stack) will probably get you quite far.
