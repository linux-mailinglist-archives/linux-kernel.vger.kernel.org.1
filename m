Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6892FAB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437994AbhARU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437983AbhARU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:26:48 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752DEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 12:26:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aIj-0035kQ-Ag; Mon, 18 Jan 2021 19:34:57 +0000
Date:   Mon, 18 Jan 2021 19:34:57 +0000
From:   Al Viro <viro@zeniv-ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118193457.GA736435@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118085311.GA2735@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:53:11AM +0100, Christoph Hellwig wrote:
> On Sat, Jan 16, 2021 at 05:46:33PM +0100, Johannes Berg wrote:
> > > For my case, I attempted to instead implement splice_write and
> > > splice_read in tty_fops; I managed to get splice_write working calling
> > > ld->ops->write, but splice_read is not so simple because the
> > > tty_ldisc_ops read method expects a userspace buffer. So I cannot see
> > > how to implement this without either (a) using set_fs, or (b)
> > > implementing iter ops on all line disciplines.
> > > 
> > > Is splice()ing between a tty and a pipe worth supporting at all? Not a
> > > big deal for my use case at least, but it used to work.
> > 
> > Is it even strictly related to the tty?
> > 
> > I was just now looking into why my cgit/fcgi/nginx setup no longer
> > works, and the reason is getting -EINVAL from sendfile() when the input
> > is a file and the output is a pipe().
> 
> Yes, pipes do not support ->splice_write currenly.   I think just wiring
> up iter_file_splice_write would work.  Al?

I'd rather have sendfile(2) do what splice(2) does and handle pipes
directly.  Let me take a look,,,
