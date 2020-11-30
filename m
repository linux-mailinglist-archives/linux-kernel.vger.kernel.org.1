Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614322C86BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgK3O3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgK3O3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:29:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55994C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p21so14797pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMH70OZbYbfu4mqCg7tDH7/JmyKUq6CymvLW5yP/MDA=;
        b=l7prswL4S7CkRqcvc/1+W+Kx4kED2f9IeS1534ZKvGnq7944txC/XUHcKH+B7FWhqh
         h2tpJIsgRX83c4xgEGLP209fo+MUeJ2V+iB517xyXGKNfB/IwymV5hVYIMWwSHQaMluZ
         Qu+HDc2oNroEncGk2oyjZ0xEK4dVvvILl8XKmXuCfRrpPHe1tdLkz61fxzzwo1gyjgHD
         ltbvPZ6MMwro7wQorOurRud4N56AG5TfwARMrQF9XEn1qWisTdC/Di9DUh5Q/nbuTrL/
         f8DLW/LM0Wvi2CdjABE13ZjjIc/J5W3f/027+QDQqllOaYmbHffM2PCrOjPiYUu22Lti
         10Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMH70OZbYbfu4mqCg7tDH7/JmyKUq6CymvLW5yP/MDA=;
        b=VczOimJ/Z9coBVzxraQTcj/JIAZIl/1Dx8ndrlt/J1uOTxcJh77rCQ38xGB3+D/nwj
         9V3MBcNJEQBpUQxYCjCNh8yJUn/xN33v9QwZ9V//hg1W2Hopr+QZHwbcy25uDJ59VpuF
         d1OGsWMzBDzP0RWwxMjTt1yxLJeFBQtfLMVuDGcQoJUcTkUVL78TdiBjC+feLSPQBLT0
         B4bNdubxNq03D1972RhA4Msh5Ql+FS/rWG+nsZnRLiysrKEcdfsxmK1SHzG2OpU6ACM0
         l9sRTc9ppnpSoe8BJzT5Mtsxhv+iZxdjKpAAT3l/YROQHB4pRwnNv2sqcQfUyx4kHPDD
         FZyQ==
X-Gm-Message-State: AOAM531gtBRAvCGDbEqol+3+7dJ00FFR4okV51bNLJ5U+YgR2l3IODha
        l5qxZ1i9cj8tvr0Wtr0TWXc=
X-Google-Smtp-Source: ABdhPJwMRVGCkfmLoCENoxc2z9C1+NXLjoe2j2hWYrA46gYsYk38Oev3yliJaxfzLfYehzsW57wjxg==
X-Received: by 2002:a17:902:c401:b029:da:6fa4:d208 with SMTP id k1-20020a170902c401b02900da6fa4d208mr7690313plk.33.1606746523934;
        Mon, 30 Nov 2020 06:28:43 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 17sm15580479pfh.173.2020.11.30.06.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:28:43 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 30 Nov 2020 22:28:28 +0800
Message-Id: <1606746513-30909-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../display/sprd/sprd,display-subsystem.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
new file mode 100644
index 0000000..9487a39
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsystem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc DRM master device
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+description: |
+  The Unisoc DRM master device is a virtual device needed to list all
+  DPU devices or other display interface nodes that comprise the
+  graphics subsystem.
+
+properties:
+  compatible:
+    const: sprd,display-subsystem
+
+  ports:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should contain a list of phandles pointing to display interface port
+      of DPU devices.
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "sprd,display-subsystem";
+        ports = <&dpu_out>;
+    };
+
-- 
2.7.4

