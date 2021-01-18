Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CB2F9B93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbhARIxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:53:55 -0500
Received: from verein.lst.de ([213.95.11.211]:47062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbhARIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:53:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66CE968AFE; Mon, 18 Jan 2021 09:53:11 +0100 (CET)
Date:   Mon, 18 Jan 2021 09:53:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Oliver Giles <ohw.giles@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118085311.GA2735@lst.de>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 05:46:33PM +0100, Johannes Berg wrote:
> > For my case, I attempted to instead implement splice_write and
> > splice_read in tty_fops; I managed to get splice_write working calling
> > ld->ops->write, but splice_read is not so simple because the
> > tty_ldisc_ops read method expects a userspace buffer. So I cannot see
> > how to implement this without either (a) using set_fs, or (b)
> > implementing iter ops on all line disciplines.
> > 
> > Is splice()ing between a tty and a pipe worth supporting at all? Not a
> > big deal for my use case at least, but it used to work.
> 
> Is it even strictly related to the tty?
> 
> I was just now looking into why my cgit/fcgi/nginx setup no longer
> works, and the reason is getting -EINVAL from sendfile() when the input
> is a file and the output is a pipe().

Yes, pipes do not support ->splice_write currenly.   I think just wiring
up iter_file_splice_write would work.  Al?

> So I wrote a simple test program (below) and that errors out on kernel
> 5.10.4, while it works fine on the 5.9.16 I currently have. Haven't
> tried reverting anything yet, but now that I haev a test program it
> should be simple to even bisect.
> 
> johannes
> 
> 
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/sendfile.h>
> #include <stdio.h>
> #include <assert.h>
> 
> int main(int argc, char **argv)
> {
> 	int in = open(argv[0], O_RDONLY);
> 	int p[2], out;
> 	off_t off = 0;
> 	int err;
> 
> 	assert(in >= 0);
> 	assert(pipe(p) >= 0);
> 	out = p[1];
> 	err = sendfile(out, in, &off, 1024);
> 	if (err < 0)
> 		perror("sendfile");
> 	assert(err == 1024);
> 
> 	return 0;
> }
> 
---end quoted text---
