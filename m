Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122F8276B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIXHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIXHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:46:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772BC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:46:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so1364076pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pn8AkGMTGfdnWTJRca9J7bhZq32aHx0QMblFYoTDsz4=;
        b=GdNsA/P0p61OU5c03zIIUOXZv3MQ0nBBcfB3Hc9r0sEY0oXx591w0DRyGt7MjNUDFN
         VhTXCFtMPSzKYr/yxvOnJ7w4D4VOiPCHAj6p2KnhZp3U+tyTB5l9ahqgKrzkT19oYxJA
         +jl1MwnAxFEWmHLz7pOEouqNuDZDlIBIFbkB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pn8AkGMTGfdnWTJRca9J7bhZq32aHx0QMblFYoTDsz4=;
        b=dZff3sPAloD4DSAqGbfmTAqkXtk4xYn6TLzx4P5Jr0X9B3o/1bX9+IXrSfKfwQLu8T
         HRiM7Lwly2qKnFmiw/RAzIr8lsNb4ktI05iFtjP/m9ZjR6JJa83U9nDpKUVFVV+Omh74
         /+YUvoaoihmHKf2BQkr7sR7+fD0UtTkRNeTlAh+J55DNycKk6VlVJyaeHtHOtUu/SI7a
         ZXOgeCEBGtA46zQ8uBBXMkQFVaRISRXxyIgqdYmsFP8qb+wNxeyk3yjAjZrcqFZL0B4j
         R7hbwPHG6DgaMcOifIeOutIW9hElCAdCI6TxAPgt2lZSw949PzgbZyXps88GMhdhVBqX
         4kPg==
X-Gm-Message-State: AOAM531phipzRaPEZhCUtF0hh+CkX+bLhjQ6VxBTj3zcAN3ciRUSf8DQ
        HfdaqtEm+FRULjaQghMRasz0BA==
X-Google-Smtp-Source: ABdhPJxpv5eo0PCR5lxqSFEPXJ04YWDS30xuJeZwg37nkM2ihTg/HjMMDvdx6OdSaODt3kicQemxsw==
X-Received: by 2002:aa7:8dc7:0:b029:151:2237:52c5 with SMTP id j7-20020aa78dc70000b0290151223752c5mr3014124pfr.32.1600933601671;
        Thu, 24 Sep 2020 00:46:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm1969377pfb.198.2020.09.24.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:46:40 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:46:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Paul Moore <paul@paul-moore.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] seccomp: Emulate basic filters for constant action
 results
Message-ID: <202009240038.864365E@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-5-keescook@chromium.org>
 <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:47:47AM +0200, Jann Horn wrote:
> On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > This emulates absolutely the most basic seccomp filters to figure out
> > if they will always give the same results for a given arch/nr combo.
> >
> > Nearly all seccomp filters are built from the following ops:
> >
> > BPF_LD  | BPF_W    | BPF_ABS
> > BPF_JMP | BPF_JEQ  | BPF_K
> > BPF_JMP | BPF_JGE  | BPF_K
> > BPF_JMP | BPF_JGT  | BPF_K
> > BPF_JMP | BPF_JSET | BPF_K
> > BPF_JMP | BPF_JA
> > BPF_RET | BPF_K
> >
> > These are now emulated to check for accesses beyond seccomp_data::arch
> > or unknown instructions.
> >
> > Not yet implemented are:
> >
> > BPF_ALU | BPF_AND (generated by libseccomp and Chrome)
> 
> BPF_AND is normally only used on syscall arguments, not on the syscall
> number or the architecture, right? And when a syscall argument is
> loaded, we abort execution anyway. So I think there is no need to
> implement those?

Is that right? I can't actually tell what libseccomp is doing with
ALU|AND. It looks like it's using it for building jump lists?

Paul, Tom, under what cases does libseccomp emit ALU|AND into filters?

> > Suggested-by: Jann Horn <jannh@google.com>
> > Link: https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/seccomp.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++---
> >  net/core/filter.c |  3 +-
> >  2 files changed, 79 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 111a238bc532..9921f6f39d12 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -610,7 +610,12 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
> >  {
> >         struct seccomp_filter *sfilter;
> >         int ret;
> > -       const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
> > +       const bool save_orig =
> > +#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH)
> > +               true;
> > +#else
> > +               false;
> > +#endif
> 
> You could probably write this as something like:
> 
> const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
> __is_defined(SECCOMP_ARCH);

Ah! Thank you. I went looking for __is_defined() and failed. :)

> 
> [...]
> > diff --git a/net/core/filter.c b/net/core/filter.c
> [...]
> > -static void bpf_release_orig_filter(struct bpf_prog *fp)
> > +void bpf_release_orig_filter(struct bpf_prog *fp)
> >  {
> >         struct sock_fprog_kern *fprog = fp->orig_prog;
> >
> > @@ -1154,6 +1154,7 @@ static void bpf_release_orig_filter(struct bpf_prog *fp)
> >                 kfree(fprog);
> >         }
> >  }
> > +EXPORT_SYMBOL_GPL(bpf_release_orig_filter);
> 
> If this change really belongs into this patch (which I don't think it
> does), please describe why in the commit message.

Yup, more cruft I failed to remove.

-- 
Kees Cook
