Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEF2B978F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgKSQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:15:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKSQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:15:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DFCF21F45A30
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Rich Felker <dalias@libc.org>
Cc:     libc-alpha@sourceware.org, Florian Weimer <fw@deneb.enyo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel prctl feature for syscall interception and emulation
Organization: Collabora
References: <873616v6g9.fsf@collabora.com>
        <20201119151317.GF534@brightrain.aerifal.cx>
Date:   Thu, 19 Nov 2020 11:15:46 -0500
In-Reply-To: <20201119151317.GF534@brightrain.aerifal.cx> (Rich Felker's
        message of "Thu, 19 Nov 2020 10:13:18 -0500")
Message-ID: <87h7pltj9p.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Felker <dalias@libc.org> writes:

> On Wed, Nov 18, 2020 at 01:57:26PM -0500, Gabriel Krisman Bertazi via Libc-alpha wrote:

[...]

>
> SIGSYS (or signal handling in general) is not the right way to do
> this. It has all the same problems that came up in seccomp filtering
> with SIGSYS, and which were solved by user_notif mode (running the
> interception in a separate thread rather than an async context
> interrupting the syscall. In fact I wouldn't be surprised if what you
> want can already be done with reasonable efficiency using seccomp
> user_notif.

Hi Rich,

User_notif was raised in the kernel discussion and we had experimented
with it, but the latency of user_notif is even worse than what we can do
right now with other seccomp actions.

Regarding SIGSYS, the x86 maintainer suggested redirecting the syscall
return to a userspace thunk, but the understanding among Wine developers
is that SIGSYS is enough for their emulation needs.

> The default-intercept and excepting libc code segment is also bogus,
> and will break stuff, including vdso syscall mechanism on i386 and any
> code outside libc that makes its own syscalls from asm. If you need to
> tag regions to control interception, it should be tagging the emulated
> Windows guest code, which is bounded and you have full control over,
> rather than the host code, which is unbounded and includes any
> libraries that get linked indirectly by Wine.

The vdso trampoline, for the architectures that have it, is solved by
the kernel implementation, who makes sure that region is allowed.

The Linux code is not bounded, but the dispatcher region main goal is to
support trampolines outside of the vdso case. The correct userspace
implementation requires flipping the selector on any Windows/Linux code
boundary cross, exactly because other libraries can issue syscalls
directly.  The fact that libc is not the only one issuing syscalls is
the exact reason we need something more complex than a few seccomp
filters.

Flipping the selector on every boundary crosses is fine for performance,
since we don't go into the kernel.  But if we can avoid checking it from
kernelspace, that's an optimization, which is what I meant by the
dispatcher region allowing the more parts of the glibc code.  That's
just an optimization, but not strictly necessary for correctness.

I still don't think anything is broken here.

> But I'm skeptical that doing any new kernel-side logic for tagging is
> needed. Seccomp already lets you filter on instruction pointer so you
> can install filters that will trigger user_notif just for guest code,
> then let you execute the emulation in the watcher thread and skip the
> actual syscall in the watched thread.

As I mentioned, we can check IP in seccomp and write filters.  But this
has two problems:

1) Performance.  seccomp filters use cBPF which means 32bit comparisons,
no maps and a very limited instruction set.  We need to generate
boundary checks for each memory segment.  The filter becomes very large
very quickly and becomes a observable bottleneck.

2) Seccomp filters cannot be removed.  And we'd need to update them
frequently.

-- 
Gabriel Krisman Bertazi
