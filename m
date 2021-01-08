Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50472EEDFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbhAHHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 02:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbhAHHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 02:48:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF7C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 23:47:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x18so5245607pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxN7Ql6o+SZAidFXTRR4YApaIeN7xqQ60rez/PZAroI=;
        b=SACCD/lZUwxHWXCdfqsKwXI5c6hrG5mawwzzB5OE7Y/CUAbqISZR+A9CGNt7OxZkrD
         y740zJiiJks5yKSIwncYpth5K/NV52cl8AT8pIy+XZ7HhoeYUXV4+fJgUkVvuPya2xwU
         W4keWj5uUnkfl4XgE1EG9LBMqBLNo6jBrWwbM1YwwQ82rW0C1PWGj1eulJWv7g+k1db6
         T5d7XXFDIOQgt4QUNO/sVHr9SEPEpF/v/39QWnpyy/8llDvQaWDPCXsdanwP8YafVC7a
         OUR+twUrkP0bM8L2Mt7wOEdoyztU4hUhIKqrH6Dcn5Tju3/umAy5ciQhC4+vle12IUTa
         yzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oxN7Ql6o+SZAidFXTRR4YApaIeN7xqQ60rez/PZAroI=;
        b=g7fBGgTLO31A+hbwG18ENLxXarEKs4sfVqQBycFLY53s+tU1o7tqqlN1f45BvgF6Ww
         o5icLargSDEMg0fJp9P6deOyt49K+NDMsr+pW5XgvvLvaFpF8LwI98xq/f/mwqjmULDR
         j83QZl2wq9ADDPVT1QmyUQuBjTKugqEepYBlk8ZIrcyJhlV7LXSrp8wkjGidaDIOV6dn
         cJI81RpR6tjbgPBGX6WPZ289JmZqTYexB4DVmFFxPtHyI4SOrqkHhlGmzYB9NNmBv8BB
         zEm5UjQDffRbbBlw3Xo2j+/OmG9KfdAVBt1oZLczrWNlQ3q/GnsTruN75ak8C65J1Exo
         VODg==
X-Gm-Message-State: AOAM532vbO1YRZ9dBROYoC2ZuS4TgXjPTaDclntCvZW76SAMS1uyJ5ze
        0rnRUaiaaALaBvmOI44xAts=
X-Google-Smtp-Source: ABdhPJwupXJ5b6UrmPP4OqQblPe+fWvykEOsz1vnMav74WiddecbeOj1UMgkg2zkmBkPFBMQDFr78Q==
X-Received: by 2002:a17:902:ed0a:b029:dc:55b:5cb9 with SMTP id b10-20020a170902ed0ab02900dc055b5cb9mr2701424pld.40.1610092040244;
        Thu, 07 Jan 2021 23:47:20 -0800 (PST)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id q23sm7764950pfg.192.2021.01.07.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:47:19 -0800 (PST)
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
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf test: Fix shadow stat test for non-bash shells
Date:   Fri,  8 Jan 2021 16:47:12 +0900
Message-Id: <20210108074712.947223-1-namhyung@kernel.org>
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
 tools/perf/tests/shell/stat+shadow_stat.sh | 24 ++++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 249dfe48cf6a..e2c7ac4ed91d 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -16,24 +16,24 @@ test_global_aggr()
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
 		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
-		if [[ $ipc != $res ]]; then
+		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different: $res != $ipc  ($num / $cyc)"
 			exit 1
 		fi
@@ -42,36 +42,38 @@ test_global_aggr()
 
 test_no_aggr()
 {
-	declare -A results
+	results=$(mktemp /tmp/perf-test-shadow-stat-XXXXXX)
 
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
+			echo $cpu $num >> $results
 			continue
 		fi
 
 		# skip if no cycles
-		local cyc=${results[$cpu]}
-		if [[ -z $cyc ]]; then
+		local cyc=$(grep $cpu $results | cut -d' ' -f2)
+		if [ -z "$cyc" ]; then
 			continue
 		fi
 
 		# use printf for rounding and a leading zero
 		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
-		if [[ $ipc != $res ]]; then
+		if [ "$ipc" != "$res" ]; then
 			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
+			rm -f $results
 			exit 1
 		fi
 	done
+	rm -f $results
 }
 
 test_global_aggr
-- 
2.30.0.284.gd98b1dd5eaa7-goog

