Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230F2CFF60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLEVta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:49:30 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B89C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 13:48:43 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l11so12686647lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=NgOYFB3w2ozT15c6KTWZv0enLaAd1y6aEFLAwu8sfZEhVJFQT3YDSsf8mh5inygnTD
         qSEvHemuLDsMP1d+lO21AxXB5E09EAmFX+E8C7V0CHtZ4ISusoDLTZ5/5bjnps4/kTbp
         53dzA5TZwK1A1KAm0beZnK6xYAAHycukTYYETy01fzPtJ2Snupc4IEj3qaF1zH6pCJsW
         rl3cSKd2571TkecKI7QQMjSMiZF7qQqhWcSZFLomEfmnVDx2PPA6HVS1tAvxUVdMnkQ1
         YODu8L8KwkVvsKOPBqoytw6Vj8VJ7WAJFQLTEoYKbiJUyxK2BWu2kogHzj4ztIozJttr
         eZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=rlOuJFid0c+7sEbnmyrMCudffLM9WpemjtF4Ajbt79uef5O4Fl+Oze8M99XcivD+Zy
         MmwYJD4jkLZCKYGm7NoDxCCmkTZlqezxfHee6ju50d09TOTBf701JjKJ6ZwTeqjkuDQM
         55u9urWMrD9Mfb6S6AKrHo+cjP6LPLPIsF6HMEj+6g8l+OFtM1VJRVq4uqm1jpe6GnuI
         j3z/TvTEsTiTXg0WCDHve1ChNoGU6Ap+yZvY5+pFWm6GUNLca16fDDjIOn14cBbbhNMO
         b50u4dW2Omd9n4C9TXzfZ2svyyJop5NGkbhToKJw8QZRNBGlOrNRtAobZqCwCgtyhps7
         0gng==
X-Gm-Message-State: AOAM5329jg5inDYF6rSXPGREDGL7swf31dLUqYio0iuOKqVqVj4Ao+eX
        ssr7e5YDrVQ/SjuJLurQKT2Tesn1zYbbzg==
X-Google-Smtp-Source: ABdhPJzzmN9BeQ6HC000oiVBIsk9acuP5zbfCPA2STIhoA3y45LjhD0Ms0+rHmyKEoUN1MQKKq5Ntw==
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr1802088lfs.529.1607204922207;
        Sat, 05 Dec 2020 13:48:42 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id d25sm2551221lja.40.2020.12.05.13.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Dec 2020 13:48:41 -0800 (PST)
Date:   Sat, 5 Dec 2020 22:48:38 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20201205214838.zgdh5txvtmlpk7hd@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-gpio.yaml          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
new file mode 100644
index 000000000000..2e021ac6ff4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic software PWM for modulating GPIOs
+
+maintainers:
+  - Nicola Di Lieto <nicola.dilieto@gmail.com>
+
+properties:
+  "#pwm-cells":
+    description: |
+      It must be 2. See pwm.yaml in this directory for a
+      description of the cells format.
+    const: 2
+
+  compatible:
+    const: pwm-gpio
+
+  gpios:
+    description:
+      GPIO to be modulated
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pwm0 {
+        #pwm-cells = <2>;
+        compatible = "pwm-gpio";
+        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.11.0

