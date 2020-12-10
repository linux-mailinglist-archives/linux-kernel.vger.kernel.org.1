Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7462D6B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394224AbgLJWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:32:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40319 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405129AbgLJW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:26:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id t37so5596542pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDWcEk/bsx49QrHA7le6QrzeyX76Cr1G90wWwfXt9og=;
        b=eyVki26QxbAouCaaS+b5GUx8CLMRFIUjtoypoV1IvhDtSzOg3ca6z5EmYDGXNGdnsl
         U+P3N8j9mIzu2E6FUrgaBxpdccT6tWtbHCrRjZMks0d0xEp+Chmmqgi1Hxnek/CfhSSb
         J/g7qBme+dbBvOTXGw++vYsu1hR611rkrq7AKJAuQe39bo/lcfts5+qbjkI83D1B1OTP
         I+AkQfB8YDF2EkuZYN/PtM6wUI/ebdlwaa3KjJp+l64dFy3cwul8BPM8X9BMoxO+lorY
         c46YnKuEqYtlLlnSw4CRt/ovwT+/sQjuIuY9PLoZ/koHhXzyXUfoJqAoagvAWP5ophzp
         1nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDWcEk/bsx49QrHA7le6QrzeyX76Cr1G90wWwfXt9og=;
        b=l+Nj2u59b/O1zbVAIH9xsBWRcmutxBwgBrX4gaBPGljUvgOSI7pi3Ru+ekEF5oBcOC
         2k+/Flp3fcBqURrFYbGfKV2Z63XhMe5OS2JYDQHlutdx07rrMseTKBmT9T6TffRsac0U
         Jmm6OOOLV8DI5Gu23VZYcznXmgeNjFD9ZPY41VerbkfIzsncAmTa7E0tfwIu/mUzUlJ4
         4BD/dlhmuayp1RLVLNZtulWPNeaK5xTJRbD2RvDVNyTRX5U5oZUV+6hiRRQKMstPq01v
         kplyQA9/Nje7XEHiRmP/+DGgSg5h4vOUCxcYSJyQjB8qoBl/ulkGd1yZUD4bt/Wkcasm
         kNIA==
X-Gm-Message-State: AOAM5304cFUVmiLLNi7r43huOTQABKU0RjVRVR2IYAWmQzyUR4DW9fC/
        Lh6265JUaCt35hoFyh0G7e2X8oSRJS3CnBjlVTyRA2FOP/Klqw==
X-Google-Smtp-Source: ABdhPJzopPgY04RexLu7seRjCtvQA796q4DkmGgHbAC5sIUU3JvJreGcaZy2uhTAnU3vlcA/nOou9RxdlKuQmXwmL5M=
X-Received: by 2002:a63:184c:: with SMTP id 12mr1082455pgy.381.1607636935147;
 Thu, 10 Dec 2020 13:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
 <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
 <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
 <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com> <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com>
In-Reply-To: <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Dec 2020 13:48:43 -0800
Message-ID: <CAKwvOdn7c20vATaJMzsMYtCngs6ZDQMW8LX9ywhARxL6OKEdNg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Marco Elver <elver@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 8:25 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 10 Dec 2020 at 14:29, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Thu, Dec 10, 2020 at 11:35 AM Marco Elver <elver@google.com> wrote:
> > >
> > > It looks like there's no clear MAINTAINER for this. :-/
> > > It'd still be good to fix this for 5.11.
> >
> > Richard seems to be the author, not sure if he picks patches (CC'd).
> >
> > I guess Masahiro or akpm (Cc'd) would be two options; otherwise, I
> > could pick it up through compiler attributes (stretching the
> > definition...).
>
> Thanks for the info. I did find that there's an alternative patch to
> fix _Static_assert() with genksyms that was sent 3 days after mine
> (it's simpler, but might miss cases). I've responded there (
> https://lkml.kernel.org/r/X9JI5KpWoo23wkRg@elver.google.com ).
>
> Now we have some choice. I'd argue for this patch, because it's not
> doing preprocessor workarounds, but in the end I won't make that call.
> :-)

I was half kidding about depending on a production C parser.  See
internal reference pa/1432607, choice quotes:
```
...
CONFIG_MODVERSIONS uses scripts/genksyms/genksyms to create a file,
Module.symvers, that is a simple mapping of CRCs of various symbols'
types to the symbol names.  It produces these CRCs by using the C
preprocessor, then passing this into genksyms. genksyms has a lex/yacc
based C parser to parse the preprocessed sources of kernel modules.  It
turns out that it's incomplete, copied from an upstream project that
ceased development in 2013, and was slated to be removed around the 4.9
kernel release.
...
Some possible solutions:
* Update the kernel's version of genksyms.  There's a comment that the
  kernel's sources were copied from "modutils." It seems that modutils'
  last release was v2.4.27 in 2004, and that development on it has
  stopped.  Upstream modutils also has the same parsing bug.
...
* Fix the parsing bug in genksysms. While the discussion about removing
  CONFIG_MODVERSIONS has started again upstream due to my bugreport,
  this would be the optimal solution, if I could just figure out how to
  rewrite the parser correctly.
...
A better long term solution would be to replace genksyms's
modutils/lex/yacc based incomplete and dead C parser with a libclang
based one, but such work is beyond the scope of a toolchain update.

For future travelers that would like to take a crack at fixing the
existing parser, I found the develop/build/test/debug cycle to be:

$ rm scripts/genksyms/genksyms
$ make scripts/genksyms/
$ ./scripts/genksyms/genksyms -d < test_case.i
$ ./scripts/genksyms/genksyms -d -d < test_case.i
Best of luck on that endeavor.
```

I was planning on talking about this timebomb at plumbers, but had to
cut it due to the tight time constraints we were allotted.
-- 
Thanks,
~Nick Desaulniers
