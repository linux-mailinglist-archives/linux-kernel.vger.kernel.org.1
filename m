Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241FB2946F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411763AbgJUD2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:28:21 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44132 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411752AbgJUD2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:28:20 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09L3RPu1000409;
        Wed, 21 Oct 2020 05:27:25 +0200
Date:   Wed, 21 Oct 2020 05:27:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amit Klein <aksecurity@gmail.com>, George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
Message-ID: <20201021032725.GB396@1wt.eu>
References: <20201012203226.GA11861@1wt.eu>
 <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
 <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Oct 20, 2020 at 04:08:03PM -0700, Linus Torvalds wrote:
> On Tue, Oct 20, 2020 at 12:26 PM Amit Klein <aksecurity@gmail.com> wrote:
> >
> > Quick question: is this patch still planned for inclusion in 5.10-rc1?
> 
> It doesn't even build for me, so no. It clearly hasn't been in
> linux-next or anything like that.
> 
> Hint: grep for prandom_seed_early.

I'm a bit surprised, as it worked for me, but thanks for checking. Given
the lack of responses from many participants on these patches, on several
occations I feel that this series is really not welcome. Initially I just
tried to test and fix Spelvin's patch, but if there's not that much
interest in it, or even reluctance, I'd rather stop. If it's just that
the current state is ugly with the two PRNGs side by side, I can get
back to completely removing the original one as I did in my first series,
and propose a larger series. Or if nobody's interested, I'd rather know
so that I don't have to put more time on it :-/

Thanks for letting me know,
Willy
