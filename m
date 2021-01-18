Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E232FAA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437698AbhARTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394005AbhARTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:46:33 -0500
X-Greylist: delayed 644 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jan 2021 11:45:53 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:45:53 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aTB-0036Nk-PE; Mon, 18 Jan 2021 19:45:45 +0000
Date:   Mon, 18 Jan 2021 19:45:45 +0000
From:   Al Viro <viro@zeniv-ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118194545.GB736435@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:26:00AM -0800, Linus Torvalds wrote:
> On Mon, Jan 18, 2021 at 12:58 AM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >
> > > I think just wiring up iter_file_splice_write would work.  Al?
> >
> > Seems to work for the simple test case that I had, at least:
> 
> Mind sending me a signed-off patch for this?
> 
> Yeah, I know it's a trivial one-liner, but I much prefer having an
> author with a patch and a sign-off to just doing it personally and
> reaping all that glory for it..

IMO it's a wrong way to handle that.   Look: do_sendfile() calls
do_splice_direct(), which calls splice_direct_to_actor().  There
we allocate an internal pipe and go through "feed from source into
that pipe, then shove what's there into destination".  Which is
insane for the case when destination (or source, for that matter)
is a pipe itself.

do_splice_direct() does something that do_splice() won't - it
handles non-pipe to non-pipe case.  Which is how sendfile(2) is
normally used, of course.

I'll look into that in more details, but IMO bothering with
internal pipe is just plain wrong for those cases.
