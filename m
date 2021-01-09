Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78D2EFE54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbhAIHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:45:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A95C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:07 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h186so7755127pfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBb9CTdjrCaMFSuv37sDBP44Tr8vgCGxsAMBQeMmvPk=;
        b=wUib81WgxJb23ACV58kgLXqy7B3iiG1FXO6+uepjDpylx5t7XtWXJaRyx1UWQ8tFFS
         JWFyGkXaymuJVJARpo1G2ArFT5JNrDgfTXm3YyCwNzffNXX/EDG2KOFeic4bx9a8lULU
         zV2YhLnDLqYIEaOcjlHJ10/azV1tul+3iWZIYDpU8k7JrOoNgR+QJI762BmMeNVKxaTd
         7eoWGDwW1ws7O1gzaOQgAqvLepYiWyFaAd8olKZISQBszjDUKtpYYYS1cTIjc/QZMJ90
         lGfz/5D0VihsvKUPtPzzjd3utUcgrVN+fM+M7uKitCBiCnbqpHH1YzKlk9UQycwJ29ZZ
         CW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBb9CTdjrCaMFSuv37sDBP44Tr8vgCGxsAMBQeMmvPk=;
        b=j6MbXlLUku58ObhHKEVhR520H58ZATZQHZeWbF3/4WDbnYjVzIyAbwH75ybPNaB5On
         FddM+P/ipKrfLg3oz8+c+RL/dqTB7UCQWxjhLra28BbgPb2jvx4RamGfCUl5tAwZQaps
         z4mQX/wW9B5zeaUg3j4G/AWylfF+krs5UpB1MZHWqA8WYrX3Yo1UsAlfqksnSaBQKSo0
         3g2b4i/DxWs8wgPr3uJA4CumH+Y+7JX2EWu/rNEBwDYQv88ZuBFm0/FbcSyWJ2p0rSik
         WqmWlsT91iuUDGq77VuA2+KKVQpP1p4noFNuLm/kPU6iCeOQpHjlgqqGmjGwK7SLDyjZ
         IzwA==
X-Gm-Message-State: AOAM530J4fOsY760AbHjS2VbVmc5wSAhnMGeEFZwO/l0YCHjJatccuU0
        tjSTxPQ5SVKTr7hQSkR+7jdk/g==
X-Google-Smtp-Source: ABdhPJzwdpapP0aNr8+muZOEh1vXlCI2en4/FOpH/5RUlCRozju4tXOh05m2lyzRedQacz4+gVR4YA==
X-Received: by 2002:a63:5942:: with SMTP id j2mr10550010pgm.33.1610178306716;
        Fri, 08 Jan 2021 23:45:06 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 73sm11721257pga.26.2021.01.08.23.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:45:06 -0800 (PST)
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/7] perf cs-etm: Add PID format into metadata
Date:   Sat,  9 Jan 2021 15:44:32 +0800
Message-Id: <20210109074435.626855-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for CoreSight to trace PID in either CONTEXTIDR_EL1 or
CONTEXTIDR_EL2, the PID format info is used to distinguish the PID
is traced in which register.

This patch saves PID format into the metadata when record.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 21 +++++++++++++++++++++
 tools/perf/util/cs-etm.c          |  2 ++
 tools/perf/util/cs-etm.h          |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index fad7b6e13ccc..ee78df3b1b07 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -613,6 +613,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+	u64 pid_fmt;
 
 	/* first see what kind of tracer this cpu is affined to */
 	if (cs_etm_is_etmv4(itr, cpu)) {
@@ -641,6 +642,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 				      metadata_etmv4_ro
 				      [CS_ETMV4_TRCAUTHSTATUS]);
 
+		/*
+		 * The PID format will be used when decode the trace data;
+		 * based on it the decoder will make decision for setting
+		 * sample's PID as context_id or VMID.
+		 */
+		pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
+		if (!pid_fmt)
+			pid_fmt = 1ULL << ETM_OPT_CTXTID;
+		info->priv[*offset + CS_ETMV4_PID_FMT] = pid_fmt;
+
 		/* How much space was used */
 		increment = CS_ETMV4_PRIV_MAX;
 	} else {
@@ -658,6 +669,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 			cs_etm_get_ro(cs_etm_pmu, cpu,
 				      metadata_etmv3_ro[CS_ETM_ETMIDR]);
 
+		/*
+		 * The PID format will be used when decode the trace data;
+		 * based on it the decoder will make decision for setting
+		 * sample's PID as context_id or VMID.
+		 */
+		pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
+		if (!pid_fmt)
+			pid_fmt = 1ULL << ETM_OPT_CTXTID;
+		info->priv[*offset + CS_ETM_PID_FMT] = pid_fmt;
+
 		/* How much space was used */
 		increment = CS_ETM_PRIV_MAX;
 	}
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e284725dceb..763085db29ae 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2447,6 +2447,7 @@ static const char * const cs_etm_priv_fmts[] = {
 	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
 	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
 	[CS_ETM_ETMIDR]		= "	ETMIDR			       %llx\n",
+	[CS_ETM_PID_FMT]	= "	PID Format		       %llx\n",
 };
 
 static const char * const cs_etmv4_priv_fmts[] = {
@@ -2459,6 +2460,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
 	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+	[CS_ETMV4_PID_FMT]	= "	PID Format		       %llx\n",
 };
 
 static void cs_etm__print_auxtrace_info(__u64 *val, int num)
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4ad925d6d799..8cbbea6100a1 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -38,6 +38,7 @@ enum {
 	/* RO, taken from sysFS */
 	CS_ETM_ETMCCER,
 	CS_ETM_ETMIDR,
+	CS_ETM_PID_FMT,
 	CS_ETM_PRIV_MAX,
 };
 
@@ -52,6 +53,7 @@ enum {
 	CS_ETMV4_TRCIDR2,
 	CS_ETMV4_TRCIDR8,
 	CS_ETMV4_TRCAUTHSTATUS,
+	CS_ETMV4_PID_FMT,
 	CS_ETMV4_PRIV_MAX,
 };
 
-- 
2.25.1

