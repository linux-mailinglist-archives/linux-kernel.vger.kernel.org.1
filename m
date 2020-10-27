Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0664E29C794
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828867AbgJ0Siu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:38:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43610 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825136AbgJ0Sit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:38:49 -0400
Received: by mail-il1-f194.google.com with SMTP id k1so2416173ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiO536AD0kVAcMS1nvBFWPaDHL/6Ip6VypBDRiSKR20=;
        b=lsGwBrEqSVcHL0bMljNjO4ezVKGqSsp9nWInL3C63xb2PfozbnUf06FRu0AMl9ni6X
         Bi9suCGK1f45eXLCN2ax8a76eSQYpZ+3gat8/oUDfrXl7oO5VehKVW/4R62swqsE2nC7
         6wLpJB1VbC61FOGxIN9T9QaT7uFKaaNdhinIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiO536AD0kVAcMS1nvBFWPaDHL/6Ip6VypBDRiSKR20=;
        b=mhs+CBEkIvR0QynkvZz5IS2u9YixbLw1Vp39bndUH2Sr8cIHr07yseKyo8//KsN902
         6DooJloWEYm8Gwvj0yGkX4KqMhkR5F99qD5Fib5IUg0/XxmwR0yuvYTVrH1QGdskFfNU
         XPD9ymynICaj0wxxpk3Y+NfO5dPBPFru2RPdcA9iBPrMaasqzUyeJ3Oeq4tevyrvFVjI
         kdtBd+2flVPqF5CnoPpArMGL43oinJb1dmS6bljs8UcwWXx1wbxgqkSY406uCo17zn7l
         ApSqCmSK/tTtlbN6QEVlm6p1AEOow0NXfkfVU9Q0zF5FFbiZAByoa+w/O1uPUom5DiK1
         4hsQ==
X-Gm-Message-State: AOAM532Qovdoam/GIHwaqqf/8/HbWs48ZdEWx/gTC+NxOl0PKwgFmn3t
        WdRTzPbpaz6BiUn4APSrogNz6hsTnr8RGqzpRZYN
X-Google-Smtp-Source: ABdhPJxm1R6B3j7qwb/SJHdaVnNFjfNds3NG15mUS4t24rGu4bAN9GXYSEVvdt0aR8PyxfyMpNMgdP2eEtXsuzXHfQ0=
X-Received: by 2002:a92:6410:: with SMTP id y16mr3002898ilb.126.1603823927105;
 Tue, 27 Oct 2020 11:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201026230254.911912-1-atish.patra@wdc.com> <20201026230254.911912-3-atish.patra@wdc.com>
 <20201027100427.GL1154158@kernel.org>
In-Reply-To: <20201027100427.GL1154158@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 27 Oct 2020 11:38:35 -0700
Message-ID: <CAOnJCUJF8DTNpiGxL0Tz8CUk43CvfJS2w5fw=Y51afKgW22cTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Initialize SBI early
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 3:04 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:02:50PM -0700, Atish Patra wrote:
> > Currently, SBI is initialized towards the end of arch setup. This prevents
> > the set memory operations to be invoked earlier as it requires a full tlb
> > flush.
> >
> > Initialize SBI as early as possible.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/kernel/setup.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index c424cc6dd833..7d6a04ae3929 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -89,6 +89,9 @@ void __init setup_arch(char **cmdline_p)
> >               pr_err("No DTB found in kernel mappings\n");
> >  #endif
> >
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
>
> Maybe
>         if (IS_ENABLED(CONFIG_RISCV_SBI))
>                 sbi_init()
>

ok. Will update.

> > +     sbi_init();
> > +#endif
> >  #ifdef CONFIG_SWIOTLB
> >       swiotlb_init(1);
> >  #endif
> > @@ -97,10 +100,6 @@ void __init setup_arch(char **cmdline_p)
> >       kasan_init();
> >  #endif
> >
> > -#if IS_ENABLED(CONFIG_RISCV_SBI)
> > -     sbi_init();
> > -#endif
> > -
> >  #ifdef CONFIG_SMP
> >       setup_smp();
> >  #endif
> > --
> > 2.25.1
> >
>
> --
> Sincerely yours,
> Mike.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
