Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBB2E190C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgLWGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLWGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:40:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w1so653652pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6uJ+kErWklNE/7gO57BMrhqrOWmHLQYq2mwzGxfa8Y=;
        b=PNLk4qHQtyvRwY/OmJ+vez7yBo96Xg4JAC2HxGo9NwlQ7I7yJ1JvpiPKQ4IERJQYTq
         FEKC9ejA3T56V0ynXpcGwnPjQoxBZMgP8OOFS709tcheaKJLa2bkXGmJetgp9wrrsXqA
         AbyoF8CEs2hP33xV7O4Ui0KkSIVPhp88FfOgHPm61IEonKSw5FmV5+WoPaebtXlHUoW5
         3DUoV7keG4zFcuCwqy76gtOE13KzxP02eCX/Bf8KZ7uQQ00m3DGeqFNuXmHdWL1pmMmr
         NyMiQV9L2VtAc7kfQRBwHHUVZ6ATalnRBM+GwL2Fz6pbqOpd4I7e0EPvIKRyKZwYlMMl
         bTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J6uJ+kErWklNE/7gO57BMrhqrOWmHLQYq2mwzGxfa8Y=;
        b=TDvuvn5MsrhO1+Rf4ezy6W/mEqErd9z6E3sq5PqEX+pbpqhwfQUpJjphjVWWoeLNIz
         CoQEP7FSbS1pIcEsulBFMtdJJY1ZjrnpdClIy3I70xuheJ5PJrbUHY8rXBPQjYT6lpr1
         gEh6EC8yp0ZEGcuRHK152m+tsU2Fnduh+gEE8GlLTjFrNN+Is8h/MPQKrWYLLEtlcZ69
         Y9/5ifRXApLDf9fZhm2Vo6EhZ++vW/yDcdiPIH6yGqFmasDcrnMaGO0mFRXbK6vyF0UI
         CJRlmdoaLLlG8OFw4zbQkLE0JGWXyC1fpDri5kIyqZ/mmC5LG8ErGxfpmWGiHLgacz+x
         8G5w==
X-Gm-Message-State: AOAM532n9rNGeLNkupnU+wC3lpXAsDHEs2JJcC5ZqSluVfGUY5AbPfiu
        4CtXZE4rhSUvvLAi7uGEfBVQdF3PDLbXvJxS
X-Google-Smtp-Source: ABdhPJwLdksuy3q/3B3+z2o6Vs3HiUJbLNYvWdNYiZ8lQF+JtLu0b2vU22cVoQnvbRHfayRlCXV3AQ==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr25581931pjb.232.1608705594570;
        Tue, 22 Dec 2020 22:39:54 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id n4sm22242926pfu.150.2020.12.22.22.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Dec 2020 22:39:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf probe: Fixup Arm64 SDT arguments
Date:   Wed, 23 Dec 2020 14:39:04 +0800
Message-Id: <20201223063905.25784-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223063905.25784-1-leo.yan@linaro.org>
References: <20201223063905.25784-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 ELF section '.note.stapsdt' uses string format "-4@[sp, NUM]" if
the probe is to access data in stack, e.g. below is an example for
dumping Arm64 ELF file and shows the argument format:

  Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]

Comparing against other archs' argument format, Arm64's argument
introduces an extra space character in the middle of square brackets,
due to argv_split() uses space as splitter, the argument is wrongly
divided into two items.

To support Arm64 SDT, this patch fixes up for this case, if any item
contains sub string "[sp", concatenates the two continuous items.  And
adds the detailed explaination in comment.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/probe-file.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 064b63a6a3f3..60878c859e60 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -794,6 +794,8 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 	char *ret = NULL, **args;
 	int i, args_count, err;
 	unsigned long long ref_ctr_offset;
+	char *arg;
+	int arg_idx = 0;
 
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
@@ -815,8 +817,34 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 	if (note->args) {
 		args = argv_split(note->args, &args_count);
 
-		for (i = 0; i < args_count; ++i) {
-			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0)
+		for (i = 0; i < args_count; ) {
+			/*
+			 * FIXUP: Arm64 ELF section '.note.stapsdt' uses string
+			 * format "-4@[sp, NUM]" if a probe is to access data in
+			 * the stack, e.g. below is an example for the SDT
+			 * Arguments:
+			 *
+			 *   Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]
+			 *
+			 * Since the string introduces an extra space character
+			 * in the middle of square brackets, the argument is
+			 * divided into two items.  Fixup for this case, if an
+			 * item contains sub string "[sp,", need to concatenate
+			 * the two items.
+			 */
+			if (strstr(args[i], "[sp,") && (i+1) < args_count) {
+				arg = strcat(args[i], args[i+1]);
+				i += 2;
+			} else {
+				arg = strdup(args[i]);
+				i += 1;
+			}
+
+			err = synthesize_sdt_probe_arg(&buf, arg_idx, arg);
+			free(arg);
+			arg_idx++;
+
+			if (err < 0)
 				goto error;
 		}
 	}
-- 
2.17.1

