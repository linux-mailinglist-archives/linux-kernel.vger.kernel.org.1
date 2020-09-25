Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A82279541
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgIYX4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIYX4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:56:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E76C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:56:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so3628351qtn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVRiXw53Dj8EuhtpVqx9cmImzC41CEkZ81HklgkbMRs=;
        b=KINUH6Gk9DXuN2Qgg5rtZO6qeZ266gVzb3mu8jMxXaHxMFyyr/lTV/44wUhpMpEdIc
         z0QqgmcXR5gwRNyMl23Dq+S/mZWoCqQJCKxUlVSgbBOArl12X36Vhc82HKbh3Uuyh0wy
         eGGb46obkXuJzBRcHPH+soBFTMN2z745t4HDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVRiXw53Dj8EuhtpVqx9cmImzC41CEkZ81HklgkbMRs=;
        b=Z6q5DBkOS1T7O3DMLtjop5bv1fGXYBfPN77c/hXmafJubIrm+W++dQimOCL/4/GcQA
         gC+J9tKs2cui0fU5VvFyoa8MinZ7h1Ko4M6P6Pl9GkFdqH+tJiIsmzBHmA7uC03fGCTg
         GS2rQbF3L8lamjFjc9fJvTmFLGVZvEPvXYWdTEX+5Kl2CHROXWpEvtW58/Xy/2Tn/SQe
         garZV7j6P7+iv+VsXO736Gy+TSDDnA5Q4QwUGpUoZN8xdyBQ28Aemr4TviI0HMnfnoo9
         oqlRrbjXbat10x/alON3eVu9Q+yN4/9RYgm8kpiJNj3gCA++ChE9dp3swj9J1CQrTOJZ
         6xKA==
X-Gm-Message-State: AOAM533+PH9yZYCsfzCsHdiAmCh5tT0dCo2bPDwTHd5O7iVWR8c2ycct
        a+OfiwQrKZn9CH1KA+9jWKWqrWt+mEvkgw==
X-Google-Smtp-Source: ABdhPJwIlfGiX06lqoFVPnGiWsLXE1VkRY6AhMkMsg+Ys2RSehAc8Z1gtxQgz3py2Dv4CluXDs/8xQ==
X-Received: by 2002:ac8:694c:: with SMTP id n12mr2291961qtr.79.1601078201460;
        Fri, 25 Sep 2020 16:56:41 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s18sm2721013qks.44.2020.09.25.16.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:56:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf: sched: Show start of latency as well
Date:   Fri, 25 Sep 2020 19:56:34 -0400
Message-Id: <20200925235634.4089867-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf sched latency is really useful at showing worst-case latencies that task
encountered since wakeup. However it shows only the end of the latency. Often
times the start of a latency is interesting as it can show what else was going
on at the time to cause the latency. I certainly myself spending a lot of time
backtracking to the start of the latency in "perf sched script" which wastes a
lot of time.

This patch therefore adds a new column "Max delay start". Considering this,
also rename "Maximum delay at" to "Max delay end" as its easier to understand.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


---
A sample output can be seen after applying patch:
https://hastebin.com/raw/ivinimaler

 tools/perf/builtin-sched.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 459e4229945e..2791da1fe5f7 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -130,7 +130,8 @@ struct work_atoms {
 	struct thread		*thread;
 	struct rb_node		node;
 	u64			max_lat;
-	u64			max_lat_at;
+	u64			max_lat_start;
+	u64			max_lat_end;
 	u64			total_lat;
 	u64			nb_atoms;
 	u64			total_runtime;
@@ -1096,7 +1097,8 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
 	atoms->total_lat += delta;
 	if (delta > atoms->max_lat) {
 		atoms->max_lat = delta;
-		atoms->max_lat_at = timestamp;
+		atoms->max_lat_start = atom->wake_up_time;
+		atoms->max_lat_end = timestamp;
 	}
 	atoms->nb_atoms++;
 }
@@ -1322,7 +1324,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	int i;
 	int ret;
 	u64 avg;
-	char max_lat_at[32];
+	char max_lat_start[32], max_lat_end[32];
 
 	if (!work_list->nb_atoms)
 		return;
@@ -1344,13 +1346,14 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 		printf(" ");
 
 	avg = work_list->total_lat / work_list->nb_atoms;
-	timestamp__scnprintf_usec(work_list->max_lat_at, max_lat_at, sizeof(max_lat_at));
+	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
+	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
 
-	printf("|%11.3f ms |%9" PRIu64 " | avg:%9.3f ms | max:%9.3f ms | max at: %13s s\n",
+	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
 	      (double)work_list->total_runtime / NSEC_PER_MSEC,
 		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
 		 (double)work_list->max_lat / NSEC_PER_MSEC,
-		 max_lat_at);
+		 max_lat_start, max_lat_end);
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3118,7 +3121,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
 			list_splice(&data->work_list, &this->work_list);
 			if (this->max_lat < data->max_lat) {
 				this->max_lat = data->max_lat;
-				this->max_lat_at = data->max_lat_at;
+				this->max_lat_start = data->max_lat_start;
+				this->max_lat_end = data->max_lat_end;
 			}
 			zfree(&data);
 			return;
@@ -3157,9 +3161,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -----------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
-	printf(" -----------------------------------------------------------------------------------------------------------------\n");
+	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
+	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
-- 
2.28.0.709.gb0816b6eb0-goog
