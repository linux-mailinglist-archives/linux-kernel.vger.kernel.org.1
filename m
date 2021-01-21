Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1642FE3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhAUH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:27:40 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49246 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbhAUHVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:32 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7Khvq023832;
        Thu, 21 Jan 2021 08:20:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 6/9] tools/nolibc: get timeval, timespec and timezone from linux/time.h
Date:   Thu, 21 Jan 2021 08:20:28 +0100
Message-Id: <20210121072031.23777-7-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ones conflict with linux/time.h when building, so better take
them from there directly.
[This is nolibc's upstream commit dc45f5426b0c]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 833693faf53c..611d9d15899d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -94,6 +94,7 @@
 #include <asm/errno.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
+#include <linux/time.h>
 
 #define NOLIBC
 
@@ -152,24 +153,6 @@ struct pollfd {
 	short int revents;
 };
 
-/* for select() */
-struct timeval {
-	long    tv_sec;
-	long    tv_usec;
-};
-
-/* for pselect() */
-struct timespec {
-	long    tv_sec;
-	long    tv_nsec;
-};
-
-/* for gettimeofday() */
-struct timezone {
-	int tz_minuteswest;
-	int tz_dsttime;
-};
-
 /* for getdents64() */
 struct linux_dirent64 {
 	uint64_t       d_ino;
-- 
2.28.0

