Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883312E35A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgL1KCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgL1KCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:02:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293EAC061795;
        Mon, 28 Dec 2020 02:02:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z12so5700762pjn.1;
        Mon, 28 Dec 2020 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHfnNx0J3r3BjI2ETPq9kmvQWmw+pKoPMGoXArL8lcQ=;
        b=uuIkDnzFiQ46bqkuMSED83M1+xu9rcfblRWN/z96s1e/E7c/fN9Rt7wjv0khxii1SS
         s+XwH1wYSCfxvHtR1BYKdqkFPTwVoe8b82qEhylYMw2LbRVnAZNYBotbDosOk12b7OXT
         mcoKIwGT1zxTHV76dBr2nuOU1hHbk92H8SKlOxzJ6ejKDC0IcBjw34iI323jL2HrcInN
         vnnGQ0h6Ur9TNi6S1x/v2pOfRJ9qqVq9/XS9/f+YAq3mLJAOwWJcdYvIwOqxRprA7FbS
         FNDp1eNIoNu3+OSWZucW8ZFl+rsr54MSfyEjcvUdqgrmgUZbn+oKHEruRqcF8Nzh+1uZ
         bobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zHfnNx0J3r3BjI2ETPq9kmvQWmw+pKoPMGoXArL8lcQ=;
        b=gjIx4LuVWadsXVuUEDDqAbk29zxW1wJ8UkoiROjhEYXIfLrLjZHlF4ZacGXmPNDsoB
         xSOi7nyIQ1Fzf0sWNg5kzt/17A9L3SIa6NiMpSKyN0L47L7i6uDGO+OUKqET+kr/7vl0
         hCBLZubvPMp8ijNIaOjgQYBy2pUFwWLSo0F1SXONBWZ2mkF256Q0sN1UC6JNMJexufTn
         gmNK1YkFu+0x5C3C3wu8obwA3iwfhQS/xlek2quMXWc2nPSB4sIHrMXSibHsXiccGjyL
         newaW4jxULyhWg8Z+qJFd35R4niwiwRx338gbUDIhIhXh5HDvNgWCOnK/qJf+kypd0Sf
         OQMg==
X-Gm-Message-State: AOAM532qd0qaMAjO8l/gzfM2dB1HSyQ+zPdW+iN9de62DtQ1YZz/rEw6
        M3+SFPK/dCE+F14+Ges/lDY=
X-Google-Smtp-Source: ABdhPJw6MrtK9ABsb5+uxGCF/YNyyzyA3Wig1l4YTaVHxAp42e3RStEpPvNWMaEvOQq9OA/5WtxX2g==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr20231275pjd.204.1609149722779;
        Mon, 28 Dec 2020 02:02:02 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s1sm33775240pjk.1.2020.12.28.02.01.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 02:02:02 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 28 Dec 2020 18:01:42 +0800
Message-Id: <1609149707-21411-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
References: <1609149707-21411-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Unisoc's display pipeline have several components as below
description, multi display controllers and corresponding physical interfaces.
For different display scenarios, dpu0 and dpu1 maybe binding to
different encoder.

E.g:
  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
  dpu0 binding to DSI for primary display, and dpu1 binding to DP for external display;

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,display-subsystem.yaml       | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
new file mode 100644
index 0000000..3d107e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
@@ -0,0 +1,64 @@
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
+  Unisoc's display pipeline have several components as below description,
+  multi display controllers and corresponding physical interfaces.
+  For different display scenarios, dpu0 and dpu1 maybe binding to different
+  encoder.
+
+  E.g:
+  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
+  dpu0 binding to DSI for primary display, and dpu1 binding to DP for external display;
+
+          +-----------------------------------------+
+          |                                         |
+          |                            +---------+  |
+  +----+  |   +----+    +---------+    |DPHY/CPHY|  |   +------+
+  |    +----->+dpu0+--->+MIPI|DSI +--->+Combo    +----->+Panel0|
+  |AXI |  |   +----+    +---------+    +---------+  |   +------+
+  |    |  |                  ^                      |
+  |    |  |                  |                      |
+  |    |  |      +-----------+                      |
+  |    |  |      |                                  |
+  |APB |  |   +--+-+    +-----------+    +---+      |   +------+
+  |    +----->+dpu1+--->+DisplayPort+--->+PHY+--------->+Panel1|
+  |    |  |   +----+    +-----------+    +---+      |   +------+
+  +----+  |                                         |
+          +-----------------------------------------+
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

