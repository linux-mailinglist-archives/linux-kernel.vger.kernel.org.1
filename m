Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7137E2B8438
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKRS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:57:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKRS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:57:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 543081F44B45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     libc-alpha@sourceware.org
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
Subject: Kernel prctl feature for syscall interception and emulation
Date:   Wed, 18 Nov 2020 13:57:26 -0500
Message-ID: <873616v6g9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm proposing a kernel patch for a feature I'm calling Syscall User
Dispatch (SUD).  It is a mechanism to efficiently redirect system calls
of only part of a binary back to userspace to be emulated by a
compatibility layer.  The patchset is close to being accepted, but
Florian suggested the feature might pose some constraints on glibc, and
requested I raise the discussion here.

The problem I am trying to solve is that modern Windows games running
over Wine are issuing Windows system calls directly from the Windows
code, without going through the "WinAPI", which doesn't give Wine a
chance to emulate the library calls and implement the behavior.  As a
result, Windows syscalls reache the Linux kernel, and the kernel has
no context to differentiate them from native syscalls coming from the
Wine side, since it cannot trust the ABI, not even syscall numbers to be
something sane.  Historically, Windows applications were very respectful
of the WinAPI, not bypassing it, but we are seeing modern applications
like games doing it more often for reasons, I believe, of DRM.

It is worth mentioning that, by design, Wine and the Windows application
run on the same process space, so we really cannot just filter specific
threads or the entire application. We need some kind of filter executed
on each system call.

Now, the obvious way to solve this problem would be cBPF filtering
memory regions, through Seccomp.  The main problem with that approach is
the performance of executing a large cBPF filter.  The goal is to run
games, and we observed the Seccomp filter become a bottleneck, since we
have many, many memory areas that need to be checked by cBPF.  In
addition, seccomp, as a security mechanism, doesn't support some filter
update operations, like removing them.  Another approaches were
explored, like making a new mode out of seccomp, but the kernel
community preferred to make it a separate, self-contained mechanism.
Other solutions, like (live) patching the Windows application are out
of question, as they would trip DRM and anti-cheat protection
mechanisms.

The SUD interface I proposed to the kernel community is self-contained
and exposed as a prctl option.  It lets userspace define a switch
variable per-thread that, when set, will raise a SIGSYS for any syscall
attempted.  The idea is that Wine can just flip this switch efficiently
before delivering control to the Windows portions of the binary, and
flip it back off when it needs to execute native syscalls.  It is
important for us that the switch flip doesn't require a syscall, for
performance reasons.  The interface also lets userspace define a
"dispatcher region" from where any syscalls are always executed,
regardless of the selector variable.  This is important for the return
of the SIGSYS directly to a Windows segment, where we need to execute
the signal return trampoline with the selector blocked.  Ideally, Wine
would simply define this dispatcher region as the entire libc code
segment, and just use the selector to safe-guard against Linux libraries
issuing syscalls by themselves (they exist).

I think my questions to libc are: what are the constraints, if any, that
libc would face with this new interface?  I expected this to be
completely invisible to libc.  In addition, are there any problems you
foresee with the current interface?

Finally, I don't think it makes sense to bother you immediately with
the kernel implementation patches, but if you want to see the them,
they are archived in the link below.  I can also share them directly on
this ML if you request it.

  https://lkml.org/lkml/2020/11/17/2347

Nevertheless, I think it is useful the share the final patch, that has
the in-tree documentation for the interface, which I inlined in this
message.

Thanks.

-- >8 --
Subject: [PATCH v7 7/7] docs: Document Syscall User Dispatch

Explain the interface, provide some background and security notes.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/syscall-user-dispatch.rst     | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
new file mode 100644
index 000000000000..e2fb36926f97
--- /dev/null
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Syscall User Dispatch
+=====================
+
+Background
+----------
+
+Compatibility layers like Wine need a way to efficiently emulate system
+calls of only a part of their process - the part that has the
+incompatible code - while being able to execute native syscalls without
+a high performance penalty on the native part of the process.  Seccomp
+falls short on this task, since it has limited support to efficiently
+filter syscalls based on memory regions, and it doesn't support removing
+filters.  Therefore a new mechanism is necessary.
+
+Syscall User Dispatch brings the filtering of the syscall dispatcher
+address back to userspace.  The application is in control of a flip
+switch, indicating the current personality of the process.  A
+multiple-personality application can then flip the switch without
+invoking the kernel, when crossing the compatibility layer API
+boundaries, to enable/disable the syscall redirection and execute
+syscalls directly (disabled) or send them to be emulated in userspace
+through a SIGSYS.
+
+The goal of this design is to provide very quick compatibility layer
+boundary crosses, which is achieved by not executing a syscall to change
+personality every time the compatibility layer executes.  Instead, a
+userspace memory region exposed to the kernel indicates the current
+personality, and the application simply modifies that variable to
+configure the mechanism.
+
+There is a relatively high cost associated with handling signals on most
+architectures, like x86, but at least for Wine, syscalls issued by
+native Windows code are currently not known to be a performance problem,
+since they are quite rare, at least for modern gaming applications.
+
+Since this mechanism is designed to capture syscalls issued by
+non-native applications, it must function on syscalls whose invocation
+ABI is completely unexpected to Linux.  Syscall User Dispatch, therefore
+doesn't rely on any of the syscall ABI to make the filtering.  It uses
+only the syscall dispatcher address and the userspace key.
+
+Interface
+---------
+
+A process can setup this mechanism on supported kernels
+CONFIG_SYSCALL_USER_DISPATCH) by executing the following prctl:
+
+  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
+
+<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
+disable the mechanism globally for that thread.  When
+PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
+
+<offset> and <offset+length> delimit a closed memory region interval
+from which syscalls are always executed directly, regardless of the
+userspace selector.  This provides a fast path for the C library, which
+includes the most common syscall dispatchers in the native code
+applications, and also provides a way for the signal handler to return
+without triggering a nested SIGSYS on (rt_)sigreturn.  Users of this
+interface should make sure that at least the signal trampoline code is
+included in this region. In addition, for syscalls that implement the
+trampoline code on the vDSO, that trampoline is never intercepted.
+
+[selector] is a pointer to a char-sized region in the process memory
+region, that provides a quick way to enable disable syscall redirection
+thread-wide, without the need to invoke the kernel directly.  selector
+can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
+value should terminate the program with a SIGSYS.
+
+Security Notes
+--------------
+
+Syscall User Dispatch provides functionality for compatibility layers to
+quickly capture system calls issued by a non-native part of the
+application, while not impacting the Linux native regions of the
+process.  It is not a mechanism for sandboxing system calls, and it
+should not be seen as a security mechanism, since it is trivial for a
+malicious application to subvert the mechanism by jumping to an allowed
+dispatcher region prior to executing the syscall, or to discover the
+address and modify the selector value.  If the use case requires any
+kind of security sandboxing, Seccomp should be used instead.
+
+Any fork or exec of the existing process resets the mechanism to
+PR_SYS_DISPATCH_OFF.
-- 
2.29.2

-- 
Gabriel Krisman Bertazi
