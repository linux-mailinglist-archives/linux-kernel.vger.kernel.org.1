Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159942A9358
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKFJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKFJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g12so526048pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gyYJX6U3NOEuwm2pQQw6iRTnTZ9dTHCKnboYno3Fn0=;
        b=eDPnQ/hPekJscHqaciQ0ydCVuC/LJl7Hm2zo/wyGXuuDwnDkz4JmTx0pQvyHssTZqu
         f8cC3cP/EJWGIPQniUiUrf2IiBZsraXM9CmsuE5wC+PMm50yixuOmndxPtrW3jiXj7jy
         Ks3JhNxfMx08yMwMwV0IUbzP2sSCAWOf6jwYB5+4UT+P2qyD5Czo0y6/MTgs+o22mocP
         rVirgEwlEI893jKtyCoqdCFvDX1OawYDyPPON2nhVjTy5v8364W/ebiHhRw+uK2qJsLX
         EAvIpzVxuSPU0AxP0GF8N1UGn72fBAN6+mIj+FJLWYC1wtqSuucSNEuP8A8WvxvI5m0V
         M3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6gyYJX6U3NOEuwm2pQQw6iRTnTZ9dTHCKnboYno3Fn0=;
        b=nIrlq9R6KH4+rsZ20PgJrheH6fMMgqIWcIqmaJWwyNMEFkfolyvyG2dD9mRAqrdfvF
         20FRPKnZ+D2kEnnw37z9uX6LWgiINGCXIosEt8auI9eMSRh55b+Wksz5DfCRye6E3CG2
         WeXleMVak6NdZSzBswyLDrd7WC6tkA6W1DcHRC2EEbOnAlhx1BTO7SGsoWoZFl5KOcyw
         tCbKzAEvE5b6CGEw6AUpkUeeDJbO92PlSMMnszsEgoI7GK93A0bwUWXFhUsFh+6G1/S1
         PfE2bEVpUBsnQhyBmdhsUZ8pyZKi6m4ZFHPFxW4SGgvzIL1L/tep7PZP7XSIjYMhO4Ji
         VBwg==
X-Gm-Message-State: AOAM533Y6I+6yVvJtGplDhKcIG4yjuOMO9j6/xjblRSr51GE3623+f3t
        SxnnfDX+v2UibCZgUSXZc5UFeg==
X-Google-Smtp-Source: ABdhPJwJJESyuv/z/ampf0Af9nG+/JX+ly1LGjU4MnWxGRtyVWfoXByhK/dBbzJMEBNd0dZC59Ub7w==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr1020087pgi.95.1604656191730;
        Fri, 06 Nov 2020 01:49:51 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id o70sm1417999pfg.214.2020.11.06.01.49.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:51 -0800 (PST)
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
Subject: [PATCH v4 6/9] perf auxtrace: Add itrace option '-M' for memory events
Date:   Fri,  6 Nov 2020 17:48:50 +0800
Message-Id: <20201106094853.21082-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add itrace option '-M' to synthesize memory event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index d3740c8f399b..079cdfabb352 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -11,6 +11,7 @@
 		d	create a debug log
 		f	synthesize first level cache events
 		m	synthesize last level cache events
+		M	synthesize memory events
 		t	synthesize TLB events
 		a	synthesize remote access events
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 42a85c86421d..62e7f6c5f8b5 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1333,6 +1333,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->flc = true;
 	synth_opts->llc = true;
 	synth_opts->tlb = true;
+	synth_opts->mem = true;
 	synth_opts->remote_access = true;
 
 	if (no_sample) {
@@ -1554,6 +1555,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'a':
 			synth_opts->remote_access = true;
 			break;
+		case 'M':
+			synth_opts->mem = true;
+			break;
 		case 'q':
 			synth_opts->quick += 1;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 951d2d14cf24..7e5c9e1552bd 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -88,6 +88,7 @@ enum itrace_period_type {
  * @llc: whether to synthesize last level cache events
  * @tlb: whether to synthesize TLB events
  * @remote_access: whether to synthesize remote access events
+ * @mem: whether to synthesize memory events
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -126,6 +127,7 @@ struct itrace_synth_opts {
 	bool			llc;
 	bool			tlb;
 	bool			remote_access;
+	bool			mem;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
-- 
2.17.1

