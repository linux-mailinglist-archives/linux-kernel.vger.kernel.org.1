Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F3297030
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464427AbgJWNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464437AbgJWNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:19:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA2C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:19:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 184so2057799lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qx8/8JORiXv27o7v4yO39cefNVmWr3jvO/t75+dTjdY=;
        b=O4WPwwWWSIuLDEhXdfDmBZxgy/Nr8cebRFOYQJJ3+J7ISE6p/nk5iIPmM+zgUGewyg
         MP+TKcbNJzxvYkZdJmi+FdBJeM/ohwuRIVdLf8LrSWXplvXpPRadHCw2JZXCZpcEPOoc
         ktI1tJOQH+JKOXtvO3feIt7P2bPll32MDidUcJb505BLFpnjgDUa33neAJYZoa53c45T
         kqa+EfmhCH7caOXvAZGJ7Qw4FmWTVm6526FmYGyJGTEFWc/G42qIzAZMYAXjhTfODJmH
         MIDFtJ8ug/drLHsoQSPUpz3wU1UOM20Fl2O4s9U/JGwxHofMx6hOoCCDAN+8/A8C0K+j
         2ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qx8/8JORiXv27o7v4yO39cefNVmWr3jvO/t75+dTjdY=;
        b=tgfXbyfnRI247EkCgr/aAAmj7wcZPFH/7l3E7sfHIc9AgXJF2AmRX0RirRm7ND6jal
         pFPqd/8nsxCGdhTIP2CR9jfN22uUDW6VyJUG6B44k8O+hmsTn4UGCnpsAMHiHf0BPTAY
         C9Lxx9k+Spl+OSznNLFQtvGW5gZ4BwgPLPJ7a6ItKBIaI1NfH/l4D7XkZvhnLw8TYchi
         7FHi+bIPFRXtT79bVTLayDVetjaZm6uIy0+ma1Yn/el+5QioVZaWdGcstjwxSTt3Lujq
         QbfZy1exHjbq/iYpDqrQkydjHfSukghlZgYLdfDU/VUq0HJJ2TxaxTc7wfgJ75jHRqW3
         VUEQ==
X-Gm-Message-State: AOAM531+7gZGoGAEr7PbS2mooWv6Zq7gF3dRnrNw2IMPQea+wW4z8ahc
        UmQdf7trKMo9hwrG7vye5R43Ww==
X-Google-Smtp-Source: ABdhPJy869i54RJ9lJRegmrL7jXaydJIBnXbZK4NV5LGAXgaZbez6DNT7lcUk+T2TUqH4/5SWz+7/A==
X-Received: by 2002:ac2:4ec8:: with SMTP id p8mr710093lfr.433.1603459172815;
        Fri, 23 Oct 2020 06:19:32 -0700 (PDT)
Received: from eriador.lan ([188.162.64.195])
        by smtp.gmail.com with ESMTPSA id o22sm161564ljg.122.2020.10.23.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:19:32 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: regulator: fixed: provide bindings using power domain
Date:   Fri, 23 Oct 2020 16:19:21 +0300
Message-Id: <20201023131925.334864-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023131925.334864-1-dmitry.baryshkov@linaro.org>
References: <20201023131925.334864-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bindings for fixed regulator using power domain performance state
to enable/disable corresponding regulator.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/regulator/fixed-regulator.yaml   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index 92211f2b3b0c..d3d0dc13dd8b 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -26,12 +26,22 @@ if:
         const: regulator-fixed-clock
   required:
     - clocks
+else:
+  if:
+    properties:
+      compatible:
+        contains:
+          const: regulator-fixed-domain
+    required:
+      - power-domains
+      - required-opps
 
 properties:
   compatible:
     enum:
       - regulator-fixed
       - regulator-fixed-clock
+      - regulator-fixed-domain
 
   regulator-name: true
 
@@ -46,6 +56,20 @@ properties:
       is mandatory if compatible is chosen to regulator-fixed-clock.
     maxItems: 1
 
+  power-domains:
+    description:
+      Power domain to use for enable control. This binding is only
+      available if the compatible is chosen to regulator-fixed-domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      Performance state to use for enable control. This binding is only
+      available if the compatible is chosen to regulator-fixed-domain. The
+      power-domain binding is mandatory if compatible is chosen to
+      regulator-fixed-domain.
+    maxItems: 1
+
   startup-delay-us:
     description: startup time in microseconds
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -89,4 +113,27 @@ examples:
       gpio-open-drain;
       vin-supply = <&parent_reg>;
     };
+    reg_1v8_clk: regulator-1v8-clk {
+      compatible = "regulator-fixed-clock";
+      regulator-name = "1v8";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <1800000>;
+      clocks = <&clock1>;
+      startup-delay-us = <70000>;
+      enable-active-high;
+      regulator-boot-on;
+      vin-supply = <&parent_reg>;
+    };
+    reg_1v8_domain: regulator-1v8-domain {
+      compatible = "regulator-fixed-domain";
+      regulator-name = "1v8";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <1800000>;
+      power-domains = <&domain1>;
+      required-opps = <&domain1_state1>;
+      startup-delay-us = <70000>;
+      enable-active-high;
+      regulator-boot-on;
+      vin-supply = <&parent_reg>;
+    };
 ...
-- 
2.28.0

