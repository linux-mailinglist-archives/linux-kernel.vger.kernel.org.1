Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9C2C5FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392491AbgK0FoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392483AbgK0FoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:44:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 21:44:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so3522025pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 21:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KyoyRLPn2VjW1Dn9Oeq2by/YppU7fBj9WgqM013nTDw=;
        b=Ou4jr2bEeRSTpMTJBhUwfI/D+zwC/BtTPRXJvZBdHkyC3Ajgi7n8ylcHE2JLNRdyKg
         Xn5zuu1v0ZHl96Ge3qGWvQSapyTANg85kxSahJMc6aZXbxGH0EhYKVDxMerOtG95qx43
         xNBQXFXv39ILJSykauCr48fwbhZpEpjotI6PjGNfOa9I1ZiP+AdhpXaijQT4EMDUMG25
         40ZJjTxXqdCot34fMFBpWCJSqtF81i1g8dBfhYsKvH6N6dJl3rLtRbTgfcc+n6xcRnPz
         +zttToeBiVaMXkU8rUJZHOYP8yP1r03LNA2//9BTAJLWL0zMJ8dVjNAZfVHXsx6reO/V
         VgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KyoyRLPn2VjW1Dn9Oeq2by/YppU7fBj9WgqM013nTDw=;
        b=Uw05LHrhrH/LqTofTlW4faJIahina6QHArzxvQJoq+3sOMbwWW7zYgC/N/TCxLN4j3
         C8CAfhv/KAmCgkxZaa9BXC0FIghhj1YDmBqIgVj5wMU2TCm41t0gAkALOwnK0+/OfjG6
         COHlCGf+1/ljuqW37oWPXOj/2jZ5CbX6erBhw3vysZKYEGY4rYbRKRLzbYHjq/MTwHUR
         s9kdkXleP7+1X74QQ/JDaC4ioYAzGgba/HTtLvhtZyKt4p9mXMhDA5ZOEcyQsM6pAs6x
         s63adf4fvgzbaFgDwaTxb5ucPTVzlmtSWoZvQYW/Pqy5gXnlQ7F+LtVauqC5wvliPK2S
         wmFA==
X-Gm-Message-State: AOAM533eDnb+H3EYtzmqYOq/9s0JxWnIYFe8HlwzNYq8rUOikDUV3f99
        FhHTkPpj7ASBge6x+FDpL7Y=
X-Google-Smtp-Source: ABdhPJzChgKfyWxbRtLvE1tm9Y9seR3sLQ38id6fJ0uvdV9yzYDsfUjU4Vbi7E7JlSjJXgofCdogPw==
X-Received: by 2002:a17:90b:fd1:: with SMTP id gd17mr7738917pjb.148.1606455842557;
        Thu, 26 Nov 2020 21:44:02 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id w137sm4791569pfc.190.2020.11.26.21.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 21:44:01 -0800 (PST)
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
Subject: [PATCH] perf record: Synthesize cgroup events only if needed
Date:   Fri, 27 Nov 2020 14:43:56 +0900
Message-Id: <20201127054356.405481-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It didn't check the tool->cgroup_events bit which is set when
the --all-cgroups option is given.  Without it, samples will not have
cgroup info so no reason to synthesize.

We can check the PERF_RECORD_CGROUP records after running perf record
*WITHOUT* the --all-cgroups option:

Before:
  $ perf report -D | grep CGROUP
  0 0 0x8430 [0x38]: PERF_RECORD_CGROUP cgroup: 1 /
          CGROUP events:          1
          CGROUP events:          0
          CGROUP events:          0

After:
  $ perf report -D | grep CGROUP
          CGROUP events:          0
          CGROUP events:          0
          CGROUP events:          0

Fixes: 8fb4b67939e16 ("perf record: Add --all-cgroups option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8a23391558cf..d9c624377da7 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -563,6 +563,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
 	char cgrp_root[PATH_MAX];
 	size_t mount_len;  /* length of mount point in the path */
 
+	if (!tool || !tool->cgroup_events)
+		return 0;
+
 	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
 		pr_debug("cannot find cgroup mount point\n");
 		return -1;
-- 
2.29.2.454.gaff20da3a2-goog

