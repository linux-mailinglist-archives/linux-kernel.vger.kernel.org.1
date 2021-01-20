Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CA2FD5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404025AbhATQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391488AbhATQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:27:29 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5EC061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2GJ6-003tsI-NW; Wed, 20 Jan 2021 16:26:09 +0000
Date:   Wed, 20 Jan 2021 16:26:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210120162608.GB740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118195400.GC736435@zeniv-ca>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 07:54:00PM +0000, Al Viro wrote:
> On Mon, Jan 18, 2021 at 11:46:42AM -0800, Linus Torvalds wrote:
> > On Mon, Jan 18, 2021 at 11:35 AM Al Viro <viro@zeniv-ca> wrote:
> > >
> > > I'd rather have sendfile(2) do what splice(2) does and handle pipes
> > > directly.  Let me take a look,,,
> > 
> > It's not technically just the sendfile() thing. Some things do
> > sendfile "internally" (ie they use do_splice_direct()).
> > 
> > Although maybe they always happen just on non-pipe destinations (ie
> > file-to-file copy). I didn't check.
> > 
> > But particularly if it can be handled in do_splice_direct(), that
> > would be a good thing.
> 
> FWIW, it might make sense to merge do_splice_direct() and do_splice();
> interfaces are very similar and do_splice() is basically
> 	if both are pipes
> 		....
> 	else if input is pipe
> 		....
> 	else if output is pipe
> 		....
> 	else
> 		return -EINVAL
> with do_splice_direct() being fairly close to the missing case.

Yecchhh...  The situation with checks is interesting.
	do_splice():
		in needs FMODE_READ, out - FMODE_WRITE [EBADF]
		if in is a pipe, off_in must be NULL.  [ESPIPE]
		if out is a pipe, off_out must be NULL.  [ESPIPE]
		if in is not a pipe
			non-NULL off_in is allowed only with FMODE_PREAD [EINVAL]
			rw_verify_area done on in
		if out is not a pipe
			non-NULL off_out is allowed only with FMODE_PWRITE [EINVAL]
			no O_APPEND on out [EINVAL]
			rw_verify_area done on out
		either in or out must be a pipe [EINVAL]
	do_splice_direct():
		out needs FMODE_WRITE [EBADF]
		rw_verify_area done on out
		no O_APPEND on out [EINVAL]
Callers:
	__do_splice() -> do_splice():
		if in is a pipe, off_in must be NULL.  [ESPIPE, duplicate]
		if out is a pipe, off_out must be NULL.  [ESPIPE, duplicate]

	io_uring io_splice() -> do_splice():
		no extra checks

        do_sendfile() -> do_splice_direct():
		in needs FMODE_READ [EBADF]
                out needs FMODE_WRITE [EBADF, duplicate]
		non-NULL off_in is allowed only with FMODE_PREAD [EINVAL]
		for out we act as splice with NULL off_out (== use ->f_pos)
		rw_verify_area done on in
		rw_verify_area done on out [duplicate]

	vfs_copy_file_range() -> do_copy_file_range() ->
		-> generic_copy_file_range() or __ceph_copy_file_range() ->
		-> do_splice_direct():
		both in and out must be regular [EINVAL or EISDIR]
		in needs FMODE_READ [EBADF]
		out needs FMODE_WRITE [EBADF]
		no O_APPEND on out [EBADF]
		on immutable for out [EPERM]
		rw_verify_area done on in
		rw_verify_area done on out [duplicate]
		FMODE_P{READ,WRITE} is ignored.  I wonder what happens if
			somebody starts playing with copy_file_range(2) on
			e.g. procfs or sysfs...

	ovl_copy_up_date() -> do_splice_direct():
		both in and out are hopefully regular - I'm not sure that copyup
			logics is sufficiently protected, TBH.
		FMODE_READ on in and FMODE_WRITE on out are guaranteed
		lack of O_APPEND on out is guaranteed
		FMODE_P{READ,WRITE} is completely ignored.  Should be OK, modulo
			the same issues with protection against manipulation of
			layers.

Checks in vfs_copy_file_range() need to remain there - do_splice_direct() is
not guaranteed downstream of that.

AFAICS, we have the following:
	in must have FMODE_READ
	out must have FMODE_WRITE
	no O_APPEND on out, unless a pipe[1]
	for non-pipe out we do rw_verify_area
	for non-pipe in we do rw_verify_area
	no offsets for pipes

The lack of offsets for pipes should've been "not without FMODE_P{READ,WRITE}",
but that's not entirely consistent - we have splice(2) fail with EINVAL in
case of non-NULL off_in on a file that doesn't allow pread(), except that
when this file happens to be a pipe (which obviously doesn't allow pread())
we fail with ESPIPE instead.  Note that for pread(2)/pwrite(2)/sendfile(2)
we fail with consistent ESPIPE in all such cases.

We also do not check FMODE_PREAD/FMODE_PWRITE for copy_file_range()/copyup.
Which is probably wrong.

Another inconsistency is that rw_verify_area() in copyup is done for
output (once for each chunk), but not for input.  The tricky part here
is that there's an LSM hook in the end of rw_verify_area()...

Can we turn "not a pipe, but lacks FMODE_PREAD" error value for splice(2)
from EINVAL to ESPIPE?  Would make the logics easier to consolidate...
Right now the checks are spread over many layers of several call chains
and rather hard to follow.

[1] yes, it is possible to have O_APPEND opened pipes - open a FIFO with
O_APPEND and you've got it.  We are not quite consistent in handling
those - sendfile() to such is rejected, splice() is not.
