Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6E2FE558
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbhAUIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbhAUIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:45:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E75D239CF;
        Thu, 21 Jan 2021 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611218683;
        bh=sdhfOBU4yNqElkYgqvaCMCLhYYAFwCeX+2JsdASHq9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pw/tr8cKR42V926RFqwcUVOEAIc2fjEqU7PK/dDYzI8svTiVhMhx56AyfDfquDzVE
         DkVhx1slLHvE6r0b0nb57zTMOdsRTd5zF8gtJU+6pcHPepp5XRkITTzNdpEm0AZFKJ
         nkgZWwwlwTj6OCAsFmY23uLMquXg+D5m3VI3IK3Y=
Date:   Thu, 21 Jan 2021 09:44:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: tty splice branch (was "Re: Splicing to/from a tty")
Message-ID: <YAk+7dy9hemw1/yb@kroah.com>
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
 <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:18:36PM -0800, Linus Torvalds wrote:
> On Tue, Jan 19, 2021 at 8:44 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'll come back to this tomorrow and do the line-buffered icanon case
> > too (unless pull requests pile up), and then I'll be happy with the
> > tty changes, and I think I can submit this series for real to Greg.
> 
> Greg, I don't know how you want to handle this.
> 
> I have a branch with my tty splice patches at
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git tty-splice
> 
> and that now includes doing that "cookie continuation" thing even for
> the N_TTY icanon modes.
> 
> It passes my local tests, and I did try a few rather odd things. And
> Oliver tested an ealier version without that final commit on his load.
> But...
> 
> That tty splice thing is clearly a regression, but it's not like we
> have seen a lot of reports of it, so it's clearly a very special
> thing.
> 
> End result: I'm leaving it to you to decide how you want to handle it.
> You can tell me to just merge it myself as a regression fix, despite
> it being fairly late in the 5.11 series.  Or you can pull it into your
> tty tree for linux-next and 5.12. And we can just plan to backport it
> (for 5.10 and 5.11) later when it has had more wide testing.
> 
> Another alternative is to do just that first patch immediately (the
> "tty: implement write_iter" one), because that one should be the
> simple case that gets sendfile() and splice() working when the
> _destination_ is a tty. The "source is a tty" is the much more complex
> case that the other patches deal with.

Let me do this last thing.  I've taken your one patch into my
"tty-linus" branch and will go beat on it for a day and then ask you to
pull it in for the next 5.11-rc release, and I've taken your full series
into my "tty-next" branch so it will get much wider testing in
linux-next for a few weeks.  If it turns out that we get reports of the
"splice/sendfile from a tty", we can always merge them into 5.11 and
5.10 as needed.

Thanks for doing this work,

greg k-h
