Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98CD230D34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgG1PNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgG1PNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:13 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s21so16459562ilk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHxD6udjM+BmNfhqgaIfVpk0lOiGcwdA5o4lB9ADOmg=;
        b=Nxhgyc2o90wGCC4mr9sfow37Cv8CwXysAIFqU5XftS8rVLH/R0j6zi4OUP+0feVtHc
         2aQrmr4IZpXxZXEk5WU8glZ3RpNmTVQgrtkZ7t2nHytXPgPRxQ5Jn7oNJRmf4U5+GCw0
         rbQ+jK6iC+QaaegD5ga8biXsQl1XuUdSjDycA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHxD6udjM+BmNfhqgaIfVpk0lOiGcwdA5o4lB9ADOmg=;
        b=dQnVAfmXsnX/7+Gr9EV+JDBKtZKtlhoUHW243AnmGrR2lNs/T2w2LObcMAQVNRPicV
         Xmf2IgHXlABm+yLKpBWdEV42X1g41Aa/zuJ/MwocyJjvINng0iuKkxS2CJOvPz1sPHdX
         tSSY/oVad752Qbj9v0pIjg/XxT7I9Rpzib6VNN/5rjaRKMLrTnB+6YK4Mmb7wjGzLxkz
         yw6dCoVX20YZd3LdWYr0YhcVjFWFlvN12o66G+A5VnaQJ74jbol0Ec0t9oRVyhnOxXWv
         kTXs5XuMIct9ETU16NEnOk0CNXBnSXHIRhfNGKAER45iFngdiG9Ml6v5QlvN4c3XsGAw
         31aA==
X-Gm-Message-State: AOAM530jmkKx9pIgOFD8JT+Iiz364xAlK9GQ4z48NKFLY9JAeo+CvbY0
        1mmJ3m5axO4K9zoTXODygldZjw==
X-Google-Smtp-Source: ABdhPJyY0Au2KBM6mUQMhG/TED004pcY9xvoRI9jRFk1FoUdWituv1aslVKg5ArjQJN0Jf9d+hx9og==
X-Received: by 2002:a92:de42:: with SMTP id e2mr28066004ilr.189.1595949193089;
        Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:12 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Tue, 28 Jul 2020 09:12:44 -0600
Message-Id: <20200728091057.1.I3bf8ece8c303bd9ecfc1573464cdacc47d73784b@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..ba734ee868c77f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9310 capacitive proximity sensor
+
+maintainers:
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9310/SX9311 capacitive proximity/button solution.
+
+  Specifications about the devices can be found at:
+  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx9310
+      - semtech,sx9311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9310";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+      };
+    };
-- 
2.28.0.rc0.142.g3c755180ce-goog

