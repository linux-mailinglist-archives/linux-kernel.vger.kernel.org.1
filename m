Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C4C29E2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404423AbgJ2CWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:22:46 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38082 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgJ1VfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:23 -0400
Date:   Wed, 28 Oct 2020 14:35:11 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     Camille Mougey <commial@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <20201028183511.GE534@brightrain.aerifal.cx>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
 <20201028164936.GC534@brightrain.aerifal.cx>
 <CAG48ez2rC1OKYMM6eG4Fyq2xvTit6t3PUY0VE8A56EAqNmEVzg@mail.gmail.com>
 <20201028175241.GD534@brightrain.aerifal.cx>
 <CAG48ez3aSn2HSWuO0bhrRSFr_EPqkqshspsqiDZX+aYSpHnjOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3aSn2HSWuO0bhrRSFr_EPqkqshspsqiDZX+aYSpHnjOA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:25:45PM +0100, Jann Horn wrote:
> On Wed, Oct 28, 2020 at 6:52 PM Rich Felker <dalias@libc.org> wrote:
> > On Wed, Oct 28, 2020 at 06:34:56PM +0100, Jann Horn wrote:
> > > On Wed, Oct 28, 2020 at 5:49 PM Rich Felker <dalias@libc.org> wrote:
> > > > On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> > > > > On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > > > > You're just focusing on execve() - I think it's important to keep in
> > > > > mind what happens after execve() for normal, dynamically-linked
> > > > > binaries: The next step is that the dynamic linker runs, and it will
> > > > > poke around in the file system with access() and openat() and fstat(),
> > > > > it will mmap() executable libraries into memory, it will mprotect()
> > > > > some memory regions, it will set up thread-local storage (e.g. using
> > > > > arch_prctl(); even if the process is single-threaded), and so on.
> > > > >
> > > > > The earlier you install the seccomp filter, the more of these steps
> > > > > you have to permit in the filter. And if you want the filter to take
> > > > > effect directly after execve(), the syscalls you'll be forced to
> > > > > permit are sufficient to cobble something together in userspace that
> > > > > effectively does almost the same thing as execve().
> > > >
> > > > I would assume you use SECCOMP_RET_USER_NOTIF to implement policy for
> > > > controlling these operations and allowing only the ones that are valid
> > > > during dynamic linking. This also allows you to defer application of
> > > > the filter until after execve. So unless I'm missing some reason why
> > > > this doesn't work, I think the requested functionality is already
> > > > available.
> > >
> > > Ah, yeah, good point.
> > >
> > > > If you really just want the "activate at exec" behavior, it might be
> > > > possible (depending on how SECCOMP_RET_USER_NOTIF behaves when there's
> > > > no notify fd open; I forget)
> > >
> > > syscall returns -ENOSYS. Yeah, that'd probably do the job. (Even
> > > though it might be a bit nicer if userspace had control over the errno
> > > there, such that it could be EPERM instead... oh well.)
> >
> > EPERM is a major bug in current sandbox implementations, so ENOSYS is
> > at least mildly better, but indeed it should be controllable, probably
> > by allowing a code path for the BPF to continue with a jump to a
> > different logic path if the notify listener is missing.
> 
> I guess we might be able to expose the listener status through a bit /
> a field in the struct seccomp_data, and then filters could branch on
> that. (And the kernel would run the filter twice if we raced with
> filter detachment.) I don't know whether it would look pretty, but I
> think it should be doable...

I was thinking the race wouldn't be salvagable, but indeed since the
filter is side-effect-free you can just re-run it if the status
changes between start of filter processing and the attempt at
notification. This sounds like it should work.

I guess it's not possible to chain two BPF filters to do this, because
that only works when the first one allows? Or am I misunderstanding
the multiple-filters case entirely? (I've never gotten that far with
programming it.)

Rich
