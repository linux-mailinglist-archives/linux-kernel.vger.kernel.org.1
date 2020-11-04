Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3542A5B85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgKDBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgKDBIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:08:22 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD21AC040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:08:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y14so15870602pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 17:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgDpLMdL0ctn8FkV6OAwyNPpcX4s32XQCwmQR7ICMB0=;
        b=lvA7m4DDUgfjoovfzncxNedjERH1n9fecUi1FvRvrQGPGyN0Y8X/eBJ0gVk0Wkgwyr
         i47GIA7hY7S2am3aVp5i6BEnRz0inMhyCV7X4fb0LBhbjKEcZDp5cyQJ+7zQ+QXHaMMF
         3BH1xIi0Ip35KcUHrSMK8JBTWg5SVeSYt+ePWohv48OCwe+64IZz2GCwZxO5w+xQzFte
         FdB/V2i12zPmW7ubs6yJfcWfGJ+VSSLVPcAdpmyniInLIieaeo+fmZXM72KFFe00qfd7
         9qTcRmCzCgWIq3fnQOAW4tIsNo+pG4WmAK0cO1d+XMtUE7zE6ca6FPqmhQ508N5jr6q5
         X4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgDpLMdL0ctn8FkV6OAwyNPpcX4s32XQCwmQR7ICMB0=;
        b=oB0Wpv1CVYSS9wu76QwlOI72K7IQFypZBpy922TZ4aTEIF3//z9lZ779hZ3EUqLMwl
         tu8pVv5Z5UHs5T5aWDa4lxZyHyXIUK0tlkF3ObIbfGJKCwV7Y+8fnHk+fsCnew7AohQC
         c+EEwjDzzu/CFdW5UyfzetmyVrOn70W23E30+nrO/Li+rYUV6QjPIT7oiYNff9je6FzN
         GKwu9Tfy+/z8/2ttmIjU/d6c8OuR+14x4/0uML+pXk92CLZyBfK8NG4Z2T7clOUC4WkC
         UygjDWmc2Mj86j/tdQA9+3epfXb+3bAYwnt7dtFoUJIBQPs8JiQvIVOpR1+0aI743SdP
         M4dA==
X-Gm-Message-State: AOAM532dpwzb06rBhGjdxNS36Atx858mRCikCTwt4rDX4CJxgSx0mlIQ
        rPhwxp8Rmxp3qs6NU/YaAn5otPNprpKvHvPD2hLYOz9oaaI=
X-Google-Smtp-Source: ABdhPJzm5Kacl/j56hBCyyGxtmrwdzn34UZh4TKQKnq3qdy/1g/TLal5FN2oEsgWVik2BdyNDVl3pzb7cy/hkaYmQrk=
X-Received: by 2002:a62:5e06:0:b029:164:a9ca:b07e with SMTP id
 s6-20020a625e060000b0290164a9cab07emr27533012pfb.36.1604452101924; Tue, 03
 Nov 2020 17:08:21 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com> <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
In-Reply-To: <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Nov 2020 17:08:10 -0800
Message-ID: <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 1:33 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Joe,
>
> On Tue, Nov 3, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
> >
> > Now that the clang minimum supported version is > 10.0, enable the
> > commented out conditional reformatting key:value lines in the file.
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >
> > Hey Miguel.
> >
> > I don't use this, but on its face it seems a reasonable change
> > if the commented out key:value lines are correct.

Joe,
what would it take to get you to use clang-format, or at least try it?
 Beers?  Bribes? Dirty deeds, done dirt cheap?

> It is, yeah; however, the concern is that there may be developers
> running an old clang-format from their distro (i.e. not using it for
> compiling the kernel). We need to compare the functionality advantage
> vs. the inconvenience of installing a current LLVM. The best would be
> to ask whoever is using it right now, but there is no easy way to do
> that -- many will only notice when the change is actually pushed :-)
>
> So far, I have avoided upgrading the requirement until clang-format
> could match the kernel style even better (i.e. so that when the
> upgrade happens, there is a reason for it). Also, the configuration
> can be overridden in subfolders, thus a maintainer can push things
> forward in a subsystem meanwhile.

Miguel,
Really? :P I'd bet if you picked up this patch no one would notice.

I recommend a simpler approach to multiple version support, which is
just matching the one version recommended for the rest of LLVM tools.
Sure, technically you can use older tools, but do so at your own peril
and don't complain to us if it doesn't work.  Otherwise trying to
explain different versions and even for different directories gets way
too complex for anyone to take seriously.  It's not like we backport
raising the minimum version.

I was very much in denial of committing to a relatively high minimum
version of LLVM myself, until Linus recommended the simpler approach
which folks voted in favor of at Plumbers.  Maybe not a perfect
analogy though.
-- 
Thanks,
~Nick Desaulniers
