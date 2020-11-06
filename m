Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0182A935B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKFJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKFJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:50:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F85C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:50:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so813056pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILWWMC+AJIBjzFX4DDF2uqdjSVU6HVG1cDD622d/Z14=;
        b=o/zsdk0MYdA3+OjXAHB4Q5EolCthoG0Uc1Tm9hDPo81yAL86/NGa1bQBcmJt3vClKS
         sfJHWhOwtj036yMY6FB+9Yx1SUwKe+acy7GPAtvhsXRs/byQNu6XsA8Xk6JGASTETWoH
         9tg1ykxHTPkiJD+eCk7JwFt+UKlROYKRgviaem9/ezEOBAVeUsJv8GF92epkvSj2rZIJ
         P3ZD10OO3P7fsqmu0DOVPXy+IVQlOIWFi/g6Tvmwc5/rghaVSV6aFvBtZXZ0AzHWXyDD
         h0buN6x0igG58B9280pvMNqxfDueh6CocLFWCeUdD+fCEp8i7DoobCEFLs5HalPIDa7q
         Qxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILWWMC+AJIBjzFX4DDF2uqdjSVU6HVG1cDD622d/Z14=;
        b=nX1qu9K7YBULzYh8sCA4it/RXT6jfy4zmT44WLI2nbRPBKjC6Bg4qdnqsQhuwV62ht
         uuJHJKDC3MvjqB0plbffGw7EBzItf7QN03B7aLhwdVM1jKA+tTpsA2AhdBJu16Jopwgx
         6IOo5tCMcYBgrV+3zdjxGNl8H19ZzVy0nyIWvHFpNGtt+ElrscxmvGoeYnwrKMl55tEV
         v7EftmrZbYMj8Uo6S1OKHbrGZz8eyaN8b+MGoYPWQaSGb0eqpYZvNYSToQP4PQZWwtzr
         +5LPSfLxQcKCQnPjdDfhA8CspTC7jB+MD5v4al0jnSMuOmy55Q2eEF7OZm/BkxmbDNmv
         Z92A==
X-Gm-Message-State: AOAM532Kv2WKhyckI2tWVEDG5h3yENhl+od/sCb4aO8+Vp8yBlsGrrAy
        IQ2gVWNH0P8qcZHsL8gRc8qsNQ==
X-Google-Smtp-Source: ABdhPJyFb/tZZFeyGSfVT09TIevO/mVqY52Rn1dBHNCV4+JW0BQ32q72IJDGavChxDl8bQVZu2OWWw==
X-Received: by 2002:a17:90a:ce8c:: with SMTP id g12mr1598141pju.181.1604656204657;
        Fri, 06 Nov 2020 01:50:04 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id s18sm1585697pfc.5.2020.11.06.01.50.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:50:04 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 8/9] perf c2c: Support AUX trace
Date:   Fri,  6 Nov 2020 17:48:52 +0800
Message-Id: <20201106094853.21082-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the AUX callbacks in session structure, so support
AUX trace for "perf c2c" tool; make itrace memory event as default for
"perf c2c", this tells the AUX trace decoder to synthesize samples and
can be used for statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 98ae33eac6cc..c5babeaa3b38 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -369,6 +369,10 @@ static struct perf_c2c c2c = {
 		.exit		= perf_event__process_exit,
 		.fork		= perf_event__process_fork,
 		.lost		= perf_event__process_lost,
+		.attr		= perf_event__process_attr,
+		.auxtrace_info  = perf_event__process_auxtrace_info,
+		.auxtrace       = perf_event__process_auxtrace,
+		.auxtrace_error = perf_event__process_auxtrace_error,
 		.ordered_events	= true,
 		.ordering_requires_timestamps = true,
 	},
@@ -2678,6 +2682,12 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 
 static int perf_c2c__report(int argc, const char **argv)
 {
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = true,
+		.mem = true,	/* Only enable memory event */
+		.default_no_sample = true,
+	};
+
 	struct perf_session *session;
 	struct ui_progress prog;
 	struct perf_data data = {
@@ -2757,6 +2767,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out;
 	}
 
+	session->itrace_synth_opts = &itrace_synth_opts;
+
 	err = setup_nodes(session);
 	if (err) {
 		pr_err("Failed setup nodes\n");
-- 
2.17.1

