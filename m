Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9392FDDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392894AbhAUAQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390992AbhATXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:16:56 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6209C061349
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:14:49 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2MgR-0041Ne-2x; Wed, 20 Jan 2021 23:14:39 +0000
Date:   Wed, 20 Jan 2021 23:14:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210120231439.GE740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:27:26AM -0800, Linus Torvalds wrote:
> On Wed, Jan 20, 2021 at 11:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Why do we care about O_APPEND on anything without FMODE_PWRITE (including
> > pipes), anyway?  All writes there ignore position, after all...
> 
> We shouldn't care.
> 
> Also, I think we should try to move away from FMODE_PWRITE/PREAD
> entirely, and use FMODE_STREAM as the primary "this thing doesn't have
> a position at all".
> 
> That's what gets rid of all the f_pos locking etc after all. The
> FMODE_PWRITE/PREAD flags are I think legacy (although we do seem to
> have the seq_file case that normally allows position on reads, but not
> on writes, so we may need to keep all three bits).

Umm...  Why do we clear FMODE_PWRITE there, anyway?  It came in
commit 915a29ec1c5e34283a6231af1036114e4d612cb0
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Sat Aug 7 02:08:23 2004 -0700

    Add pread/pwrite support bits to match the lseek bit.
    
    This also removes the ESPIPE logic from pipes and seq_files,
    since the VFS layer now supports it.

with seq_read() losing the special-cased pread prevention and
seq_open() getting a ban on both pread and pwrite.  With
pread() support added in 2009, and (pointless) pwrite prohibition
left in place.
