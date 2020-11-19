Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AD2B95DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKSPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:13:19 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:48266 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:13:19 -0500
Date:   Thu, 19 Nov 2020 10:13:18 -0500
From:   Rich Felker <dalias@libc.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     libc-alpha@sourceware.org, Florian Weimer <fw@deneb.enyo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel prctl feature for syscall interception and emulation
Message-ID: <20201119151317.GF534@brightrain.aerifal.cx>
References: <873616v6g9.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873616v6g9.fsf@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:57:26PM -0500, Gabriel Krisman Bertazi via Libc-alpha wrote:
> Hi,
> 
> I'm proposing a kernel patch for a feature I'm calling Syscall User
> Dispatch (SUD).  It is a mechanism to efficiently redirect system calls
> of only part of a binary back to userspace to be emulated by a
> compatibility layer.  The patchset is close to being accepted, but
> Florian suggested the feature might pose some constraints on glibc, and
> requested I raise the discussion here.
> 
> The problem I am trying to solve is that modern Windows games running
> over Wine are issuing Windows system calls directly from the Windows
> code, without going through the "WinAPI", which doesn't give Wine a
> chance to emulate the library calls and implement the behavior.  As a
> result, Windows syscalls reache the Linux kernel, and the kernel has
> no context to differentiate them from native syscalls coming from the
> Wine side, since it cannot trust the ABI, not even syscall numbers to be
> something sane.  Historically, Windows applications were very respectful
> of the WinAPI, not bypassing it, but we are seeing modern applications
> like games doing it more often for reasons, I believe, of DRM.
> 
> It is worth mentioning that, by design, Wine and the Windows application
> run on the same process space, so we really cannot just filter specific
> threads or the entire application. We need some kind of filter executed
> on each system call.
> 
> Now, the obvious way to solve this problem would be cBPF filtering
> memory regions, through Seccomp.  The main problem with that approach is
> the performance of executing a large cBPF filter.  The goal is to run
> games, and we observed the Seccomp filter become a bottleneck, since we
> have many, many memory areas that need to be checked by cBPF.  In
> addition, seccomp, as a security mechanism, doesn't support some filter
> update operations, like removing them.  Another approaches were
> explored, like making a new mode out of seccomp, but the kernel
> community preferred to make it a separate, self-contained mechanism.
> Other solutions, like (live) patching the Windows application are out
> of question, as they would trip DRM and anti-cheat protection
> mechanisms.
> 
> The SUD interface I proposed to the kernel community is self-contained
> and exposed as a prctl option.  It lets userspace define a switch
> variable per-thread that, when set, will raise a SIGSYS for any syscall
> attempted.  The idea is that Wine can just flip this switch efficiently
> before delivering control to the Windows portions of the binary, and
> flip it back off when it needs to execute native syscalls.  It is
> important for us that the switch flip doesn't require a syscall, for
> performance reasons.  The interface also lets userspace define a
> "dispatcher region" from where any syscalls are always executed,
> regardless of the selector variable.  This is important for the return
> of the SIGSYS directly to a Windows segment, where we need to execute
> the signal return trampoline with the selector blocked.  Ideally, Wine
> would simply define this dispatcher region as the entire libc code
> segment, and just use the selector to safe-guard against Linux libraries
> issuing syscalls by themselves (they exist).
> 
> I think my questions to libc are: what are the constraints, if any, that
> libc would face with this new interface?  I expected this to be
> completely invisible to libc.  In addition, are there any problems you
> foresee with the current interface?
> 
> Finally, I don't think it makes sense to bother you immediately with
> the kernel implementation patches, but if you want to see the them,
> they are archived in the link below.  I can also share them directly on
> this ML if you request it.
> 
>   https://lkml.org/lkml/2020/11/17/2347
> 
> Nevertheless, I think it is useful the share the final patch, that has
> the in-tree documentation for the interface, which I inlined in this
> message.

SIGSYS (or signal handling in general) is not the right way to do
this. It has all the same problems that came up in seccomp filtering
with SIGSYS, and which were solved by user_notif mode (running the
interception in a separate thread rather than an async context
interrupting the syscall. In fact I wouldn't be surprised if what you
want can already be done with reasonable efficiency using seccomp
user_notif.

The default-intercept and excepting libc code segment is also bogus,
and will break stuff, including vdso syscall mechanism on i386 and any
code outside libc that makes its own syscalls from asm. If you need to
tag regions to control interception, it should be tagging the emulated
Windows guest code, which is bounded and you have full control over,
rather than the host code, which is unbounded and includes any
libraries that get linked indirectly by Wine. But I'm skeptical that
doing any new kernel-side logic for tagging is needed. Seccomp already
lets you filter on instruction pointer so you can install filters that
will trigger user_notif just for guest code, then let you execute the
emulation in the watcher thread and skip the actual syscall in the
watched thread.

Rich
