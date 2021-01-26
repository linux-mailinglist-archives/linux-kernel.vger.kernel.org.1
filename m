Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93CB3044D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbhAZRPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbhAZGIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:08:17 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:07:35 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4HVY-00689w-Ko; Tue, 26 Jan 2021 06:07:20 +0000
Date:   Tue, 26 Jan 2021 06:07:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210126060720.GJ740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca>
 <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 11:11:42AM -0800, Linus Torvalds wrote:
> Al,
>  coming back to this because rc5 is imminent..
> 
> On Mon, Jan 18, 2021 at 11:45 AM Al Viro <viro@zeniv-ca> wrote:
> >
> > do_splice_direct() does something that do_splice() won't - it
> > handles non-pipe to non-pipe case.  Which is how sendfile(2) is
> > normally used, of course.
> >
> > I'll look into that in more details, but IMO bothering with
> > internal pipe is just plain wrong for those cases.
> 
> You clearly thought about this, with the emails about odd error cases,
> but I get the feeling that for fixing the current "you can't
> sendfile() to a pipe" regression (including stable) we should do the
> one-liner. No?
> 
> I agree that it would be better fixed by just having sendfile()
> basically turn into splice() for the pipe target case, but I haven't
> seen any patches from you, so I assume it wasn't 100% trivial.
> 
> Hmm?

Just to make clear - sendfile() regular-to-pipe is *not* the same
issue as splice to/from tty.  The latter needs ->splice_read()
and ->splice_write() in tty_fops; the former can be dealt with
by teaching do_sendifile() to use the guts of do_splice() in
case when in or out happens to be a pipe (with some rearrangement
of checks) instead of bothering with do_splice_direct().

The only commonality between these two is that both got broken
by the same patch series.  Johannes' patch is an attempt to
deal with regular-to-pipe sendfile(2), and it's not a good
way to handle that.  Neither it, nor the variant I proposed
would do a damn thing for tty (and sendfile(2) never worked
for source other than regular or block anyway).  FWIW, the real
check in do_splice_direct() should be "has FMODE_PREAD", regardless
of the position we are asking to read from - do_splice_direct()
is basically
	while left to copy
		splice_read from in to internal pipe
		splice_write from internal pipe to out
and if splice_write ends up with short copy, we advance the position
by the amount written and discard everything left in the internal pipe.
Using it for something non-seekable would end up with data silently
lost on short copy.

Note that decision against splice(2) between non-pipes appears
to have been deliberate and unless Jens (and mingo?) decide
they are OK with that change, I'm *not* adding that functionality
to do_splice().

Anyway, the series is in vfs.git #work.sendfile, 5.11-rc1-based

Shortlog:
Al Viro (3):
      do_splice_to(): move the logics for limiting the read length in
      take the guts of file-to-pipe splice into a helper function
      teach sendfile(2) to handle send-to-pipe directly

Diffstat:
 fs/internal.h   |  9 +++++++++
 fs/read_write.c | 19 +++++++++++++------
 fs/splice.c     | 42 +++++++++++++++++++++++-------------------
 3 files changed, 45 insertions(+), 25 deletions(-)

Individual patches in followups; first two are equivalent transformations
(fairly obvious cleanup and taking a part of do_splice() into a helper),
while the third one makes do_sendfile() use that new helper for file-to-pipe
case.
