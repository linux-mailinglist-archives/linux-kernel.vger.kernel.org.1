Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841402C6317
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgK0K26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgK0K2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:49 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so5047768wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8LfNjI2YK+QqbI1KrKFfCLd9R2a6y5l7Nv6AmHyNbg=;
        b=FPQWfas3+gd7oeMfzwpBEsuUabIzYgRflvks6QfPgk0LN/kXoHYlgOmY8TI8roufT8
         FwNidr1e4Lkoo56NZsZOU6PXw48MY+JiDuYtkaG4oiEX2ptgPcbnhqKbrh3M7q7+PnvP
         jLQMTP2Nz3fAqgWdaF0p5UM7A4vT74pKogFeVi0EcjZU5sChJ1NvN+nreBGL7GMr/5cQ
         fS6yNo/dr0rBzhoFyL3Bi9IRGxAXTHcPo1CRGQj67X+yARvQ1HqUATKTiDNl2vbf7nhc
         ZClc00VVUlixFvXzbR0YDxquN20MkcnKsXCrZllBsNEvFv4rtycMnXatr42jGcx8ookk
         Kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8LfNjI2YK+QqbI1KrKFfCLd9R2a6y5l7Nv6AmHyNbg=;
        b=itn4MR/vS5ezs1nKRhWDeUYKmo3U2NA+1OdiGYrAHBB/jrzGqp+2h7tICI7+pnJxF3
         qX9Xw7MtraDPjn9F+pQwiy+e5kd05kSmHrOE2VkIgCcIt6uc999+3yMz6JkW2hZn/fT8
         /TCVl5hQ8GC+VKnKc6j+td0zELMBpxMMNNsuGrZ4byXtXrBD9LH9hj7S6sVu08yeu9Wz
         mXIO9P92ssNmpFZkcONFzTJ6CbjGfQQRQB65N5/HnECNEdhK5uOt/5rQHPoodyKu9oKR
         xyWERjEf9friKrErYyNk5RP47SU9joco3g18FFj2kzU0uKXnb6Y9qIv/tIUEwQLsuTAD
         oCnA==
X-Gm-Message-State: AOAM531W8jmcnSTxIcwdDO9JZVHnLWu+UKILAVIqEtLfCmbnXZtZL3a7
        OCihvI9kG+rAdJZLvxFzJJjG4Q==
X-Google-Smtp-Source: ABdhPJyero0+06kXeC9FouNC33rRbaoQ/iCA+vrAmYZC7OO/Oa6WVjfabRZqAyDW9WAFb6bHOozXwg==
X-Received: by 2002:adf:eb88:: with SMTP id t8mr920538wrn.105.1606472928061;
        Fri, 27 Nov 2020 02:28:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] dt-bindings: nvmem: Add soc qfprom compatible strings
Date:   Fri, 27 Nov 2020 10:28:35 +0000
Message-Id: <20201127102837.19366-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
References: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

Add SoC-specific compatible strings so that data can be attached
to it in the driver.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 1a18b6bab35e..992777c90a0b 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -14,7 +14,18 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,qfprom
+    items:
+      - enum:
+          - qcom,apq8064-qfprom
+          - qcom,apq8084-qfprom
+          - qcom,msm8974-qfprom
+          - qcom,msm8916-qfprom
+          - qcom,msm8996-qfprom
+          - qcom,msm8998-qfprom
+          - qcom,qcs404-qfprom
+          - qcom,sc7180-qfprom
+          - qcom,sdm845-qfprom
+      - const: qcom,qfprom
 
   reg:
     # If the QFPROM is read-only OS image then only the corrected region
@@ -60,7 +71,7 @@ examples:
       #size-cells = <2>;
 
       efuse@784000 {
-        compatible = "qcom,qfprom";
+        compatible = "qcom,sc7180-qfprom", "qcom,qfprom";
         reg = <0 0x00784000 0 0x8ff>,
               <0 0x00780000 0 0x7a0>,
               <0 0x00782000 0 0x100>,
@@ -85,7 +96,7 @@ examples:
       #size-cells = <2>;
 
       efuse@784000 {
-        compatible = "qcom,qfprom";
+        compatible = "qcom,sdm845-qfprom", "qcom,qfprom";
         reg = <0 0x00784000 0 0x8ff>;
         #address-cells = <1>;
         #size-cells = <1>;
-- 
2.21.0

