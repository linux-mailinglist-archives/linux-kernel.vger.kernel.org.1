Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247632E33AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgL1Cml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:42:41 -0500
Received: from smtp2.axis.com ([195.60.68.18]:55196 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgL1Cml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1609123360;
  x=1640659360;
  h=from:to:cc:subject:mime-version:
   content-transfer-encoding:message-id:date;
  bh=c/Ou/kG0IGXrZXF2bpT2eD4g6EjPFR87QllRTAJk7vs=;
  b=IVcm6yQ8mJSj7kvBtiYmWf598tat8GB6FGHzxIIn1xJM0MSsZR7SNG6b
   Gx+hYIC8QizuwPA6CJD+r5/4YV5vCztg/KqqC/1wEIpnFI5HKpvNnSUc8
   rzRY2CVz7NJehp2YGIlVSL5Est20zpCLRcF66i7OoD1sAolNWUAD+jllZ
   wmUMCKelj+Mtc8BTA6qZZeDGEAzlNHFBGm7vms2Yc++xd7F6RQBcwoRed
   n+7g4McQItYwxdpgzW/EljTkPWILOS/5+Rrr4CU+gOm8VM2Zi7zkynMdx
   kquUrHPV/b0msPg9HDEYh3bY4/lVXwC6dIJMQIkvvQY5W7ph7clSbX51c
   A==;
From:   Hans-Peter Nilsson <hp@axis.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH] perf arm64: Simplify mksyscalltbl
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <20201228024159.2BB66203B5@pchp3.se.axis.com>
Date:   Mon, 28 Dec 2020 03:41:59 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch isn't intended to have any effect on the compiled
code.  It just removes one level of indirection: calling the
*host* compiler to build and then run a program that just
printf:s the numerical entries of the syscall-table.  In other
words, the generated syscalls.c changes from:
	[46] = "ftruncate",
to:
	[__NR3264_ftruncate] = "ftruncate",
The latter is as good as the former to the user of perf, and
this can be done directly by the shell-script.  The syscalls
defined as non-literal values (like "#define __NR_ftruncate
__NR3264_ftruncate") are trivially resolved at compile-time
without namespace-leaking and/or collision for its sole user,
perf/util/syscalltbl.c, that just #includes the generated file.
A future "-mabi=32" support would probably have to handle this
differently, but that is a pre-existing problem not affected by
this simplification.

Calling the *host* compiler only complicates things and
accidentally can get a completely wrong set of files and syscall
numbers, see earlier commits.  Note that the script parameter
hostcc is now unused.

At the time of this patch, powerpc (the origin, see comments),
and also e.g. x86 has moved on, from filtering "gcc -dM -E"
output to reading separate specific text-file, a table of
syscall numbers.  IMHO should arm64 consider adopting this.

Signed-off-by: Hans-Peter Nilsson <hp@axis.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index a7ca48d1e37b..22cdf911dd9a 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -23,34 +23,17 @@ create_table_from_c()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
-
-	{
-
-	cat <<-_EoHEADER
-		#include <stdio.h>
-		#include "$input"
-		int main(int argc, char *argv[])
-		{
-	_EoHEADER
-
 	while read sc nr; do
-		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", __NR_$sc);"
+		printf "%s\n" "	[$nr] = \"$sc\","
 		last_sc=$sc
 	done
 
-	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
-	printf "}\n"
-
-	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
-
-	$create_table_exe
-
-	rm -f $create_table_exe
+	printf "%s\n" "#define SYSCALLTBL_ARM64_MAX_ID __NR_$last_sc"
 }
 
 create_table()
 {
+	echo "#include \"$input\""
 	echo "static const char *syscalltbl_arm64[] = {"
 	create_table_from_c
 	echo "};"
-- 
2.11.0

brgds, H-P
