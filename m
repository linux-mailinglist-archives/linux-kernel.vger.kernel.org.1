Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E712A20B2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKASID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:32954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgKASIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:08:02 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9FA22253
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254082;
        bh=OfBjCIPtc0TxbS1/4RHTocGxkKTL3vnRTUDz7fBxN1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ECSincphbOM5qbSu3Xdc6BUpyip/6hXudBbbPlAJm8riQGC6eQ60ewr48wfyZIStO
         1hd8Y7QABAoZY/PQ3+O91ngG/ORXZQYzClemLRo0Jg1zvBTIU9kVlgbfzELq2lBsvH
         UyDyOe/bxmlP0z9RKlZDIXyeOXFEmpT80xEoMkJY=
Received: by mail-wr1-f48.google.com with SMTP id n15so12033086wrq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 10:08:01 -0800 (PST)
X-Gm-Message-State: AOAM531LealxlE3k35J2ZPSHpB3Hq4n0yD3T2CwmqaEiHWh0/OIVssQ6
        ijHhKEBlylSTEMWoqo8GHJ8P0zqMHgmTURY7G6IZWw==
X-Google-Smtp-Source: ABdhPJwNmxbNxAUXbrn41Qe7+wawCb/dKKHipu5/XiWdwZEDvnJGpaWgv5/MFRybgjV/Vu0tMFAI6HYHlE/q/5vUafw=
X-Received: by 2002:adf:e682:: with SMTP id r2mr15522981wrm.184.1604254080252;
 Sun, 01 Nov 2020 10:08:00 -0800 (PST)
MIME-Version: 1.0
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com> <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx> <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
In-Reply-To: <20201101015013.GN534@brightrain.aerifal.cx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 1 Nov 2020 10:07:48 -0800
X-Gmail-Original-Message-ID: <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
Message-ID: <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
To:     Rich Felker <dalias@libc.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-x86_64@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 6:50 PM Rich Felker <dalias@libc.org> wrote:
>
> On Sun, Nov 01, 2020 at 01:27:35AM +0000, Jessica Clarke wrote:
> > On 1 Nov 2020, at 01:22, Rich Felker <dalias@libc.org> wrote:
> > > On Sat, Oct 31, 2020 at 04:30:44PM -0700, Andy Lutomirski wrote:
> > >> cc: some libc folks
> > >>
> > >> On Mon, Oct 12, 2020 at 6:45 AM Jessica Clarke <jrtc27@jrtc27.com> w=
rote:
> > >>>
> > >>> POSIX specifies that the first field of the supplied msgp, namely m=
type,
> > >>> is a long, not a __kernel_long_t, and it's a user-defined struct du=
e to
> > >>> the variable-length mtext field so we can't even bend the spec and =
make
> > >>> it a __kernel_long_t even if we wanted to. Thus we must use the com=
pat
> > >>> syscalls on x32 to avoid buffer overreads and overflows in msgsnd a=
nd
> > >>> msgrcv respectively.
> > >>
> > >> This is a mess.
> > >>
> > >> include/uapi/linux/msg.h has:
> > >>
> > >> /* message buffer for msgsnd and msgrcv calls */
> > >> struct msgbuf {
> > >>        __kernel_long_t mtype;          /* type of message */
> > >>        char mtext[1];                  /* message text */
> > >> };
> > >>
> > >> Your test has:
> > >>
> > >> struct msg_long {
> > >>    long mtype;
> > >>    char mtext[8];
> > >> };
> > >>
> > >> struct msg_long_ext {
> > >>    struct msg_long msg_long;
> > >>    char mext[4];
> > >> };
> > >>
> > >> and I'm unclear as to exactly what you're trying to do there with th=
e
> > >> "mext" part.
> > >>
> > >> POSIX says:
> > >>
> > >>       The application shall ensure that the argument msgp points to =
 a  user-
> > >>       defined  buffer that contains first a field of type long speci=
fying the
> > >>       type of the message, and then a data portion that holds the da=
ta  bytes
> > >>       of the message. The structure below is an example of what this=
 user-de=E2=80=90
> > >>       fined buffer might look like:
> > >>
> > >>           struct mymsg {
> > >>               long   mtype;       /* Message type. */
> > >>               char   mtext[1];    /* Message text. */
> > >>           }
> > >>
> > >> NTP has this delightful piece of code:
> > >>
> > >>   44 typedef union {
> > >>   45   struct msgbuf msgp;
> > >>   46   struct {
> > >>   47     long mtype;
> > >>   48     int code;
> > >>   49     struct timeval tv;
> > >>   50   } msgb;
> > >>   51 } MsgBuf;
> > >>
> > >> bluefish has:
> > >>
> > >> struct small_msgbuf {
> > >> long mtype;
> > >> char mtext[MSQ_QUEUE_SMALL_SIZE];
> > >> } small_msgp;
> > >>
> > >>
> > >> My laptop has nothing at all in /dev/mqueue.
> > >>
> > >> So I don't really know what the right thing to do is.  Certainly if
> > >> we're going to apply this patch, we should also fix the header.  I
> > >> almost think we should *delete* struct msgbuf from the headers, sinc=
e
> > >> it's all kinds of busted, but that will break the NTP build.  Ideall=
y
> > >> we would go back in time and remove it from the headers.
> > >>
> > >> Libc people, any insight?  We can probably fix the bug without
> > >> annoying anyone given how lightly x32 is used and how lightly POSIX
> > >> message queues are used.
> > >
> > > If it's that outright wrong and always has been, I feel like the old
> > > syscall numbers should just be deprecated and new ones assigned.
> > > Otherwise, there's no way for userspace to be safe against data
> > > corruption when run on older kernels. If there's a new syscall number=
,
> > > libc can just use the new one unconditionally (giving ENOSYS on
> > > kernels where it would be broken) or have a x32-specific
> > > implementation that makes the old syscall and performs translation if
> > > the new one fails with ENOSYS.
> >
> > That doesn't really help broken code continue to work reliably, as
> > upgrading libc will just pull in the new syscall for a binary that's
> > expecting the broken behaviour, unless you do symbol versioning, but
> > then it'll just break when you next recompile the code, and there's no
> > way for that to be diagnosed given the *application* has to define the
> > type. But given it's application-defined I really struggle to see how
> > any code out there is actually expecting the current x32 behaviour as
> > you'd have to go really out of your way to find out that x32 is broken
> > and needs __kernel_long_t. I don't think there's any way around just
> > technically breaking ABI whilst likely really fixing ABI in 99.999% of
> > cases (maybe 100%).
>
> I'm not opposed to "breaking ABI" here because the current syscall
> doesn't work unless someone wrote bogus x32-specific code to work
> around it being wrong. I don't particularly want to preserve any of
> the current behavior.
>
> What I am somewhat opposed to is making a situation where an updated
> libc can't be safe against getting run on a kernel with a broken
> version of the syscall and silently corrupting data. I'm flexible
> about how avoiding tha tis achieved.

If we're sufficiently confident that we won't regress anything by
fixing the bug, I propose we do the following.  First, we commit a fix
that's Jessica's patch plus a fix to struct msghdr, and we mark that
for -stable.  Then we commit another patch that removes 'struct
msghdr' from uapi entirely, but we don't mark that for -stable.  If
people complain about the latter, we revert it.

After all, we could argue that the x32 bug here isn't really that
different from any of the huge number of various syscall bugs we've
had in the past and should just be fixed in the kernel.  If you run
user programs on a buggy kernel, you get buggy behavior...

--Andy
