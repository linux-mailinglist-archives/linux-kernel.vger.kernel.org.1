Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEA2E33AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgL1CkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:40:24 -0500
Received: from smtp2.axis.com ([195.60.68.18]:45409 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgL1CkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1609123223;
  x=1640659223;
  h=from:to:cc:subject:mime-version:
   content-transfer-encoding:message-id:date;
  bh=V2SBeunGq+h3UtsNHb+tqmxZ59PpV2K+y2jJcGaooWM=;
  b=g/3lsZ5J1InC3JzsKXWYYW/7qGkv8vc18EudSZ3FgcSIosAnPrHLR8E4
   8afzIe7oT/r8Xyv3GXhzwGb2cM+ahTu3XTbaB/r46MJmwp8SwOSkW4TGs
   0oZ8Eeu7a6hSs9n6cSU1XmYv6U9Xov8QSC4pZYwIeztI3Fi5BZsk7Y2U6
   RuZZM4nPIqF+3UQwmCUuuw/HVghVg/lOogvUPF6IRrVb1Pl3Yb/O5W98t
   9EptO8gL7EtsHbNFwSfz81igzRk15IzvCFEgV2D6hTiEgE7jJKMOutbde
   6UHMaKJQNkqD7vdGiuB3glA6rF1wIRN0EKDd/h9GrabNdLxTE+SpcK6G2
   g==;
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
Subject: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to sort -nu
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
Date:   Mon, 28 Dec 2020 03:39:41 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using "sort -nu", arm64 syscalls were lost.  That is, the
io_setup syscall (number 0) and all but one (typically
ftruncate; 64) of the syscalls that are defined symbolically
(like "#define __NR_ftruncate __NR3264_ftruncate") at the point
where "sort" is applied.

This creation-of-syscalls.c-scheme is, judging from comments,
copy-pasted from powerpc, and worked there because at the time,
its tools/arch/powerpc/include/uapi/asm/unistd.h had *literals*,
like "#define __NR_ftruncate 93".

With sort being numeric and the non-numeric key effectively
evaluating to 0, the sort option "-u" means these "duplicates"
are removed.  There's no need to remove syscall lines with
duplicate numbers for arm64 because there are none, so let's fix
that by just losing the "-u".  Having the table numerically
sorted on syscall-number for the rest of the syscalls looks
nice, so keep the "-n".

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
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 459469b7222c..a7ca48d1e37b 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -58,5 +58,5 @@ create_table()
 
 $gcc -E -dM -x c -I $incpath/include/uapi $input \
 	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+	|sort -t' ' -k2 -n	       \
 	|create_table
-- 
2.11.0

brgds, H-P
