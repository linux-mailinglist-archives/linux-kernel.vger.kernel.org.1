Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300E32EF17E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAHLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbhAHLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:40:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA8C0612F9;
        Fri,  8 Jan 2021 03:39:25 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id n7so7524656pgg.2;
        Fri, 08 Jan 2021 03:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG3QUss2Mw2LHvaADYDsO3W7gD6GpMHwEvXoc/WIGa8=;
        b=RG9EPVAGY8kQ+HP8A5vbzyQOVa8/2zlPM5vKCn8PVY8IsqDB6bF9YXeUBVWQDJ/oao
         /IyLuXuemocKHPLS5yJ7NwrKAKqmVMXgesgt3oAYxlcg0YTyXDAM0W2K8YsAQ05a41GA
         HyZSNBZQxTKrBVWA++JxdAIxp28kUk5vtuTO/OEHrCx+xQbbfagivRT9uS63NnpPHoPv
         OjLQCnxWt6e1upM3QMi1ZGbXG3g3BB9kplrzr7GXsAeQJAimTug7+FqjStwPJqT0jigF
         UnlGBGQrdf1Knqdg90nMBSXMcgq5BBrwcmk2twBGUu5+Is0/jZHYnlisLNKqW2WdwebZ
         CGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG3QUss2Mw2LHvaADYDsO3W7gD6GpMHwEvXoc/WIGa8=;
        b=OHIgdnh1Q2FAUkjC1y4Tkd3eMXgkD6XjBNxdpiR1ACSonxEsjzb6pfPmwZQx/38Ceu
         qU7ZOSA3K8rHL1F+wqcUCr4jRjM/WjQ5G/P6putO1RaE2j4M4rf0y21jVhOxaIqh9cDY
         hFQ0VSzEy4FZkydEC6KeJ8LyAvdLUHINyXqMQv1yvFP4U3m+Xt4qrIs9qUu+tQePmdgE
         drLcZS8UMlEXpwxKxsIfHiJJr0bxtTnAMZ64qCqgaQgKJ9K2e+UIRgFmgB6pLmkWXD9C
         v9e/JDhfyqrqf2yZE3BY8ITXnz6yr70Z0Y85H4ZWWzFp3Av6Z3XHXL0D/5CLoR7ncdwp
         cVMw==
X-Gm-Message-State: AOAM530QybwXsDojQ8OTgDhCJGFIT0hrKCk8ZfnbXhl8n0RWULPrXgaT
        BO3+q9BND7O3RQ8J5Z6hSQ78RAxsDQAt7g==
X-Google-Smtp-Source: ABdhPJw5IbfLiabVtdNH6drZOTeV31Atl25pgHRRcLuVyayr43zK8MJf683ZQ/PR0M7IdYTKFkx7Ug==
X-Received: by 2002:a63:d903:: with SMTP id r3mr6557255pgg.445.1610105965095;
        Fri, 08 Jan 2021 03:39:25 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id gm18sm4589136pjb.55.2021.01.08.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:39:24 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH V2 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date:   Fri,  8 Jan 2021 19:38:50 +0800
Message-Id: <20210108113851.354947-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108113851.354947-1-zhang.lyra@gmail.com>
References: <20210108113851.354947-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch only adds bindings to support display iommu.

The iommu support for others would be added once finished tests with those
devices, such as Image codec(jpeg) processor, a few signal processors,
including VSP(video), GSP(graphic), ISP(image), and camera CPP, etc.

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

