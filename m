Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279FF2B97F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKSQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:28:07 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:48318 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgKSQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:28:04 -0500
Date:   Thu, 19 Nov 2020 11:28:02 -0500
From:   Rich Felker <dalias@libc.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     libc-alpha@sourceware.org, Florian Weimer <fw@deneb.enyo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel prctl feature for syscall interception and emulation
Message-ID: <20201119162801.GH534@brightrain.aerifal.cx>
References: <873616v6g9.fsf@collabora.com>
 <20201119151317.GF534@brightrain.aerifal.cx>
 <87h7pltj9p.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7pltj9p.fsf@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:15:46AM -0500, Gabriel Krisman Bertazi wrote:
> Rich Felker <dalias@libc.org> writes:
> 
> > On Wed, Nov 18, 2020 at 01:57:26PM -0500, Gabriel Krisman Bertazi via Libc-alpha wrote:
> 
> [...]
> 
> >
> > SIGSYS (or signal handling in general) is not the right way to do
> > this. It has all the same problems that came up in seccomp filtering
> > with SIGSYS, and which were solved by user_notif mode (running the
> > interception in a separate thread rather than an async context
> > interrupting the syscall. In fact I wouldn't be surprised if what you
> > want can already be done with reasonable efficiency using seccomp
> > user_notif.
> 
> Hi Rich,
> 
> User_notif was raised in the kernel discussion and we had experimented
> with it, but the latency of user_notif is even worse than what we can do
> right now with other seccomp actions.

Is there a compelling argument that the latency matters here? What
syscalls are windows binaries making like this? Is there a reason you
can't do something like intercepting the syscall with seccomp the
first time it happens, then rewriting the code not to use a direct
syscall on future invocations?

> Regarding SIGSYS, the x86 maintainer suggested redirecting the syscall
> return to a userspace thunk, but the understanding among Wine developers
> is that SIGSYS is enough for their emulation needs.

It might work for Wine needs, if Wine can guarantee it will never be
running code with signals blocked and some other constraints, but then
you end up with a mechanism that's designed just for Wine and that
will have gratuitous reasons it's not usable elsewhere. That does not
seem appropriate for inclusion in kernel.

> > The default-intercept and excepting libc code segment is also bogus,
> > and will break stuff, including vdso syscall mechanism on i386 and any
> > code outside libc that makes its own syscalls from asm. If you need to
> > tag regions to control interception, it should be tagging the emulated
> > Windows guest code, which is bounded and you have full control over,
> > rather than the host code, which is unbounded and includes any
> > libraries that get linked indirectly by Wine.
> 
> The vdso trampoline, for the architectures that have it, is solved by
> the kernel implementation, who makes sure that region is allowed.

I guess that works but it's ugly and assumes particular policy goals
matching Wine's rather than being a general mechanism.

> The Linux code is not bounded, but the dispatcher region main goal is to
> support trampolines outside of the vdso case. The correct userspace
> implementation requires flipping the selector on any Windows/Linux code
> boundary cross, exactly because other libraries can issue syscalls
> directly.  The fact that libc is not the only one issuing syscalls is
> the exact reason we need something more complex than a few seccomp
> filters.

I don't think this is correct. Rather than listing all the host
library code ranges to allow, you just list all the guest Windows code
ranges to intercept. Wine knows them by virtue of being the loader for
them. This all seems really easy to do with seccomp with a very small
filter.

> > But I'm skeptical that doing any new kernel-side logic for tagging is
> > needed. Seccomp already lets you filter on instruction pointer so you
> > can install filters that will trigger user_notif just for guest code,
> > then let you execute the emulation in the watcher thread and skip the
> > actual syscall in the watched thread.
> 
> As I mentioned, we can check IP in seccomp and write filters.  But this
> has two problems:
> 
> 1) Performance.  seccomp filters use cBPF which means 32bit comparisons,
> no maps and a very limited instruction set.  We need to generate
> boundary checks for each memory segment.  The filter becomes very large
> very quickly and becomes a observable bottleneck.

This sounds like you're doing something wrong. Range checking is O(log
n) and n cannot be large enough to make log n significant. If you do
it with a linear search rather than binary then of course it's slow.

> 2) Seccomp filters cannot be removed.  And we'd need to update them
> frequently.

What are the updating requirements?

I'm not sure if Windows code is properly PIC or not, but if it is,
then you just do your own address assignment in a single huge range
(first allocated with PROT_NONE, then MAP_FIXED over top of it) so
that a single static range check suffices.

Rich
