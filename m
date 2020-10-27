Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C529C7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822786AbgJ0SmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:42:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39704 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438692AbgJ0SmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:42:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id e15so1427258pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4UOH5jyqTNumhZnEvlhMMc/cRwn1xdTsrZ9+JD6lok=;
        b=aEKMwtsbLlwKF5zNE4rOEF/KhPjoWyAKxo3KgcBykM6hKR6fWiFv9A5Rgbk+rJkprZ
         bQRzrc7k2utYWXIfncAA1L2r6aoMmPYcRVFJwmBRZi3AjdaIJy5RW96pGQevSWqHmc8B
         /lD/cExdWJxZ1EysQdHshj/lVIhuOjSVgeF89NFYpFztviw5lePGO9vpcSiaj/NyJyYf
         3+0B/Tr06H3GfQ9mjcLbPT0rKzqWd8kS69qKUKKO/E0iuAy1m7HRCKCgz6dChM+9MOdA
         6vZsP+BfCZ2KzGUixs0voNMxJzfWnVnsGz4j54MDOVL5AgQ1sVY5QpPID3bTukJNcZ39
         WHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4UOH5jyqTNumhZnEvlhMMc/cRwn1xdTsrZ9+JD6lok=;
        b=LeBezssYV1xEmEYX6XkMTt6u78NpjRBILbX5wVloAJgcLVcjRQUx22O7pMZhc3nKLo
         6zwbmo4VlIEkRvGFFjt13030fwIz33Hyl7pIHzIuE/Li9x3HzgsDrg0WapucnuF8PmHl
         YlTA42pOKTJPIEGsqaF0Dmh6nRmlP5Coy+AJotqgryWDJeJAFqejw3g82dxJZAcfpQ37
         YRL5PpVBef/VLDmRNTZtjhPkUdRUQZQlrl1jh8Bac2hbGqlg1Ds81a2Fu6hy1WtE1tf0
         bG3coXG4xLLB4RGvRwoicJsstjLxjO13qBqeJoDWyuqik7dHLndUtiV1H0D7Re5TdKBP
         0BZA==
X-Gm-Message-State: AOAM5301lZjMiFpxpFjA2SneumzMjeR3ciybhT2k+gSj9pLxm0LZPTo8
        3pr3/TvT5OBHoN5uP8HgHLQLdFffZpk1wPpsQe03KA==
X-Google-Smtp-Source: ABdhPJzQmNmx0bWlzudNNkOjp+XHfqzhleL72oPPZRT/u/xUY8OxG4+g0kFR0A9s3htUEaPIhp4n2jmEr2T58gGeub0=
X-Received: by 2002:a63:5152:: with SMTP id r18mr2927519pgl.381.1603824138147;
 Tue, 27 Oct 2020 11:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201027164255.1573301-1-trix@redhat.com>
In-Reply-To: <20201027164255.1573301-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 11:42:07 -0700
Message-ID: <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Tom Rix <trix@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Joe Perches <joe@perches.com>,
        Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cutting down the CC list to something more intimate)

Tom, I'm over the moon to see clang-tidy being used this way.  I
totally forgot it could automatically apply fixits.  I'm glad Nathan
and Masahiro were able to get the foundation laid for running
clang-tidy on the kernel this summer.

On Tue, Oct 27, 2020 at 9:43 AM <trix@redhat.com> wrote:
>
> This rfc will describe
> An upcoming treewide cleanup.
> How clang tooling was used to programatically do the clean up.
> Solicit opinions on how to generally use clang tooling.
>
> The clang warning -Wextra-semi-stmt produces about 10k warnings.
> Reviewing these, a subset of semicolon after a switch looks safe to
> fix all the time.  An example problem
>
> void foo(int a) {
>      switch(a) {
>                case 1:
>                ...
>      }; <--- extra semicolon
> }
>
> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
> These fixes will be the upcoming cleanup.
>
> clang already supports fixing this problem. Add to your command line
>
>   clang -c -Wextra-semi-stmt -Xclang -fixit foo.c
>
>   foo.c:8:3: warning: empty expression statement has no effect;
>     remove unnecessary ';' to silence this warning [-Wextra-semi-stmt]
>         };
>          ^
>   foo.c:8:3: note: FIX-IT applied suggested code changes
>   1 warning generated.

Ah, doesn't that rely on clang-tidy to apply the fixit?  (oh, what,
maybe not: https://stackoverflow.com/a/49749277)

And doesn't that require your patch to clang-tidy to land?
https://reviews.llvm.org/D90180

Now I'm confused; if clang can apply the fixit for warnings, why do we
need another patch to clang-tidy?

>
> The big problem is using this treewide is it will fix all 10k problems.
> 10k changes to analyze and upstream is not practical.
>
> Another problem is the generic fixer only removes the semicolon.
> So empty lines with some tabs need to be manually cleaned.
>
> What is needed is a more precise fixer.
>
> Enter clang-tidy.
> https://clang.llvm.org/extra/clang-tidy/
>
> Already part of the static checker infrastructure, invoke on the clang
> build with
>   make clang-tidy
>
> It is only a matter of coding up a specific checker for the cleanup.
> Upstream this is review is happening here
> https://reviews.llvm.org/D90180

Sorry, I still don't understand how the clang-tidy checker wont also
produce 10k fixes?

>
> The development of a checker/fixer is
> Start with a reproducer
>
> void foo (int a) {
>   switch (a) {};
> }
>
> Generate the abstract syntax tree (AST)
>
>   clang -Xclang -ast-dump foo.c
>
> `-FunctionDecl
>   |-ParmVarDecl
>   `-CompoundStmt
>     |-SwitchStmt
>     | |-ImplicitCastExpr
>     | | `-DeclRefExpr
>     | `-CompoundStmt
>     `-NullStmt
>
> Write a matcher to get you most of the way
>
> void SwitchSemiCheck::registerMatchers(MatchFinder *Finder) {
>   Finder->addMatcher(
>       compoundStmt(has(switchStmt().bind("switch"))).bind("comp"), this);
> }
>
> The 'bind' method is important, it allows a string to be associated
> with a node in the AST.  In this case these are
>
> `-FunctionDecl
>   |-ParmVarDecl
>   `-CompoundStmt <-------- comp
>     |-SwitchStmt <-------- switch
>     | |-ImplicitCastExpr
>     | | `-DeclRefExpr
>     | `-CompoundStmt
>     `-NullStmt
>
> When a match is made the 'check' method will be called.
>
>   void SwitchSemiCheck::check(const MatchFinder::MatchResult &Result) {
>     auto *C = Result.Nodes.getNodeAs<CompoundStmt>("comp");
>     auto *S = Result.Nodes.getNodeAs<SwitchStmt>("switch");
>
> This is where the string in the bind calls are changed to nodes
>
> `-FunctionDecl
>   |-ParmVarDecl
>   `-CompoundStmt <-------- comp, C
>     |-SwitchStmt <-------- switch, S
>     | |-ImplicitCastExpr
>     | | `-DeclRefExpr
>     | `-CompoundStmt
>     `-NullStmt <---------- looking for N
>
> And then more logic to find the NullStmt
>
>   auto Current = C->body_begin();
>   auto Next = Current;
>   Next++;
>   while (Next != C->body_end()) {
>     if (*Current == S) {
>       if (const auto *N = dyn_cast<NullStmt>(*Next)) {
>
> When it is found, a warning is printed and a FixItHint is proposed.
>
>   auto H = FixItHint::CreateReplacement(
>     SourceRange(S->getBody()->getEndLoc(), N->getSemiLoc()), "}");
>   diag(N->getSemiLoc(), "unneeded semicolon") << H;
>
> This fixit replaces from the end of switch to the semicolon with a
> '}'.  Because the end of the switch is '}' this has the effect of
> removing all the whitespace as well as the semicolon.
>
> Because of the checker's placement in clang-tidy existing linuxkernel
> checkers, all that was needed to fix the tree was to add a '-fix'to the
> build's clang-tidy call.

I wonder if there's a way to differentiate existing checks we'd prefer
to run continuously vs newer noisier ones?  Drowning in a sea of 10k
-Wextra-semi-stmt doesn't sound like fun.  Maybe a new target for make
to differentiate reporting vs auto fixing?

>
> I am looking for opinions on what we want to do specifically with
> cleanups and generally about other source-to-source programmatic
> changes to the code base.
>
> For cleanups, I think we need a new toplevel target
>
> clang-tidy-fix

ah, yep, I agree.  Though I'm curious now that I know that clang can
be used as the driver to apply fixits rather than clang-tidy, how else
we can leverage clang over manually writing clang-tidy checks.  Unless
I have something confused there?

>
> And an explicit list of fixers that have a very high (100%?) fix rate.
>
> Ideally a bot should make the changes, but a bot could also nag folks.
> Is there interest in a bot making the changes? Does one already exist?

Most recently Joe sent a treewide fix for section attributes that
Linux pulled just after the merge window closed, IIUC.  Maybe that
would be the best time, since automation makes it trivial for anyone
to run the treewide fixit whenever.

>
> The general source-to-source is a bit blue sky.  Ex/ could automagicly
> refactor api, outline similar cut-n-pasted functions etc. Anything on
> someone's wishlist you want to try out ?
>
> Signed-off-by: Tom Rix <trix@redhat.com>
>
> --

-- 
Thanks,
~Nick Desaulniers
