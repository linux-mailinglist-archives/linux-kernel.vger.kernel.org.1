Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD92B6C35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKQRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgKQRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:49:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB62C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so10647634plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVl81ZS9fFrGd+ufPYRPV6WNHXbkD50mNDrAZQnv39A=;
        b=hkLaoiz2lCG8tln82zm7qfOl0cDYLureyURBuaXH0PW+24+gvVK577hO5cNqI/F2aV
         +GzMDYmWlne/pkBM+dzDfJnQpgrLbniED7sUDitRpnxxKZjuzR8aLV0dYiozsnsOmwn1
         9UHgFxx1EGsPczmBiB4PDynbbKEf8EDnIK5/jsO+eUuGGwO2CW6vU/uolWJExRUfW0Ig
         G4Fn3d8qgVU/z/93B6Yaq4oInZigk7lXpZpyUcXiaajbhasY2FeLedNhRlai/r3pYYrb
         XXb4u2iaMe7ReCIl9scVlGdGRvnn7UWb7invf8vBpD0I8VswVGhoBQLc5gUaHPzdyVph
         yqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVl81ZS9fFrGd+ufPYRPV6WNHXbkD50mNDrAZQnv39A=;
        b=Klnu7nXo98UUMJNhpg94KihCj0QbxpEdoITPy7mleccYa0Ngky/r40YrIg0sGHXzuU
         3GXlorFQL+yePcm3c6yBZ+osesslJNy5eVo4jk7NfsiN4cMme44QlJ0WtLgvQ4PQWOG2
         JoyvH1rN+KHYbt8/QWXwtDNcF+oJdkdfv9857JFU6KPXjhbmcwFEQAg3U7lKbwZRDJ4h
         W3N8DtHFXeBeKwpZolD+xG/LxwQEZJg5RP7hF6KyR+kcg3Ah3crATrxGR66T+Y3Dh7qp
         FFeDFAG0ZkuBuXGxowM/XDKgtTKUMvOsGIagu3IPl7OK/YWY1vrZOdgC7GSQf+pZExrI
         ADuA==
X-Gm-Message-State: AOAM5324fso66xUlJ/XL6IfLdgtG1fqRbwKVgQRT425LJqRl6OjmzskD
        /VkfZNH5BSIdqxcx4JgwlkCySesND3Ij
X-Google-Smtp-Source: ABdhPJxZXnb+Y1pWwUT4dnxesIRY7MEakGxf2a8hxor9743lNW9sz1zrysWJ+bDn30ZzJWekwpI2UA==
X-Received: by 2002:a17:90a:1b44:: with SMTP id q62mr201421pjq.59.1605635340003;
        Tue, 17 Nov 2020 09:49:00 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 192sm22222810pfz.200.2020.11.17.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:48:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: mtd: partitions: Add binding for Qcom SMEM parser
Date:   Tue, 17 Nov 2020 23:18:42 +0530
Message-Id: <20201117174845.28684-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
References: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML binding for Qualcomm Shared Memory (SMEM) Flash partition
parser.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../mtd/partitions/qcom,smem-part.yaml        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
new file mode 100644
index 000000000000..cf3f8c1e035d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/qcom,smem-part.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SMEM NAND flash partition parser binding
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  The Qualcomm SoCs supporting the NAND controller interface features a Shared
+  Memory (SMEM) based partition table scheme. The maximum partitions supported
+  varies between partition table revisions. V3 supports maximum 16 partitions
+  and V4 supports 48 partitions.
+
+properties:
+  compatible:
+    const: qcom,smem-part
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    flash {
+        partitions {
+            compatible = "qcom,smem-part";
+        };
+    };
-- 
2.17.1

