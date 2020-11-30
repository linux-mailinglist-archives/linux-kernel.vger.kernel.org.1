Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF02C8FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgK3VNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbgK3VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:13:34 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B98C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:13:19 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id m62so7129134vsd.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqzHfapJ3F/aP/Sj74fFO0QxtwYdPG/PGUQjcAovr1k=;
        b=djo0Ivg+KsZ5rWvUBIcGBis6lXvAnNR55o+KHu/r4ezk21pgDp5P7XWlgs3yCRySQK
         lR38TMl1fA8MIdM9IeocinICRorzA+NcOchTlplISt3pDDhOqDTRIrU8UPNVjFiW0Cek
         MauP5GTlwQnJGIfcXHrLtyPv3Tn+EHcFzMOBNbvpsL9v9e16Jiusz+kN6ywKkNSvzhXU
         KY1s7xyJ99COV18ZUFXw9dH9Clr44zcWTNLA1vuZ6AJbQ1qeHlgZezzOhYdERZ2vq8jS
         zIBTwtF/HRqW2FWV/IVALKgPbo06JdcPd+KXFjYGARgULl431cz7JjtebM3PxhNj/FpE
         YIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqzHfapJ3F/aP/Sj74fFO0QxtwYdPG/PGUQjcAovr1k=;
        b=FCjA/75yL8kgWjWHkwkWRs0lgnajXYPz19fP4RABaMD3oyovDZlHM88C8UUNYRFRJi
         rOignWLKBs+fIZcQ+EQMI+VLwPM5yroq1jAgXQCQuutE0l6Yq2kBCXSIa11v0t8zJPhv
         MEqwmEQJq9kukIi2Nu4hxFg/aPEeJdTs2wnNHJxukhWAQorSiLImxxLnqqjYXpMCJH+H
         2FroF4kOCgigRroxiguPO2rqX10YjOynm4YKLBgcLK2u/ozEEOEboiRmI+g4tpFn/Lan
         pJhezbyZ+5NRucKhCoK00FO+l5j9i7ugIggrcE4DRvEdOgFmNLx6Vg7WTZuaoC+usAY6
         ssEA==
X-Gm-Message-State: AOAM530w0TylWSSRqPTvnTR9/uvjA54DbrKAJxEMQahWQTrTMy7xhnLa
        pLeK9u5yKg3OLa1V4qL+i2CdkntnyEL/1++iZm8mmw==
X-Google-Smtp-Source: ABdhPJxsvZE/vxnMU3Fe1JLI0zpquMutlEXi68MVfogDgRtXehEQXxlO/XLBW3FdMghturJW3Teo3vGuvDOGNCxI54I=
X-Received: by 2002:a67:f74f:: with SMTP id w15mr17805420vso.54.1606770798445;
 Mon, 30 Nov 2020 13:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-3-samitolvanen@google.com> <20201130114940.GB24563@willie-the-truck>
In-Reply-To: <20201130114940.GB24563@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Nov 2020 13:13:07 -0800
Message-ID: <CABCJKud6UiidpqqwJcghnqLKDkqM3pzMUUwe3_HH3ODDqOdANA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 24, 2020 at 11:59:40AM -0800, Sami Tolvanen wrote:
> > Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
> > using statically allocated stacks.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/kernel/Makefile |  1 -
> >  arch/arm64/kernel/entry.S  |  6 ++--
> >  arch/arm64/kernel/irq.c    | 19 ++++++++++
> >  arch/arm64/kernel/scs.c    | 16 ---------
> >  arch/arm64/kernel/sdei.c   | 71 +++++++++++++++++++++++++++++++-------
> >  include/linux/scs.h        |  4 ---
> >  6 files changed, 81 insertions(+), 36 deletions(-)
> >  delete mode 100644 arch/arm64/kernel/scs.c
>
> [...]
>
> > @@ -70,18 +97,40 @@ static int _init_sdei_stack(unsigned long * __percpu *ptr, int cpu)
> >       return 0;
> >  }
> >
> > +static int _init_sdei_scs(unsigned long * __percpu *ptr, int cpu)
> > +{
> > +     void *s;
> > +
> > +     s = scs_alloc(cpu_to_node(cpu));
> > +     if (!s)
> > +             return -ENOMEM;
> > +     per_cpu(*ptr, cpu) = s;
> > +
> > +     return 0;
> > +}
> > +
> >  static int init_sdei_stacks(void)
> >  {
> >       int cpu;
> >       int err = 0;
> >
> >       for_each_possible_cpu(cpu) {
> > -             err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> > -             if (err)
> > -                     break;
> > -             err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> > -             if (err)
> > -                     break;
> > +             if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> > +                     err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
> > +                     if (err)
> > +                             break;
> > +                     err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
> > +                     if (err)
> > +                             break;
> > +             }
> > +             if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> > +                     err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
> > +                     if (err)
> > +                             break;
> > +                     err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
> > +                     if (err)
> > +                             break;
>
> This looks ok to me, but I think it would be better to follow the same
> approach as you have for the IRQ stacks and instead have a separate
> init_sdei_scs() function (similarly for the free() path), which means
> you can simply the IS_ENABLED() checks too.

OK, I can change this in v3. It makes error handling in
sdei_arch_get_entry_point() a bit more awkward though. We'll need
something like this:

        if (IS_ENABLED(CONFIG_VMAP_STACK)) {
                if (init_sdei_stacks())
                        return 0;
        }

        if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
                if (init_sdei_scs()) {
                        if (IS_ENABLED(CONFIG_VMAP_STACK))
                                free_sdei_stacks();
                        return 0;
                }
        }

Sami
