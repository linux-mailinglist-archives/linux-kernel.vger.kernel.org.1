Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08E2EF31D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbhAHNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:35:08 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:47061 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbhAHNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:35:06 -0500
Received: by mail-lf1-f46.google.com with SMTP id o10so12016501lfl.13;
        Fri, 08 Jan 2021 05:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xj8LSTU8vPc67ScPamRxJpTzRoIqMJnKv0HHpRz1cDk=;
        b=f6qutRlXdJfDFWreref8TFOjA4s7sbt1hg/ky9wDj71pbko0GzkNRe89HY4wWYYbmh
         Yt4X4So6zl4VKxnk2RMVGC6pnCLgdkzEXM9nC/bnhc8NB+NH75zbqaBX0Pksuk8WQ99z
         ToKB94RVu1H03JaM1eorMZKCF5uNmMsLjR5FO9Nxh3PaUnuQ2XHlSrtdMMtCGIMZe18f
         qR2r8UzdzwmntIozDv9yp6m+9KpF+UCE+jZ2ClclyI0DQsn70MLsDnIK+NXKKZAJdrLp
         yja9wyswyLkunLBP+B3y79MXUBn6rlhBFkQEDK4icy6+i0apRMizXDXncKMaplo+9ZFd
         4bdg==
X-Gm-Message-State: AOAM531wtSIp0DMsdno4O0h4owxC6ginnfblm07qMr3fLK5E7bp3HDeO
        l0Nb7ZBdZOWiq5EDBdqzRAMKriL7tnY=
X-Google-Smtp-Source: ABdhPJyrFTlAhVcuaZTf0fZ5bGxlbwRAJxNnMJ0znFzRxSFEdjVl0kuPSFR9uTwCbMxT/Aqvv2W0fA==
X-Received: by 2002:a19:e8e:: with SMTP id 136mr1591854lfo.272.1610112864158;
        Fri, 08 Jan 2021 05:34:24 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v23sm2158976ljg.97.2021.01.08.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:34:23 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:34:16 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH 04/15] dt_bindings: bd71828: Add clock output mode
Message-ID: <a91eb6288331bb80b30534a31049cde508307fc0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD71828 allows configuring the clk32kout pin mode to CMOS or
open-drain. Add device-tree property for specifying the preferred mode.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 3a6a1a26e2b3..cba085836bc0 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -44,6 +44,13 @@ properties:
   clock-output-names:
     const: bd71828-32k-out
 
+  rohm,clkout-mode:
+    description: clk32kout mode. Can be set to "open-drain" or "cmos".
+    $ref: "/schemas/types.yaml#/definitions/string"
+    enum:
+      - open-drain
+      - cmos
+
   rohm,charger-sense-resistor-ohms:
     minimum: 10000000
     maximum: 50000000
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
