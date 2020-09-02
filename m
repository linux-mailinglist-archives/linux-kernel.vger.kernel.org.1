Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0287425A3EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 05:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBDPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 23:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIBDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:14:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767FC061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 20:14:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so261379qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLoaAoUtSGtp7+gBUBV6btVKeUPUq6rFicIl47OfSpo=;
        b=f1cKG9a0OBiCmD6lOGogf9UqOgWjT5icFCsyL+iw9hSyMMSj8T4o60ufsRQd0wUEPt
         oBHW+l5TXWjfDugQ2at9wTeXNkVybuCnbkTDajCMrNBRh6yS3fmMDxj8s+t8bU7Hw3Q9
         81MVzUyMMCxqu6gc6n2TBiRaJ1iNTyLraLggGLjdVkW7FzGifdBZAvLQMaaQolYMEvH3
         p7vFinyOZTFVy0WODinPa91XthDEDDOxtTmyFite2lQVsuPiG+cBqJo61kteg95Sx00P
         2Jotnfib9sG9/NpgjA9J0IfGBh6zxvAkX7iFOjL6qJOPF7OSg+0U4sNWkXOMzM2r/pbD
         DELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLoaAoUtSGtp7+gBUBV6btVKeUPUq6rFicIl47OfSpo=;
        b=cwlEKpOvr1csgg3krlndwRCRB29e2BsBxmqlxReqi/iIUF1G7aB5LQJOgTPG/c2Co/
         fz11Nr12MBxnVF9qDdzkNaYTRdVesVIVexx8BVeDzvfogzDtsJATwwhd0R209cMR7Evh
         XRoh3B+/jqyXnwSzkC7CrOwKb0MWlPnEeUyQJs4OaKDsltvSyYrEcNo7eZurBuOMuPnv
         MIEtu1+oa7VDP73z9KbpM/aBKFFs2qXbXWL7Dqd5XZP8cin2X65vILpugzeNTMzXoI5z
         i2s2Zy/gOcEWZPot9uwNb8UBYoUyKQMmomVM8OUNq9dtgja1pbLjWB57l3m8eA26vSoB
         QMlg==
X-Gm-Message-State: AOAM531XFb5znm3kIVoIZKmTixYwFlKPBV3GqPVeaOAlpv9hI5d8SSv6
        y84lSrxCjdrGpfXpmPabCFkimw==
X-Google-Smtp-Source: ABdhPJwz2z7JMP/w5QusfHVG4O/g1gp4R3KUabUxBwLDTLhP67qhIa0ZZaf67abU0RsiwtXNaJurdg==
X-Received: by 2002:a0c:a819:: with SMTP id w25mr4045773qva.100.1599016495404;
        Tue, 01 Sep 2020 20:14:55 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q35sm3755649qtd.75.2020.09.01.20.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 20:14:55 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: clock: add SM8150 QCOM video clock bindings
Date:   Tue,  1 Sep 2020 23:13:52 -0400
Message-Id: <20200902031359.6703-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200902031359.6703-1-jonathan@marek.ca>
References: <20200902031359.6703-1-jonathan@marek.ca>
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

