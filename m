Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1F2295AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgGVKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbgGVKI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE12C0619DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x5so829534wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZOb8R7MJ2d5mfe9t2yzGmTymT+mHQhGLtoqq5U00jQ=;
        b=kqJZ9Wz6O05/5quqgWjyGgTYJ8I2k3BynGbf+b1OstUX6CITO55O1xdu6a84r7XHwc
         78hfs09QfvFiRdyB3r+TjfTK9Dh3SVOkwJGXGTU2eDGgpZM5N1LkDJ7e+eEmH7PWjUAv
         GYK/oC2HPBM9oX3EKa0zZIjMrgADG/JQivOecitMfjFX/erQNVUs3o00DiHCRHPHPyaV
         9lijQ925EeEt2rc80nq5lEsmIPyF3PqtYTEOL0jcu/AKer9o/XvJolssRN/L5YPvHGna
         aFvOlW8CwqUC3gBvXPnIVJnyXArVFWth8Q8dlvQIcZ2AM/0znqjXWpepXI2tCqHYEm8Y
         plWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZOb8R7MJ2d5mfe9t2yzGmTymT+mHQhGLtoqq5U00jQ=;
        b=Syd8uvVqbJR7rH/Jcqsaa00q5fzcctdhGIgfswU65quVqVI/BHSJSZlPqxwK5iYzbl
         ENfY5jtb3EX4Ezok9yW2iuv7Zh+D5X6M6fDgOwXCxQrzjzWSVoV87Nv896hIzGNHynpg
         Wa4tnekf19zZZeQRNOywotVZFnndvqN8jxNOfNEnqpEI+icg8ZV/hsA0GJJG6k2X7v9k
         C/lQbDOaNKRI5YC3iiiKtm5bJ83P0VuUH8ipF6R7FllZE/eVQwyrsSfytTV9cCEeXBEz
         ah1KB3GGoOUzvqROb6pFwgEgbDkbWHRpVLXzfU8YP0063H5StcNhubxMrr8X9aN8i2Do
         zzaA==
X-Gm-Message-State: AOAM530Z9oIvfngMaN+RuMFGDGdD7+8m4zh/KybZBuFku4CAUDjGsren
        ufw1+8LKXpp4JC4qQ1dT2d4pOA==
X-Google-Smtp-Source: ABdhPJzBB42SqN02WSmnpJATjFMOcEmQMZvIG65eyQlZZBYLJB07buIdBSf7D/Q+HWkrdHlLrGM0Og==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr2291722wmj.92.1595412505416;
        Wed, 22 Jul 2020 03:08:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/14] dt-bindings: nvmem: SID: add binding for A100's SID controller
Date:   Wed, 22 Jul 2020 11:07:04 +0100
Message-Id: <20200722100705.7772-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's SID controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/allwinner,sun4i-a10-sid.yaml        | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index daf1321d76ad..6687ab720304 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -15,14 +15,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - allwinner,sun4i-a10-sid
-      - allwinner,sun7i-a20-sid
-      - allwinner,sun8i-a83t-sid
-      - allwinner,sun8i-h3-sid
-      - allwinner,sun50i-a64-sid
-      - allwinner,sun50i-h5-sid
-      - allwinner,sun50i-h6-sid
+    oneOf:
+      - const: allwinner,sun4i-a10-sid
+      - const: allwinner,sun7i-a20-sid
+      - const: allwinner,sun8i-a83t-sid
+      - const: allwinner,sun8i-h3-sid
+      - const: allwinner,sun50i-a64-sid
+      - items:
+          - const: allwinner,sun50i-a100-sid
+          - const: allwinner,sun50i-a64-sid
+      - const: allwinner,sun50i-h5-sid
+      - const: allwinner,sun50i-h6-sid
 
   reg:
     maxItems: 1
-- 
2.21.0

