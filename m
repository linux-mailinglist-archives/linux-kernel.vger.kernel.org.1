Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2427D973
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgI2U7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgI2U7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:59:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:59:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so5933157pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j96NedzGrWve7hqjmdtY+y6fO2Eq0jqMR0Z821xkzTY=;
        b=XKwEiCwmAC3jhPabqr8QHkp/dKsSR5IyQtwHI1IpeT4t2z6bPbJe2tZ1S0DbzstuJU
         8MSecgKhO0ch+8KnP59v/SBpMJjwvayqDhknG6UrekmAgP8I1gsQ39xs4z30s2/r037g
         UzAc0No2XTKC1EuUHL+clUa2rZ52ZT3jq7GxV7m/ERMUokR63+XZ/3W7P4AegkQ2bsgn
         jmnqeEx7isCw3BFV1nmfAA2sq1fiFjYg9GcXEGjzDC/Vt4OCRuSldJWDU5H5VRyTW2su
         p10pUUvJNz01iA5tYwKBouK/F2vLbCOeW2TEgqoi14irfphSrnKDdMCNkafoUbh2Yyqh
         Jfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j96NedzGrWve7hqjmdtY+y6fO2Eq0jqMR0Z821xkzTY=;
        b=ISn3ri6H7xehjcnfnOckGk2H/N6CxRpX8ly7OC3NlvMG809chaDIgMx+vc8PkqbRgq
         GHeltv4hNw0tg+yWAMQw44uXj/0iKBR0/JJgKPkvCmEsfkrSw0vWu8vONYtujAi762i4
         e9X8FCt0gUkYbhB8ff6k6hX/YC0vPjucIFiygI5Lx1jkQScmy2Fq7qY/ynfgFZvoHfsU
         RLuP/UGr33RN5OKluybnbiZxg5wFqeTp8KZdRLuyVwF14dF7YIYRjlMsC0+ES3YfJ2EO
         b1JIddQp4OX1HQMLV1bcPohERdWz+XJCrGUSB6i1uK8c/ZhtVv7SR0uksBNkUPeBHHR7
         rZLQ==
X-Gm-Message-State: AOAM530S3g5E9StTPoE2HZBDwDVW4knUwh76hYYhSsV9Lc6Zv70fQIzR
        eWDwoICRwrOeT86s5Sm2KG7EUf3JgPV6/k4iQIJiQCG3pzxjVg==
X-Google-Smtp-Source: ABdhPJx+h2DQVVa4KIVpWHd1F9+9PUWh5wcJwN9YgMDn1Yrv/xPFWNzisfb3RFx/nclCBKxiri5ZY/qtW9qvV46RRZE=
X-Received: by 2002:a17:902:c151:b029:d2:42a6:2fb with SMTP id
 17-20020a170902c151b02900d242a602fbmr6414637plj.10.1601413182230; Tue, 29 Sep
 2020 13:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200929194318.548707-1-ndesaulniers@google.com>
 <20200929200801.GA2668747@rani.riverdale.lan> <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
 <CAKwvOdmA746irmMVAzs5pJz4XgcWMBA8jWM2Ha1Z5c6hajWzJw@mail.gmail.com> <20200929204748.GA2683578@rani.riverdale.lan>
In-Reply-To: <20200929204748.GA2683578@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Sep 2020 13:59:30 -0700
Message-ID: <CAKwvOd=Pj1FiFxKwbGu1g-LjabHqbct4_HF2BpEj4Su6+Fv-Gw@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 1:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Sep 29, 2020 at 01:30:22PM -0700, Nick Desaulniers wrote:
> > On Tue, Sep 29, 2020 at 1:25 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 1:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
> > > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > > they treat section names that contain \".
> > > > >
> > > > > The portable solution is to not use a string literal with the
> > > > > preprocessor stringification operator.
> > > > >
> > > > > In this case, since __section unconditionally uses the stringification
> > > > > operator, we actually want the more verbose
> > > > > __attribute__((__section__())).
> > > > >
> > > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > > Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > ---
> > > > >  include/linux/compiler.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > > index 92ef163a7479..ac45f6d40d39 100644
> > > > > --- a/include/linux/compiler.h
> > > > > +++ b/include/linux/compiler.h
> > > > > @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > > >       extern typeof(sym) sym;                                 \
> > > > >       static const unsigned long __kentry_##sym               \
> > > > >       __used                                                  \
> > > > > -     __section("___kentry" "+" #sym )                        \
> > > > > +     __attribute__((__section__("___kentry+" #sym)))         \
> > > > >       = (unsigned long)&sym;
> > > > >  #endif
> > > > >
> > > > > --
> > > > > 2.28.0.709.gb0816b6eb0-goog
> > > > >
> > > >
> > > > There was this previous mini-thread:
> > > > https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
> > > > and this older one:
> > > > https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/
> > > >
> > > > Just for my own curiosity: how does KENTRY actually get used? grep
> > > > doesn't show any hits, and the thread from 2019 was actually going to
> > > > drop it if I read it right, and also just remove stringification from
> > > > the __section macro.
> > >
> > > Oh, sorry I didn't respond on that thread; I could have sworn I ran a
> > > grep for KENTRY back then.
> > >
> > > $ git log -S KENTRY
> >
> > Added by
> > b67067f1176df6ee727450546b58704e4b588563 ?
> >
>
> Yeah but nothing seems to have used it. I assume for LTO we use some
> other technique to mark functions as used?

Nicholas, do you recall why KENTRY was added in
b67067f1176df6ee727450546b58704e4b588563?  May I remove that and the
addition to INIT_DATA from that commit?

-- 
Thanks,
~Nick Desaulniers
