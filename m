Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9452C2EA018
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhADWji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 17:39:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42417 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbhADWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:39:38 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-281-CM56XzXDPwKrUvpunGmZUQ-1; Mon, 04 Jan 2021 22:34:48 +0000
X-MC-Unique: CM56XzXDPwKrUvpunGmZUQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 4 Jan 2021 22:34:48 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 4 Jan 2021 22:34:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: RE: in_compat_syscall() on x86
Thread-Topic: in_compat_syscall() on x86
Thread-Index: AQHW4tnp52+Fp/HYSH2MXxqk00t/OqoYCInQ
Date:   Mon, 4 Jan 2021 22:34:48 +0000
Message-ID: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
References: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
        <20210104165827.GJ3579531@ZenIV.linux.org.uk>
 <87sg7gfnaa.fsf@x220.int.ebiederm.org>
In-Reply-To: <87sg7gfnaa.fsf@x220.int.ebiederm.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman
> Sent: 04 January 2021 20:41
> 
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Mon, Jan 04, 2021 at 12:16:56PM +0000, David Laight wrote:
> >> On x86 in_compat_syscall() is defined as:
> >>     in_ia32_syscall() || in_x32_syscall()
> >>
> >> Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
> >> However in_x32_syscall() is a horrid beast that has to indirect
> >> through to the original %eax value (ie the syscall number) and
> >> check for a bit there.
> >>
> >> So on a kernel with x32 support (probably most distro kernels)
> >> the in_compat_syscall() check is rather more expensive than
> >> one might expect.
> 
> I suggest you check the distro kernels.  I suspect they don't compile in
> support for x32.  As far as I can tell x32 is an undead beast of a
> subarchitecture that just enough people use that it can't be removed,
> but few enough people use it likely has a few lurking scary bugs.

It is defined in the Ubuntu kernel configs I've got lurking:
Both 3.8.0-19_generic (Ubuntu 13.04) and 5.4.0-56_generic (probably 20.04).
Which is probably why it is in my test builds (I've just cut out
a lot of modules).

> >> It would be muck better if both checks could be done together.
> >> I think this would require the syscall entry code to set a
> >> value in both the 64bit and x32 entry paths.
> >> (Can a process make both 64bit and x32 system calls?)
> >
> > Yes, it bloody well can.
> >
> > And I see no benefit in pushing that logics into syscall entry,
> > since anything that calls in_compat_syscall() more than once
> > per syscall execution is doing the wrong thing.  Moreover,
> > in quite a few cases we don't call the sucker at all, and for
> > all of those pushing that crap into syscall entry logics is
> > pure loss.
> 
> The x32 system calls have their own system call table and it would be
> trivial to set a flag like TS_COMPAT when looking up a system call from
> that table.  I expect such a change would be purely in the noise.

Certainly a write of 0/1/2 into a dirtied cache line of 'current'
could easily cost absolutely nothing.
Especially if current has already been read.

I also wondered about resetting it to zero when an x32 system call
exits (rather than entry to a 64bit one).

For ia32 the flag is set (with |=) on every syscall entry.
Even though I'm pretty sure it can only change during exec.

> > What's the point, really?
> 
> Before we came up with the current games with __copy_siginfo_to_user
> and x32_copy_siginfo_to_user I was wondering if we should make such
> a change.  The delivery of compat signal frames and core dumps which
> do not go through the system call entry path could almost benefit from
> a flag that could be set/tested when on those paths.

For signal delivery it should (probably) depend on the system call
that setup the signal handler.
Although I'm sure I remember one kernel where some of it was done
in libc (with a single entrypoint for all hadlers).

> The fact that only SIGCHLD (which can not trigger a coredump) is
> different saves the coredump code from needing such a test.
> 
> The fact that the signal frame code is simple enough it can directly
> call x32_copy_siginfo_to_user or __copy_siginfo_to_user saves us there.
> 
> So I don't think we have any cases where we actually need a flag that
> is independent of the system call but we have come very close.

If a program can do both 64bit and x32 system calls you probably
need to generate a 64bit core dump if it has ever made a 64bit
system call??

> For people who want to optimize I suggest tracking down the handful of
> users of x32 and see if x32 can be made to just go away.

Unlikely since Ubuntu seem to have enabled it for years.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

