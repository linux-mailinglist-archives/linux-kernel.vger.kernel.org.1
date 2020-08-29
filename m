Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F421A25640A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH2B4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 21:56:14 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:47880 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgH2B4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:56:14 -0400
Date:   Fri, 28 Aug 2020 21:56:13 -0400
From:   Rich Felker <dalias@libc.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] seccomp: kill process instead of thread for unknown actions
Message-ID: <20200829015609.GA32566@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous termination of a thread outside of the userspace thread
library's knowledge is an unsafe operation that leaves the process in
an inconsistent, corrupt, and possibly unrecoverable state. In order
to make new actions that may be added in the future safe on kernels
not aware of them, change the default action from
SECCOMP_RET_KILL_THREAD to SECCOMP_RET_KILL_PROCESS.

Signed-off-by: Rich Felker <dalias@libc.org>
---

This fundamental problem with SECCOMP_RET_KILL_THREAD, and that it
should be considered unsafe and deprecated, was recently noted/fixed
seccomp in the man page and its example. Here I've only changed the
default action for new/unknown action codes. Ideally the behavior for
strict seccomp mode would be changed too but I think that breaks
stability policy; in any case it's less likely to be an issue since
strict mode is hard or impossible to use reasonably in a multithreaded
process.

Unfortunately changing this now won't help older kernels where unknown
new actions would still be handled unsafely, but at least it makes it
so the problem will fade away over time.

 kernel/seccomp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d653d8426de9..ce1875fa6b39 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -910,10 +910,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			seccomp_init_siginfo(&info, this_syscall, data);
 			do_coredump(&info);
 		}
-		if (action == SECCOMP_RET_KILL_PROCESS)
-			do_group_exit(SIGSYS);
-		else
+		if (action == SECCOMP_RET_KILL_THREAD)
 			do_exit(SIGSYS);
+		else
+			do_group_exit(SIGSYS);
 	}
 
 	unreachable();
-- 
2.21.0

