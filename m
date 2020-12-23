Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6303C2E1BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgLWLR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:17:28 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF848C0613D3;
        Wed, 23 Dec 2020 03:16:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t22so10204422pfl.3;
        Wed, 23 Dec 2020 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8cSGTFdV6NDouRQh8ewWda9XJF0YqAiRaVhtmmVYqs=;
        b=FdVyJfiMZLgccBvmk28x2IxrfNCBbrDkEui8a2XFvqwT8XMQnbnq2eUij1zz6Z9FZ/
         Ac6DIc9SYTKcn7Fkf5L8DNH6xKPaahH8DctB5c6O/X8H3PZg3CsjLLsgeVhPqJW1AT8e
         QHtnlOxWWeCU7VeRwRE59prGitlRMHyQazqW19YCf1stXTjhu4+pQ2gVrKphwbUyZERH
         3zVAECN9nAcRlbrK0WEJ7eX+5JjUOkhMVqQ36KFKiATHTxPailU9agD0m2Mz5DDqMQsy
         PIswlgqE3Edb+PDN6kXRqfH6z1P5lutf+WC+15NxoBfyeRUu53lVu5sfBH5M7hEv+Xav
         1f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8cSGTFdV6NDouRQh8ewWda9XJF0YqAiRaVhtmmVYqs=;
        b=K6SMOOBOt/9awTM6jAmPmQz3bRlPssSLEXjG8lkPOHzTcI3LxahSipF+qWa5Dbbtmo
         eTHl+EPmNHWmT3Vc8ow21rimZItbB5dkOBRr5ty8mAiJ/ZK0KvV+uoY76snHfB1zVUjS
         5/xZC1G39ulyG0rX7W9rrkJi2uoBZ9TCuQxHlfp9B1jp/dVCF/lIa0u1/ocrCW5Qunis
         TVOGvwVQoSR+Q38Ofp9c7JV2iKnLp1+MmU0K9BTcn7EdW+zFYLaugiyAu70QULMskEQR
         MfCE1D2MF0Zc4/XhuXsc0WsYcEbTG/QdVbV9dB3Mn6Vv+UvngHulO6HQCZkWqNJD06dt
         YkeA==
X-Gm-Message-State: AOAM531Fi5ziEdaRz3BtdsEMYG8crXYdwaPb7y3npmuAMIkcdQkuX6QV
        eTQ+dK5LTVg1u6sZWCISnWQ=
X-Google-Smtp-Source: ABdhPJz8Q7qY4aMwzKG1OtlSYN46oJ8PbdL1vUkKfcU+6WDsOFNd/Q3biq6nIjtENA6Lt5NzGH6rSg==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr23820319pgb.332.1608722207535;
        Wed, 23 Dec 2020 03:16:47 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id ga12sm21771023pjb.48.2020.12.23.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:16:46 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>
Subject: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date:   Wed, 23 Dec 2020 19:16:32 +0800
Message-Id: <20201223111633.1711477-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch only adds bindings to support display iommu, support for others
would be added once finished tests with those devices, such as Image
codec(jpeg) processor, a few signal processors, including VSP(video),
GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4d9a578a7cc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc IOMMU and Multi-media MMU
+
+maintainers:
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,iommu-disp
+
+  reg:
+    maxItems: 1
+
+  "#iommu-cells":
+    const: 0
+    description:
+      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
+      additional information needs to associate with its master device.
+      Please refer to the generic bindings document for more details,
+      Documentation/devicetree/bindings/iommu/iommu.txt
+
+required:
+  - compatible
+  - reg
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu_disp: iommu@63000000 {
+      compatible = "sprd,iommu-disp";
+      reg = <0x63000000 0x880>;
+      #iommu-cells = <0>;
+    };
+
+...
-- 
2.25.1

