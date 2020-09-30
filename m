Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D180F27F452
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgI3VlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3VlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:41:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D67C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:41:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so2242588pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ne0Tvj0LHDNoNtT3tCH3e2zAqdrRlJSiwY/+6OCzSRk=;
        b=kbGgM2Os4lnrxJsMIgRxFQNFc6xu0BbOErzR7ku01j8+p1FHcxDfpz5h9so3n1uMsv
         7A9aI6yGddKPtt+1pNiFLdkJ+/xVeKtTMUdAzZc/cy2SfT0SxmKkyZGt+7yB5jd1c0z4
         dagyXQLQyS0zenl5ndJttkryDst1MwxCbc20q/3d5JpRkpF1BSPPj++dfYEIg6+DWe9Q
         K1OiYlbIAA8aXSAGmdNvPBRBXlr9Ta9U60l6z5fRTAVd3ue4cB4lhpKuUBzXYgBcsJCy
         buhIaN2YbRTp9NQ5R5/pWu+440bd8w1RwQBGQT2w4Cpy3hf2RnXwxa9m8iwMLnmVxfVQ
         1l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ne0Tvj0LHDNoNtT3tCH3e2zAqdrRlJSiwY/+6OCzSRk=;
        b=B7gDtu5w2qAsGDdd0abPGTZVUNJkyi7IDD6mU75/Jo2PoOcuyd2LYI9wjTx9kaaU2g
         Rbct+fJqJNGfeftHUywxTkVoovmo5vt27oMpRTBG2xBoJAzMr665BnOgsQ+9wiXfquAu
         KRE59xNritRtYM9FvtM8cRm7cvuv510D0HSErtpLv5C5UHVpFQJvUvIVzVd8q5sYSDYI
         LAme2HE26SqJ/7CDDFxaSf7R0/lol0QzMBjmBCNzR15myF1qmtSceg4tXkMo+5Yz0gDa
         ZQeO+bghEmf/sQLa9qYdXEPaG92ut0gL8PIPrYfoZVAS0u1dPayp466UfeVz85uWdPi5
         zADg==
X-Gm-Message-State: AOAM53083g23kwxHKRSh94CVHWHTRunU84a2pmueptmVKvvBTxVgKtUt
        COOP0FevMmfu0gumAhb6ClBzbO79gyN5UcJBM947mwQasXkmmQ==
X-Google-Smtp-Source: ABdhPJxmQZ2xAuUPBAlKfZHL8pW+RLFby0uRw4CRW7TnQmWa/w64csKigs9yFzxKQ9LMeF1owhbyN9G+WFkvvDvrwlE=
X-Received: by 2002:a17:902:c40d:b029:d2:93e8:1f4b with SMTP id
 k13-20020a170902c40db02900d293e81f4bmr4285228plk.29.1601502066090; Wed, 30
 Sep 2020 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com> <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
In-Reply-To: <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 14:40:54 -0700
Message-ID: <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
>
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.
>
> Remove the quote operator # from compiler_attributes.h __section macro.
>
> Convert all unquoted __section(foo) uses to quoted __section("foo").
> Also convert __attribute__((section("foo"))) uses to __section("foo")
> even if the __attribute__ has multiple list entry forms.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> This is the current output from the script against next-20200930
> attached in this link:
>
> https://lore.kernel.org/lkml/0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com/
>
> It might be useful to run the script immediately before
> the next -rc1.

$ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
powernv_defconfig
$ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
...
arch/powerpc/boot/main.c:193:44: error: expected ';' after top level declarator
static char cmdline[BOOT_COMMAND_LINE_SIZE]
                                           ^
                                           ;
$ git blame arch/powerpc/boot/main.c -L 193 | head -n2
a2dd5da77f2cc arch/powerpc/boot/main.c (Anton Blanchard
2014-04-14 21:54:05 +1000 193) static char
cmdline[BOOT_COMMAND_LINE_SIZE]
9d04187c25477 arch/powerpc/boot/main.c (Joe Perches
2020-09-30 12:16:43 -0700 194)   __section("__builtin_cmdline");

Looks like arch/powerpc/boot/main.c doesn't include
compiler_attributes.h? Preprocessing it doesn't expand __section as
expected.  I think scripts/Makefile.lib's c_flags injects this via
-include flag.

(x86_64, arm, and arm64 defconfigs worked fine for me otherwise).

https://lore.kernel.org/lkml/46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com/
-- 
Thanks,
~Nick Desaulniers
