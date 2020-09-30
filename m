Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610A427F437
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgI3V3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:29:43 -0400
Received: from [157.25.102.26] ([157.25.102.26]:35754 "EHLO orcam.me.uk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgI3V3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:29:43 -0400
Received: from bugs.linux-mips.org (eddie.linux-mips.org [IPv6:2a01:4f8:201:92aa::3])
        by orcam.me.uk (Postfix) with ESMTPS id ED5F42BE086;
        Wed, 30 Sep 2020 22:29:39 +0100 (BST)
Date:   Wed, 30 Sep 2020 22:29:36 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
In-Reply-To: <20200918102750.GA27828@angband.pl>
Message-ID: <alpine.LFD.2.21.2009302216230.333514@eddie.linux-mips.org>
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org> <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org> <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com> <20200916205434.GA10389@duo.ucw.cz>
 <20200918102750.GA27828@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020, Adam Borowski wrote:

> > > Note that scrollback hasn't actually gone away entirely - the original
> > > scrollback supported by _hardware_ still exists.
> > > 
> > > Of course, that's really just the old-fashioned text VGA console, but
> > > that one actually scrolls not by moving any bytes around, but by
> > > moving the screen start address. And the scrollback similarly isn't
> > > about any software buffering, but about the ability of moving back
> > > that screen start address.
> 
> > Could we pause this madness? Scrollback is still useful. I needed it
> > today... it was too small, so command results I was looking for
> > already scrolled away, but... life will be really painful with 0 scrollback.
> > 
> > You'll need it, too... as soon as you get oops and will want to see
> > errors just prior to that oops.
> 
> I concur -- this a serious usability regression for regular users.  Linus:
> you have a serial cable on your main dev machine, so do I, but hardly any
> regular people do -- that's restricted to mostly IPMI and such.
> 
> And without some kind of scrollback, there's no way of knowing why eg.
> your rootfs failed to mount (there was some oops, but its reason was at
> the beginning...).  Or, any other problem the user would be able to solve,
> or pass the error messages to someone more knowledgeable.
> 
> I also wonder why did you choose to remove softscrollback which is actually
> useful, yet leave hardscrollback which doesn't come to use on any
> non-ancient hardware:
> * on !x86 there's no vgacon at all
> * on x86, in-tree drivers for GPUs by Intel, nVidia and AMD (others are
>   dead) default to switching away from vgacon
> * EFI wants its own earlycon
> ... thus, the only niche left is nVidia proprietary drivers which, the last
> time I looked, still used CGA text mode.

 For the record I keep using the console scrollback all the time, and FWIW 
I have gone through all the hoops required to keep using VGA hardware 
emulation and its console text mode with my most recent laptop, which is a 
ThinkPad P51; no longer manufactured, but still hardly an obsolete device 
by today's standards I believe.  Sadly this video adapter setup has its 
shortcomings which used not to be there with my older hardware, which I 
find a functional regression to be blamed on the manufacturer, but I have 
learnt to live with that as I found no alternative I would find 
comfortable to work with.

 So no, it's not that nobody uses that stuff anymore, and not with 
obsolete hardware either.

  Maciej
