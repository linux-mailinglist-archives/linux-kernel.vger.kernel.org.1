Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A9273E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:21:25 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42076 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIVJVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:21:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 08M9LLFh016492;
        Tue, 22 Sep 2020 11:21:21 +0200
Date:   Tue, 22 Sep 2020 11:21:21 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 28/32] auxdisplay: hd44780: Remove clear_fast
Message-ID: <20200922092121.GG16421@1wt.eu>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-29-poeschel@lemonage.de>
 <20200922052227.GA16386@1wt.eu>
 <20200922084912.sck4j3iazqevaskg@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922084912.sck4j3iazqevaskg@lem-wkst-02.lemonage>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:49:12AM +0200, Lars Poeschel wrote:
> > I might have got confused, but it looks to me like patches 27 and 28
> > basically undo patch 26: in 26 you moved code to hd44780 and wrote a
> > fallback, just to later delete that code.
> 
> To be honest: I also got confused by this whole clear code and why are
> there 3 different clear variants. ;-)
> The reason why I did it this way is to show what happened to the
> original code. The original code has a fallback that kind of does the
> same like my naive implementation but it uses the fact, that on hd44780
> displays the underlying buffer can be accessed in a linear manner to
> speed things up a little. This then also clears the not visible area of
> the buffer (which my naive implementation does not). To become
> independent of hd44780 code at this point I had to do something.
> I opted to for this naive implementation as a replacement for the old
> optimized clear loop. The fallback was already there.
> And then I did a separate step to remove it because I found it a bit
> suboptimal. All current users have the clear command...

I'm not contesting your naive implementation, it just looks to me that
patch 26 adds it while moving code that patch 27 removes, and patch 28
removes it. So I don't understand why not to remove it entirely in the
first place. It's possible I missed something related to other users of
that code but that wasn't clear from the patch nor the descriptions.

> > I seem to remember that the reason for the clear_fast() implementation
> > is that the default clear_display() is quite slow for small displays,
> > compared to what can be achieved by just filling the display with spaces
> > (in the order of tens of milliseconds vs hundreds of microseconds). But
> > I could be mistaken given how old this is, so please take my comment
> > with a grain of salt.
> 
> ... well, and what the hd44780 controller does when it executes the
> clear command is also writing a space character to all character
> locations (also to the not visible ones). Probably very much the same
> than the original fallback implementation.

I've just checked on some old datasheets, and indeed the Display clear
command takes up to 1.6 ms, which looks very reasonable. But the charlcd
code currently sleeps 15 ms, which is 10 times more than needed. I've
just found its roots inside the panel-0.8.1 version that changed the delay
from 1ms to 15ms on 2001/11/10, and added the lcd_clear_fast() function
as a workaround. Thus probably 1ms was too short for the 1.6 ms spec,
but 15ms was needlessly high. So I think we can get rid of all of this
indeed!

> For me issuing the clear command is faster by at least one order!
> I have one of these cheap china displays with 4x20 characters. The flow
> is like this: i2c -> gpio -> hd44780 in 4 bit mode. And gpio is issuing
> a i2c request for EVERY SINGLE gpio. This is slow as hell. But it works.
> :-)

Good point for sur over i2c it would stink a little bit! Same for those
using 9600 bps serial interfaces.

> As I said I also was a bit confused by the different clean
> implementations, but the only real user of the clear_fast is the panel
> driver. The hd44780 one I use did not provide a clear_fast.
> 
> So I would opt for the way I proposed in the patch series with the clear
> command instead of the loop. And let the panel driver use its optimized
> clear.

Or we could align the panel driver to get rid of it as well.

Thanks for the explanation,
Willy
