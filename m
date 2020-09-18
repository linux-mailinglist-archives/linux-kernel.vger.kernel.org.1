Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742D26FA92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgIRK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgIRK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:27:59 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC1C06174A;
        Fri, 18 Sep 2020 03:27:59 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kJDcM-0002VN-JV; Fri, 18 Sep 2020 12:27:50 +0200
Date:   Fri, 18 Sep 2020 12:27:50 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Message-ID: <20200918102750.GA27828@angband.pl>
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
 <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
 <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com>
 <20200916205434.GA10389@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916205434.GA10389@duo.ucw.cz>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:54:34PM +0200, Pavel Machek wrote:
> On Mon 2020-09-14 18:28:34, Linus Torvalds wrote:
> > Note that scrollback hasn't actually gone away entirely - the original
> > scrollback supported by _hardware_ still exists.
> > 
> > Of course, that's really just the old-fashioned text VGA console, but
> > that one actually scrolls not by moving any bytes around, but by
> > moving the screen start address. And the scrollback similarly isn't
> > about any software buffering, but about the ability of moving back
> > that screen start address.

> Could we pause this madness? Scrollback is still useful. I needed it
> today... it was too small, so command results I was looking for
> already scrolled away, but... life will be really painful with 0 scrollback.
> 
> You'll need it, too... as soon as you get oops and will want to see
> errors just prior to that oops.

I concur -- this a serious usability regression for regular users.  Linus:
you have a serial cable on your main dev machine, so do I, but hardly any
regular people do -- that's restricted to mostly IPMI and such.

And without some kind of scrollback, there's no way of knowing why eg.
your rootfs failed to mount (there was some oops, but its reason was at
the beginning...).  Or, any other problem the user would be able to solve,
or pass the error messages to someone more knowledgeable.

I also wonder why did you choose to remove softscrollback which is actually
useful, yet leave hardscrollback which doesn't come to use on any
non-ancient hardware:
* on !x86 there's no vgacon at all
* on x86, in-tree drivers for GPUs by Intel, nVidia and AMD (others are
  dead) default to switching away from vgacon
* EFI wants its own earlycon
... thus, the only niche left is nVidia proprietary drivers which, the last
time I looked, still used CGA text mode.

> If it means I get to maintain it... I'm not happy about it but that's
> better than no scrollback.

That'd be greatly appreciated.  There are also some simplifications/rewrites
that could be done, like getting rid of redundant 1-byte/4-byte storage (or
even the code for 1-byte...).  Hard scrollback could be axed altogether (it
provides only a small amount of scroll).  Etc...

>  Kernel is now very verbose, so important messages
>  during bootup scroll away. It is way bigger deal when you can no
>  longer get to them using shift-pageup.

Thus hard scrollback is inadequate in the rare cases it's even present.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
