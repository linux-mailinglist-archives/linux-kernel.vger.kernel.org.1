Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F72B53EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgKPVo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:44:56 -0500
Received: from z5.mailgun.us ([104.130.96.5]:12904 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgKPVox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:44:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605563093; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KOp6edaSdp4EA6F1wsybQ0yhLlIQtFM9uSCrsTJodEI=; b=J0ljTTJbtmLlCx5JHYhP4pPHn9Kpe/5ZS/Y8CuTYp978MIIVZDustoa3ckyQQsedjnmbfBIW
 sOoFgHWI+YEDSzlLGqnIO0G8JIYGtzTgsxIvbmnCfU8e1tAVx7UKYRfbhmcYfPOOPqoiAEjK
 jgfNi5FAWiAAZ67A6qOSmRavSJI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fb2f2d4d6e6336a4ec39fd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 21:44:52
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF0C0C43465; Mon, 16 Nov 2020 21:44:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11965C433ED;
        Mon, 16 Nov 2020 21:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11965C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 2/3] firmware: scm: Add tracepoints to scm driver for pas calls
Date:   Mon, 16 Nov 2020 13:44:43 -0800
Message-Id: <1605563084-30385-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605563084-30385-1-git-send-email-rishabhb@codeaurora.org>
References: <1605563084-30385-1-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace events to the qcom_scm driver to trace pas calls.
These events can help us analyze the time impact for each scm
operation and can also serve as standard checkpoints in code.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/firmware/qcom_scm.c     |  9 +++++++++
 include/trace/events/qcom_scm.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/qcom_scm.h

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7be48c1..5bc9b65 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -19,6 +19,9 @@
 
 #include "qcom_scm.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_scm.h>
+
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
 
@@ -442,6 +445,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 	};
 	struct qcom_scm_res res;
 
+	trace_qcom_scm_call("Start scm_pas_init_image");
 	/*
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
@@ -467,6 +471,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 
 free_metadata:
 	dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
+	trace_qcom_scm_call("Complete scm_pas_init_image");
 
 	return ret ? : res.result[0];
 }
@@ -495,6 +500,7 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 	};
 	struct qcom_scm_res res;
 
+	trace_qcom_scm_call("Start scm_pas_mem_setup");
 	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
@@ -502,6 +508,7 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_clk_disable();
 
+	trace_qcom_scm_call("Complete scm_pas_mem_setup");
 	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_mem_setup);
@@ -525,6 +532,7 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 	};
 	struct qcom_scm_res res;
 
+	trace_qcom_scm_call("Start auth_and_reset");
 	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
@@ -532,6 +540,7 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_clk_disable();
 
+	trace_qcom_scm_call("Complete  auth_and_reset");
 	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_auth_and_reset);
diff --git a/include/trace/events/qcom_scm.h b/include/trace/events/qcom_scm.h
new file mode 100644
index 0000000..d918332
--- /dev/null
+++ b/include/trace/events/qcom_scm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_scm
+
+#if !defined(_TRACE_QCOM_SCM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_SCM_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(qcom_scm_call,
+
+	TP_PROTO(const char *event),
+
+	TP_ARGS(event),
+
+	TP_STRUCT__entry(
+		__string(event, event)
+	),
+
+	TP_fast_assign(
+		__assign_str(event, event);
+	),
+
+	TP_printk("qcom_scm_call event:%s", __get_str(event))
+);
+
+#endif
+#include <trace/define_trace.h>
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

