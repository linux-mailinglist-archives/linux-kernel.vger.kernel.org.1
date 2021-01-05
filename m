Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543022EAC41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbhAENrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbhAENrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDCBC061796;
        Tue,  5 Jan 2021 05:46:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m5so1712327pjv.5;
        Tue, 05 Jan 2021 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHfnNx0J3r3BjI2ETPq9kmvQWmw+pKoPMGoXArL8lcQ=;
        b=I1/5c9FKHoAjrf+5PqehvC/HSKYNkE7sAkdo7sz7TNmLP5hbCBQZJ9E8Dav+Glou5w
         Ynjc+9K2JwpOTOHftifYppyYWvuJDe6YGZZXl0aje+qB5V3n7P7r7PgKAUZD7Dltpzo8
         f//k/PBy/HdHVqUSP4iairbTIUjbojbqpgtnhGvoqjr9sjUJzP2w0aY1zSqrlLLCTJ41
         8Et27tjY+5YyVX+PhU53hTl1/qaLJPYmB90dKHQZOQfaEhJScVp73Imbxqf//fu16chM
         JYAeXwGNNC7gERJ07hbN0D4rclkuGhsemAXOSLgmvM6ooRyK9bNeiu2rFfvH7YeuWH+u
         suuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zHfnNx0J3r3BjI2ETPq9kmvQWmw+pKoPMGoXArL8lcQ=;
        b=lNEaQ2sRpliSSnnE2K4rmeVjUlx8SV8AOtirTRowFtVxMHrvk0Rk7k4dM+jwkCDgR7
         evdHyWtranV8fSzDUSqX9bY6gaWZSjH7CGiFCUg1dAFqLoDGLA/Bz0mF5KsaNdy8TT3H
         OWlZb1fhEejkjfkMryM6U3mXOoPrgVYsfu81+iqSbmOYEXQrLUI6am69Mz67zsBRCRQE
         rH/erd31i4K1UdmIN/ev05CBJS8duIoAq5a1n/jYV+vZOqDmm/dw+TQiElOoG35eyZ3P
         BJT+c18Avdhbghbfz5R/tITdEa5RrDyaGfWcUo4SbljBe0+5Dk1sOms8Ujdr5MI3trej
         vA/w==
X-Gm-Message-State: AOAM5303vH93YlZyCtbNd2XOMsPg1RgtJf6PwRnc/EHWeRftwZvXNzte
        ksczmx5vry0BmPvbxoSxmEE=
X-Google-Smtp-Source: ABdhPJyP4cHof0BEv5VIopYvsOWM1sFoMETO0LpHexGY1RBUIVD1pe2G4kV/wKnyxYyBobhqaMP/YQ==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr4062558pjz.168.1609854385451;
        Tue, 05 Jan 2021 05:46:25 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w63sm57582284pfc.20.2021.01.05.05.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:46:24 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Tue,  5 Jan 2021 21:46:02 +0800
Message-Id: <1609854367-2720-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
References: <1609854367-2720-1-git-send-email-kevin3.tang@gmail.com>
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

