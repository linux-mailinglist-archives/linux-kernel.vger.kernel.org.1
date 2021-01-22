Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B4301064
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbhAVW4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbhAVWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:55:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8742C0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f63so4773980pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCpMQt807YfEcZdAppn4nUQWg8RV5dkORnfM2cJGiws=;
        b=GyRDl7sp0dtyUfCDl5HO9xPItncqAWM6Tc4EvX3IkIW8rzXYaWMcilC2XbVLXaraUb
         fosVbBfXNGPnxyU0OwomVFp0SzmipHwJ1DZ4mOKfkUmHE17J9dtDjPuXMK5inKsi/r+X
         XcX5KI8C347+LjeSxwXt/PimsB+hqPmW6hMYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCpMQt807YfEcZdAppn4nUQWg8RV5dkORnfM2cJGiws=;
        b=MBmY3yQRfiLzYvXi1V8GTtCVeuDxT1f9xv8CthwMv526nOiZDgB/jdhWq6rPpfg935
         PexT1MY8rlH3CSOzwlLiWiJTSmaAXO/jfjbSTW9OD99PdCVmEDNS26UC4ChM5MGABMs1
         cr5bGZXuIu3tBbjnZ24BUitMhN7gusGL7Jt3Hl/fF8W1Mo/hpasPZHmeCeechUEOvbuh
         +aQRLcqZEOzkl3vxksg1kkUplpGrPy4bI5jEp5iJFBFz9CJldgCBYBnK4zpJIzAqZo82
         2Q+AiAvUc1CRdo3/07eAlXT6AUTuypLHD6v9mK4zY3V+wGf6uykFaRKSch54tz5j5TJA
         jN+w==
X-Gm-Message-State: AOAM5332PGWHFi7XdvFQlZF8/w+poPt5yTBzWr9FT169rXbilBf1r8aq
        c786hzYn+ois07perYWBNwloQA==
X-Google-Smtp-Source: ABdhPJzfKBQiaAswAZ8TMCEFXHh2DRTfPXYvu6GVRfiPMkLTzLmMgr+i4DwSvTbM1yzXAKBQEfzmFQ==
X-Received: by 2002:aa7:8b10:0:b029:1be:ab7d:3743 with SMTP id f16-20020aa78b100000b02901beab7d3743mr565125pfd.79.1611356087565;
        Fri, 22 Jan 2021 14:54:47 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i62sm6433509pfe.84.2021.01.22.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:54:47 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Fri, 22 Jan 2021 14:54:42 -0800
Message-Id: <20210122225443.186184-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122225443.186184-1-swboyd@chromium.org>
References: <20210122225443.186184-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
a node that is a child of the main cros_ec device node. Devices that
have this ability will describe this in firmware.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../proximity/google,cros-ec-proximity.yaml   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
new file mode 100644
index 000000000000..c0a34bdfe4fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-proximity.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC MKBP Proximity Sensor
+
+maintainers:
+  - Stephen Boyd <swboyd@chromium.org>
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  Google's ChromeOS EC sometimes has the ability to detect user proximity.
+  This is implemented on the EC as near/far logic and exposed to the OS
+  via an MKBP switch bit.
+
+properties:
+  compatible:
+    const: google,cros-ec-proximity
+
+  label:
+    description: Name for proximity sensor
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    proximity {
+        compatible = "google,cros-ec-proximity";
+        label = "proximity-wifi-lte";
+    };
-- 
https://chromeos.dev

