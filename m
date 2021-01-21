Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9172FDF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbhAUB7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392612AbhAUBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:46:59 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A52C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:45:55 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2P2O-0043lS-5S; Thu, 21 Jan 2021 01:45:28 +0000
Date:   Thu, 21 Jan 2021 01:45:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210121014528.GG740243@zeniv-ca>
References: <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca>
 <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
 <20210121003835.GF740243@zeniv-ca>
 <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:04:17PM -0800, Linus Torvalds wrote:

> The whole point of O_APPEND is that the position shouldn't matter.
> 
> And the whole point of "pwrite()" is that you specify a position.
> 
> So the two just do not go together - although we may have legacy
> issues, of course.

Our pwrite(2):
BUGS
       POSIX  requires  that  opening  a  file  with the O_APPEND flag
       should have no effect on the location at which pwrite() writes
       data.  However, on Linux, if a file is opened with O_APPEND,
       pwrite() appends data to the  end of the file, regardless of
       the value of offset.
POSIX pwrite(2):
	The pwrite() function shall be equivalent to write(), except that
	it writes into a given position and does not change the file offset
	(regardless of whether O_APPEND is set).  The first three arguments
	to pwrite() are the same as write() with the addition of a fourth
	argument offset for the desired position inside the file.  An attempt
	to perform a pwrite() on a file that is incapable of seeking shall
	result in an error.

I don't believe that we could change behaviour of our pwrite(2) without
breaking userland, even if we wanted to.  It's been that way since
2.1.60 when pwrite() had been first introduced - 23 years ago is more
than enough to have it cast in stone.  We do allow pwrite(2) with O_APPEND
and on such descriptors it acts like write(2) on the same.

> Now, splice() is able to do *both* write() and pwrite(), because
> unlike pwrite() it doesn't take a "pos" argument, it takes a _pointer_
> to pos. So with a NULL pointer, it's like read/write, and with a
> non-NULL pointer it is like pread/pwrite.
> 
> So I do think that "splice with non-NULL off_out and O_APPEND" should
> cause an error in general.

splice() triggers an error for seekable destination with O_APPEND and
with NULL off_out.  Same for splice() to socket with
	fcntl(sock_fd, F_SETFL, O_APPEND);
done first.
 
> Honestly, I don't think it's a huge deal. O_APPEND isn't that
> interesting, but I do hope that if we allow O_APPEND and a file
> position, then O_APPEND always overrides it.

It does, when it is allowed.
