Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DAD27A789
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgI1G1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1G1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:27:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BDC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:27:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so29395pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/YkV3j0PuCHVneaFRnKH2O393BGuMCEHqD/8icBnHI=;
        b=rIqM/cdqvFK+rTkrDnGH2WrIpOQvCJYGGixvTcmKGGVgyo4H37+i/0ymPvcQOXVTBb
         HuG/FLQaDWsdycSZIzqkEJnyYSk0lUiCbF3vSwsRw7Ed2A4buODNNLjWIAPxFXX5UQ8z
         lLhsW2E1IvQovjYEeCa6+Xu9L7QDX8erTCr8GyG1t61ExUaBmez+Zc2M+xePDlOnA3un
         l4ykqTEl4bxfatStFwHqeGOwNZnw4ETec9e8Rp2Dlch5RycRmxNd/2fkyzHjmHXgw3lg
         3vUl9j2tgkgEyfRCn5J1B7zVpymf0/fO3Huv06HhfBwPgXfPWWcTuAdnjHShN3ha9i3V
         uhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/YkV3j0PuCHVneaFRnKH2O393BGuMCEHqD/8icBnHI=;
        b=fdyISJC/elWsjTGN3uE67r6Sn/c6de0DNCvq35Bj8VTdmWezdeLpdmOhHJgm4OpnHm
         eMsQX9QuTLoiA0pfs1fEjXMlsj+PQcgncxlle6mExh6VfvCZTy5byVDrfuoR8aw9omiN
         nprdYxaCE85A/BrtRkPM2slIBYREmLGGrLU8iWxrU4vbMq1s/Y3Y8pD03WrIDxUWt0kK
         j2kxgZ3reoE3e6wDT1wo+YpghcD4IUz0mAmGVQ/etLFuvwrXVzq3rlvbw/6axEHxDa3Z
         sYhaSFfk7aNJ866YxXlURWnzZWYcXspvJv27ymhr/d85+5WTyhnEZLbcf64J6A+Cm5+C
         qhRQ==
X-Gm-Message-State: AOAM5313cTkiqgY1y++U+RDZLkYunfZJTb9iB4iK1mvc+wNDdaMOQJls
        XoHv9MU1Aq1MaUW74yHWEdY=
X-Google-Smtp-Source: ABdhPJytxijcMC4nE98KRt5IyGUyzvM9wk1tlgWsulk2qtN81SLZBDlTRXb0lDeKi3rAtGvlO3iiJg==
X-Received: by 2002:a17:90b:4b8b:: with SMTP id lr11mr8585pjb.218.1601274472897;
        Sun, 27 Sep 2020 23:27:52 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id il14sm5712509pjb.54.2020.09.27.23.27.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 23:27:52 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v7 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Mon, 28 Sep 2020 14:27:35 +0800
Message-Id: <1601274460-7866-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

RFC v7:
  - Fix DTC unit name warnings
  - Fix the problem of maintainers

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

