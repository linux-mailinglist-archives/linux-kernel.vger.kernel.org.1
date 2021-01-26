Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0788304F89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhA0DO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404349AbhAZTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:43:48 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5BC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:42:53 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4UEd-006NDD-QE; Tue, 26 Jan 2021 19:42:44 +0000
Date:   Tue, 26 Jan 2021 19:42:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210126194243.GL740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca>
 <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210126060720.GJ740243@zeniv-ca>
 <CAHk-=wh9BELRf-huvVa2vQpFqKiqLHwqu9Wc6RHTvCcVS=5SDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9BELRf-huvVa2vQpFqKiqLHwqu9Wc6RHTvCcVS=5SDA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:49:11AM -0800, Linus Torvalds wrote:
> On Mon, Jan 25, 2021 at 10:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Jan 24, 2021 at 11:11:42AM -0800, Linus Torvalds wrote:
> > >
> > > I agree that it would be better fixed by just having sendfile()
> > > basically turn into splice() for the pipe target case, but I haven't
> > > seen any patches from you, so I assume it wasn't 100% trivial.
> >
> > Just to make clear - sendfile() regular-to-pipe is *not* the same
> > issue as splice to/from tty.
> 
> That's not what I meant.
> 
> sendfile() to a pipe is basically the same thing as splice() to a pipe.
> 
> Except I think it might have different looping behavior. And as you
> noted earlier, the error returns may be randomly different.

Sure.  What I'm saying is that there'd been two different regressions
discussed in that thread, and the one dealt with by this patch series
is not the one brought up in the original posting.  IOW, it's an
alternative not to "let's add ->splice_{read,write}() for tty" stuff
but to "let's add ->splice_write() for pipes" one-liner.

I do not doubt that you know that.  But the thread had been confusing
enough (hell, the sendfile-related subthread has kept the original
subject explicitly refering to tty), so I wanted to avoid any confusion
for somebody looking through it a year or two down the road.
