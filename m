Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0942DE76A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgLRQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgLRQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:25:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1553C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:24:06 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d20so2420420otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqQbpFMD6dkYLibiVClg3d7g7y7tRyurb1/VW+ic+G0=;
        b=MhcTzhtSsPXPCXJbfWKHsmWz86Veki87y6eADP+xTqJnN5ZPTGjxAb4fDGzbH4YBLt
         WjUjiYEfSKD7mmKYTplE11kGtdoITHmq58NPUS4k5ZNNp3GzDUpJfij4bNl6906lglYy
         wUVxADPIm1LYqZIpXEf+CWX27BGN6+uVe+kpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqQbpFMD6dkYLibiVClg3d7g7y7tRyurb1/VW+ic+G0=;
        b=oJqAkb3Z4BarzCHVeuVGk7DldM2n/lyhGldcLfR5Ihzj+ttNv6cs1EmG81IuG/73hO
         AWGJLmgllNR7BCyw5mSbwKzroCz8kSj0sBQlMuHOWbZNdpHi1bWKibznLB6HV9TQaps3
         wn8KNGioCbKcJQrNiNPgbla1WqV9BVyv3qByM4xNyYuk1rxE0HFrMzC7Mm8gUmBNoPy3
         3kdjSWEPGpmDQALs3Zw0uiS6LoX5nqYJh3qpmaSYYdhcGAbjmkF+V2BbQYUqEAEVZtor
         TvBX02xYDz8hob62ZK+bysmucOO+kAR7nLoKj+x9lMiYL8dYUiefRMLRK/Rbo1N3zNQ6
         FFQg==
X-Gm-Message-State: AOAM532dya794513gC+R/7/S2zSuL1fMXtV+CMNBDQhupRBMBjdsAoQn
        2EgjtL7uV99K+N4FmKJoGXuXP3AYk4Mzbxgm4/xODA==
X-Google-Smtp-Source: ABdhPJwcCzLk4SZo7l5u4xEQ9jFcCgTViVhvgvQnWJwu13ClsiUz4ogGyWTFmuZasY2Lmv3ZnmkKKq/LXncK/+CK+t0=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr3434686otb.281.1608308646236;
 Fri, 18 Dec 2020 08:24:06 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cb6db205b68a971c@google.com> <CAKMK7uEiS5SrBYv-2w2wWL=9G4ByoHvtiWVsPqekswZzOGmzjg@mail.gmail.com>
 <20201216161621.GH2657@paulmck-ThinkPad-P72> <CAKMK7uH1agVS=e245b=25Lv9Q+u5c7=KL-_NF8Hte10nKTqAXw@mail.gmail.com>
 <20201218111031.226f8b59@gandalf.local.home>
In-Reply-To: <20201218111031.226f8b59@gandalf.local.home>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 18 Dec 2020 17:23:55 +0100
Message-ID: <CAKMK7uEOojWe=KEAkdor4fqWh8=Q6wZTYRNBPWaACaen-iyi0Q@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in modeset_lock
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+972b924c988834e868b2@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 5:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 17 Dec 2020 11:03:20 +0100
> Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> > I think we're tripping over the might_sleep() all the mutexes have,
> > and that's not as good as yours, but good enough to catch a missing
> > rcu_read_unlock(). That's kinda why I'm baffled, since like almost
> > every 2nd function in the backtrace grabbed a mutex and it was all
> > fine until the very last.
> >
> > I think it would be really nice if the rcu checks could retain (in
> > debugging only) the backtrace of the outermost rcu_read_lock, so we
> > could print that when something goes wrong in cases where it's leaked.
> > For normal locks lockdep does that already (well not full backtrace I
> > think, just the function that acquired the lock, but that's often
> > enough). I guess that doesn't exist yet?
> >
> > Also yes without reproducer this is kinda tough nut to crack.
>
> I'm looking at drm_client_modeset_commit_atomic(), where it triggered after
> the "retry:" label, which to get to, does a bit of goto spaghetti, with
> a -EDEADLK detected and a goto backoff, which calls goto retry, and then
> the next mutex taken is the one that triggers the bug.

This is standard drm locking spaghetti using ww_mutexes. Enable
CONFIG_DEBUG_WW_MUTEX_SLOWPATH and you'll hit this all the time, in
all kinds of situations. We're using this all the time because it's
way too easy to to get the error cases wrong.

> As this is hard to reproduce, but reproducible by a fuzzer, I'm guessing
> there's some error return path somewhere in there that doesn't release an
> rcu_read_lock().

We're maybe a bit too happy to use funny locking schemes like
ww_mutex, but at least to my knowledge there's no rcu anywhere near
these. Or preempt disable fwiw (which I think the consensus is the
more likely culprit). So I have no idea how this leaks.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
