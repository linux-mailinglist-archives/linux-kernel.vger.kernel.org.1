Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE02CFF5C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgLEVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:47:01 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC0C0613CF;
        Sat,  5 Dec 2020 13:46:21 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y7so10731457lji.8;
        Sat, 05 Dec 2020 13:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=VmrnzKCVo3a8w78uIJDkDsQBWOkeb9zbMnNqo8ytJZqpdp7foEcjCNE0zxFjb62u52
         b6DCnWXRAz2C7IQ3Fpe4SZe6+H0CyfJu/1aptYpbF4xLy8q308Ax0RLc8+3QkZ7F7tT8
         n+L+GBDdLKwLo79CXNRlVJRaWm3dXqtJDnUx6cFO2pZTlVG2xkg0ZUg44p2o00PBPA6m
         4mIIZA2mmVobw+gBYQUZ1W2+WZWWxfJIdN0vJWh/taDnl5Kuyok6bEtlN8FzlpZWWnFa
         c4v6vtGEgcHgw1TPA1N88qxPgJnbPRv++wf0lJs5hjFGtHw0GLw/VpCESww16F6YXrFW
         dROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=Waj1HA8sJ+KoKNEMNk1gUR5jpxZX5seheq4bSxXK5Hk3MUkcoD7m9DeSosor6z02bg
         NsyvjdfGsjB6969CA5z92YvYtsL7Riy26f9Ocmu1fz666ikWxFbzijhTtBYEzs/hZqit
         0tOa5OdWK42Hou8LUVmDpgm/OmdcRqWiqAlfYeRsLTcx6SyGsIsUCri77wFCxDE7cP1n
         mL+bU8pMTwvppKdjY+sTV4UC42Jg49Ptl8tcXJ6mTR1cgSJTN9C/bHNL/JfnoN2SY1yl
         UeuuPE30e2RiAH2qIY2zXgOjaQoxUsuoqvLoBJErrCMg8KosIcSgOUOUFuMGs+eSYic2
         N8mw==
X-Gm-Message-State: AOAM532sjXuwEXmPHnX/1zMNgnu02s5S2lriKDF0qbxs8UM/LusmRotE
        k+BcGQWfU/mR5II4EaMg4SG0IrDQwYNpeg==
X-Google-Smtp-Source: ABdhPJwFNfvkxCte0G5xa3BJHWUYiT4H5ucp/GJRsvk9KMUb/O+NiZ/DQAd7ENCNi73FkE3rwR5zqA==
X-Received: by 2002:a2e:91cd:: with SMTP id u13mr6018600ljg.239.1607204779667;
        Sat, 05 Dec 2020 13:46:19 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id o12sm110933ljp.123.2020.12.05.13.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Dec 2020 13:46:19 -0800 (PST)
Date:   Sat, 5 Dec 2020 22:46:16 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20201205214616.e4one25o3oz5dhrp@einstein.dilieto.eu>
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

