Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581A2982F8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416880AbgJYRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416754AbgJYRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:54:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013BC061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 10:54:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a4so7289168lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ggYmrSHY803yXkxxFpr8c9ktR4N+VPXPUnvy1vJqsI=;
        b=Bl0echuUtFDLnzPfg4i5SkRU1dPT0elshJP0RN/DyWfiqQZ+UN+tXJAnCXe7RU48b2
         9fsgwl7hSA/chuzxcXlwgVR9Xyox7VfjXV05FDGgWS8yDbYTYK3i3FPKYUT7opuImSOD
         3fTRb/iGMyWIEKlEaff9D3/wUexS99Ik09pBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ggYmrSHY803yXkxxFpr8c9ktR4N+VPXPUnvy1vJqsI=;
        b=Yc7qEN1TwBveTk60TOzv2yEuAQVzNRJuH6cvOh2SGDdKgrOnJ4d3d9RvXj30Et4AKj
         dw3QbKLHGkaMKfOnmpEC8xXbj+KTcUp5rXLBVlx+8cM0dd2aUz9NQvmeUflm+mRvcPAA
         /+LPo1Bdb1zUvUWAxkArsmOMmOd/Ep8Dj6W2gHFNfRTtSINaLjzdDQ+3wzzc0rRFncMT
         2G9/gpMuJdjdAkPkwwAvEQSD/dxZQ8WJgVkwSh12Bdl0T86+WRc4C7uheg3MqwpicIC6
         nF/L4W3SA5YCdyFHGkjvCoWgLh0dlbt5eqHtcanGFipkfuGQ7pHFmVI/eFPul+1HHXjw
         2NtQ==
X-Gm-Message-State: AOAM533V7ucrLYxo1mBlwTUuudFtZyeFUFPb7srsotB6zTnWxPxjNpCo
        7rKmXX/d45RS18SRyNwXCldA8Gez4LJXQA==
X-Google-Smtp-Source: ABdhPJy9AhNXJY215SxpaQOi5vlYKApdl4p7Vc3eEZHP3yeR72xhprShNh/p/xRskQkJG66fEW0FNw==
X-Received: by 2002:a2e:8194:: with SMTP id e20mr4460429ljg.405.1603648489446;
        Sun, 25 Oct 2020 10:54:49 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j83sm320495lfj.221.2020.10.25.10.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 10:54:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v6so8907745lfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 10:54:47 -0700 (PDT)
X-Received: by 2002:a19:9142:: with SMTP id y2mr3431981lfj.352.1603648486915;
 Sun, 25 Oct 2020 10:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
 <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
 <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com> <CAJ-EccMu_AGfOYASyteGosdOc1SMHeVTLax5aoZSQf7_n0Xq2Q@mail.gmail.com>
In-Reply-To: <CAJ-EccMu_AGfOYASyteGosdOc1SMHeVTLax5aoZSQf7_n0Xq2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Oct 2020 10:54:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAYrg_N9ZZ38C5YqPQT4eyCj8JoJ4oax479DpOkdH07w@mail.gmail.com>
Message-ID: <CAHk-=whAYrg_N9ZZ38C5YqPQT4eyCj8JoJ4oax479DpOkdH07w@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:15 PM Micah Morton <mortonm@chromium.org> wrote:
>
> Ok so before the rebase ("reparent"), the commits were based on top of
> some commit that was months old at this point (can't quite remember
> now, I think one of the -rc's for v5.8).

Nobody cares if the old parent is old. In fact, that's usually a good
sign that the code has had testing and is changing things that aren't
in flux for other reasons.

It's often a good idea to make a test-merge and verify that things are
ok, but that's for your _personal_ verification, and shouldn't be
something that anybody else sees.

And even with a test-merge, it doesn't matter if there is some simple
conflict - we have those all the time, and conflicts aren't bad. In
fact, they allow me to see "ok, things have changed here in parallel",
and I'll be aware of it.

The main reason to rebase is if things have changed _so_ much that you
really need to re-do things, or if there is some major bug in _your_
branch that simply needs to be fixed.

>    So I had basically considered it
> a no-op rebase. I probably should have explained this in the pull
> request.

If it's a no-op rebase, thern DON'T DO IT. Really. It just means that
now you have lost all the testing.

Thinking that it's a no-op doesn't really help. No bugs are
_intentional_, I would seriously hope. Lack of testing is lack of
testing, regardless of whether you think it would not matter.

It also destroys the real history of the code, which is sad.

Now, sometimes you may _want_ to destroy the real history of the code
(as in "Oh, this history is too ugly to survive, and makes bisection
impossible because some of the intermediate state was seriously
buggy"). That is then one of those few valid reasons to rebase (see
the "major bug in your branch" case above).

But 99% of the time, rebasing is bad. If it was in linux-next and
there were no horrible problems with it, and it got tested there, then
just leave it alone and don't destroy the testing it did get.

Anyway, I've pulled this now, but honestly, don't do this again. Stop
rebasing without a big and immediate reason, and stop destroying
whatever testing it got in linux-next.

And if you _do_ rebase, and you _do_ have a real and very serious
reason, then mention that reason and explain it. But no "the rebase
didn't make any difference" isn't a reason. Quite the reverse.

               Linus

                   Linus
