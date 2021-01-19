Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03C2FB830
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392303AbhASMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391386AbhASLzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:55:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A55FD23119;
        Tue, 19 Jan 2021 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611057241;
        bh=wvq4C/3v9L4iyBq8nK9CMBpB2psXlVLWdxYI1r7PMNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnYTiamp7E6WFxI16nLBJw4b72lHRzH+ai+2ApJZ0efgIdvfTjVdDbBGxA56IytGL
         ZuYyK6Vq68nzYyHCkS5J17bYc9g+K5xv/CngZ627ksX6wsOgTzvLt0zGc2FsQNYrMY
         06Egi1USOX+cutVf31hMcil0VQ738OigBKC2Nyng=
Date:   Tue, 19 Jan 2021 12:53:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: Splicing to/from a tty
Message-ID: <YAbIVgGt1Qz8ItMh@kroah.com>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
 <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
 <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
 <CAHk-=wjgufiORSuAb270XpGn45jexRjP9SCmcc7AAAZsVrAaPw@mail.gmail.com>
 <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 05:38:55PM -0800, Linus Torvalds wrote:
> On Mon, Jan 18, 2021 at 2:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So it's not a "real" patch, but with improved buffer handling in
> > tty_read(), I think this is actually quite close.
> 
> Hmm.
> 
> I somehow ended up working on this all because it's a Monday, and I
> don't see a lot of pull requests early in the week.
> 
> And I think I have a solution for the HDLC "we may need to copy a
> packet that might be up to 64kB" issue, that isn't really all that
> ugly.
> 
> We can just iterate over a random "cookie" that the line discipline
> can use any way it wants to. In the case of n_hdlc, it can just put
> the 'rbuf' thing it has into that cookie, and then it can copy it all
> piece-meal until it is all used up. And if it runs out of space in the
> middle, it will return -EOVERFLOW, and we're all good.
> 
> The only other thing such a line discipline needs is the offset into
> the cookie, but the iterator has to maintain that anyway, so that's
> simple enough.
> 
> So here's a fourth patch for this thing today, this time with what I
> think is actually a working model for the buffer handling.
> 
> Other line disciplines *could* use the cookie if they want to. I
> didn't do any of that, though.
> 
> The normal n_tty line discipline, for example, could easily just loop
> over the data. It doesn't need an offset or that 'rbuf' pointer, but
> it still needs to know whether the call is the first one or not,
> because the first time the n_tty line discipline is called it may need
> to wait for a minimum number of characters or whatever the termios
> settings say - but obviously once it has waited for it once, it
> shouldn't wait for it again the next time around (only on the next
> actual full read()). IOW, it would be wrong if the termios said "wait
> for 5 characters", and then it saw 68 characters, copied the first 64,
> in the first iteration, and than saw "oh, now there are only 4
> characters left so now I have to wait for a fifth".
> 
> So n_tty could use the cookie purely to see whether it's the first
> iteration or not, and it could just set the cookie to a random value
> (it always starts out as NULL) to just show what state it is in.
> 
> I did *NOT* do that, because it's not technically necessary - unlike
> the hdlc packet case, n_tty returning a partial result is not wrong
> per se even if we might have reasons to improve on it later.
> 
> What do people think about this?
> 
> Also, does anybody have any test-code for the HDLC case? I did find an
> interesting comment when doing a Debian code search:
> 
>   /* Bloody hell... readv doesn't work with N_HDLC line discipline... GRR! */
> 
> and yes, this model would allow us to handle readv() properly for hdlc
> (and no, the old one did not, because it really wanted to see the
> whole packet in *one* user buffer).
> 
> But I have no idea if hdlc is even relevant any more, and if anybody
> really cares.
> 
> Anybody?


This looks sane, but I'm still missing what the goal of this is here.
It's nice from a "don't make the ldisc do the userspace copy", point of
view, but what is the next step in order to tie that into splice?

I ask as I also have reports that sysfs binary files are now failing for
this same reason, so I need to make the same change for them and it's
not excatly obvious what to do:
	https://lore.kernel.org/r/1adf9aa4-ed7e-8f05-a354-57419d61ec18@codeaurora.org

thanks,

greg k-h
