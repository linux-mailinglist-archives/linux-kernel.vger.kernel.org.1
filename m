Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B02E29E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 06:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgLYF2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 00:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLYF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 00:28:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A3C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m5so2135932pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HfQeMTR9dHIFoLebfafxegiW3US03+p5EYWEz17ILko=;
        b=HvswmbMDL5uxqB0KAbPcLNnn+5vuDGciqdkPp8cLLiFowOTsnt2IpO66ZQq3/eFtND
         9RAVODop0575vtynRDfV8yk0g2eoRiSMLPj7ACMw9U86P6k45SkXO955Wb9FyxMwrGjm
         Qn6Z5WJWYHuzASpFJfIae3mF3TpQAbrYn1Uls/Dqd8LZh1JF4MRI0PuGZXpx+sLnhBN/
         n6vF2LUWpKWeTQAyXzAdaRYFymypMBc62kUu2uC6P1O+w4L56GkLs5452qAg6Ieji8dO
         nZYNdetwUmuFNUpdE6q8tWL9ShTWWI+6Ossq+vMHxbSJgjXV/nW3GoElhbUKFamCpF4N
         dfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HfQeMTR9dHIFoLebfafxegiW3US03+p5EYWEz17ILko=;
        b=Txl3dToxDFTVaz1j26SYTj83kij4lA+xICYKCuZk+vpggvKikwLgCDSQhNdv91l4Lp
         FET4NQp9OqPq317v7DrlMenyvg7Mb2ipzUCSJCWyB9rBx6rR6KceqWLEkqtu5KCv51EP
         26j/US5MOtF/GlWsR4H3Iu8vSYwrWxKAMp93PkjtGlBo2GcAJUmIZ9Tsb7a/DzbvgGB4
         LRjmfUkR5UaXFO4meCUcU9bBCMjlC/RJnXj50t49yJJpjaOHKfGkuL5UfXCTgpUG84FL
         L7WOK6oh0m7YNYbYLPZVVY5Tk58OQhUnOQ0YU7fr1jWQKR3s4CCCycxr+BiUGZROxj8h
         ybNQ==
X-Gm-Message-State: AOAM533F992CeYopKs0U+hJp86YB146A+KZj92TzXgGSWBVSyHEp08vI
        8EXOfxWAIuojFPbPgGp6hMtHug==
X-Google-Smtp-Source: ABdhPJxa4v8+ZEPmtpingASgL6mL9hIJ/HsSt0yN+89oa3vDVZanYG1LKPFxrCXADzFZ98phXDi9mA==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr7246522pjb.134.1608874090429;
        Thu, 24 Dec 2020 21:28:10 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id f15sm4156167pju.49.2020.12.24.21.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 21:28:09 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        He Zhe <zhe.he@windriver.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/3] perf probe: Fixup Arm64 SDT arguments
Date:   Fri, 25 Dec 2020 13:27:50 +0800
Message-Id: <20201225052751.24513-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201225052751.24513-1-leo.yan@linaro.org>
References: <20201225052751.24513-1-leo.yan@linaro.org>
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
 tools/perf/util/probe-file.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index bbecb449ea94..52273542e6ef 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -794,6 +794,8 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 	char *ret = NULL;
 	int i, args_count, err;
 	unsigned long long ref_ctr_offset;
+	char *arg;
+	int arg_idx = 0;
 
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
@@ -818,11 +820,43 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 		if (args == NULL)
 			goto error;
 
-		for (i = 0; i < args_count; ++i) {
-			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0) {
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
+				err = asprintf(&arg, "%s %s", args[i], args[i+1]);
+				i += 2;
+			} else {
+				err = asprintf(&arg, "%s", args[i]);
+				i += 1;
+			}
+
+			/* Failed to allocate memory */
+			if (err < 0) {
 				argv_free(args);
 				goto error;
 			}
+
+			if (synthesize_sdt_probe_arg(&buf, arg_idx, arg) < 0) {
+				free(arg);
+				argv_free(args);
+				goto error;
+			}
+
+			free(arg);
+			arg_idx++;
 		}
 
 		argv_free(args);
-- 
2.17.1

