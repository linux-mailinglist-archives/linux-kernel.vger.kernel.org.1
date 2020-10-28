Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D529E2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJ1VfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:35:22 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38078 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgJ1VfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:15 -0400
Date:   Wed, 28 Oct 2020 12:49:36 -0400
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
Message-ID: <20201028164936.GC534@brightrain.aerifal.cx>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> +luto just in case he has opinions on this
> 
> On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > From my understanding, there is no way to delay the activation of
> > seccomp filters, for instance "until an _execve_ call".
> 
> (FWIW, there are some tricks that you can use for this. In particular,
> you can attach to the child with ptrace before the child runs
> execve(), and then use seccomp to inject a filter after execve(), or
> something like that. The disadvantage is that this is not super pretty
> because it interferes with debugging of the parent process. IIRC e.g.
> Ubuntu's launchd did things this way.)

Yes, in principle everything seccomp does could have been done with
ptrace but the whole point was not to use ptrace as a primitive to
build hacks upon. So this is not a good solution.

> > But this might be useful, especially for tools who sandbox other,
> > non-cooperative, executables, such as "systemd" or "FireJail".
> >
> > It seems to be a caveat of seccomp specific to the system call
> > _execve_. For now, some tools such as "systemd" explicitly mention
> > this exception, and do not support it (from the man page):
> > > Note that strict system call filters may impact execution and
> > > error handling code paths of the service invocation.
> > > Specifically, access to the execve system call is required for
> > > the execution of the service binary — if it is blocked service
> > > invocation will necessarily fail
> >
> > "FireJail" takes a different approach[1], with a kind of workaround:
> > the project uses an external library to be loaded through LD_PRELOAD
> > mechanism, in order to install filters during the loader stage.
> > This approach, a bit hacky, also has several caveats:
> > * _openat_, _mmap_, etc. must be allowed in order to reach the
> > LD_PRELOAD mechanism, and for the crafted library to work ;
> 
> Those caveats are not specific to the LD_PRELOAD approach. Actually,
> the LD_PRELOAD approach is the only one which I would expect to *not*
> have that caveat. (Of course, non-executable mmap() and probably also
> openat() are anyway needed for almost any real-world service to do its
> job correctly.)
> 
> > * it doesn't work for static binaries.
> 
> IMO the important thing about LD_PRELOAD is that it is unreliable:
> When the LD_PRELOAD library can't be opened, glibc just prints a
> warning and continues execution - and an attacker may be able to cause
> opening an LD_PRELOAD library to fail by opening so many files in
> other processes that the global limit is reached. So you can't build
> reliable security infrastructure on LD_PRELOAD. This is not a
> fundamental problem though - glibc could address this.

Using LD_PRELOAD for security infrastructure is a really bad idea
anyway. There are nearly unboundedly many ways code could end up
executing before the preloaded ctors. Preinit arrays, malformed ELF
headers seizing control of execution of ldso, etc. The seccomp filters
really need to be in place *before* the untrusted code runs.

> > I only see hackish ways to restrict the use of _execve_ in a
> > non-cooperative executable. These methods seem globally bypassables
> > and not satisfactory from a security point of view.
> 
> You're just focusing on execve() - I think it's important to keep in
> mind what happens after execve() for normal, dynamically-linked
> binaries: The next step is that the dynamic linker runs, and it will
> poke around in the file system with access() and openat() and fstat(),
> it will mmap() executable libraries into memory, it will mprotect()
> some memory regions, it will set up thread-local storage (e.g. using
> arch_prctl(); even if the process is single-threaded), and so on.
> 
> The earlier you install the seccomp filter, the more of these steps
> you have to permit in the filter. And if you want the filter to take
> effect directly after execve(), the syscalls you'll be forced to
> permit are sufficient to cobble something together in userspace that
> effectively does almost the same thing as execve().

I would assume you use SECCOMP_RET_USER_NOTIF to implement policy for
controlling these operations and allowing only the ones that are valid
during dynamic linking. This also allows you to defer application of
the filter until after execve. So unless I'm missing some reason why
this doesn't work, I think the requested functionality is already
available.

If you really just want the "activate at exec" behavior, it might be
possible (depending on how SECCOMP_RET_USER_NOTIF behaves when there's
no notify fd open; I forget) to setup the filter so that the "mode
switch" happens automatically at exec by having the notify fd being
close-on-exec (notifications handled by a thread before exec). If this
works it would avoid having an extra process involved and managing its
lifetime.

> Your usecase might be better served by adding a glibc feature for
> "unskippable LD_PRELOAD" paired with a constructor function, or
> something along those lines.

I don't think this can be made into a safe security boundary.

> > and have the very firsts
> > instructions of potentially untrusted binaries already subject to
> > seccomp filters.
> 
> By "untrusted", do you mean "actively malicious" or "exploitable"? If
> they are just exploitable, you probably don't need to apply filters
> from the first instruction, only from when the buggy code actually
> starts running and parsing input.
> If they are actively malicious, it'd be a different story; but as far
> as I know, normally even if a service has been compromised, its
> executables and libraries are owned by root, and so an attacker
> shouldn't be able to overwrite those.
> (And you could apply a basic filter before execve and then add some
> finer restrictions for things like mmap() at a later point.)

This distinction is probably over-rated. Certainly there's a lot of
software (see the example of systemd) that's on a spectrum between
"actively malicious" and "actively doing things that the developers
don't intend or perceive as malicious but that the user does, and that
would be harmful to their system if allowed to execute outside of the
sandbox". This also applies to things like games with invasive/spyware
anti-cheat features, proprietary software with license manager
interactions, etc.

Rich
