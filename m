Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC629CA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373336AbgJ0UvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:51:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34819 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373317AbgJ0UvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:51:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1so1407129ple.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHNOVc4DdavJvtU3kYnOGO87AVK1l/GKrv9DB/l735I=;
        b=pCCE0K0+AsssSdpqoKaF8gYI5U+5nd65fizOd9gu0r3hbmqdHEe4eJj8kLFaU4cXZs
         Qxd5y2fd4uklQ8vZ3tsKiF6a0fGWLkjbzro22c2GkE7QQNHOyePNLzKjZZjG7BIyexs6
         D/y9JmTNjSkeMLgUQRlWQWxPeCYUm+2wxx2Gn8vw/f0HS8y/w/u6a/pyS/f3qiGxaO3I
         M33Kwtf1WnHUAVfXWMIEDh91nS96XVhxnxiBAzupJ1HYeWc36P4z7fMukaGuPA0tj/vR
         4ShaX6P+8XeyBd4GArKFGjfIqwtvqEIN62aRxxumFqwjiXSNNHGKAUuz95fW4TxfOhEJ
         CWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHNOVc4DdavJvtU3kYnOGO87AVK1l/GKrv9DB/l735I=;
        b=kMLKB8Lp9h2StLE4En66jVBT6ag70trU7vNFc86OXhEAajnYe7Xvm0CaUKdyqprWLv
         1HnqBnd3fH3D01SRcn9DnRgrqOdLs1nEa/VDAghUrMo9/QS5DUyLYJP914Ezh0nimj1E
         HZmkqEAvdIhuTQHxbqu5GoMA0Wj64mFmpZLknxpK2TuxOicutomaOAl8IydBoCI5VJE9
         eKYUC9mhRH5z1C7gmtmx5RbjopOJAS9gYdww1yw3Fp282DzYGITt+zfY5XfmVVy5dsJM
         TQOFqoZc/IvWlEfs0IFldMfB3vXc4agpSLqmWMF57Cf1ImVnzPxbryGC5pOKU2Zm/gf5
         ngaA==
X-Gm-Message-State: AOAM532nIqdzzEzwMb2mrBcYFp6EAvJjVzjc6tdY2Jy6qMaMtchDTcOp
        Z+Ybc0ztsFiwD/wvDCiXlinedBOAxgCeTzgiHN0hpsU5kjTQ5g==
X-Google-Smtp-Source: ABdhPJwYgtc739QT+unvNHIo2b5YOB7guKQq6IlLg4Mha24w+3ypuJgVwic+jXZrLM62rFnYMecjpmK3t6Ny/NLZrHo=
X-Received: by 2002:a17:90a:740a:: with SMTP id a10mr3680150pjg.32.1603831864267;
 Tue, 27 Oct 2020 13:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201027164255.1573301-1-trix@redhat.com> <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
 <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com> <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
In-Reply-To: <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 13:50:53 -0700
Message-ID: <CAKwvOd=NiUEv51BCXVUDERwbs9qCX1SbMarrof5H0RoCdxP0NA@mail.gmail.com>
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Joe Perches <joe@perches.com>
Cc:     Tom Rix <trix@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:52 PM Joe Perches <joe@perches.com> wrote:
>
> (Adding Stephen Rothwell)
>
> On Tue, 2020-10-27 at 12:33 -0700, Tom Rix wrote:
> > On 10/27/20 11:42 AM, Nick Desaulniers wrote:
> > > (cutting down the CC list to something more intimate)
>
> []
>
> > I am interested in treewide fixes.
>
> As am I, but here the definition of fixes is undefined though.
> Whitespace / style changes and other bits that don't change generated
> object code aren't considered fixes by many maintainers.
>
> > Cleaning them up (maybe me not doing all the patches) and keeping them clean.
> >
> > The clang -Wextra-semi-stmt -fixit will fix all 10,000 problems
>
> I rather doubt there are 10K extra semicolons in the kernel source tree.
> Is there a proposed diff/patch posted somewhere?

Ah, I think I see where I (and Joe) may be misinterpreting.  Tom, do
you mean to say that `clang -fixit` will attempt to fix EVERY warning
in tree (including but regardless of -Wextra-semi-stmt, where
-Wextra-semi-stmt is a red herring), so the clang-tidy check is
specific to applying fixits just for -Wextra-semi-stmt?  (If so, I
wonder if we could improve clang to accept more fine grain control
over *which* fixits we want applied.  Not at all of them for all of
the different distinct warnings, for example).

>
> > This clang tidy fixer will fix only the 100 problems that are 'switch() {};'
> >
> > When doing a treewide cleanup, batching a bunch of fixes that are the same problem and fix
> > is much easier on everyone to review and more likely to be accepted.
>
> That depends on the definition of batching.
>
> If individual patches are sent to multiple maintainers, the
> acceptance / apply rate seems always < 50% and some are rejected
> outright by various maintainers as "unnecessary churn".
>
> Single treewide patches are generally not applied unless by Linus.
> The trivial tree isn't widely used for this.
>
> Perhaps a 'scripted' git tree could be established that is integrated
> into -next that would allow these automated patches to be better
> vetted and increase the acceptance rate of these automated patches.
>
> > Long term, a c/i system would keep the tree clean by running the switch-semi checker/fixer.
> > And we can all move onto the next problem.
>
> Good idea...
> I hope a scripted patches mechanism will be established.

Yes, if I can automate myself out of job, then I can hang out of the
roof and drink margaritas all day.  That is the plan of record, but
this !##$'ing compiler is constantly broken!!!!1

-- 
Thanks,
~Nick Desaulniers
