Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E32FE3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbhAUH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:28:10 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49254 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbhAUHVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:44 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7KfcE023828;
        Thu, 21 Jan 2021 08:20:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/9] tools/nolibc: make dup2() rely on dup3() when available
Date:   Thu, 21 Jan 2021 08:20:24 +0100
Message-Id: <20210121072031.23777-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent boot failure on 5.4-rc3 on arm64 revealed that sys_dup2()
is not available and that only sys_dup3() is implemented, thus let's
detect this and fall back to sys_dup3() when available.
[This is nolibc's upstream commit fd5272ec2c66]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3115c6467d10..5fda4d844054 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1502,10 +1502,22 @@ int sys_dup(int fd)
 	return my_syscall1(__NR_dup, fd);
 }
 
+#ifdef __NR_dup3
+static __attribute__((unused))
+int sys_dup3(int old, int new, int flags)
+{
+	return my_syscall3(__NR_dup3, old, new, flags);
+}
+#endif
+
 static __attribute__((unused))
 int sys_dup2(int old, int new)
 {
+#ifdef __NR_dup3
+	return my_syscall3(__NR_dup3, old, new, 0);
+#else
 	return my_syscall2(__NR_dup2, old, new);
+#endif
 }
 
 static __attribute__((unused))
@@ -1876,6 +1888,20 @@ int dup2(int old, int new)
 	return ret;
 }
 
+#ifdef __NR_dup3
+static __attribute__((unused))
+int dup3(int old, int new, int flags)
+{
+	int ret = sys_dup3(old, new, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+#endif
+
 static __attribute__((unused))
 int execve(const char *filename, char *const argv[], char *const envp[])
 {
-- 
2.28.0

