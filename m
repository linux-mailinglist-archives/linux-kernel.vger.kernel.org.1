Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778EB2EA1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhAEA5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbhAEA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:57:48 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00592C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:57:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwaei-006vbx-1c; Tue, 05 Jan 2021 00:57:00 +0000
Date:   Tue, 5 Jan 2021 00:57:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
Subject: Re: in_compat_syscall() on x86
Message-ID: <20210105005700.GR3579531@ZenIV.linux.org.uk>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
 <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
 <87mtxodxat.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtxodxat.fsf@x220.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 06:47:38PM -0600, Eric W. Biederman wrote:
> >> It is defined in the Ubuntu kernel configs I've got lurking:
> >> Both 3.8.0-19_generic (Ubuntu 13.04) and 5.4.0-56_generic (probably 20.04).
> >> Which is probably why it is in my test builds (I've just cut out
> >> a lot of modules).
> 
> Interesting.  That sounds like something a gentle prod to the Ubuntu
> kernel team might get them to disable.  Especially if there are not any
> x32 binaries in sight.

What for?

> The core dump code is currently tied to what binary you exec.
> The code in exec sets mm->binfmt, and the coredump code uses mm->binfmt
> to pick the coredump handler.
> 
> An x32 binary will make all kinds of 64bit calls where it doesn't need
> the compat handling.  And of course x32 binaries run in 64bit mode with
> 32bit pointers so looking at the current execution mode doesn't help.
> 
> Further fun compat_binfmt_elf is shared between x32 and ia32, because
> except for a few stray places they do exactly the same thing.

FWIW, there's a series cleaning that crap up nicely; as a side benefit,
it converts both compats on mips (o32 and n32) to regular compat_binfmt_elf.c
Yes, the current mainline is bloody awful in that area (PRSTATUS_SIZE and
SET_PR_FPVALID are not for weak stomach), but that's really not hard to
get into sane shape - -next had that done in last cycle and I'm currently
testing (well, building the test kernel) of port of that to 5.11-rc1.

I really don't see the point of getting rid of x32 - mips n32 is *not*
going away, and that's an exact parallel.

PS: if anything, I wonder if we would better off with binfmt_elf{64,32}.o,
built from fs/binfmt_elf.c; it's not that hard to do.  With arseloads
of weirdness going away if we do that...
