Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11152F9858
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbhARDoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbhARDoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:44:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3844C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 19:43:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v1so8600874pjr.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 19:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLcD1KsLMyFBd6UHMlBHWAx5VWQMXZTljJhkoezxzl8=;
        b=q5WaNaCqvCm4ogcoKOyiIAjCjA9JwOvrGrtehIVqzJRrLngSXhKrB/RdwXjOaHaQRw
         QbLIkOyl+IZbFEYDJ+Rf+yu5lUVKJxSg76AmI63C73ArO4Egf4IClxCSzDd6yODmm4Dr
         5jbOBEkyRWiak3M9i5Gj/Hm52sGrdzHoGZ2FhxVbYUnkNV9tYsh2gMt8DEQ4djse+p4N
         gOqAj4UfZMggsXlkrOd/QgoOfoj9uv+vaLo0IvQ9EE6YtmZylrA7laAqcMvIuALb8ndg
         /yYEL/v/O92EYB+Vc2O6QriwUEeq95nzCOdQfYoabUGr19PXnwiwwmc2G8TDUVxXJimA
         yY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QLcD1KsLMyFBd6UHMlBHWAx5VWQMXZTljJhkoezxzl8=;
        b=jRBiz2c7YuGmXF3SpQW2PtvlH9Ty+4feJ6J5I8ddbb09xU+cIhIY0qAOi8+FtHTAg0
         0oIaSoa4zuIcO3woWwrQMydh2M79vycyq3qC/6j6/h0REKajtcfRg/2Butj1MTt/wlcN
         KyX5QzaVvYuvG/WOZqh4uVG5aP+uyMiPKR/ojap6wBvXRNSNP5VFqtaOrDRJq2Wq0yS3
         nEUlWUFhWoeTm5llGWzGuD6ny13oKYfpRFyiBmxVGohmRmj8WxBPm8mRubgGGcco1PG3
         n4JdXdSx+vqhEyxf8oiWz29H+QYsXPHgJq16tZUALplu9NzvtUq7ZqDPadP0Quv07Qwq
         iNdw==
X-Gm-Message-State: AOAM532zZTH0cF6VWY7RC2RNbOV2A38gW06tXiOiABrkEfb9d/hZNQnE
        ZfDERwyG0nhlwbBSTL6CkmU=
X-Google-Smtp-Source: ABdhPJw2tjoAEwBlQt2/XcS+yDBhkvaWARPurZXwVQPMiPlDvxtlPzG4RCQ49zWn7Bzs+lvJBHW+0A==
X-Received: by 2002:a17:90a:708b:: with SMTP id g11mr23498675pjk.23.1610941409458;
        Sun, 17 Jan 2021 19:43:29 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id i62sm7979978pfc.150.2021.01.17.19.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 19:43:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
Date:   Mon, 18 Jan 2021 12:43:23 +0900
Message-Id: <20210118034323.427029-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now we silently ignore pinned events when it's failed to be
scheduled and make it error state not try to schedule it again.
That means we won't get any samples for the event.

But there's no way for users to notice and respond to it.  Let's
emit a lost event with a new misc bit to indicate this situation.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/perf_event.h |  2 ++
 kernel/events/core.c            | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e3447cd9f..3c0e115dd8b7 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -679,11 +679,13 @@ struct perf_event_mmap_page {
  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
  *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_LOST_PINNED- PERF_RECORD_LOST event
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
+#define PERF_RECORD_MISC_LOST_PINNED		(1 << 13)
 /*
  * These PERF_RECORD_MISC_* flags below are safely reused
  * for the following events:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d18791a72d..523927575434 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3654,6 +3654,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
+static void perf_log_lost_event(struct perf_event *event);
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -3675,6 +3677,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+			perf_log_lost_event(event);
 		}
 
 		*can_add_hw = 0;
@@ -8414,6 +8417,39 @@ void perf_event_aux_event(struct perf_event *event, unsigned long head,
 	perf_output_end(&handle);
 }
 
+/*
+ * failed/errored events logging
+ */
+static void perf_log_lost_event(struct perf_event *event)
+{
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret;
+	struct {
+		struct perf_event_header header;
+		u64			 id;
+		u64			 lost;
+	} lost_event = {
+		.header = {
+			.type = PERF_RECORD_LOST,
+			.misc = PERF_RECORD_MISC_LOST_PINNED,
+			.size = sizeof(lost_event),
+		},
+		.id		= event->id,
+	};
+
+	perf_event_header__init_id(&lost_event.header, &sample, event);
+
+	ret = perf_output_begin(&handle, &sample, event,
+				lost_event.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, lost_event);
+	perf_event__output_id_sample(event, &handle, &sample);
+	perf_output_end(&handle);
+}
+
 /*
  * Lost/dropped samples logging
  */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

