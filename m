Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFE2FE3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAUH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:28:53 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49261 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbhAUHWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:22:01 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7Kg15023831;
        Thu, 21 Jan 2021 08:20:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 5/9] tools/nolibc: implement poll() based on ppoll()
Date:   Thu, 21 Jan 2021 08:20:27 +0100
Message-Id: <20210121072031.23777-6-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures like arm64 do not implement poll() and have to
use ppoll() instead.
[This is nolibc's upstream commit 800f75c13ede]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index fdd5524e0e54..833693faf53c 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1652,7 +1652,17 @@ int sys_pivot_root(const char *new, const char *old)
 static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
+#if defined(__NR_ppoll)
+	struct timespec t;
+
+	if (timeout >= 0) {
+		t.tv_sec  = timeout / 1000;
+		t.tv_nsec = (timeout % 1000) * 1000000;
+	}
+	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
+#else
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
+#endif
 }
 
 static __attribute__((unused))
-- 
2.28.0

