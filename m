Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59FD2FDE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbhAUBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbhAUAj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:39:29 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02206C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 16:38:48 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Nzf-0042f0-6V; Thu, 21 Jan 2021 00:38:35 +0000
Date:   Thu, 21 Jan 2021 00:38:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210121003835.GF740243@zeniv-ca>
References: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca>
 <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 03:40:29PM -0800, Linus Torvalds wrote:
> On Wed, Jan 20, 2021 at 3:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  Why do we clear FMODE_PWRITE there [seq_open - ed], anyway?
> 
> I think it's pointless and historical, and comes from "several /proc
> files supported the simple single-write model, nothing ever supported
> moving around and writing".
> 
> The seq_file stuff was always about reading, and then the writing part
> was generally random special-case hacks on the side.
> 
> So I think that "clear PWRITE" thing is to make sure we get sane error
> cases if somebody tries something funny, knowing that none of the
> hacky stuff support it.
> 
> And then the very special kernfs thing adds it back in, because it
> does in fact allow seeking writes.

OK...  I wonder how many debugfs writable files allow pwrite() with
BS results...

Anyway, possibly more interesting question is why do we care about
O_APPEND at all - why not treat it the same way we do in write()?
Hell, even our pwrite() just goes ahead and writes to the end of
file, whatever position it had been given.  Yes, for pwrite(2) that's
contrary to POSIX, but it's probably cast in stone by that point
anyway...

Looking through the instances of ->splice_write(), iter_file_splice_write()
will end up appending the data to EOF and so will gfs2_file_splice_write().
For sockets (generic_splice_sendpage()) we definitely don't give a toss
about O_APPEND (F_SETFL can set it, so that case is possible to hit),
ditto for splice_write_null() and port_fops_splice_write().  Which leaves
only one instance: fuse_dev_splice_write(), which also should ignore
O_APPEND (IMO fuse_dev_open() ought to call nonseekable_open() anyway).

So... why do we ban O_APPEND on destination for splice() or for sendfile()?
AFAICS, if we simply remove that test, we'll end up with write going to
the end of O_APPEND file. same as for write()/pwrite().

Comments?
