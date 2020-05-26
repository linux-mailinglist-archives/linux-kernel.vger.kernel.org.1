Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19C1E02E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgEXVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbgEXVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:06:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFEC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w3so10465619qkb.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IO3OJdtgmbM1LhZ6cGI9jz8O0RG1bcFdj81mJPo7wxQ=;
        b=NO3qKV8cCmpf+ygMNPIzrFoEvyt+zJykJ1/ie15SO2f1o5FedXX4n+/UzuBqcoC3Nf
         yDGZe+BCT6huBeeGospBnny4RVZ+tRkKuq2Y9izZnKuT74hpSKu2UpFlLtTlH3kTIQAB
         EOG6EsIfPRmDZ88znIJgz2UPIXuo30E5OlXobONaaGeTB5+ty/Oq99cd5QK4pa3xTCXD
         fG1qAXWocHGUQMvjinVTXnaV6HU9orZ/4qvCVxEIiD/rSVP3D67sg9g8lbKHXqvVmiwL
         Dc/MDnGEPrDe8CQK+GR9nZlyit0rPKmmia7SlTMxozAV0QvdQDK9CS0OusQqF74bD6+e
         GKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IO3OJdtgmbM1LhZ6cGI9jz8O0RG1bcFdj81mJPo7wxQ=;
        b=DnF+WC58GRPCZLPcEMM6L+4lRerMw6LgWXlBeifbFQCQkNJpVYWgQnR++lTj3s5Dlp
         T2wVdCp/JzA9gpk5vAKB9NLJOkGGgjqO5KO2eeHfLat15jtG2g06BSGYpEWEPGmTiwbP
         xehB7929psgl9LqxiR3oTU7ZaIJPYZqJLE/NuT8//LqzUTTwVpEnqgXXlc69LF5DlWHH
         HDZHOVCTIC/v3iC3tDi7mYI7BhWRbgD0iFyN9JMeDQCHgi7eVN5uzBBc96U9c6QSB07P
         eBMVHvx1/cHhdyjKzvUr6zqv6YrljESOMUPbOvMM3STQ4k9NoBmY1UhRODpcLg1L9iQU
         fDkQ==
X-Gm-Message-State: AOAM530LrsutyisebVYeaFf5oazuGsgQle/cUHiFkvUEEvmrJl39aiMT
        PKbQ14LcW4HowPxdbKFxLVKBnA==
X-Google-Smtp-Source: ABdhPJxThCzNSKcre9wI4l6PVAIteQg0MMvMCOYd9/KL5Ys+NAfAIOXSet/6ldM8CHojzjiERs52RQ==
X-Received: by 2002:a37:b14:: with SMTP id 20mr18899833qkl.401.1590354387643;
        Sun, 24 May 2020 14:06:27 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g51sm4401769qtb.69.2020.05.24.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 14:06:27 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 06/10] dt-bindings: clock: Introduce SM8250 QCOM Graphics clock bindings
Date:   Sun, 24 May 2020 17:06:07 -0400
Message-Id: <20200524210615.17035-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524210615.17035-1-jonathan@marek.ca>
References: <20200524210615.17035-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 include/dt-bindings/clock/qcom,gpucc-sm8250.h | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8250.h

diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8250.h b/include/dt-bindings/clock/qcom,gpucc-sm8250.h
new file mode 100644
index 000000000000..c8fe64e399fd
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8250.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8250_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_APB_CLK			2
+#define GPU_CC_CX_GMU_CLK			3
+#define GPU_CC_CX_QDSS_AT_CLK			4
+#define GPU_CC_CX_QDSS_TRIG_CLK			5
+#define GPU_CC_CX_QDSS_TSCTR_CLK		6
+#define GPU_CC_CX_SNOC_DVM_CLK			7
+#define GPU_CC_CXO_AON_CLK			8
+#define GPU_CC_CXO_CLK				9
+#define GPU_CC_GMU_CLK_SRC			10
+#define GPU_CC_GX_GMU_CLK			11
+#define GPU_CC_GX_QDSS_TSCTR_CLK		12
+#define GPU_CC_GX_VSENSE_CLK			13
+#define GPU_CC_PLL1				14
+#define GPU_CC_SLEEP_CLK			15
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		16
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CX_BCR			1
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		2
+#define GPUCC_GPU_CC_GMU_BCR			3
+#define GPUCC_GPU_CC_GX_BCR			4
+#define GPUCC_GPU_CC_XO_BCR			5
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
2.26.1

