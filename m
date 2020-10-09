Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD69289BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392009AbgJIWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbgJIWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:47:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:47:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so8399056pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tY2ViAT8BuOfi5xuMFyOWzlw2bSYg16jBN39DY5VAdQ=;
        b=nFnOOMc8hwTlNtEo9+8Ej+MSHepQT8JXKR5+tljjPBINdllBge3d5tGOIDJSNx+Wkv
         GapnYtqRtJDA/6J+Yg3OlY0A/eo58LHl9EgDXJRaKOt6UVva3ErneneIJdZ6wcZYGRRP
         uQ9FxJut9HVsX/++OQYjAZO0lvCIBrRZ5MbVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tY2ViAT8BuOfi5xuMFyOWzlw2bSYg16jBN39DY5VAdQ=;
        b=TYsIf9jXsRmxrk25QyKKtIP1wrI7uSFTaBqABGisCCntlz4nfiez5/fXVDqzkCCR8R
         w2fC+MOTb2trRvbhwTOgfNIG6qdgpiexowYLVjS7f+XCFrsuE3IgOb0aWUJs7i4ljxbT
         e7Y0y6x5i7QJlgvosPJxjj74vSZzM/I1UcirdYXhRcOfZjcZ2K+R1taHJI3QiCPKZU1n
         U95RGPwWx3zcnD1HJQcfyPp/Fh+1DW+mm1KgItOSMMYSskClR+dHel9rAdJE+jCdZsCM
         NfjveOchdK0RrUNe/6rh5pgii0zD6JBCdTZd9ECi7I3XhLn/PbzwtPkz8/v+wjvpjuLN
         PVsg==
X-Gm-Message-State: AOAM533+Fluup006t9vg1ZM9wzQD1Kuqz8Aaiq2GHPXYEq458RUjPjWh
        swKReLgnZ5CB7d0VnO7SXyEV2A==
X-Google-Smtp-Source: ABdhPJwAXDU4kg0UyHq4hK2boy1nf0c4Lda0H7tYA5hp6IkpV8e/cuSuVtsBtaeJHCGeHNagW8o3DA==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr6916984pjs.155.1602283628884;
        Fri, 09 Oct 2020 15:47:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i24sm11570377pfd.15.2020.10.09.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 15:47:08 -0700 (PDT)
Date:   Fri, 9 Oct 2020 15:47:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
Message-ID: <202010091545.962A2F5@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <1a40458d081ce0d5423eb0282210055496e28774.1602263422.git.yifeifz2@illinois.edu>
 <CAG48ez1eUfjNPVKeYbk28On9WOaDBysR-=7sYDM-Q=nCzwXcDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1eUfjNPVKeYbk28On9WOaDBysR-=7sYDM-Q=nCzwXcDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:30:18PM +0200, Jann Horn wrote:
> On Fri, Oct 9, 2020 at 7:15 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> > From: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > SECCOMP_CACHE will only operate on syscalls that do not access
> > any syscall arguments or instruction pointer. To facilitate
> > this we need a static analyser to know whether a filter will
> > return allow regardless of syscall arguments for a given
> > architecture number / syscall number pair. This is implemented
> > here with a pseudo-emulator, and stored in a per-filter bitmap.
> >
> > In order to build this bitmap at filter attach time, each filter is
> > emulated for every syscall (under each possible architecture), and
> > checked for any accesses of struct seccomp_data that are not the "arch"
> > nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
> > the program returns allow, then we can be sure that the filter must
> > return allow independent from syscall arguments.
> >
> > Nearly all seccomp filters are built from these cBPF instructions:
> >
> > BPF_LD  | BPF_W    | BPF_ABS
> > BPF_JMP | BPF_JEQ  | BPF_K
> > BPF_JMP | BPF_JGE  | BPF_K
> > BPF_JMP | BPF_JGT  | BPF_K
> > BPF_JMP | BPF_JSET | BPF_K
> > BPF_JMP | BPF_JA
> > BPF_RET | BPF_K
> > BPF_ALU | BPF_AND  | BPF_K
> >
> > Each of these instructions are emulated. Any weirdness or loading
> > from a syscall argument will cause the emulator to bail.
> >
> > The emulation is also halted if it reaches a return. In that case,
> > if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
> >
> > Emulator structure and comments are from Kees [1] and Jann [2].
> >
> > Emulation is done at attach time. If a filter depends on more
> > filters, and if the dependee does not guarantee to allow the
> > syscall, then we skip the emulation of this syscall.
> >
> > [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> > [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
> [...]
> > @@ -682,6 +693,150 @@ seccomp_prepare_user_filter(const char __user *user_filter)
> >         return filter;
> >  }
> >
> > +#ifdef SECCOMP_ARCH_NATIVE
> > +/**
> > + * seccomp_is_const_allow - check if filter is constant allow with given data
> > + * @fprog: The BPF programs
> > + * @sd: The seccomp data to check against, only syscall number are arch
> > + *      number are considered constant.
> 
> nit: s/syscall number are arch number/syscall number and arch number/
> 
> > + */
> > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > +                                  struct seccomp_data *sd)
> > +{
> > +       unsigned int insns;
> > +       unsigned int reg_value = 0;
> > +       unsigned int pc;
> > +       bool op_res;
> > +
> > +       if (WARN_ON_ONCE(!fprog))
> > +               return false;
> > +
> > +       insns = bpf_classic_proglen(fprog);
> 
> bpf_classic_proglen() is defined as:
> 
> #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
> 
> so this is wrong - what you want is the number of instructions in the
> program, what you actually have is the size of the program in bytes.
> Please instead check for `pc < fprog->len` in the loop condition.

Oh yes, good catch. I had this wrong in my v1.

-- 
Kees Cook
