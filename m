Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559DF29EDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgJ2N4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:56:19 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38314 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgJ2N4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:56:18 -0400
Date:   Thu, 29 Oct 2020 09:56:17 -0400
From:   Rich Felker <dalias@libc.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        Camille Mougey <commial@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <20201029135614.GM534@brightrain.aerifal.cx>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <202010281503.3D1FCFE0@keescook>
 <20201029075841.GB29881@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029075841.GB29881@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:58:42AM +0000, Sargun Dhillon wrote:
> A mechanism for the thing listening on the listener FD to turn itself on or off 
> and indicate that it is no longer interested in receiving notifications and to 
> always continue / return an error code, or that it has taken an interest now, 
> and it would like to return to handling these events. The idea of an action 
> other than ENOSYS (specifically SECCOMP_USER_NOTIF_FLAG_CONTINUE) if the 
> listener goes away is attractive as well, in case the supervisor crashes. EPERM 
> is somewhat "cleaner" of an error code than ENOSYS (most people don't write 
> handling for ENOSYS on connect).

This is a common misconception that really needs to be addressed.
EPERM is not a suitable error code for as-yet-unknown seccomp-blocked
syscalls, and is not suitable for a large portion of currently known
ones either. It use has actively broken lots of things that would have
worked fine with ENOSYS returned. This is because a caller will react
to ENOSYS by attempting to do whatever it wanted to do in another way,
one which your policy might handlle better (for example, if your
filter is outdated and blocking clock_gettime64 but not clock_gettime,
or blocking statx but not stat64) while it will react to EPERM as an
indication that your filter understands the abstract operation it was
trying to perform and considers that action forbidden. We hit issues
like this with virtually every seccomp-using application while moving
to time64 because the wrong idiom is so widespread, and further vdso
prevented it from being caught right away (only users without vdso hit
it later).

From a standards perspective (and thus of programming to them), POSIX
does permit implementations to define additional errors for any
interface that already has errors defined, but does not permit
overloading the standard errors defined, so if EPERM is already
defined for an interface, returning it is probably not ok. (IMO it is
defensible if the seccomp policy can be thought of as an extension of
the permission model that would cause the standaed EPERM, but it's not
defensible if the policy is just "we don't know about this syscall
yet" since the syscall might just be a new/better way of implementing
some existing operation that makes the policy appear inconsistent.)

In your example of connect, I think either is semantically defensible;
one is "you lack suitable privilege to perform the operation" and the
other is "you're running on a type of system that doesn't have socket
connect functionality" (because it's a minimal execution environment).

Rich
