Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541E2FE3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbhAUH2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:28:34 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49258 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbhAUHVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:53 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7KgLB023830;
        Thu, 21 Jan 2021 08:20:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4/9] tools/nolibc: implement fork() based on clone()
Date:   Thu, 21 Jan 2021 08:20:26 +0100
Message-Id: <20210121072031.23777-5-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some archs such as arm64 do not have fork() and have to use clone()
instead so let's make fork() always use clone() when available. This
requires to include signal.h to get the definition of SIGCHLD.
[This is nolibc's upstream commit d2dc42fd6149]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 9209da89044a..fdd5524e0e54 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -271,6 +271,8 @@ struct stat {
 #define WEXITSTATUS(status)   (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)     (((status) & 0x7f) == 0)
 
+/* for SIGCHLD */
+#include <asm/signal.h>
 
 /* Below comes the architecture-specific code. For each architecture, we have
  * the syscall declarations and the _start code definition. This is the only
@@ -1529,7 +1531,15 @@ int sys_execve(const char *filename, char *const argv[], char *const envp[])
 static __attribute__((unused))
 pid_t sys_fork(void)
 {
+#ifdef __NR_clone
+	/* note: some archs only have clone() and not fork(). Different archs
+	 * have a different API, but most archs have the flags on first arg and
+	 * will not use the rest with no other flag.
+	 */
+	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
+#else
 	return my_syscall0(__NR_fork);
+#endif
 }
 
 static __attribute__((unused))
-- 
2.28.0

