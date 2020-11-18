Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D382B7BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKRKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgKRKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:55:47 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:55:47 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id js21so860920pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BhH5K+MTGdgFbetyPicr43Tgk9xbnv048ZFFhJrT76c=;
        b=sNIOU6nzfYfYFxIvSbcgf48QEfwH01iuyELKAXAEwooWu1JSqpHtZtxjceQvqGOgYn
         HvcEqC1pzgYDwoCioWwlv7WUwHw0NZ6nqlw+TkVDcuWAzhjR7ngSGR9ScMK9dfyhNsgF
         ZU2+pHm1skUxQ6gTlQbWWz5B8uJih1n6F1ZKpqJYbW8VDlPgF8ZyWXU9wlqREZ9HJ3LE
         pYTObFX74Hl1odxB+/YhnXeLtfA3Xc60oB4ppkZDOBEB/UH8IA1ZmVUwJgl7B78rcA5o
         yygYS0+AkWRj3i6aRfD5TMV20WA/7j+N3kfE+yjnQNtVCY+/zzYHj/STowYHyKYRMOt3
         2k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BhH5K+MTGdgFbetyPicr43Tgk9xbnv048ZFFhJrT76c=;
        b=LwikL64ebn1MRBvkKjsXAkXmMkSpn3/3Kjue7FNspRRhAG7Q50UyxyZVmTBGuICm5g
         xV18GURzwjXaVZYLlmGfvt5Ud9Z1BrXmHOooJVFL/4NIgujOAw1YHEFUZ2JVIaU0glMg
         ioJxWGhfQX0MFs9o9sjLCEFnIzc2DcQK0+J14SGgxCG7IkbsISUL4lCPDLGREvFHOtBO
         J7+bhCjMtXJ/Ngtjrl7/IK6ktcFle8KMtK15ZBNf9+epgmSuFxWbeRvUNvDF1qDaMOcd
         HRsUGmXIgJv4cSu53OLq98fk4X39mAOMdeuC+YcaEh83VNnZPDFvxW2YmIHBsi+Y08Jp
         BqyA==
X-Gm-Message-State: AOAM532NP82C1HOmitdcp399VqU2F2OxQfCVLBRFcj/RUZAHp1IxdKvn
        d3orzKMRYXovd+H+z5Fz4RyV2g==
X-Google-Smtp-Source: ABdhPJyHpTEFeDBScxBjHGmAWhhOFmwgBeungmQZoef05A00MHVBLXgyzQaSJnoDP+hxKD9Bnhs8kA==
X-Received: by 2002:a17:90a:c254:: with SMTP id d20mr3482540pjx.112.1605696946394;
        Wed, 18 Nov 2020 02:55:46 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e17sm26746896pfl.216.2020.11.18.02.55.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 02:55:45 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFC PATCH] perf session: Fixup timestamp for ordered events
Date:   Wed, 18 Nov 2020 18:55:34 +0800
Message-Id: <20201118105534.27828-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool relies on MMAP/MMAP2 events to prepare DSO maps, it allocates
DSO maps for MMAP/MMAP2 events which is used for parsing symbol.  Thus,
during the recording, perf tool implictly expects the MMAP/MMAP2 events
should arrive before AUX event, in other words, MMAP/MMAP2's timestamp
should less than AUX event's timestamp, and the MMAP/MMAP2 events will
be added into the front of ordered event list; this can allow the DSO
maps to be prepared and can be consumed when process AUX event.

See the function perf_evlist__prepare_workload(), though it uses pipes
to handshake before perf process (the parent process) and forked process
for the profiled program, it cannot promise the timing between
MMAP/MMAP2 events and AUX event.

On Arm Juno board, the AUX event can be observed to arrive ahead than
MMAP2 event, with the command:

  perf record -e cs_etm/@tmc_etr0/ -S -- dd if=/dev/zero of=/dev/null

The follow diagram depicts the flow for how the AUX event is arriving
ahead than MMAP2 event:

       T1:          T3:                  T4:
  perf process   Open PMU device    Perf is scheduled out;
                                    invoke perf_aux_output_end()
	                            and generate AUX event
       ^            ^                    ^
       |            |                    |
 CPU0 ---------------------------------------------------> (T)
       \
        \  Forked process is placed on another CPU
         V
 CPU1 ---------------------------------------------------> (T)
              |                                |
	      V                                V
	      T2:                              T5:
        Invoke execvp() for profiled       Record MMAP2 event
      	program


In this scenario, the perf main process runs on CPU0 and the profiled
program (which is forked child process) runs on CPU1.  The main process
opens PMU device for AUX trace (T3) and it will generate AUX event until
the perf process is scheduled out (T4); the profiled program will be
launched by execvp() (T2) and later will record MMAP event for memory
mapping (T5).

Usually, the AUX event will be later than MMAP2 event, but on the Arm
Juno platform, it has chance that AUX event occurs prior to MMAP2 event
with two reasons:

- Arm Juno platform is big.LITTLE architecture, so CPU0 is big CPU and
  CPU1 is LITTLE CPU, the performance between big CPU and LITTLE CPU is
  significant, this gives chance for the perf main process to run much
  faster than the profiled program;

- In the kernel, the RT thread (like kernel's CPUFreq thread) has chance
  to preempt perf main thread, so when the perf main thread is
  switched out, the AUX event will be generated and it might be early
  than profiled program's MMAP2 event.

To fix this issue, this patch records the first AUX event's timestamp
into 'aux_timestamp', if find any MMAP/MMAP2 event is late coming, it
fixes up the MMAP/MMAP2 events' timestamp as 'aux_timestamp-1', so the
MMAP/MMAP2 event will be inserted into ordered list ahead than AUX event
and also will be handled before AUX event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/session.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 098080287c68..1aa54941bf81 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1753,11 +1753,36 @@ static s64 perf_session__process_event(struct perf_session *session,
 
 	if (tool->ordered_events) {
 		u64 timestamp = -1ULL;
+		static u64 aux_timestamp = -1ULL;
 
 		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (ret && ret != -1)
 			return ret;
 
+		/*
+		 * Cache the first AUX event's timestamp into 'aux_timestamp',
+		 * which is used to fixup MMAP/MMAP2's timestamp.
+		 */
+		if ((event->header.type == PERF_RECORD_AUX) &&
+		    (aux_timestamp == -1ULL))
+			aux_timestamp = timestamp;
+
+		/*
+		 * If the AUX event arrives prior to MMAP/MMAP2 events, it's
+		 * possible to have no chance to create DSOs when decode AUX
+		 * trace data, thus the symbol cannot be parsed properly.
+		 * To allow the DSOs are prepared before process AUX event,
+		 * fixup the MMAP/MMAP2 events' timestamp to be prior to any
+		 * AUX event's timestamp, so MMAP/MMAP2 events will be
+		 * handled ahead and the DSO map will be prepared before AUX
+		 * event handling.
+		 */
+		if (event->header.type == PERF_RECORD_MMAP2 ||
+		    event->header.type == PERF_RECORD_MMAP) {
+			if (timestamp > aux_timestamp)
+				timestamp = aux_timestamp - 1;
+		}
+
 		ret = perf_session__queue_event(session, event, timestamp, file_offset);
 		if (ret != -ETIME)
 			return ret;
-- 
2.17.1

