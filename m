Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF182FE3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAUH30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:29:26 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49267 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbhAUHWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:22:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7Khmr023835;
        Thu, 21 Jan 2021 08:20:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 9/9] tools/nolibc: fix position of -lgcc in the documented example
Date:   Thu, 21 Jan 2021 08:20:31 +0100
Message-Id: <20210121072031.23777-10-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation header in the file provides a command line example
to explain how to build, but it places -lgcc before the source,
which usually fails with libgcc.a (e.g. on ARM when uidiv is
needed). Let's fix this before it leaks into makefiles.
[This is nolibc's upstream commit b5e282089223]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 618acad6c932..8b7a9830dd22 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -71,7 +71,7 @@
  *
  * A simple static executable may be built this way :
  *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
- *            -static -include nolibc.h -lgcc -o hello hello.c
+ *            -static -include nolibc.h -o hello hello.c -lgcc
  *
  * A very useful calling convention table may be found here :
  *      http://man7.org/linux/man-pages/man2/syscall.2.html
-- 
2.28.0

