Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7529CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832152AbgJ0WDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:03:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760112AbgJ0WDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:03:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id e7so1707994pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIgA23QX48XZ046Ge9ljl2tKSIQwwh1UxXCcpF43RtQ=;
        b=DQ4QYs8mm70+rmT6lRf4l6/moOr/APcehE0qI2sTetrRpD0rKQcuE06shQpHs4ISpv
         +xskUF2josJN6OZ7d1A7Szw1vnt+kuUpFQR9AMXT1EDP+t9+TC0zAGPXYCQYI2F+v573
         ncdjsWm5Lk/qtYVSspLjcRFflT9AVKO93yQwXSpZpqGOZKI8TOiMPnggSNISM68S9udt
         G/QCm6BtoytS6FFs4Cib7tax4L4ONjrZI1HVW00ZAS1uygE38BcNPpv+dzMtTzFMC0ss
         +BqJM6oJmL3i3yTBUH/czr/Y7LWL8D5KjZVFlF+xNlOG+YauJn6iVtG0d7sgAr1HwTVy
         UYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIgA23QX48XZ046Ge9ljl2tKSIQwwh1UxXCcpF43RtQ=;
        b=mFW9KuM+weFR98vQhCP+0QxlrNG5Pg3jwNoRN4MW2tW4vItp+oOlYTdShAp3lPIrpS
         CqaADxyz4xY67nSU7lOAY186OPX+e7layK8s6qJUGWt4XA27ocLSjvavXzlUsWg5YiLP
         DV8tf+BoITnIG7InvQtYr/22StrJLkfFMlV0nxEPEdQG79PinDo+8dk6fvqdJjdV7lyS
         XhuBdSlSIFhJknAlomjQ2Nqo1lNZd0BaOFOkwxN+dL4UTEVoJVwLVlTY2LJI+PgKRB2/
         x8dITnbecQGF25uHPHWQHIhTq/XCj/FjTD0KW28OZ8Wtn4qJLD2BTPzIIF6ar+AZdE3c
         jgMA==
X-Gm-Message-State: AOAM5327wQMcAm3bMdbh/SBvJbsZYhf1ybIO+Op0KERbOjwKvQeeLuTc
        eDiy8BR82wRflT9V20W77Y1sm4VdbzvDlT5oMcdOT8H6gYg=
X-Google-Smtp-Source: ABdhPJx8L1OiCbNFAi5Sliu7v9cXX6Ed/uwWX333oVtC4BVqOz5Cs6zhmcXllfQaAoaMy9QHY2yTF0fhz6TiuhuH5rw=
X-Received: by 2002:a62:ce41:0:b029:160:c0c:e03d with SMTP id
 y62-20020a62ce410000b02901600c0ce03dmr4426890pfg.15.1603836222920; Tue, 27
 Oct 2020 15:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201027205723.12514-1-ardb@kernel.org> <CAKwvOdmSaVcgq2eKRjRL+_StdFNG2QnNe3nGCs2PWfH=HceadA@mail.gmail.com>
 <CAMj1kXHb8Fe9fqpj4-90ccEMB+NJ6cbuuog-2Vuo7tr7VjZaTA@mail.gmail.com>
In-Reply-To: <CAMj1kXHb8Fe9fqpj4-90ccEMB+NJ6cbuuog-2Vuo7tr7VjZaTA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 15:03:31 -0700
Message-ID: <CAKwvOdnfkZXJdZkKO6qT53j6nH4HF=CcpUZcr7XOqdnQLSShmw@mail.gmail.com>
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

On Tue, Oct 27, 2020 at 2:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 22:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 1:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > index 6e390d58a9f8..ac3fa37a84f9 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -247,10 +247,6 @@ struct ftrace_likely_data {
> > >  #define asm_inline asm
> > >  #endif
> > >
> > > -#ifndef __no_fgcse
> > > -# define __no_fgcse
> > > -#endif
> > > -
> > Finally, this is going to disable GCSE for the whole translation unit,
> > which may be overkill.   Previously it was isolated to one function
> > definition.  You could lower the definition of the preprocessor define
> > into kernel/bpf/core.c to keep its use isolated as far as possible.
> >
>
> Which preprocessor define?

__no_fgcse

>
> > I'm fine with either approach, but we should avoid new warnings for
> > clang.  Thanks for the patch!

-- 
Thanks,
~Nick Desaulniers
