Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD229ACE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900498AbgJ0NLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:11:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41678 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900491AbgJ0NLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:11:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id s9so1834798wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdzVNUmBorGOvHJ+kuujXmASC0q55W9RUZ1wT5ddYb4=;
        b=XL3n8URZ9/nfLX3xpUTkreqFiTCvhLbd3edP321U7deumP3SwL+CNrBhKQBC7WVEEj
         rl0EJqEa/2M3UvYBKdt4UGbtA6+okNwPigKuI0n2CrbVBsQ4MohEol1ehgw1/SIwLcHa
         eUC0pa+IvSOHijYIYXL7kZwNv7s2kk31YjG+zMwteNgJM7W8JBOAy1IShG1Wzw9ByK0C
         cXccgKR/2cBh2DnATn2IqnozPPM/LZ0mPBvWnoIPckintDaQaqoaZcFqeh/drfWsktFQ
         XPbckvfEaJnvn+eVZBJ+A6uX57uQa3LUQ04EQBEnNLRlRdLODxccpg4agk8WZJq27vaU
         QACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdzVNUmBorGOvHJ+kuujXmASC0q55W9RUZ1wT5ddYb4=;
        b=hCQlTv6mm0sos8mDfLEQpCiTw75vu3tJKRRrBbA+yfU6yukAQAzoLva2KJi1YQEiiM
         aBUcqh5YCcv+5QW2djNI0O56gXx8Jmy73Mg74izODL39Fu+UNxoPgmJC+bpfzuBSiy+G
         6vtjVtG7zAJgvTSoRIeVGWFpAHF402tKvV2d+0+z4TpAQRMUVTujhOU8IyRp/XiaYiGR
         FkJ6BOi3XDZLhjA94KOrp4l3CPrW1jjkUl/xDLBcd15cvW8GYXSFhNDNqieXhydx715f
         QNN7bvZ/YK+FhYzaneUdmQBeOimJ7whZWaqbJFLT7tZ+DgV/Tn4xDsj9CikSiCgh4M2n
         HQEw==
X-Gm-Message-State: AOAM530kHFY8z8a9BV+ONJYtawCdCko2CCB0wclMyLOBzescnbj9uxdt
        n/iWe1/3uyeVCdwxURkCFr5IMw==
X-Google-Smtp-Source: ABdhPJxoBc58msQkjTQ20On5cTV8fuD0bFRNORO6EcSQUdHPh39ckWgocQL7IVi4sOz4bXLDzKG48w==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr1396904wrm.80.1603804306588;
        Tue, 27 Oct 2020 06:11:46 -0700 (PDT)
Received: from localhost.localdomain (54.169.185.81.rev.sfr.net. [81.185.169.54])
        by smtp.gmail.com with ESMTPSA id v6sm1780117wmj.6.2020.10.27.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:11:45 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     enric.balletbo@collabora.com, Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: power: Add MT8167 power domains
Date:   Tue, 27 Oct 2020 14:11:20 +0100
Message-Id: <20201027131122.374046-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8167.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

This patch depends on the SCPSYS PM domains driver [0].

v2:
	* Implement on top of new SCPSYS PM domains driver [0]

[0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=370737

 .../power/mediatek,power-controller.yaml       |  2 ++
 include/dt-bindings/power/mt8167-power.h       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8167-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 0318ffb1133c..73e5452c3a5d 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -23,6 +23,7 @@ properties:
 
   compatible:
     enum:
+      - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
       - mediatek,mt8192-power-controller
@@ -59,6 +60,7 @@ patternProperties:
       reg:
         description: |
           Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
diff --git a/include/dt-bindings/power/mt8167-power.h b/include/dt-bindings/power/mt8167-power.h
new file mode 100644
index 000000000000..7e3babfc2eef
--- /dev/null
+++ b/include/dt-bindings/power/mt8167-power.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8167_POWER_H
+#define _DT_BINDINGS_POWER_MT8167_POWER_H
+
+#define MT8167_POWER_DOMAIN_MM		0
+#define MT8167_POWER_DOMAIN_DISP	0
+#define MT8167_POWER_DOMAIN_VDEC	1
+#define MT8167_POWER_DOMAIN_ISP		2
+#define MT8167_POWER_DOMAIN_CONN	3
+#define MT8167_POWER_DOMAIN_MFG_ASYNC	4
+#define MT8167_POWER_DOMAIN_MFG_2D	5
+#define MT8167_POWER_DOMAIN_MFG		6
+
+#endif /* _DT_BINDINGS_POWER_MT8167_POWER_H */
-- 
2.28.0

