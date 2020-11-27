Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED23D2C5F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 05:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392418AbgK0EOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 23:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgK0EOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 23:14:22 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FABC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 20:14:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e8so3371883pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 20:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1tVmP/PHpXY2bvMHNWougHchvh1cOtUJ10LGhajZa0=;
        b=OpzcbFaMqvK3/YotvwcUtONByEvXGgFISy7zsQxCQ/asb/H8fhUoXJM9qHbmzEVPsC
         R/4z3NmVGgX8x/8JCkqab/uJmvwXdNgCyjVpWaFWBQXbwwzfME/7zPpXaEQacO1AU1hv
         4CTfKVMuuvGOE978teDhCzL+iUF3O1ZdnotMNO598CU99lSlcwMGKep50bkMvMbOLpWa
         jSFDpyaoz6GRf26KNYcUmqUzWIdAqkmTX2WZ4kbt4QZu5WLLN6S9pD4XBaARMVC5H9I4
         lghPmiqFRw4goCclpELyCikVfmeUnIU0YeD7kAve5/6lgZilbBO/z3/zgMAktwdU0zaE
         joJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=I1tVmP/PHpXY2bvMHNWougHchvh1cOtUJ10LGhajZa0=;
        b=WP6td4tOqkXN8o1iT2NkegD/XinWjK1kEvRQdZ611HrU9vq51bx8Sz9uB1Gs5ycZNk
         ly5ZF4aRIPxnh+NMlDO0YFie4sP1oz0oM/X4ng05AmXe8sNaxMDuDy2Ss3oEVGJNTAn/
         WZm2UiyiK8cnjKJVL0Nyvi83ZQ41QP7t7xUi5p1EMOC++ygqol4uPBxmHCtu9Ls/XZnc
         28Vgnkd51x4AQm1DlVWYo8WWW7MtiwohD9HA7l/ReR8UPJYJ1V6ty2QO3cLxgceewtvv
         DWPebWtrQZE5/RLXNhvjbwbc0InvyuY/yckAlc457opDNIHJyabZd/BwvllzmOBMuk8I
         wajw==
X-Gm-Message-State: AOAM532sRlnHbwDUfXdNFElrAvplYiN/ImgH5zH9aJHuk/TgOLMq7+eK
        W/zMXhtwtIM0m2fen5mwdjI=
X-Google-Smtp-Source: ABdhPJzJd9N1/ODWeWo6Mtm8RI4pYqg41b6JORotl/W4IO1AvBqzqaybmHJyZI1TUEOcECR/4eftLw==
X-Received: by 2002:a63:2322:: with SMTP id j34mr5033490pgj.367.1606450461656;
        Thu, 26 Nov 2020 20:14:21 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id m18sm8096298pjl.41.2020.11.26.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 20:14:21 -0800 (PST)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add shadow stat test
Date:   Fri, 27 Nov 2020 13:14:04 +0900
Message-Id: <20201127041404.390276-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201127041404.390276-1-namhyung@kernel.org>
References: <20201127041404.390276-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It calculates IPC from the cycles and instruction counts and compares
it with the shadow stat for both global aggregation (default) and no
aggregation mode.

 $ perf stat -a -A -e cycles,instructions sleep 1

   Performance counter stats for 'system wide':

  CPU0   39,580,880      cycles
  CPU1   45,426,945      cycles
  CPU2   31,151,685      cycles
  CPU3   55,167,421      cycles
  CPU0   17,073,564      instructions      #    0.43  insn per cycle
  CPU1   34,955,764      instructions      #    0.77  insn per cycle
  CPU2   15,688,459      instructions      #    0.50  insn per cycle
  CPU3   34,699,217      instructions      #    0.63  insn per cycle

       1.003275495 seconds time elapsed

In this example, the 'insn per cycle' should be matched to the number
for each cpu.  For CPU2, 0.50 = 15,688,459 / 31,151,685 .

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+shadow_stat.sh

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
new file mode 100755
index 000000000000..249dfe48cf6a
--- /dev/null
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+# perf stat metrics (shadow stat) test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# skip if system-wide mode is forbidden
+perf stat -a true > /dev/null 2>&1 || exit 2
+
+test_global_aggr()
+{
+	local cyc
+
+	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	grep -e cycles -e instructions | \
+	while read num evt hash ipc rest
+	do
+		# skip not counted events
+		if [[ $num == "<not" ]]; then
+			continue
+		fi
+
+		# save cycles count
+		if [[ $evt == "cycles" ]]; then
+			cyc=$num
+			continue
+		fi
+
+		# skip if no cycles
+		if [[ -z $cyc ]]; then
+			continue
+		fi
+
+		# use printf for rounding and a leading zero
+		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		if [[ $ipc != $res ]]; then
+			echo "IPC is different: $res != $ipc  ($num / $cyc)"
+			exit 1
+		fi
+	done
+}
+
+test_no_aggr()
+{
+	declare -A results
+
+	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	grep ^CPU | \
+	while read cpu num evt hash ipc rest
+	do
+		# skip not counted events
+		if [[ $num == "<not" ]]; then
+			continue
+		fi
+
+		# save cycles count
+		if [[ $evt == "cycles" ]]; then
+			results[$cpu]=$num
+			continue
+		fi
+
+		# skip if no cycles
+		local cyc=${results[$cpu]}
+		if [[ -z $cyc ]]; then
+			continue
+		fi
+
+		# use printf for rounding and a leading zero
+		local res=`printf "%.2f" $(echo "scale=6; $num / $cyc" | bc -q)`
+		if [[ $ipc != $res ]]; then
+			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
+			exit 1
+		fi
+	done
+}
+
+test_global_aggr
+test_no_aggr
+
+exit 0
-- 
2.29.2.454.gaff20da3a2-goog

