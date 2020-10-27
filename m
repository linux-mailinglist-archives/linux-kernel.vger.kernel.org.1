Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56C329CC15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832514AbgJ0WiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:38:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40558 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506756AbgJ0WiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:38:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id x13so1612367pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9O+TmXhlnfP5R6O9DpvzK2ercmawtIkUjzbxe45Iwg=;
        b=otD0MCq45wssDlOXzQwczNbnAOzRVOtZq8ghq/C9+xy1YHDSsCKD90mb3q8OLOqT04
         AWo+bHszx+5HStkJxvJhg262Oqr0seRMbRPO2PwP29amCUZyYV6nax37AcvcQDidjX7k
         BoSPvpE0Go7t2cGoWmLGxZhAL195kZI4C8kSw6TZJsqHFC8MhcuKrPBQNyrgrfaeCY6f
         gWlRsRRvcroD3aYV82K9WS4hqzO3eDXAGVsUZ8YrybzSHF3qoqgYhZuSyvXSrp6Lh+1U
         ZIDUyXA0G3vT/1CkBNC7OodyLxOIBILUbnGwO70M3ujrcyA9spiw7g3ZCl6CzSshSTEv
         szCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9O+TmXhlnfP5R6O9DpvzK2ercmawtIkUjzbxe45Iwg=;
        b=OJPrMQFRLtEWSl2aZBRUewbUPsmGQR78PiltafXJHC9vMJWIJZMnUePydlZiFsDJ8t
         Eo9p/8ifZpeNcaGzyH6mVd4fov0xn4TeRlPGA3TExh79eflbFvDU9n9UCrDXy7aTYD/z
         60jWV9jOSN2qxH/uvRPx9iX6vVPIRj1TEfdZ8jqmkc4eXB9Rtn0cwP+Il2K0V0FeS7mQ
         CoXSAG7l+ohPMuvq24QkjTXMBla1m+77e2Vzgco6slVsV8PQg4BglsJYa2oggSXl1ZSY
         ymvIOSvvK7mZvNiBQ3f4yHUwS1UiEf6vufUcP+XPS+99Qg+IHnkuEog4261coLc34t6A
         7VXg==
X-Gm-Message-State: AOAM5313lPxR4GWqrbSe17zfJbg9J6G6a3O97bhcWx+48PU4oPtjgQ2C
        g/Fz5ljqHx7mzle8LqP10kleF7CfSTF4ylA7KFo4/g==
X-Google-Smtp-Source: ABdhPJzP7j1Lbj4WSsoUKb2lWQx7WDgPStbwHlqaHM9gPztwgyJ4hgczG3OAoGh39yapaieXK2OogSBg7OE6lsO67Tk=
X-Received: by 2002:a62:2905:0:b029:15b:57ef:3356 with SMTP id
 p5-20020a6229050000b029015b57ef3356mr3561178pfp.36.1603838297314; Tue, 27 Oct
 2020 15:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027205723.12514-1-ardb@kernel.org> <CAKwvOdmSaVcgq2eKRjRL+_StdFNG2QnNe3nGCs2PWfH=HceadA@mail.gmail.com>
 <CAMj1kXHb8Fe9fqpj4-90ccEMB+NJ6cbuuog-2Vuo7tr7VjZaTA@mail.gmail.com>
 <CAKwvOdnfkZXJdZkKO6qT53j6nH4HF=CcpUZcr7XOqdnQLSShmw@mail.gmail.com> <CAMj1kXGFWr5FSiO79VYEYhB2eCpDP5vyTJmdskxrKWnUz-GP-w@mail.gmail.com>
In-Reply-To: <CAMj1kXGFWr5FSiO79VYEYhB2eCpDP5vyTJmdskxrKWnUz-GP-w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 15:38:06 -0700
Message-ID: <CAKwvOdmcuSce_R_4=BmewPm_3t75_dkDan7YMXF_cb39mQEDyw@mail.gmail.com>
Subject: Re: [PATCH] bpf: don't rely on GCC __attribute__((optimize)) to
 disable GCSE
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 3:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 23:03, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 2:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 27 Oct 2020 at 22:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Tue, Oct 27, 2020 at 1:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > > > index 6e390d58a9f8..ac3fa37a84f9 100644
> > > > > --- a/include/linux/compiler_types.h
> > > > > +++ b/include/linux/compiler_types.h
> > > > > @@ -247,10 +247,6 @@ struct ftrace_likely_data {
> > > > >  #define asm_inline asm
> > > > >  #endif
> > > > >
> > > > > -#ifndef __no_fgcse
> > > > > -# define __no_fgcse
> > > > > -#endif
> > > > > -
> > > > Finally, this is going to disable GCSE for the whole translation unit,
> > > > which may be overkill.   Previously it was isolated to one function
> > > > definition.  You could lower the definition of the preprocessor define
> > > > into kernel/bpf/core.c to keep its use isolated as far as possible.
> > > >
> > >
> > > Which preprocessor define?
> >
> > __no_fgcse
> >
>
> But we can't use that, that is the whole point of this patch.

Ah, right because the attribute drops other command line flags...ok,
then -fno-gcse the whole translation unit it is then.

Still need to avoid new warnings with clang though.
-- 
Thanks,
~Nick Desaulniers
