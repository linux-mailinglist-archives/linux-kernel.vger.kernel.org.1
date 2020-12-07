Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34832D140C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLGOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLGOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:51:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF6C061604;
        Mon,  7 Dec 2020 06:50:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t8so10200017pfg.8;
        Mon, 07 Dec 2020 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrrEiyyZ4w15dxdldM0El36dYiAlZNUkE/azvm2gXww=;
        b=AY16VVGgkE9e7fMqvn+JJTlDm04VVbqbxGWOtyPG1a8qgcBmeTOWCAgxUcFLt1dxOo
         jeE5hbDZB6S+oKldBajg3LFQP/frVZDveH1rOzq7+kSfuFi1/E5mrwiqsjOIuzua7DdO
         Q1erIYF7qJfg+x1730gvs2DHqr911Z74cJXxQsTqXxytdCT0HpuQwOFTpE2/rF4+pgim
         ShsyJ1cRBIAU88WBSQIo3qYUcu5bpYNRVOx63MCyVxHTEHQ+v+8hd7i/8DMwSUmgIhXn
         f7r8nzTYCd6f7LrdoiF2qiGfqz5dtnYis/ewlo2gk7HjV6nUKZ9MlDtniKdWrGH6hGvX
         sUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrrEiyyZ4w15dxdldM0El36dYiAlZNUkE/azvm2gXww=;
        b=t3ao4xfjsH+u/uP/oEWVlrjx8mWdmKafGPCjzuecgwFYGLe8IrMFpvW/QFLMnrjRj/
         afVsyVZ3u7PGypR4gCPWPwBQx1KazJoJlx2+xsRy5ofFZJSdhkhFnm7/8lOpc7u9sS1O
         A9Qe7SfiVb7ZU6XpygmFZHQN8pJCU+oVHiZkjK/oFe6vbIHRw6ju0D12mxw9FUo9N0cR
         4Aa69wa1zmNP6zPc1pdGk0Vq2mP0ZV4klUi3IHtiEXfslJedrKGr2RqXLqqGlHIj1eUa
         3Z1p42N+USi7B6N9X3dlqb12In4Y/XlSNqrMAeAudfkYTL3clvPVkHcdzga+ShoLf/+J
         hGEA==
X-Gm-Message-State: AOAM533FWqp85eaJWa6ab5LohqiolxVFXm81jYWHWCr+1v8MqoMN9DkO
        mroO934desj/uyd3jcjkz6c=
X-Google-Smtp-Source: ABdhPJzqTGwAZtfbeQlp10zIoKme4tqqT1RSN9sFTLNtmDvRWBpwawh+ZzCn2fgffRuTGWqhUq9uGw==
X-Received: by 2002:a63:f708:: with SMTP id x8mr13092525pgh.369.1607352638443;
        Mon, 07 Dec 2020 06:50:38 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u25sm10360249pgl.68.2020.12.07.06.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:50:37 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon,  7 Dec 2020 22:50:21 +0800
Message-Id: <1607352626-26088-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
References: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
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

