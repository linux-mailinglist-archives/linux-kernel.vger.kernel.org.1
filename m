Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6ED2F9BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbhARI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387918AbhARI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:59:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:58:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l1QN8-008Aiv-Fy; Mon, 18 Jan 2021 09:58:50 +0100
Message-ID: <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
Subject: Re: Splicing to/from a tty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oliver Giles <ohw.giles@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 18 Jan 2021 09:58:49 +0100
In-Reply-To: <20210118085311.GA2735@lst.de>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
         <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
         <20210118085311.GA2735@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-18 at 09:53 +0100, Christoph Hellwig wrote:
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
> Yes, pipes do not support ->splice_write currenly.

Well, it clearly used to work :-)

>    I think just wiring
> up iter_file_splice_write would work.  Al?

Seems to work for the simple test case that I had, at least:

diff --git a/fs/pipe.c b/fs/pipe.c
index c5989cfd564d..39c96845a72f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1206,6 +1206,7 @@ const struct file_operations pipefifo_fops = {
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
 	.fasync		= pipe_fasync,
+	.splice_write	= iter_file_splice_write,
 };
 
 /*

johannes

