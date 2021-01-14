Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDE2F5A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhANFG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhANFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:06:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E072C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:06:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c13so2647624pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cmW33qlO71FuFS0D0i4aOF0xAQVuqZ6YYIiHQHZsXwY=;
        b=qgzm9VdGcQzdu1NpjKCRUihyaTDBY0/J80BjgJGDtqFhGzAYBaleoIDl4HbHwEONdJ
         jzaVo0BTrA0DqtLLlfY6GSjE/ZLKLiyM+P/aDKiMCf6ZXBVodZQKtxOV4RcdmvLLrw5j
         6PxbfsXHvdoJy20YJjwd3hZVjO4g9QNU09vWA7/YUBKoo/PHqQ2umuL8aZvbebJ/8noQ
         gDXrVcJAaxxZWqQZ1LbXgPV6THOUmnjc5H/A/oI1rIOCfQN5GkMTe5mAVovQdNszNhUT
         gJaH4t8dJGh//poXe6kl+cI9fsrlR2MuWPBwNnMLJyWF4jp4PWrLXnSXc0CwrVV6g2dx
         bJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cmW33qlO71FuFS0D0i4aOF0xAQVuqZ6YYIiHQHZsXwY=;
        b=ohuT6C1r90BdHZe5uj+v8rAt4Je4z7syz1yeQwzP8LRqDtlF53Lvl7ruTFRYr8VlYy
         QvyjFt4qGyhYJa3rQJ4xJ32FIr/g1T9LMdDva7oNVIymcWDgb/l6XBqLRxEF4JI/CQpZ
         YBf1NuuRKhtrJwIzlNzuXvyNhHmTm6om/WWLtPo9KvxOjEvwu5AFwtfDM6X2c0rLXkSa
         7FFyUpaUk6+HNUeo3W9sgKboAMS0OyUnk4R0R+0fyX1eVusqx3pxr7xjrUh354DAwm0E
         9dvThNMywfp5WUEtDM2ZDBB4sltn5wxhME3QrvnHzTID/7k7IxqsPU/EM58E3dOa6MAs
         DtxQ==
X-Gm-Message-State: AOAM532D73eV7kVBwS3e3BFArH1RXNhs6WtZSQafIBn84Grh47Xg1yY4
        kGrUTgHiYHE6fI7KN5Z+yhE=
X-Google-Smtp-Source: ABdhPJxRjmFZ6cjSa8WMoTkgqGL0HgozPceOhzWFZlg+TecD744B6sdOb+iu7gbpu39tUvANk/+zYw==
X-Received: by 2002:a65:690e:: with SMTP id s14mr5624504pgq.302.1610600775687;
        Wed, 13 Jan 2021 21:06:15 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id z3sm3931483pfb.157.2021.01.13.21.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:06:14 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf test: Fix shadow stat test for non-bash shells
Date:   Thu, 14 Jan 2021 14:06:09 +0900
Message-Id: <20210114050609.1258820-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was using some bash-specific features and failed to parse when
running with a different shell like below:

  root@kbl-ppc:~/kbl-ws/perf-dev/lck-9077/acme.tmp/tools/perf# ./perf test 83 -vv
  83: perf stat metrics (shadow stat) test                            :
  --- start ---
  test child forked, pid 3922
  ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
  (standard_in) 2: syntax error
  ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 19: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 24: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 30: ./tests/shell/stat+shadow_stat.sh: [[: not found
  (standard_in) 2: syntax error
  ./tests/shell/stat+shadow_stat.sh: 36: ./tests/shell/stat+shadow_stat.sh: [[: not found
  ./tests/shell/stat+shadow_stat.sh: 45: ./tests/shell/stat+shadow_stat.sh: declare: not found
  test child finished with -1
  ---- end ----
  perf stat metrics (shadow stat) test: FAILED!

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 249dfe48cf6a..ebebd3596cf9 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -9,31 +9,29 @@ perf stat -a true > /dev/null 2>&1 || exit 2
 
 test_global_aggr()
 {
-	local cyc
-
 	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
 	grep -e cycles -e instructions | \
 	while read num evt hash ipc rest
 	do
 		# skip not counted events
-		if [[ $num == "<not" ]]; then
+		if [ "$num" = "<not" ]; then
 			continue
 		fi
 
 		# save cycles count
-		if [[ $evt == "cycles" ]]; then
+		if [ "$evt" = "cycles" ]; then
 			cyc=$num
 			continue
 		fi
 
 		# skip if no cycles
-		if [[ -z $cyc ]]; then
+		if [ -z "$cyc" ]; then
 			continue
 		fi
 
 		# use printf for rounding and a leading zero
-		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
-		if [[ $ipc != $res ]]; then
+		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different: $res != $ipc  ($num / $cyc)"
 			exit 1
 		fi
@@ -42,32 +40,32 @@ test_global_aggr()
 
 test_no_aggr()
 {
-	declare -A results
-
 	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
 	grep ^CPU | \
 	while read cpu num evt hash ipc rest
 	do
 		# skip not counted events
-		if [[ $num == "<not" ]]; then
+		if [ "$num" = "<not" ]; then
 			continue
 		fi
 
 		# save cycles count
-		if [[ $evt == "cycles" ]]; then
-			results[$cpu]=$num
+		if [ "$evt" = "cycles" ]; then
+			results="$results $cpu:$num"
 			continue
 		fi
 
+		cyc=${results##* $cpu:}
+		cyc=${cyc%% *}
+
 		# skip if no cycles
-		local cyc=${results[$cpu]}
-		if [[ -z $cyc ]]; then
+		if [ -z "$cyc" ]; then
 			continue
 		fi
 
 		# use printf for rounding and a leading zero
-		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
-		if [[ $ipc != $res ]]; then
+		res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
 			exit 1
 		fi
-- 
2.30.0.284.gd98b1dd5eaa7-goog

