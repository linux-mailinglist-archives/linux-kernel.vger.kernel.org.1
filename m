Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3A2FE8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbhAUL2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbhAULYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:24:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED2C0613D3;
        Thu, 21 Jan 2021 03:24:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so1132341plp.2;
        Thu, 21 Jan 2021 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lslmnlQrtpTIRDu3hWAi8sXwnSjS9donHChZd58khQg=;
        b=UXQlAdc3hwbMzWm7xePYi4qK9KThp0aPF+Fo8eaQ1m454i2Id/Fg4/2lnzVZNTBgSE
         FZWOCaKhIZ/w/ivuLaSJ2B1OBAtTUEy9gkaKWYiRQ631x4j4pJWFj7xbmWPflAoho9nx
         5TqVyroutmHFUHB3pls8vsLs3fXIoJ2ZtRZAJaKus50gRaXz5TP52PHIYHudHBo2KmHG
         d+wMkNBWjxiMYQD5ck/jol9G1dyhM3Ai4rZa8pdVwNDxsrUkX7iVLPJzc/Hd+9sbPMgD
         NRqXfPjni1Qj/64G4G1gha7qiLB0sgr0aWfZF2C/TG2c5iOX0QsU488ufpKl/6YGiDHA
         2ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lslmnlQrtpTIRDu3hWAi8sXwnSjS9donHChZd58khQg=;
        b=RvhidB7FxsCjnltIexnNR1wTtSJCrp4hQXN7x4M7rXE1rbQgjtAmJqqxcxavFdkX6v
         ksL+OPz/gwhpjglFzfFTn2CEDbsVdb+Io9eSxCVhRvCkGL+SJYi2G7Rpx4oHOcZHwaXV
         SJdC5mBa6Xnv2toWPt/+N3+StJxpsi4b2myc/PY/N5ktdx5tJWe79HZwOo3WvSLR/E70
         UIEHNyhYyXPw/TMOI0j/T66NUURsXWoecCRWxN6dzZY/9Su6axY/+uYodnpy1hPSgWca
         4oKWHVvRlPtoDwdpx94F2ngzb2dJP4I65Om7xN1a1Mkj7qubsXcsQ3lsdKfnMI14+xQb
         Vv9Q==
X-Gm-Message-State: AOAM530/A6XmWVT8B1ziuQrjW54XcyXuXwqBVQhrV8Vl7kQ8VGoTf5Bp
        jfhBCt1LrUQQWOTcAgacig6Apo1Y3dFH4Hgp
X-Google-Smtp-Source: ABdhPJxR2pyo41CIdOAqik7/AVjtgJxP91xCIN/od+oVRsP+mpgZY+ChDoR6zqNG4YsSW2ZmSO108w==
X-Received: by 2002:a17:902:e5cc:b029:df:bc77:3aba with SMTP id u12-20020a170902e5ccb02900dfbc773abamr9115606plf.72.1611228241858;
        Thu, 21 Jan 2021 03:24:01 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id me5sm5404797pjb.19.2021.01.21.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 03:24:01 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v1 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date:   Thu, 21 Jan 2021 19:23:48 +0800
Message-Id: <20210121112349.421464-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121112349.421464-1-zhang.lyra@gmail.com>
References: <20210121112349.421464-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch adds bindings to support display and Image codec(jpeg) iommu
instance.

The iommu support for others would be added once finished tests with those
devices, such as a few signal processors, including VSP(video),
GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4b912857c112
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,45 @@
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
+      - sprd,iommu-v1-disp
+      - sprd,iommu-v1-jpg
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
+      compatible = "sprd,iommu-v1-disp";
+      reg = <0x63000000 0x880>;
+      #iommu-cells = <0>;
+    };
+
+...
-- 
2.25.1

