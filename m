Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2852F9B17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbhARIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:17:10 -0500
Received: from verein.lst.de ([213.95.11.211]:46965 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733169AbhARIRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:17:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3085367373; Mon, 18 Jan 2021 09:16:16 +0100 (CET)
Date:   Mon, 18 Jan 2021 09:16:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Oliver Giles <ohw.giles@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Splicing to/from a tty
Message-ID: <20210118081615.GA1397@lst.de>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 08:35:41PM +1300, Oliver Giles wrote:
> Commit 36e2c7421f02 (fs: don't allow splice read/write without explicit ops) broke my userspace application which talks to an SSL VPN by splice()ing between "openssl s_client" and "pppd". The latter operates over a pty, and since that commit there is no fallback for splice()ing between a pipe and a pty, or any tty for that matter.
> 
> The above commit mentions switching them to the iter ops and using generic_file_splice_read. IIUC, this would require implementing iter ops also on the line disciplines, which sounds pretty disruptive.
> 
> For my case, I attempted to instead implement splice_write and splice_read in tty_fops; I managed to get splice_write working calling ld->ops->write, but splice_read is not so simple because the tty_ldisc_ops read method expects a userspace buffer. So I cannot see how to implement this without either (a) using set_fs, or (b) implementing iter ops on all line disciplines.

set_fs is gone for all the important platforms.  So yes, you basically
need to convert to iov_iter or have a huge splice_write parallel
infrastucture.

> 
> Is splice()ing between a tty and a pipe worth supporting at all? Not a big deal for my use case at least, but it used to work.

Our normal policy is no regressions for exiting userspace.  By that we'd
have to fix it.  Let me see if I can help you with this in any way.
