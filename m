Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98222EFE52
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbhAIHpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:45:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C2C061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so9147286pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQMCubmgzlrRTa03+kmNvTwcrwNhs1nXf3jbRihBgmo=;
        b=JPQAm8mKkZrg0ceXulqBGIaytFxCQsnVgLuM6fuf2yKXNydlAgB1ORNGeDTtV6oIno
         9Hi/KbJ4PBf332SxeI624u1oirZIHqJmRSVgyaHl+BBXrdJ31L6cPGfjCBdpaoawGbB6
         y9uSL/y9E4WyBKE1iXJKoXvYaLPuR8EfS4IDpU0DwBLIMtr8HzSlHxKv6E26BF+IhNEG
         NBhY4THkePFvw7ceywId+66QiJy36rnaXz3Zjm7YBm8BIbKM59HxqGuM25qBJ31viZYP
         ZQFtREygT/82YmF7d5dNOexb6baO+YyMaofc6iARj3qm5ox8ICWyizMYQN7b8803TxgQ
         dQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQMCubmgzlrRTa03+kmNvTwcrwNhs1nXf3jbRihBgmo=;
        b=eapt6g9UhWgSzzQm1u2k0fI0FrNxv21RDFfXcO8GvR5Knt+DOQjTyzqcVPhR6PPnKu
         YBJXQSMAFzaNEGNhJ8/sZaJIqQ1KBzc3OyypO4ZFZjJNL+nTnhz6BVVvfqZGGqr4sSzS
         e/v5IGfc3tDEwseBz9LldtKCfAiaUEwy2Vt6HPDDCQ4xgTZ52l+GcUJs+loTEnaN+cHr
         cHELw0GcNM0tggzcjYY2ljmW2z076LvAsDX+2q53S47b/mQ+OLJm3Ng1ndkxgRxY4qV4
         aLtVe4hW5NNerxrcxiXuoWRJm5QyRYDLKjopod9B0SiuDjYXPUGk1mmJGAuEA0jrqWc4
         ia9g==
X-Gm-Message-State: AOAM530Y5QaMHBLeLutSTCJs3QFBVUa4DuZnjDmX0dc9/Gj4lrkrop2g
        SovZjGIc0dR3+vNapRDI0kVyfw==
X-Google-Smtp-Source: ABdhPJw7tGBumAzkMbsznaxaXFQcycez6QVQ8esQCZu5MaJ/vujTzQ+/xlrWfTsfrdeSDOgpzQi07Q==
X-Received: by 2002:a65:690e:: with SMTP id s14mr10637219pgq.302.1610178300076;
        Fri, 08 Jan 2021 23:45:00 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id f64sm11488855pfb.146.2021.01.08.23.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:44:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/7] perf cs_etm: Use pid tracing explicitly instead of contextid
Date:   Sat,  9 Jan 2021 15:44:30 +0800
Message-Id: <20210109074435.626855-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If the kernel is running at EL2, the pid of the task is exposed
via VMID instead of the CONTEXTID. Add support for this in the
perf tool.

By default the perf tool requests contextid and timestamp for
task bound events. Instead of hard coding contextid, switch
to "pid" config exposed by the kernel. While at it, define new
independent macros (rather than using the "config" bits) for
requesting the "pid" and "timestamp" for cs_etm_set_option(),
since the PID config is now dynamic depending on the kernel
exception level.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 11 +++--
 tools/perf/arch/arm/util/cs-etm.c   | 68 ++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index b0e35eec6499..927c6285ce5d 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -11,16 +11,19 @@
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
 /* ETMv3.5/PTM's ETMCR config bit */
-#define ETM_OPT_CYCACC  12
-#define ETM_OPT_CTXTID	14
-#define ETM_OPT_TS      28
-#define ETM_OPT_RETSTK	29
+#define ETM_OPT_CYCACC		12
+#define ETM_OPT_CTXTID		14
+#define ETM_OPT_CTXTID_IN_VMID	15
+#define ETM_OPT_TS		28
+#define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
 #define ETM4_CFG_BIT_CTXTID	6
+#define ETM4_CFG_BIT_VMID	7
 #define ETM4_CFG_BIT_TS		11
 #define ETM4_CFG_BIT_RETSTK	12
+#define ETM4_CFG_BIT_VMID_OPT	15
 
 static inline int coresight_get_trace_id(int cpu)
 {
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index cad7bf783413..fad7b6e13ccc 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -59,14 +59,15 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
 
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
 
-static int cs_etm_set_context_id(struct auxtrace_record *itr,
-				 struct evsel *evsel, int cpu)
+static int cs_etm_set_pid(struct auxtrace_record *itr,
+			  struct evsel *evsel, int cpu)
 {
 	struct cs_etm_recording *ptr;
 	struct perf_pmu *cs_etm_pmu;
 	char path[PATH_MAX];
 	int err = -EINVAL;
 	u32 val;
+	u64 pid_fmt;
 
 	ptr = container_of(itr, struct cs_etm_recording, itr);
 	cs_etm_pmu = ptr->cs_etm_pmu;
@@ -86,21 +87,50 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 		goto out;
 	}
 
+	pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
 	/*
-	 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
-	 * is supported:
-	 *  0b00000 Context ID tracing is not supported.
-	 *  0b00100 Maximum of 32-bit Context ID size.
-	 *  All other values are reserved.
+	 * If the kernel doesn't support the "pid" format (older kernel),
+	 * fall back to using the CTXTID.
 	 */
-	val = BMVAL(val, 5, 9);
-	if (!val || val != 0x4) {
+	if (!pid_fmt)
+		pid_fmt = 1ULL << ETM_OPT_CTXTID;
+
+	switch (pid_fmt) {
+	case (1ULL << ETM_OPT_CTXTID):
+		/*
+		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
+		 * tracing is supported:
+		 *  0b00000 Context ID tracing is not supported.
+		 *  0b00100 Maximum of 32-bit Context ID size.
+		 *  All other values are reserved.
+		 */
+		val = BMVAL(val, 5, 9);
+		if (!val || val != 0x4) {
+			err = -EINVAL;
+			goto out;
+		}
+		break;
+	case (1ULL << ETM_OPT_CTXTID_IN_VMID):
+		/*
+		 * TRCIDR2.VMIDOPT[30:29] != 0 and
+		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
+		 * We can't support CONTEXTIDR in VMID if the size of the
+		 * virtual context id is < 32bit.
+		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
+		 */
+		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
+			err = -EINVAL;
+			goto out;
+		}
+		break;
+	default:
 		err = -EINVAL;
 		goto out;
 	}
 
+
 	/* All good, let the kernel know */
-	evsel->core.attr.config |= (1 << ETM_OPT_CTXTID);
+	evsel->core.attr.config |= pid_fmt;
 	err = 0;
 
 out:
@@ -156,6 +186,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
 	return err;
 }
 
+#define ETM_SET_OPT_PID		(1 << 0)
+#define ETM_SET_OPT_TS		(1 << 1)
+#define ETM_SET_OPT_MASK	(ETM_SET_OPT_PID | ETM_SET_OPT_TS)
+
 static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct evsel *evsel, u32 option)
 {
@@ -169,17 +203,17 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		if (option & ETM_OPT_CTXTID) {
-			err = cs_etm_set_context_id(itr, evsel, i);
+		if (option & ETM_SET_OPT_PID) {
+			err = cs_etm_set_pid(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ETM_OPT_TS) {
+		if (option & ETM_SET_OPT_TS) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+		if (option & ~(ETM_SET_OPT_MASK))
 			/* Nothing else is currently supported */
 			goto out;
 	}
@@ -406,7 +440,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 		err = cs_etm_set_option(itr, cs_etm_evsel,
-					ETM_OPT_CTXTID | ETM_OPT_TS);
+					ETM_SET_OPT_PID | ETM_SET_OPT_TS);
 		if (err)
 			goto out;
 	}
@@ -485,7 +519,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 		config |= BIT(ETM4_CFG_BIT_TS);
 	if (config_opts & BIT(ETM_OPT_RETSTK))
 		config |= BIT(ETM4_CFG_BIT_RETSTK);
-
+	if (config_opts & BIT(ETM_OPT_CTXTID_IN_VMID))
+		config |= BIT(ETM4_CFG_BIT_VMID) |
+			  BIT(ETM4_CFG_BIT_VMID_OPT);
 	return config;
 }
 
-- 
2.25.1

