Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0C2FE472
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbhAUH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:56:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49273 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbhAUHtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:49:00 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7mCIr024127;
        Thu, 21 Jan 2021 08:48:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/9] tools/rcutorture: fix position of -lgcc in mkinitrd.sh
Date:   Thu, 21 Jan 2021 08:48:08 +0100
Message-Id: <20210121074808.24087-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I placed -lgcc poorly in the build options, resulting in possible build
failures that are typically encountered on ARM when uidiv is required;
-lgcc must be placed after the source files.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---

Sorry for this last one, I figured after my last documentation fix that
the incorrect command line did indeed slip into one command line that is
in mkinitrd.sh. It would break ARM builds if a divide is required by the
init code.

 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 38e424d..70d62fd 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -70,7 +70,7 @@ if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
 	# architecture supported by nolibc
         ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
 		-nostdlib -include ../../../../include/nolibc/nolibc.h \
-		-lgcc -s -static -Os -o init init.c
+		-s -static -Os -o init init.c -lgcc
 else
 	${CROSS_COMPILE}gcc -s -static -Os -o init init.c
 fi
-- 
2.9.0

