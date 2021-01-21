Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6452D2FE428
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbhAUHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:40:16 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49265 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbhAUHWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:22:08 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7KgpP023829;
        Thu, 21 Jan 2021 08:20:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/9] tools/nolibc: make getpgrp() fall back to getpgid(0)
Date:   Thu, 21 Jan 2021 08:20:25 +0100
Message-Id: <20210121072031.23777-4-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getpgrp() is not implemented on arm64, getpgid(0) must be used
instead.
[This is nolibc's upstream commit 2379f25073f9]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 5fda4d844054..9209da89044a 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1544,10 +1544,16 @@ int sys_getdents64(int fd, struct linux_dirent64 *dirp, int count)
 	return my_syscall3(__NR_getdents64, fd, dirp, count);
 }
 
+static __attribute__((unused))
+pid_t sys_getpgid(pid_t pid)
+{
+	return my_syscall1(__NR_getpgid, pid);
+}
+
 static __attribute__((unused))
 pid_t sys_getpgrp(void)
 {
-	return my_syscall0(__NR_getpgrp);
+	return sys_getpgid(0);
 }
 
 static __attribute__((unused))
@@ -1950,6 +1956,18 @@ int getdents64(int fd, struct linux_dirent64 *dirp, int count)
 	return ret;
 }
 
+static __attribute__((unused))
+pid_t getpgid(pid_t pid)
+{
+	pid_t ret = sys_getpgid(pid);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 static __attribute__((unused))
 pid_t getpgrp(void)
 {
-- 
2.28.0

