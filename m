Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC412C8F09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbgK3UWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbgK3UWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:00 -0500
IronPort-SDR: KF3JWiupJ1VHqTUNvOnWEY9zIBurFdvAN60/D33EfQLw2H/3nW4MH2jOYl4W980X4OdaWqqopi
 ZIEiiThT+HCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140744"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:33 -0800
IronPort-SDR: 1MVlcWBJXCAxU009y0pqK/reLjsx1gn6xnICB3M4prAPmI7Y1rXs1ibbgvyVpNW6FSjCuvtfqy
 NjtQ+qokyb5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793794"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:32 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 11/17] selftests/resctrl: Enable gcc checks to detect buffer overflows
Date:   Mon, 30 Nov 2020 20:20:04 +0000
Message-Id: <20201130202010.178373-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David reported a buffer overflow error in the check_results() function of
the cmt unit test and he suggested enabling _FORTIFY_SOURCE gcc compiler
option to automatically detect any such errors.

Feature Test Macros man page describes_FORTIFY_SOURCE as below

"Defining this macro causes some lightweight checks to be performed to
detect some buffer overflow errors when employing various string and memory
manipulation functions (for example, memcpy, memset, stpcpy, strcpy,
strncpy, strcat, strncat, sprintf, snprintf, vsprintf, vsnprintf, gets, and
wide character variants thereof). For some functions, argument consistency
is checked; for example, a check is made that open has been supplied with a
mode argument when the specified flags include O_CREAT. Not all problems
are detected, just some common cases.

If _FORTIFY_SOURCE is set to 1, with compiler optimization level 1 (gcc
-O1) and above, checks that shouldn't change the behavior of conforming
programs are performed.

With _FORTIFY_SOURCE set to 2, some more checking is added, but some
conforming programs might fail.

Some of the checks can be performed at compile time (via macros logic
implemented in header files), and result in compiler warnings; other checks
take place at run time, and result in a run-time error if the check fails.

Use of this macro requires compiler support, available with gcc since
version 4.0."

Fix the buffer overflow error in the check_results() function of the cmt
unit test and enable _FORTIFY_SOURCE gcc check to catch any future buffer
overflow errors.

Reported-by: David Binderman <dcb314@hotmail.com>
Suggested-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile   | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index d585cc1948cc..6bcee2ec91a9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,5 +1,5 @@
 CC = $(CROSS_COMPILE)gcc
-CFLAGS = -g -Wall
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 SRCS=$(wildcard *.c)
 OBJS=$(SRCS:.c=.o)
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 188b73b5a2cc..ac1a33d9ce12 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -81,7 +81,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 		return errno;
 	}
 
-	while (fgets(temp, 1024, fp)) {
+	while (fgets(temp, sizeof(temp), fp)) {
 		char *token = strtok(temp, ":\t");
 		int fields = 0;
 
-- 
2.29.2

