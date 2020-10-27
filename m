Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601329A5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508419AbgJ0Hyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508404AbgJ0Hyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:54:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D38452224E;
        Tue, 27 Oct 2020 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603785287;
        bh=OLX9wkkkI7QN9ZrSdk1YCPwT6qJ81PrNMm/jlIzDOdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvlbGcYXkY+2/Tl1QzHm/hjrA7OghdNYGiyAffPUzIQgt+Qao5l9gfiIWZv+VAv6v
         dHEY7oJPmPHN99DPALQbu9OVxHNhvSqr4h4nbugDRqr0IVXCOhXo/FwK/wSBmoYovD
         KCw6trjZMpJoOZs2x+N1xRgec5Ks4DXlrrSOWmDY=
Date:   Tue, 27 Oct 2020 08:55:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027075541.GA24429@kroah.com>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027074911.GB29565@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:49:11AM +0000, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 07:48:32AM +0100, Greg KH wrote:
> > On Sun, Oct 25, 2020 at 03:40:27PM -0700, Linus Torvalds wrote:
> > > The most interesting - to me - change here is Christoph's setf_fs()
> > > removal (it got merged through Al Viro, as you can see in my mergelog
> > > below).  It's not a _huge_ change, but it's interesting because the
> > > whole model of set_fs() to specify whether a userspace copy actually
> > > goes to user space or kernel space goes back to pretty much the
> > > original release of Linux, and while the name is entirely historic (it
> > > hasn't used the %fs segment register in a long time), the concept has
> > > remained. Until now.
> > 
> > I told Al this yesterday, but figured I would mention it here for others
> > to see.
> > 
> > Commit 36e2c7421f02 ("fs: don't allow splice read/write without explicit
> > ops") from this patch series, is breaking the bionic test suite that
> > does the following to verify that splice is working:
> > 
> > 	int in = open("/proc/cpuinfo", O_RDONLY);
> > 	ASSERT_NE(in, -1);
> > 
> > 	TemporaryFile tf;
> > 	ssize_t bytes_read = splice(in, nullptr, pipe_fds[1], nullptr, 8*1024, SPLICE_F_MORE | SPLICE_F_MOVE);
> > 	ASSERT_NE(bytes_read, -1);
> > 
> > Before this change, all works well but now splice fails on /proc files
> > (and I'm guessing other virtual filesystems).
> > 
> > I'll ask the bionic developers if they can change their test to some
> > other file, but this is a regression and might show up in other "test
> > platforms" as well.  Using /proc for this is just so simple because
> > these files are "always there" and don't require any housekeeping for
> > test suites to worry about .
> 
> Is this just a test or a real application?   I already have the
> infrastructure to support read_iter/write_iter on procfs and seq_files,
> but due to the intrusiveness we decided to only fix instances on an as
> needed basis.  So we'll have everything ready once we pull the trigger.

This is just a test, part of the bionic test suite to verify that bionic
is working properly, and is run on new kernels as a verification that
nothing functional broke in the kernel update.

I don't know about "real applications" yet.

Do you have to implement this on a per-proc-file-basis, or will it work
for the whole filesystem?

And are the patches public anywhere that I could test them out?

thanks,

greg k-h
