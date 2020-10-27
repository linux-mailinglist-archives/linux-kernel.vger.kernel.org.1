Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83629C906
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900678AbgJ0TeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437262AbgJ0TeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603827245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4k50Yu7bOoV/ZgIg7/uNXPd/NZkISAhyo8g0Xv0iog=;
        b=SHfAVCCPgCzijCIqXtdF+/tGsWreR5vYSt2FrLEx/T4N8v5kyEWwWHKeM5pM4HaN76Aa5q
        O5ne/mmvG758JtVywtG7nSy7rvaPwObuYMDua6P6Vose1sZ5iJgzbf3T+D/RYdkZayPdk7
        jdfNxXgA7gt4OVKqcFS1EIfQsogQ3hI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-jnis3yeEMnKNz3zlw_stwg-1; Tue, 27 Oct 2020 15:34:02 -0400
X-MC-Unique: jnis3yeEMnKNz3zlw_stwg-1
Received: by mail-oo1-f71.google.com with SMTP id v18so1242433oou.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J4k50Yu7bOoV/ZgIg7/uNXPd/NZkISAhyo8g0Xv0iog=;
        b=rSRh624xvv/YE5Q91oG0fsuQrXcsi6EgyUw6LLUVoMhm//5m3x5VoX973+BCOAajnr
         ZGaasAJBjAA2ymexRljOQ0gTgeeeaPibIsS+C6Tn+/m473Bw1W3uywzmH497IQsUroo6
         gWX+bnNrLortZlKKxWfIbE2kH6jSpEFXJ5jPq5wtfRhK//5A7/2zq1ik1kyNg0SwgK2u
         j+O6/YGZyQ3YfPOhEv9E8tZAj7ex2b+HOAMj7WGJxvIpAWbR8yTeh8SmcQMpSbbCy+jD
         pD/R3uuLZ8BXPH+4MhHZLhSTKSAX+nM+hWG26/uIFpnWQZUwjm+cICOYsGHioDOUJPSL
         /scg==
X-Gm-Message-State: AOAM531EHZCgBZU4xj+NyLfQaKhlrDcP2B2KKhhAABcyScwdorRQ07ME
        1rU4uhXuenyEJFDf/W3GVuDo9JopzzY2IQs1oQqpwO11yt9vDuq5hRbgmxJ1x5qlyFfefuCLYqd
        e7vPzIZ8cHNMQKjkOPn+GAi0B
X-Received: by 2002:a9d:a0d:: with SMTP id 13mr2459888otg.348.1603827241680;
        Tue, 27 Oct 2020 12:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/CVz4QW3xBtwsuz3hvNgp/jcHMdkWjdUbFaTV3XYJJZl+DTuGslKqVVp3boNyN9e5AmQ+rw==
X-Received: by 2002:a9d:a0d:: with SMTP id 13mr2459868otg.348.1603827241311;
        Tue, 27 Oct 2020 12:34:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 105sm1398629otf.52.2020.10.27.12.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:34:00 -0700 (PDT)
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Joe Perches <joe@perches.com>,
        Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
References: <20201027164255.1573301-1-trix@redhat.com>
 <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
Date:   Tue, 27 Oct 2020 12:33:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/20 11:42 AM, Nick Desaulniers wrote:
> (cutting down the CC list to something more intimate)
>
> Tom, I'm over the moon to see clang-tidy being used this way.  I
> totally forgot it could automatically apply fixits.  I'm glad Nathan
> and Masahiro were able to get the foundation laid for running
> clang-tidy on the kernel this summer.
>
> On Tue, Oct 27, 2020 at 9:43 AM <trix@redhat.com> wrote:
>> This rfc will describe
>> An upcoming treewide cleanup.
>> How clang tooling was used to programatically do the clean up.
>> Solicit opinions on how to generally use clang tooling.
>>
>> The clang warning -Wextra-semi-stmt produces about 10k warnings.
>> Reviewing these, a subset of semicolon after a switch looks safe to
>> fix all the time.  An example problem
>>
>> void foo(int a) {
>>      switch(a) {
>>                case 1:
>>                ...
>>      }; <--- extra semicolon
>> }
>>
>> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
>> These fixes will be the upcoming cleanup.
>>
>> clang already supports fixing this problem. Add to your command line
>>
>>   clang -c -Wextra-semi-stmt -Xclang -fixit foo.c
>>
>>   foo.c:8:3: warning: empty expression statement has no effect;
>>     remove unnecessary ';' to silence this warning [-Wextra-semi-stmt]
>>         };
>>          ^
>>   foo.c:8:3: note: FIX-IT applied suggested code changes
>>   1 warning generated.
> Ah, doesn't that rely on clang-tidy to apply the fixit?  (oh, what,
> maybe not: https://stackoverflow.com/a/49749277)
>
> And doesn't that require your patch to clang-tidy to land?
> https://reviews.llvm.org/D90180
>
> Now I'm confused; if clang can apply the fixit for warnings, why do we
> need another patch to clang-tidy?

No, this shows where the fixer is upstream.

I am in the process of pushing out the patches.

Long term the clang-tidy part of the build will change once it lands.

globbing the checker to -checker=-*,linuxkernel* would be easiest on the kernel

but that may not be where the checker lands.

>> The big problem is using this treewide is it will fix all 10k problems.
>> 10k changes to analyze and upstream is not practical.
>>
>> Another problem is the generic fixer only removes the semicolon.
>> So empty lines with some tabs need to be manually cleaned.
>>
>> What is needed is a more precise fixer.
>>
>> Enter clang-tidy.
>> https://clang.llvm.org/extra/clang-tidy/
>>
>> Already part of the static checker infrastructure, invoke on the clang
>> build with
>>   make clang-tidy
>>
>> It is only a matter of coding up a specific checker for the cleanup.
>> Upstream this is review is happening here
>> https://reviews.llvm.org/D90180
> Sorry, I still don't understand how the clang-tidy checker wont also
> produce 10k fixes?

I am interested in treewide fixes.

Cleaning them up (maybe me not doing all the patches) and keeping them clean.

The clang -Wextra-semi-stmt -fixit will fix all 10,000 problems

This clang tidy fixer will fix only the 100 problems that are 'switch() {};'

When doing a treewide cleanup, batching a bunch of fixes that are the same problem and fix

is much easier on everyone to review and more likely to be accepted.


Long term, a c/i system would keep the tree clean by running the switch-semi checker/fixer.

And we can all move onto the next problem.

>
>> The development of a checker/fixer is
>> Start with a reproducer
>>
>> void foo (int a) {
>>   switch (a) {};
>> }
>>
>> Generate the abstract syntax tree (AST)
>>
>>   clang -Xclang -ast-dump foo.c
>>
>> `-FunctionDecl
>>   |-ParmVarDecl
>>   `-CompoundStmt
>>     |-SwitchStmt
>>     | |-ImplicitCastExpr
>>     | | `-DeclRefExpr
>>     | `-CompoundStmt
>>     `-NullStmt
>>
>> Write a matcher to get you most of the way
>>
>> void SwitchSemiCheck::registerMatchers(MatchFinder *Finder) {
>>   Finder->addMatcher(
>>       compoundStmt(has(switchStmt().bind("switch"))).bind("comp"), this);
>> }
>>
>> The 'bind' method is important, it allows a string to be associated
>> with a node in the AST.  In this case these are
>>
>> `-FunctionDecl
>>   |-ParmVarDecl
>>   `-CompoundStmt <-------- comp
>>     |-SwitchStmt <-------- switch
>>     | |-ImplicitCastExpr
>>     | | `-DeclRefExpr
>>     | `-CompoundStmt
>>     `-NullStmt
>>
>> When a match is made the 'check' method will be called.
>>
>>   void SwitchSemiCheck::check(const MatchFinder::MatchResult &Result) {
>>     auto *C = Result.Nodes.getNodeAs<CompoundStmt>("comp");
>>     auto *S = Result.Nodes.getNodeAs<SwitchStmt>("switch");
>>
>> This is where the string in the bind calls are changed to nodes
>>
>> `-FunctionDecl
>>   |-ParmVarDecl
>>   `-CompoundStmt <-------- comp, C
>>     |-SwitchStmt <-------- switch, S
>>     | |-ImplicitCastExpr
>>     | | `-DeclRefExpr
>>     | `-CompoundStmt
>>     `-NullStmt <---------- looking for N
>>
>> And then more logic to find the NullStmt
>>
>>   auto Current = C->body_begin();
>>   auto Next = Current;
>>   Next++;
>>   while (Next != C->body_end()) {
>>     if (*Current == S) {
>>       if (const auto *N = dyn_cast<NullStmt>(*Next)) {
>>
>> When it is found, a warning is printed and a FixItHint is proposed.
>>
>>   auto H = FixItHint::CreateReplacement(
>>     SourceRange(S->getBody()->getEndLoc(), N->getSemiLoc()), "}");
>>   diag(N->getSemiLoc(), "unneeded semicolon") << H;
>>
>> This fixit replaces from the end of switch to the semicolon with a
>> '}'.  Because the end of the switch is '}' this has the effect of
>> removing all the whitespace as well as the semicolon.
>>
>> Because of the checker's placement in clang-tidy existing linuxkernel
>> checkers, all that was needed to fix the tree was to add a '-fix'to the
>> build's clang-tidy call.
> I wonder if there's a way to differentiate existing checks we'd prefer
> to run continuously vs newer noisier ones?  Drowning in a sea of 10k
> -Wextra-semi-stmt doesn't sound like fun.  Maybe a new target for make
> to differentiate reporting vs auto fixing?
>
>> I am looking for opinions on what we want to do specifically with
>> cleanups and generally about other source-to-source programmatic
>> changes to the code base.
>>
>> For cleanups, I think we need a new toplevel target
>>
>> clang-tidy-fix
> ah, yep, I agree.  Though I'm curious now that I know that clang can
> be used as the driver to apply fixits rather than clang-tidy, how else
> we can leverage clang over manually writing clang-tidy checks.  Unless
> I have something confused there?

Nope.

IMO clang fixits are too coarse and will never work treewide.

Comparing my recent treewide fixing of unneeded breaks and semi's, I would much rather write a tool

than manually look at or fix anything treewide.

Tom

>
>> And an explicit list of fixers that have a very high (100%?) fix rate.
>>
>> Ideally a bot should make the changes, but a bot could also nag folks.
>> Is there interest in a bot making the changes? Does one already exist?
> Most recently Joe sent a treewide fix for section attributes that
> Linux pulled just after the merge window closed, IIUC.  Maybe that
> would be the best time, since automation makes it trivial for anyone
> to run the treewide fixit whenever.
>
>> The general source-to-source is a bit blue sky.  Ex/ could automagicly
>> refactor api, outline similar cut-n-pasted functions etc. Anything on
>> someone's wishlist you want to try out ?
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>>
>> --

