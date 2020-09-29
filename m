Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0727D806
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgI2U0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgI2UZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:25:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F8C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:25:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so5812403pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfMRjMpKzRlDMKyNSypttYHCWqFV6rG4s+gTfvHCn9o=;
        b=F+IVhAIEm5+w9caSbsklXW/Zz15I55StITvrN32TT5nzZfl7664u0Cv5kHk9dcdNsi
         ziYEEPl2KG3vHRQ4OMZqRMcBJv5TEPCBwZbn7Q0VakAtHBl+KSGHYBPpBh1SvaVrZRtP
         +Ad0cNxtyuuxJck1YidbjJzqrySGhTOrtfsTxIp6rKzXODRHcyqIHXnSTr1605p1MD9x
         V4mZX/TM3vPwgd5uU7zLb2Uprvm/MWYj82+qoSEmFCF92S9s5BGX+iH5zPfjDDH2eT+p
         loRZhMhGb1fe+YZTDWFpRmE6mS2fm3sjvWGaKv1ijpQfNl2++YwkvkNeZGZaq0wg+DxW
         npRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfMRjMpKzRlDMKyNSypttYHCWqFV6rG4s+gTfvHCn9o=;
        b=pyY+ynysrZ8AZ67jSekOFApvxatJo2d+XlF5XclDvetfxReMnK/aBigySA3+IukURr
         2T+A2Dk6eGLplN62IKZXCtfqEllxZfo+A7mci2p7idYfx8VzvvqpjSMrbC1uqIRunEUO
         AjDQBBR3aNAdiy0J0FQM3gtAvE7QGIHHb4ii/pXrQBqgYiPczUilhTr5vA/nQkFqCqpe
         UZ1pqI7VvsowTEg+dheBJmGFtoQWt5RX+8loMsTXlS0QR3zVGtzTY4ArB1yKcTbOrsaT
         9a+WBEmR3rWCHdGuEX6ZoAzmYlcVxEJ/NFvQpFHRwixzoEcbeDYU576scKsalxYs/1np
         2D/Q==
X-Gm-Message-State: AOAM531B+aQWWUVlrzADIOrMdfYZFcQ6u7pR4hX4M9+yYNM0mvnT3Grv
        vlYmnl5x75+3v8EfLR8DMQp1PraRg7xlV5mnQNxrRg==
X-Google-Smtp-Source: ABdhPJzkR3nxtaK5jFP39QpkEMUfVg/5RlAFvnIzVlO+WW8li8osllVX606KwonVvrKSnKVwgXPy5E4kjvfvcruecsA=
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a108 with SMTP id
 j128-20020a6255860000b029013ed13da108mr5642484pfb.36.1601411158903; Tue, 29
 Sep 2020 13:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200929194318.548707-1-ndesaulniers@google.com> <20200929200801.GA2668747@rani.riverdale.lan>
In-Reply-To: <20200929200801.GA2668747@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Sep 2020 13:25:47 -0700
Message-ID: <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Sep 29, 2020 at 1:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
> > The stringification operator, `#`, in the preprocessor escapes strings.
> > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > they treat section names that contain \".
> >
> > The portable solution is to not use a string literal with the
> > preprocessor stringification operator.
> >
> > In this case, since __section unconditionally uses the stringification
> > operator, we actually want the more verbose
> > __attribute__((__section__())).
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/linux/compiler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 92ef163a7479..ac45f6d40d39 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >       extern typeof(sym) sym;                                 \
> >       static const unsigned long __kentry_##sym               \
> >       __used                                                  \
> > -     __section("___kentry" "+" #sym )                        \
> > +     __attribute__((__section__("___kentry+" #sym)))         \
> >       = (unsigned long)&sym;
> >  #endif
> >
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >
>
> There was this previous mini-thread:
> https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
> and this older one:
> https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/
>
> Just for my own curiosity: how does KENTRY actually get used? grep
> doesn't show any hits, and the thread from 2019 was actually going to
> drop it if I read it right, and also just remove stringification from
> the __section macro.

Oh, sorry I didn't respond on that thread; I could have sworn I ran a
grep for KENTRY back then.

$ git log -S KENTRY

Doesn't seem to get any hits, so I'm not sure what I should use for a
proper Fixes tag in the event we just remove it.  Let me grab lunch,
then I'll send a v2 that just removes the KENTRY block.  Thanks for
the reminder!

And I don't remember what ever happened to Joe's script for treewide
conversion of __section.
-- 
Thanks,
~Nick Desaulniers
