Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F929BB85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbgJ0QQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:16:37 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:35067 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1807781AbgJ0QO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:14:57 -0400
Received: by mail-ej1-f42.google.com with SMTP id p5so3071277ejj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTfr4BhZoASi4sNuvBGDS4PrD9yz2mHwzFOcyGNrbuE=;
        b=CG6KmF8iWDTGQPhNlTROZ67H7mOeNO9xa2NDY20tknx8+WkX3f40qB/TVD4dHr+N/e
         Ly4lmr/7Ae7D56Y2xJFHrYG7iDZOI1kYAfUV+v3OuImVgmwIqQCFBNNDBlEMDK5MJIIi
         kIz1/bnZuCukWcs/wXSvjMbm+1+GsFn7Upc6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTfr4BhZoASi4sNuvBGDS4PrD9yz2mHwzFOcyGNrbuE=;
        b=cka4KTK6GGmqavkG1ReTm8x7+a4t3rMHcO6n9fZ1aA6EOdg/uS24WNRD8GQdUdxNkg
         Uvl+H/IMA0RM6zO6oLQUDJ62w19J5cTpa8kcPdBv9rWiTd9TwNrpqJI1OfzUi+UcSk9f
         QPAUbl/CsHYf2L9v4evWNXorFmKaxzlvp2UbjXjK91DUSR1p7Q3QVsKJYmRnBDzcn3K/
         K6R4o9AixHywiwfaSXFZCzFr4HMdzYWfDcJFyee8YahoROvsMCByRViwUDSChj7Z4kvH
         f5FGg1xJjlnNaZIOvxYAYj0l8K7aHgR8pJtzfYEBr7xvRGia6v4tHFsbpES/DXtFOKSs
         anGw==
X-Gm-Message-State: AOAM5339fNZAfyr2giB7mDH0pqCOtpG7yMs7aAS42eJFqsvTIi+T9crF
        g2IOzXU4LOLXVQQl69l91cDsYOq+xhKWV8S9zSgKMw==
X-Google-Smtp-Source: ABdhPJy1n+rUcW/DZIrMzAV4nH1DTEy7MZBCwEnBb5Oro1VrPGV3aFVbV7o8DWIx2T9BNdEbsTohlemZm+AOmrgj7eg=
X-Received: by 2002:a17:906:3541:: with SMTP id s1mr3246257eja.413.1603815294129;
 Tue, 27 Oct 2020 09:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
 <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
 <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
 <CAJ-EccMu_AGfOYASyteGosdOc1SMHeVTLax5aoZSQf7_n0Xq2Q@mail.gmail.com> <CAHk-=whAYrg_N9ZZ38C5YqPQT4eyCj8JoJ4oax479DpOkdH07w@mail.gmail.com>
In-Reply-To: <CAHk-=whAYrg_N9ZZ38C5YqPQT4eyCj8JoJ4oax479DpOkdH07w@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 27 Oct 2020 09:14:41 -0700
Message-ID: <CAJ-EccMyjD+DudaanLwQErKRwkA_h12ZMDL-5R3JMADaYK4+rg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 10:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 23, 2020 at 12:15 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > Ok so before the rebase ("reparent"), the commits were based on top of
> > some commit that was months old at this point (can't quite remember
> > now, I think one of the -rc's for v5.8).
>
> Nobody cares if the old parent is old. In fact, that's usually a good
> sign that the code has had testing and is changing things that aren't
> in flux for other reasons.

Ok thanks for the explanation, I think this was the most important
piece I was missing, but makes sense now.

>
> It's often a good idea to make a test-merge and verify that things are
> ok, but that's for your _personal_ verification, and shouldn't be
> something that anybody else sees.
>
> And even with a test-merge, it doesn't matter if there is some simple
> conflict - we have those all the time, and conflicts aren't bad. In
> fact, they allow me to see "ok, things have changed here in parallel",
> and I'll be aware of it.
>
> The main reason to rebase is if things have changed _so_ much that you
> really need to re-do things, or if there is some major bug in _your_
> branch that simply needs to be fixed.

Yeah sounds good, I'll just get in the habit of doing a test merge and
note in the pull request whether there are any conflicts or not.

>
> >    So I had basically considered it
> > a no-op rebase. I probably should have explained this in the pull
> > request.
>
> If it's a no-op rebase, thern DON'T DO IT. Really. It just means that
> now you have lost all the testing.
>
> Thinking that it's a no-op doesn't really help. No bugs are
> _intentional_, I would seriously hope. Lack of testing is lack of
> testing, regardless of whether you think it would not matter.
>
> It also destroys the real history of the code, which is sad.
>
> Now, sometimes you may _want_ to destroy the real history of the code
> (as in "Oh, this history is too ugly to survive, and makes bisection
> impossible because some of the intermediate state was seriously
> buggy"). That is then one of those few valid reasons to rebase (see
> the "major bug in your branch" case above).
>
> But 99% of the time, rebasing is bad. If it was in linux-next and
> there were no horrible problems with it, and it got tested there, then
> just leave it alone and don't destroy the testing it did get.
>
> Anyway, I've pulled this now, but honestly, don't do this again. Stop
> rebasing without a big and immediate reason, and stop destroying
> whatever testing it got in linux-next.

Got it.

>
> And if you _do_ rebase, and you _do_ have a real and very serious
> reason, then mention that reason and explain it. But no "the rebase
> didn't make any difference" isn't a reason. Quite the reverse.
>
>                Linus
>
>                    Linus
