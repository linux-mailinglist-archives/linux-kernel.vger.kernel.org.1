Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DC2EFE56
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbhAIHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:46:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF1C0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so9166310pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dF/EKdBMWNZukrtDgFeRBaQSiWHOXzvDtMysige8IMM=;
        b=diKFo4VOSz5+2ldh4AfV1QZNz/cCXen4m7HA5tvmSsq+HrOil8gfH0w8gHxF1twJfe
         IEOxH4puKJ1c6kSiYkGWx+ra4zzfWZL54en3bx4p6md+/8Y8kiJ7QoIljUr3oX1Rtx7O
         VN3WF1B4dDobQbkF5VndZgrDzY1fmvghrPP6kYXem/5i+YAms7GKVMGpgfUy12ZMlVIS
         mj+86A1oFjvDzvvEI3uVsoo3asL0cqOFzbSMibpcXxfC2Mm5qCZ3mNt5nYtLOkFWCnkx
         PCzpHesTIcCIFOtKJHEXOWf/Lt7Itjdip+3AydoGHH0jC1fvXzAQ6dj+vjdMl+Po0LRR
         Pbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dF/EKdBMWNZukrtDgFeRBaQSiWHOXzvDtMysige8IMM=;
        b=ImBJRQw9j7gy9MGL/Mm1pBLJjVUViFzx9LJ8g/TLpfZc0ODeGQ0gL52s1KIbR83cyz
         vXKLywG8eXRtCLLrvdp2zP/c9j06j3QO5dOhwCdVS1w75HhaxHWpdU0nsUPW8R3njp/u
         7HwqPaXrNFh3TW/w8HJj2iwF3dDElCQy4LxJulqRCKL3iiJXX0DUCQRM2dNWb452PvS7
         niOyLKzd2MsYry8lUSOqcTV4lAUSzIYFFnFj/pgO++vZXE2d/4J+qVSDvpK3P4zBXFnE
         DosSkX6woq6tQQXbNqVg/emLDEEfGOZZiCaZvyPe6qmWieK4b2F2Bo9Ny9JneVKBwAMH
         E4xA==
X-Gm-Message-State: AOAM533g8FHHpvntHGAIwe2HQDYMXZF9FAGOTblxMmtIMBSl+YcnO9P5
        Vkxhshbw+gYSO6RJE7teVemY9g==
X-Google-Smtp-Source: ABdhPJwKygRbWFTzLd1YAagyLsompFy5xCkGW8uIHWnEVp+Hs8y/4Y5lV3jiD9y1P8B4j0p+C4TLaw==
X-Received: by 2002:a65:648c:: with SMTP id e12mr10782768pgv.123.1610178310055;
        Fri, 08 Jan 2021 23:45:10 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id ay21sm7330832pjb.1.2021.01.08.23.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:45:09 -0800 (PST)
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
Subject: [PATCH v1 5/7] perf cs-etm: Fixup PID_FMT when it is zero
Date:   Sat,  9 Jan 2021 15:44:33 +0800
Message-Id: <20210109074435.626855-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the metadata item CS_ETM_PID_FMT/CS_ETMV4_PID_FMT is zero, this means
the perf data file is recorded with old version tool and the tool has
not extended to support the item.

For this case, this patch fixes up PID_FMT entry to set the value as
BIT(ETM_OPT_CTXTID), this info will be delivered to the decoder to
extract PID from packet's field "context_id".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 763085db29ae..8c125134a756 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -2577,6 +2578,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			for (k = 0; k < metadata_cpu_array_size; k++)
 				metadata[j][k] = ptr[i + k];
 
+			/*
+			 * If the data in CS_ETM_PID_FMT is zero, means the
+			 * information isn't stored in the data file, this is
+			 * because the old perf tool hasn't yet supported
+			 * CS_ETM_PID_FMT.  Fixup the item to option "CTXTID".
+			 */
+			if (!metadata[j][CS_ETM_PID_FMT])
+				metadata[j][CS_ETM_PID_FMT] = BIT(ETM_OPT_CTXTID);
+
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETM_ETMTRACEIDR];
 			i += metadata_cpu_array_size;
@@ -2590,6 +2600,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			for (k = 0; k < metadata_cpu_array_size; k++)
 				metadata[j][k] = ptr[i + k];
 
+			/*
+			 * If the data in CS_ETMV4_PID_FMT is zero, means the
+			 * information isn't stored in the data file, this is
+			 * because the old perf tool hasn't yet supported
+			 * CS_ETMV4_PID_FMT.  Fixup the item to option "CTXTID".
+			 */
+			if (!metadata[j][CS_ETMV4_PID_FMT])
+				metadata[j][CS_ETMV4_PID_FMT] = BIT(ETM_OPT_CTXTID);
+
 			/* The traceID is our handle */
 			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
 			i += metadata_cpu_array_size;
-- 
2.25.1

