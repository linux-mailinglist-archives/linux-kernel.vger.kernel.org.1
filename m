Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9D2A1BA1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 02:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKABuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:50:17 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:39112 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKABuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:50:17 -0400
Date:   Sat, 31 Oct 2020 21:50:14 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
Message-ID: <20201101015013.GN534@brightrain.aerifal.cx>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 01:27:35AM +0000, Jessica Clarke wrote:
> On 1 Nov 2020, at 01:22, Rich Felker <dalias@libc.org> wrote:
> > On Sat, Oct 31, 2020 at 04:30:44PM -0700, Andy Lutomirski wrote:
> >> cc: some libc folks
> >> 
> >> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >>> 
> >>> POSIX specifies that the first field of the supplied msgp, namely mtype,
> >>> is a long, not a __kernel_long_t, and it's a user-defined struct due to
> >>> the variable-length mtext field so we can't even bend the spec and make
> >>> it a __kernel_long_t even if we wanted to. Thus we must use the compat
> >>> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
> >>> msgrcv respectively.
> >> 
> >> This is a mess.
> >> 
> >> include/uapi/linux/msg.h has:
> >> 
> >> /* message buffer for msgsnd and msgrcv calls */
> >> struct msgbuf {
> >>        __kernel_long_t mtype;          /* type of message */
> >>        char mtext[1];                  /* message text */
> >> };
> >> 
> >> Your test has:
> >> 
> >> struct msg_long {
> >>    long mtype;
> >>    char mtext[8];
> >> };
> >> 
> >> struct msg_long_ext {
> >>    struct msg_long msg_long;
> >>    char mext[4];
> >> };
> >> 
> >> and I'm unclear as to exactly what you're trying to do there with the
> >> "mext" part.
> >> 
> >> POSIX says:
> >> 
> >>       The application shall ensure that the argument msgp points to  a  user-
> >>       defined  buffer that contains first a field of type long specifying the
> >>       type of the message, and then a data portion that holds the data  bytes
> >>       of the message. The structure below is an example of what this user-de‐
> >>       fined buffer might look like:
> >> 
> >>           struct mymsg {
> >>               long   mtype;       /* Message type. */
> >>               char   mtext[1];    /* Message text. */
> >>           }
> >> 
> >> NTP has this delightful piece of code:
> >> 
> >>   44 typedef union {
> >>   45   struct msgbuf msgp;
> >>   46   struct {
> >>   47     long mtype;
> >>   48     int code;
> >>   49     struct timeval tv;
> >>   50   } msgb;
> >>   51 } MsgBuf;
> >> 
> >> bluefish has:
> >> 
> >> struct small_msgbuf {
> >> long mtype;
> >> char mtext[MSQ_QUEUE_SMALL_SIZE];
> >> } small_msgp;
> >> 
> >> 
> >> My laptop has nothing at all in /dev/mqueue.
> >> 
> >> So I don't really know what the right thing to do is.  Certainly if
> >> we're going to apply this patch, we should also fix the header.  I
> >> almost think we should *delete* struct msgbuf from the headers, since
> >> it's all kinds of busted, but that will break the NTP build.  Ideally
> >> we would go back in time and remove it from the headers.
> >> 
> >> Libc people, any insight?  We can probably fix the bug without
> >> annoying anyone given how lightly x32 is used and how lightly POSIX
> >> message queues are used.
> > 
> > If it's that outright wrong and always has been, I feel like the old
> > syscall numbers should just be deprecated and new ones assigned.
> > Otherwise, there's no way for userspace to be safe against data
> > corruption when run on older kernels. If there's a new syscall number,
> > libc can just use the new one unconditionally (giving ENOSYS on
> > kernels where it would be broken) or have a x32-specific
> > implementation that makes the old syscall and performs translation if
> > the new one fails with ENOSYS.
> 
> That doesn't really help broken code continue to work reliably, as
> upgrading libc will just pull in the new syscall for a binary that's
> expecting the broken behaviour, unless you do symbol versioning, but
> then it'll just break when you next recompile the code, and there's no
> way for that to be diagnosed given the *application* has to define the
> type. But given it's application-defined I really struggle to see how
> any code out there is actually expecting the current x32 behaviour as
> you'd have to go really out of your way to find out that x32 is broken
> and needs __kernel_long_t. I don't think there's any way around just
> technically breaking ABI whilst likely really fixing ABI in 99.999% of
> cases (maybe 100%).

I'm not opposed to "breaking ABI" here because the current syscall
doesn't work unless someone wrote bogus x32-specific code to work
around it being wrong. I don't particularly want to preserve any of
the current behavior.

What I am somewhat opposed to is making a situation where an updated
libc can't be safe against getting run on a kernel with a broken
version of the syscall and silently corrupting data. I'm flexible
about how avoiding tha tis achieved.

Rich
