Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BD25CFA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 05:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgIDDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgIDDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:10:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C22C061247
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:10:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id db4so2399722qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 20:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLoaAoUtSGtp7+gBUBV6btVKeUPUq6rFicIl47OfSpo=;
        b=wcKDmDFhKCf/i3s6XQhoACLr+CO6BfT6c65H8XgfCtVFcv2eYdTWER+gcRIGT0MDVS
         PU5fhB46CSx9mNagPaJpnH4SfxjUqwr1kuME/OLT42B6rKY55Ed9DwA8ztknH6/V2UPD
         FdYu5dxtbUEwTY4+qZbsvBO4gq/YYfr2q8ntHkM5uXe31yLP74mvc5YE1WSTwk9JCris
         MHYhs8QTEC6BD85oM3ToXWlhIYRGAV9Y0FZiSlhIHvlPCLMlduMuvktvSkKzzh4iz9/u
         5otVUX5gVp5Jx6p2XLXsn6/j4hZhtIPBvddKR1Q59hvO7G6iLGmaq3znk/3rZIy0s/Ix
         GyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLoaAoUtSGtp7+gBUBV6btVKeUPUq6rFicIl47OfSpo=;
        b=fU0YFO+SddBeMQqsQt3pI5xFQgSdz9t4ZipEWnnzX/dobMgwYgmOv8B9dVkMLtvPuG
         LRVfTFjTsn3XWzwJRntXbMhgjaXAovLq8OiI20LYoISDbwCiL0CD498FmmGxuBZTFbLE
         2Vg7amInIcZ1IgKTRvKF0RNXyURRYeV9DjE7vqcu0Fmdw9EFTLifHLfKXeKu994onQv0
         fSAp/io8PijQv1Kb0wBaGXyM6rwmo4+OTEVbhtUSDoFmZ5hzsEItZ3c3wGZBZnJWK9P+
         4j9adO34rWhafwAfWu2ZWWBwna9I1djI+rMQGOE3vT9uTTlVLLq5IWA5BNneeLMWP3gs
         J+zg==
X-Gm-Message-State: AOAM530/tLsQALbun+1yIbZP8gtOVvG0b+FXe6q3k3+JPRhLndZH08ut
        7EbLds1n9XrhfjBmcgRi1a08/w==
X-Google-Smtp-Source: ABdhPJxrdnrjLKr++JZ16WV3P56hOKPjxUCpPOzsf37IvvrKHcAGQhY5VjTHwTnUPmFcIAs8Mdio5Q==
X-Received: by 2002:a0c:e082:: with SMTP id l2mr6100531qvk.157.1599189052164;
        Thu, 03 Sep 2020 20:10:52 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id x59sm3481063qte.14.2020.09.03.20.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 20:10:51 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] dt-bindings: clock: add SM8150 QCOM video clock bindings
Date:   Thu,  3 Sep 2020 23:09:51 -0400
Message-Id: <20200904030958.13325-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904030958.13325-1-jonathan@marek.ca>
References: <20200904030958.13325-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for video clock controller for SM8150 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/clock/qcom,videocc.yaml          |  4 ++-
 .../dt-bindings/clock/qcom,videocc-sm8150.h   | 25 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8150.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 17666425476f..d04f5bd28dde 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -11,17 +11,19 @@ maintainers:
 
 description: |
   Qualcomm video clock control module which supports the clocks, resets and
-  power domains on SDM845/SC7180.
+  power domains on SDM845/SC7180/SM8150.
 
   See also:
     dt-bindings/clock/qcom,videocc-sdm845.h
     dt-bindings/clock/qcom,videocc-sc7180.h
+    dt-bindings/clock/qcom,videocc-sm8150.h
 
 properties:
   compatible:
     enum:
       - qcom,sdm845-videocc
       - qcom,sc7180-videocc
+      - qcom,sm8150-videocc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,videocc-sm8150.h b/include/dt-bindings/clock/qcom,videocc-sm8150.h
new file mode 100644
index 000000000000..e24ee840cfdb
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,videocc-sm8150.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8150_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_IRIS_AHB_CLK		0
+#define VIDEO_CC_IRIS_CLK_SRC		1
+#define VIDEO_CC_MVS0_CORE_CLK		2
+#define VIDEO_CC_MVS1_CORE_CLK		3
+#define VIDEO_CC_MVSC_CORE_CLK		4
+#define VIDEO_CC_PLL0			5
+
+/* VIDEO_CC Resets */
+#define VIDEO_CC_MVSC_CORE_CLK_BCR	0
+
+/* VIDEO_CC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
-- 
2.26.1

