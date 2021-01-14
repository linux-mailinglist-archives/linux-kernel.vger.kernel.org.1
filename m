Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5582F6D21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbhANVXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbhANVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:23:54 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:23:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t17so5643670qvv.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jzfFa6HK8DUXvWk641uxKNtwo7CfZc7SmxmcOl3szj8=;
        b=uPkijkzJUZRg1Tsm4KPprFQRfZBjaCGENNUVb0j7+yaO2bqAjGnAjuIRTU2BxDDX3x
         RU9gbc7ksXF7WbysxlB3zjK72tiJR7hgYYMBAmEc+g/bau1Gxci4CNUh7QzM3Mlm53uE
         QDSTkUXP98mgKk/WptnI9kroA1q9xVbDkU1F6B7tM4dyqIPu3MNeTTsN1zNc83B0ue61
         h7+lxXQ2Nqg6jrd39e7jHIftl1cXUpXmGk06ZeJmUd5kAUvyIH3Asvol4uqNIFKJ1JQ0
         xxrlDtlvM3k2VvUI+Xir729sa7khOtT4Y+hTHQfWj9CgUOINIjcdYGCKxpaAu/ggeiJV
         QbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jzfFa6HK8DUXvWk641uxKNtwo7CfZc7SmxmcOl3szj8=;
        b=LM4IiJFwuK4lsC5aNe7q77Am2ybwCclaOisaCAEVCwvy2BHNWGfdWeIsKnBEHw3i+C
         6c78qKT4Ip598e7i01SpKbELCPfscYSTR2v5hmW0HxXMfbqZPJdp6taAsnUV7pTv55Jy
         eC5vaLYVi24XNONBNhl/6Awt8Bsyz2OV0Npo+9ckj1J8fSlvzsxTE31rQ9MXMJ3mXEar
         wT1u+MqbzD5imDkkns7hEuUkiEDDs9sIbUBeHGHwZDITleApxZouJ0SkoHTQx23c7aRS
         p9cHcUdyigiTkvefh8H6whNxVDYyUNBoq1l5RVaV2Dwq1BT6ea8fwBJnBPpXRysVileq
         yNpQ==
X-Gm-Message-State: AOAM531677im+bHw012wQcCttj0RhSsS74r8bxvfIdeScTU4L8GWjo9U
        FkBWxKfVhsTYtK5/fQ/5xSyTDkrRll5/
X-Google-Smtp-Source: ABdhPJwFlpCJ5GBjzu3MDP3bCHVVTrSaIa+h5JD9NQCSdghwConJwX6t/kI+vXT347djyRjqxPv0XwxM28Lc
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:fd8f:: with SMTP id
 p15mr9165518qvr.48.1610659388226; Thu, 14 Jan 2021 13:23:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:23:04 -0800
Message-Id: <20210114212304.4018119-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH] libperf tests: Avoid uninitialized variable warning.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bf is read (for a write call) without being initialized
triggering a memory sanitizer warning. Use bf in the read and switch the
write to reading from a string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 6d8ebe0c2504..1b225fe34a72 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -208,7 +208,6 @@ static int test_mmap_thread(void)
 	char path[PATH_MAX];
 	int id, err, pid, go_pipe[2];
 	union perf_event *event;
-	char bf;
 	int count = 0;
 
 	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
@@ -229,6 +228,7 @@ static int test_mmap_thread(void)
 	pid = fork();
 	if (!pid) {
 		int i;
+		char bf;
 
 		read(go_pipe[0], &bf, 1);
 
@@ -266,7 +266,7 @@ static int test_mmap_thread(void)
 	perf_evlist__enable(evlist);
 
 	/* kick the child and wait for it to finish */
-	write(go_pipe[1], &bf, 1);
+	write(go_pipe[1], "A", 1);
 	waitpid(pid, NULL, 0);
 
 	/*
-- 
2.30.0.296.g2bfb1c46d8-goog

