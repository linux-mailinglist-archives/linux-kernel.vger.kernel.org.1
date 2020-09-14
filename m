Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA142693FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgINRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgINMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:03:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170DC061354
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so12402872pfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSOVJj4da1tYC6z/DHA41bMoIW3TylIOsXwZcMYjIwM=;
        b=onU8Na4NQzsCjz1LdUqLJrE8OJCGofjylUiz2cNQ7o3o7sX3hOjQ/1wsX753/HwF6Z
         N+GDj/Q3M7N4vyAhOM83oW75+L4n3+6/3PINbSS+t2xfoByvhdbaPCmeXbubyOBT2ZYh
         af+ehDjGSxH5twfoUeND5K/STAO+iWETgv5ciaZT+JpYLbuNgi5bTK8dohZhGSnOEIZ4
         7gnMOAOpVDevGnxA2ZpCMm6Zgvr9AY6rk7qlZXcll561RsDNrVJcdKYLmdCiEmh757eb
         Y5kFltQoLnYL3OM615QGzGtgGKv3G2f69HASbgbCftZFuXa8fOv2vZ1w7324lbPOq1X/
         iHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSOVJj4da1tYC6z/DHA41bMoIW3TylIOsXwZcMYjIwM=;
        b=PsXQkbKO8VN0qGW1YUR+ECXf4yTDooBjV5GfVW9vTsgF+W+yh7HLnog9TaX8sLG6DK
         z2Ir0vB51mThmmV/qYQsUp8n1GbWAOYmysIkoWUMCMmX+uoV+9ygrmTvcA0t9d+ep8LF
         OwCqSM36uj4+N9Lkn5G1LNawQHwE/aGdRDVVPM86HURxP0xIgGmg9r4mPz+LCk/O6stD
         xrjhsybyvmH6JkksJFcVDuTgbnfwXhF9ITKSe3WvaSXr/lzb7hTnXTUIUXozRqqEds0s
         KwksniRNVTv+aoi23kLiQGSBEroVNHc5a6GOwJa2VNp3lqv9S1h83e/T6IF7w8J+1Dav
         w1Ag==
X-Gm-Message-State: AOAM5332lUzitGDYNg5AN5ln63V8PZC15WWRex16OTtwADjIwFgO3ZS1
        Y6rKD/BhYGPgpAZYrJvabdkxUw==
X-Google-Smtp-Source: ABdhPJw2OSvlqzGVUzejMKvUgrbZ8/qbT/xYRowKcqOQk7FgKYewgBRxBguBZxrEvtodbEfeLHCjAw==
X-Received: by 2002:a17:902:a715:b029:d0:89f3:28cf with SMTP id w21-20020a170902a715b02900d089f328cfmr14060884plq.11.1600084529030;
        Mon, 14 Sep 2020 04:55:29 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 137sm10620313pfu.149.2020.09.14.04.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/6] perf tsc: Support cap_user_time_short for event TIME_CONV
Date:   Mon, 14 Sep 2020 19:53:09 +0800
Message-Id: <20200914115311.2201-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesized event TIME_CONV doesn't contain the complete parameters
for counters, this will lead to wrong conversion between counter cycles
and timestamp.

This patch extends event TIME_CONV to record flags 'cap_user_time_zero'
which is used to indicate the counter parameters are valid or not, if
not will directly return 0 for timestamp calculation.  And record the
flag 'cap_user_time_short' and its relevant fields 'time_cycles' and
'time_mask' for cycle calibration.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/perf/include/perf/event.h |  4 ++++
 tools/perf/util/jitdump.c           | 14 +++++++++-----
 tools/perf/util/tsc.c               |  4 ++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 842028858d66..a6dbba6b9073 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -324,6 +324,10 @@ struct perf_record_time_conv {
 	__u64			 time_shift;
 	__u64			 time_mult;
 	__u64			 time_zero;
+	__u64			 time_cycles;
+	__u64			 time_mask;
+	bool			 cap_user_time_zero;
+	bool			 cap_user_time_short;
 };
 
 struct perf_record_header_feature {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 0804308ef285..055bab7a92b3 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -374,11 +374,15 @@ static uint64_t convert_timestamp(struct jit_buf_desc *jd, uint64_t timestamp)
 	if (!jd->use_arch_timestamp)
 		return timestamp;
 
-	tc.time_shift = jd->session->time_conv.time_shift;
-	tc.time_mult  = jd->session->time_conv.time_mult;
-	tc.time_zero  = jd->session->time_conv.time_zero;
-
-	if (!tc.time_mult)
+	tc.time_shift	       = jd->session->time_conv.time_shift;
+	tc.time_mult	       = jd->session->time_conv.time_mult;
+	tc.time_zero	       = jd->session->time_conv.time_zero;
+	tc.time_cycles	       = jd->session->time_conv.time_cycles;
+	tc.time_mask	       = jd->session->time_conv.time_mask;
+	tc.cap_user_time_zero  = jd->session->time_conv.cap_user_time_zero;
+	tc.cap_user_time_short = jd->session->time_conv.cap_user_time_short;
+
+	if (!tc.cap_user_time_zero)
 		return 0;
 
 	return tsc_to_perf_time(timestamp, &tc);
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index c0ca40204649..62b4c75c966c 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -98,6 +98,10 @@ int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
 	event.time_conv.time_mult  = tc.time_mult;
 	event.time_conv.time_shift = tc.time_shift;
 	event.time_conv.time_zero  = tc.time_zero;
+	event.time_conv.time_cycles = tc.time_cycles;
+	event.time_conv.time_mask = tc.time_mask;
+	event.time_conv.cap_user_time_zero = tc.cap_user_time_zero;
+	event.time_conv.cap_user_time_short = tc.cap_user_time_short;
 
 	return process(tool, &event, NULL, machine);
 }
-- 
2.17.1

