Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A642EFE57
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAIHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:46:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F0C0613ED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 30so9150039pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4OzOyv70Lhfq12F8FRvsAetz6bosZ6Up6z1SXm5NbU=;
        b=MRKGhr7eJRhmN9fkZMr5AF257GyyH9ZLwPvc2vQugCAUazcmLqVQ3BNC0WfQYhVoxO
         MIboq621Ct6wqDKEwP7FcQ1yyhaiMucScDXrCrj5u/iqTjYavcolW9JmwyJpozWMcUI0
         jF05XNu/Kn9sVBegFg8OwfpiqpD/0NM/Z+4NDkPY82IpHycPffb8SQmp8FUFc4Zzi/g3
         rNUCqk+DhGVOgjdwDPAQmBc8eyXY4vyZ0DakLKlBpP6SmWns+dhHNIZLau2ZKGMfJGEa
         uyhNCuxvErESioUpTVp+N+62vEFBNIHdCRegnL9xVuE8A0mFR+SyoifduoZqiTSb7yDl
         1KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4OzOyv70Lhfq12F8FRvsAetz6bosZ6Up6z1SXm5NbU=;
        b=bKyljlmoIDm4wW0Rv2RkkxjZ3WszndRVaeXt7hSVV8/97S6bc/4W4ltfY4/IF9yXlP
         HNpppiIoVu7ll6mMVCzli4ZiDJg2VrNRsIKEmPgU8XTbmG2pqj0iRSCov5etR7VDi1wJ
         R8/7KFCuFTMqVX3IXlgi4ba8AdmAkNNDqqKBxgOqkf8pkaDMBNO9Br/iGl6bBN8qhNVS
         aU6hw95Zq2a8/Y07ryjV7lJlRy62Knw4oxiz4P3MmKFPlpBxBzWfHVH4Vt7atSkOzS8V
         hY/80or9pfVq10bi4g/iQSHvI8qGy91JfVq8PiMmxHmM6xKzcjhRoL1QhbzywvzS/naC
         AlXA==
X-Gm-Message-State: AOAM530dxYF9chc1VXHjXjlkz7T4/RP23dsjAHjE5cmfbnqzo2CyKwZY
        gHyYDBFTH19YEdsegy4lvVoNyw==
X-Google-Smtp-Source: ABdhPJz059312bIOdjut/wKwfTvxECETX2CJluKIS2sy1Xom9WVZzFYE0xFijueYYkOXpr612t5kBg==
X-Received: by 2002:a62:1b06:0:b029:19d:d05d:f67a with SMTP id b6-20020a621b060000b029019dd05df67amr10514616pfb.78.1610178316718;
        Fri, 08 Jan 2021 23:45:16 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id o190sm11602324pga.2.2021.01.08.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:45:16 -0800 (PST)
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
Subject: [PATCH v1 7/7] perf cs-etm: Detect pid in VMID for kernel running at EL2
Date:   Sat,  9 Jan 2021 15:44:35 +0800
Message-Id: <20210109074435.626855-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The pid of the task could be traced as VMID when the kernel is
running at EL2. Teach the decoder to look for vmid when the
context_id is invalid but we have a valid VMID.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd007cc9c283..9e81169dfa76 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/zalloc.h>
@@ -500,13 +501,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
-	pid_t tid;
+	pid_t tid = -1;
+	u64 pid_fmt;
+	int ret;
 
-	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
-	if (!elem->context.ctxt_id_valid)
+	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
+	if (ret)
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	/*
+	 * Process the PE_CONTEXT packets if we have a valid
+	 * contextID or VMID.
+	 * If the kernel is running at EL2, the PID is traced
+	 * in contextidr_el2 as VMID.
+	 */
+	switch (pid_fmt) {
+	case BIT(ETM_OPT_CTXTID):
+		if (elem->context.ctxt_id_valid)
+			tid = elem->context.context_id;
+		break;
+	case BIT(ETM_OPT_CTXTID_IN_VMID):
+		if (elem->context.vmid_valid)
+			tid = elem->context.vmid;
+		break;
+	default:
+		break;
+	}
+
+	if (tid == -1)
 		return OCSD_RESP_CONT;
 
-	tid =  elem->context.context_id;
 	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-- 
2.25.1

