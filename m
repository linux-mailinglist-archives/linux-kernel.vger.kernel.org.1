Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE782D53A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgLJGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgLJGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:13:50 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 22:13:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f17so3236047pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 22:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMJIPhN5N3ygSU4SnE6hddzxu3jOILCMMlfPFjv7hS0=;
        b=RmA8bXWhH6YShbVhrwWQIdUzZw5vAuRqudwGXPUSmZfsgiLSCYDHIf41c/5Jcu46lN
         9Ecs0JWdEG+tGwzzIeNjGKCUpDz7idBjsUdP+NsXMEWdmPADJco0lFAX60VqhB+AegS0
         Ufs5lqFIB36gCmJ6yFZkiuqBz6DLKyXceeKKCDgwzzIzNxwituQxZI64fHdD7dKZNwaP
         QzNMxjIuBO5GCpMS1RCIqGdvB7MqtR/lGNSbyqV8cMvquyex2fozxTsdw0WGq6ea5+BX
         PD0HLlQfkRKQxMXebAiTNZDE6SuYDQdB+plZqT2GCwCXaYaVLAwBGeb5b4smdLrk4lbN
         0pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JMJIPhN5N3ygSU4SnE6hddzxu3jOILCMMlfPFjv7hS0=;
        b=iwCpA1h4YyG6FDcNltRNtF54MtnnQS9NqhDQHBJ51QgidifoxJCHhkyvMcSBB5p3vD
         3I8U9FKfto34uyQ2/wyRcey5vbdDMbHgTYvrgj6fSfyUqJ/24WcXUFXJSEn97iGs3zb3
         yjhSw0nVYrbvBBdLN0MRho/kF7m53nH+1IRY+cJPJ80m86mUgaPWeG1gdz/L/gpO9vII
         5qvvpCzDYNWc5P4u12QFzVl/7q2B1P+hqbdZIcTRze7hB4n+GCSWKrFjCJWXWDfi7pOp
         1PWPaKw4awbdKwAamYqJC0KvVOyolZ2hJg1mjm35XAKuJbmBg/GDK+UNT4GFBvz/gM/R
         EWqw==
X-Gm-Message-State: AOAM533ay8dEk17BwBzZDjC4N52/mMl0/Zc16k3DY7mjqlUHrFdEthGH
        7Nxt9DiMe66lPfKQugIyfhA=
X-Google-Smtp-Source: ABdhPJwdDwu9MZ2I/IFxxiM+vHWdgFpigRjug8NmSVXgYBP00HUo1N+ChMhRvnCK2828dgywTnXAwg==
X-Received: by 2002:a17:90a:b114:: with SMTP id z20mr5784237pjq.14.1607580789682;
        Wed, 09 Dec 2020 22:13:09 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id h11sm4771977pjg.46.2020.12.09.22.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 22:13:08 -0800 (PST)
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
Subject: [PATCH 1/2] perf report: Support --header-only for pipe mode
Date:   Thu, 10 Dec 2020 15:13:01 +0900
Message-Id: <20201210061302.88213-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --header-only checks file header and prints the feature data.  But
as pipe mode doesn't have it in the header it prints almost nothing.
Change it to process first few records until it founds HEADER_FEATURE.

Before:
  $ perf record -o- true | perf report -i- --header-only
  # ========
  # captured on    : Thu Dec 10 14:34:59 2020
  # header version : 1
  # data offset    : 0
  # data size      : 0
  # feat offset    : 0
  # ========
  #

After:
  $ perf record -o- true | perf report -i- --header-only
  # ========
  # captured on    : Thu Dec 10 14:49:11 2020
  # header version : 1
  # data offset    : 0
  # data size      : 0
  # feat offset    : 0
  # ========
  #
  # hostname : balhae
  # os release : 5.7.17-1xxx
  # perf version : 5.10.rc6.gdb0ea13cc741
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
  # cpuid : GenuineIntel,6,142,12
  # total memory : 16158916 kB
  # cmdline : perf record -o- true
  # event : name = cycles, , id = { 81, 82, 83, 84, 85, 86, 87, 88 }, size = 120, ...
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: intel_pt = 9, intel_bts = 8, software = 1, power = 20, uprobe = 7, ...
  # time of first sample : 0.000000
  # time of last sample : 0.000000
  # sample duration :      0.000 ms
  # MEM_TOPOLOGY info available, use -I to display
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5efbd0602f17..2a845d6cac09 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -226,6 +226,8 @@ static int process_feature_event(struct perf_session *session,
 		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
 		       event->feat.feat_id);
 		return -1;
+	} else if (rep->header_only) {
+		session_done = 1;
 	}
 
 	/*
@@ -1512,6 +1514,13 @@ int cmd_report(int argc, const char **argv)
 		perf_session__fprintf_info(session, stdout,
 					   report.show_full_info);
 		if (report.header_only) {
+			if (data.is_pipe) {
+				/*
+				 * we need to process first few records
+				 * which contains PERF_RECORD_HEADER_FEATURE.
+				 */
+				perf_session__process_events(session);
+			}
 			ret = 0;
 			goto error;
 		}
-- 
2.29.2.576.ga3fc446d84-goog

