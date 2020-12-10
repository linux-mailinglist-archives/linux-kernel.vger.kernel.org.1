Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB12D53A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbgLJGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733117AbgLJGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:13:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB19C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 22:13:14 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so3218496pgi.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 22:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewcP/os7ifj5TNNLtL+55DBX7EviHxX0Oc4Bwwxb4QA=;
        b=llAT2POvAB75r2giSpl9cgBDWAX/ys6bYgY1EyeN+VSTkkOkk9VzmxI7+olcUGTqgP
         96Gmscgk62i669FCL4VyUcU3mhEvmAHVK1xjkpQzn9AIHtaQ/flkGlGhzBkeM8Uu19l/
         cDaepG8G44PAvAYCx36y3TnuMJw5CYSeTGysO8aP8Y864dSs5Bn+txat88MCsv5B389v
         AoNVH4qv8jCDExy4TFN2tssN43WOx9UiclBIlc0j3gc5yEOchvw83/AAvOGRCUwb1RAr
         L3Hxd9+Dn27wIVTdXnkQ8MuEdkyP3SsgDDjTG/UuWtQp1YvU4QbKziWtuVBzfPG2wiOH
         14Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ewcP/os7ifj5TNNLtL+55DBX7EviHxX0Oc4Bwwxb4QA=;
        b=elmO4AzTA3SpTPIaGjLiyj9fORdsjbftymBbS8caXKNR+mDOnh8hDSYrroDD/PucgK
         SpE0Yf/lUUvrfc52L7IzXb7Mlc+r/a0iuP3mowf7N9iyeWn84KimYN3+uN/uz6VonBLJ
         adxFZhfVmKeWgzlUn7VxUe0euQkpPcOY0Xf3H3EgOImUDrKUW/7b/uihIpMvloukP3Jm
         D3B2l5GmcHvpyLLdIcLGRBDbdaIxDMNkFNVzNjWYuzI6YvV/Ppt+xxMu8kPbSMgf66LF
         0sNopZ2e9K8S9hnHHFHsAuCjZGcX1LZuBMTq2v72qFsRJBNKowa1/+PAhpgMp27dCZmY
         Zp6Q==
X-Gm-Message-State: AOAM531AG+R2YKAOzOzRhkDAcxC/vzcRzWJ2UHqj65FeTUXaLjFgcBVx
        +b4ddv+g0DiTFSE/adPx9Nw=
X-Google-Smtp-Source: ABdhPJzRp1aCUYqkME6S2GkJhVYc8wzRmunWF24ZlfRUXOUljbmzQ0PUqqmKS4/nLm8yUJIy6FQYxQ==
X-Received: by 2002:a17:90a:4606:: with SMTP id w6mr5905840pjg.10.1607580793686;
        Wed, 09 Dec 2020 22:13:13 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id h11sm4771977pjg.46.2020.12.09.22.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 22:13:13 -0800 (PST)
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
Subject: [PATCH 2/2] perf evlist: Support pipe mode display
Date:   Thu, 10 Dec 2020 15:13:02 +0900
Message-Id: <20201210061302.88213-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210061302.88213-1-namhyung@kernel.org>
References: <20201210061302.88213-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise, perf evlist command should print event attributes by reading
PERF_RECORD_HEADER_ATTR records.

Before:
  $ perf record -o- true | ./perf evlist -i-
  (prints nothing)

After:
  $ perf record -o- true | ./perf evlist -i-
  cycles:pppH

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-evlist.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 98e992801251..4617b32c9c97 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -17,6 +17,14 @@
 #include "util/data.h"
 #include "util/debug.h"
 #include <linux/err.h>
+#include "util/tool.h"
+
+static int process_header_feature(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
+{
+	session_done = 1;
+	return 0;
+}
 
 static int __cmd_evlist(const char *file_name, struct perf_attr_details *details)
 {
@@ -27,12 +35,20 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
+	struct perf_tool tool = {
+		/* only needed for pipe mode */
+		.attr = perf_event__process_attr,
+		.feature = process_header_feature,
+	};
 	bool has_tracepoint = false;
 
-	session = perf_session__new(&data, 0, NULL);
+	session = perf_session__new(&data, 0, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (data.is_pipe)
+		perf_session__process_events(session);
+
 	evlist__for_each_entry(session->evlist, pos) {
 		evsel__fprintf(pos, details, stdout);
 
-- 
2.29.2.576.ga3fc446d84-goog

