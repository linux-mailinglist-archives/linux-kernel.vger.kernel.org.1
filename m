Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4645F273F29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIVKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:04:04 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42081 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVKEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:04:04 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 08MA40iu016503;
        Tue, 22 Sep 2020 12:04:00 +0200
Date:   Tue, 22 Sep 2020 12:04:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 31/32] auxdisplay: charlcd: Do not print chars at end
 of line
Message-ID: <20200922100400.GH16421@1wt.eu>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-32-poeschel@lemonage.de>
 <20200922052701.GB16386@1wt.eu>
 <20200922094422.ucj24ohtervhcetv@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922094422.ucj24ohtervhcetv@lem-wkst-02.lemonage>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:44:22AM +0200, Lars Poeschel wrote:
> On Tue, Sep 22, 2020 at 07:27:01AM +0200, Willy Tarreau wrote:
> > On Mon, Sep 21, 2020 at 04:46:43PM +0200, poeschel@lemonage.de wrote:
> > > From: Lars Poeschel <poeschel@lemonage.de>
> > > 
> > > Skip printing characters at the end of a display line. This fits to the
> > > behaviour we already had, that the cursor is nailed to last position of
> > > a line.
> > 
> > Just very old memories, but wasn't this used with the ability to shift
> > the display ? IIRC the HD44780 has a 2x64 chars buffer and you can make
> > the buffered characters appear when you shift the display. That's akin
> > to seeing the display as an adjustable window over the buffer. I don't
> > remember having used that feature, so if it didn't previously work, please
> > disregard my comment, I just want to be sure we don't break a feature
> > others might be relying on.
> 
> Yes, indeed. But this is a point, where this was inconsistent. The
> feature you described worked only for displays with 2 lines or less. On
> displays with 4 lines there simply is no buffer that is not visible and
> in this case it sticks to the end of the line already.

OK.

> To make this work for all displays this would require a whole lot of
> work. We would need a fallback implementation that emulates this in
> software and then redraws the whole display from that software
> (linux-side) buffer when shifting.

I don't think that's worth it at all, really!

> Currently my patchset cuts this feature for displays with one or two
> lines. I don't see clean an easy way to leave that in. Any ideas ?

The points you mention are good enough indicators that it's extremely
unlikely anyone has ever used that feature with these drivers. So I
think it's best to keep your changes and wait to see if anyone pops
up with an obscure use case, in which case their explanation might
help figure another approach.

Willy
