Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4382EFE51
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAIHpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:45:38 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB2AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:44:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2so7733943pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zZpchzzFQSS1Vz9GJY3gB220lxq3Yt0vtCHbysiOHQ=;
        b=jIo67qTe9UoiSzFzGjMmxFWfWYZeDYurdIhM7bgcMvL7AsNyEB8C80jmQ72a6Cr7vK
         VTqG2b/YQYIQIYAJGcFQ8TquHRtFCw3KZxhs8rWNe5Cr6XxJmhzXjZJKxXnShm9s7LLV
         sE4ZOY44TiNjwWG2pXRhTG/sUrzs+cyqd9f9GdcjYKSYTp6sDPTZhYWy2vRFSxUkjYBO
         1ypqeXT45/mkl92o2POYETee4AIp2VLZOEOsfoDFyD2ME7FKippIsHYHPzOFbGHR/Ukw
         2Arjb7FS06fGzDUHiwgY4CK95LEPxJg7yEjQYJMyyOn0imzZqE2j+zLW8cLRfgZA1p2+
         /+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zZpchzzFQSS1Vz9GJY3gB220lxq3Yt0vtCHbysiOHQ=;
        b=E5e7KSFH1LpXrMUD41TdiVWYr4xGuosD/xgYMkATuQFWA1jNBuIwoCD0Ulx32J+e1w
         2p8SxcQR9WFISVV6zio+FXs9F5gejhEpTsnMgVEMqjw790SS/pAXig3E9nkV2yWIck5J
         LH/s1yIq2d4cbXacWBCulF09Lp24PwUYVLUrbWBBE85MKx5ESL19ayVbNk99DGuJrrNB
         d9alxyb173iEqmRqadKBFp2Kosw0a4+z616gT4ZET7g9D7gZMfK7xMUGvG7Bs39zsu5t
         blFqwy09/4lXOhGKS/EJ4SiumfHJNyXQyrDcCaw2JF0XSp23cHFxo7xCR+vEJZKz5YwL
         uvcw==
X-Gm-Message-State: AOAM530204QSOcDSupkVDl+CDerfCOOnyl0qjnUv0ELolfqGIHz8I1xT
        g3/MvUbviYBLQIZKGAw/Hnx7ztDItA6ZyWo2
X-Google-Smtp-Source: ABdhPJye7bbjVsAsKI7rUhlG/B48m4Qh7XWyo2LWTCvgEt9a7/rFmB+5v3pVnD4NQ4KmJxzyZDJgOA==
X-Received: by 2002:a63:f010:: with SMTP id k16mr10775149pgh.28.1610178296722;
        Fri, 08 Jan 2021 23:44:56 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e29sm11530149pfj.174.2021.01.08.23.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:44:56 -0800 (PST)
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
Subject: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing for kernel at EL2
Date:   Sat,  9 Jan 2021 15:44:29 +0800
Message-Id: <20210109074435.626855-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
Thus we should trace the VMID with VMIDOPT set to trace
CONTEXTIDR_EL2 instead of CONTEXTIDR_EL1. Given that we have an existing
config option "contextid" and this will be useful for tracing
virtual machines (when we get to support virtualization). So instead,
this patch adds a new option, contextid_in_vmid as a separate config.
Thus on an EL2 kernel, we will have two options available for
the perf tool. However, to make it easier for the user to
do pid tracing, we add a new format which will default to
"contextid" (on EL1 kernel) or "contextid_in_vmid" (on EL2
kernel). So that the user doesn't have to bother which EL the
kernel is running.

 i.e, perf record -e cs_etm/pid/u --

will always do the "pid" tracing, independent of the kernel EL.

Also, the perf tool will be updated to automatically select
"pid" config instead of the "contextid" for system wide/CPU wide
mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 14 ++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  9 +++++++++
 include/linux/coresight-pmu.h                      | 11 +++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdc34ca449f7..f763def145e4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -30,14 +30,28 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 /* ETMv3.5/PTM's ETMCR is 'config' */
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
+PMU_FORMAT_ATTR(contextid_in_vmid,	"config:" __stringify(ETM_OPT_CTXTID_IN_VMID));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
 /* Sink ID - same for all ETMs */
 PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 
+static ssize_t format_attr_pid_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *page)
+{
+	int pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID_IN_VMID : ETM_OPT_CTXTID;
+
+	return sprintf(page, "config:%d\n", pid_fmt);
+}
+
+struct device_attribute format_attr_pid = __ATTR(pid, 0444, format_attr_pid_show, NULL);
+
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_contextid.attr,
+	&format_attr_contextid_in_vmid.attr,
+	&format_attr_pid.attr,
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
 	&format_attr_sinkid.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b20b6ff17cf6..8b7c7a8b2874 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -477,6 +477,15 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
 
+	/* Do not enable VMID tracing if we are not running in EL2 */
+	if (attr->config & BIT(ETM_OPT_CTXTID_IN_VMID)) {
+		if (!is_kernel_in_hyp_mode()) {
+			ret = -EINVAL;
+			goto out;
+		}
+		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
+	}
+
 	/* return stack - enable if selected and supported */
 	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
 		/* bit[12], Return stack enable bit */
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index b0e35eec6499..927c6285ce5d 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
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
-- 
2.25.1

