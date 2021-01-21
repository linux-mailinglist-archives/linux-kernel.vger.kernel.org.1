Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489B92FE42D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbhAUHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:40:29 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49255 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbhAUHVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:53 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7KhjJ023833;
        Thu, 21 Jan 2021 08:20:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 7/9] tools/nolibc: remove incorrect definitions of __ARCH_WANT_*
Date:   Thu, 21 Jan 2021 08:20:29 +0100
Message-Id: <20210121072031.23777-8-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These definitions were added with support for aarch64 when some
syscall definitions were missing (__NR_dup2, __NR_fork,
__NR_getpgrp, etc), but these were actually wrong because these
syscalls do not exist on this platform, and definiting these
resulted in exposing invalid definitions.

The missing syscalls were since implemented based on the newer ones
(__NR_dup3,  __NR_clone, __NR_getpgid) so these incorrect defintions
are definitely not needed anymore.

Thanks to Mark Rutland for spotting this incorrect analysis and
explaining why it was wrong.

[This is nolibc's upstream commit 00b1b0d9b2a4]

Reported-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/lkml/20210119153147.GA5083@paulmck-ThinkPad-P72
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: valentin.schneider@arm.com
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 611d9d15899d..475d956ed1d6 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -81,14 +81,6 @@
  *
  */
 
-/* Some archs (at least aarch64) don't expose the regular syscalls anymore by
- * default, either because they have an "_at" replacement, or because there are
- * more modern alternatives. For now we'd rather still use them.
- */
-#define __ARCH_WANT_SYSCALL_NO_AT
-#define __ARCH_WANT_SYSCALL_NO_FLAGS
-#define __ARCH_WANT_SYSCALL_DEPRECATED
-
 #include <asm/unistd.h>
 #include <asm/ioctls.h>
 #include <asm/errno.h>
-- 
2.28.0

