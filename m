Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91602FAAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436792AbhART6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437410AbhART5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:57:32 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:56:52 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1adr-0036Zp-T9; Mon, 18 Jan 2021 19:56:48 +0000
Date:   Mon, 18 Jan 2021 19:56:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118195647.GA740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca>
 <CAHk-=wi+PF2J7PWRWdQR5nUAxGN4GDMezcxddWi6Aufw71+_Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+PF2J7PWRWdQR5nUAxGN4GDMezcxddWi6Aufw71+_Pw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:49:53AM -0800, Linus Torvalds wrote:
> On Mon, Jan 18, 2021 at 11:45 AM Al Viro <viro@zeniv-ca> wrote:
> >
> > do_splice_direct() does something that do_splice() won't - it
> > handles non-pipe to non-pipe case.  Which is how sendfile(2) is
> > normally used, of course.
> 
> Yeah, I agree, it's better if we do the pipe case specially, but if
> it's too painful for a stable backport I'll certainly take the
> one-liner..
> 
> Btw, your email setup is broken. Your emails now have a "From:" line like this:
> 
>     From: Al Viro <viro@zeniv-ca>
> 
> and that is not a valid email address.

Just noticed, should be fixed now...
