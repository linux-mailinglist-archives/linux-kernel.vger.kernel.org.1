Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70F29564A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894921AbgJVCM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:12:57 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44524 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894914AbgJVCM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:12:57 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09M2CPsC000915;
        Thu, 22 Oct 2020 04:12:25 +0200
Date:   Thu, 22 Oct 2020 04:12:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Plumb <lkml.mplumb@gmail.com>,
        Amit Klein <aksecurity@gmail.com>,
        George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
Message-ID: <20201022021225.GA911@1wt.eu>
References: <20201012203226.GA11861@1wt.eu>
 <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
 <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
 <20201021032725.GB396@1wt.eu>
 <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
 <432132f9c678dc5093fd85055e5b708584018a0d.camel@perches.com>
 <CAHk-=wi9Oe=NCG_S1X-rSFwkWe=vK7GYUHp22PFWa2W47WnzKA@mail.gmail.com>
 <12bc8364008f797324097fb1974da1c0f75776b0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12bc8364008f797324097fb1974da1c0f75776b0.camel@perches.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:41:06PM -0700, Joe Perches wrote:
> On Wed, 2020-10-21 at 14:35 -0700, Linus Torvalds wrote:
> > On Wed, Oct 21, 2020 at 2:20 PM Joe Perches <joe@perches.com> wrote:
> > > While secure solutions are useful, I really wonder if
> > > "George Spelvin" is a real person.
> > 
> > It's not his real name, no, but he's a real person.
> > 
> > I do have his real name from years ago when I needed to confirm his
> > identity for sign-offs (I forget what for, I think it was some dcache
> > name hashing thing).
> > 
> > So I can confirm he's a real person who just wants to keep private,
> > and is competent when it comes to hashing and security.
> 
> I hope that real name is in some escrow somewhere and
> not just in some long thrown away spinning rust disk.
> 
> And because George isn't a real name and contributions
> by him have been accepted, the DCO should be updated
> to show how pseudonymous contributions can be made.

Well, if that helps, given that I already needed to modify his code
and that his proposal totally makes sense, I can also replace his
signed-off-by with a suggested-by in the patch and put a link to the
original thread.

I'll do my best to propose an update before -rc1 if that's still
acceptable. Amit found that the code doesn't build when tests are
enabled, visibly they were not on my side and likely explain why
that failed for Linus.

Willy
