Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1732FDF38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbhATXzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbhATVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:30:44 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC8BC061799
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:14 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q1so49814170ion.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9L1TriC52sXrX4Zg+zQJfvyz2NNwykyudIg+FTCWFk=;
        b=BYqPKJd4KXULlM83fFhf8KfPkwVIDnob+eOlUqnk4lhCJky0T7XhoODizC2XccBIKY
         HBSUr9Suhd8yMn9tHYLrjPgEpmij39D9m9IFNtbOjgkmN8vSCP0X6ER0H4Z/VXKY7cPo
         lY7hDIgvaNqXdOh0QMpOYf5D2InqjzHY8ek2PsPOPJfKMIPeZewLdHNkJA/jpwzgqxe2
         MYPSg/E6C2p198IKcUhED/c4WTF5o+unTwQRITs3kQAOw3xPu4Pwa/7CmYzItlBQiZX7
         VL7lG8OdmOQhr68KLUo0VpxG/Gn44MgWLiuUpgSUIDI/nl5YCOJD0USfGu5FFCmXC7TU
         0pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9L1TriC52sXrX4Zg+zQJfvyz2NNwykyudIg+FTCWFk=;
        b=BI8Vx/kjDZ+uQHd/YTx9iT8BlM+3jJLhn9G99KStgvMpl4HXGbKdn4Wv2lKHuOUUaF
         GNN466lSJt3lHA2EDhBhXan535ouDS41QG2LiP+HIQicnBbfYFMGEnp1jTpZ1MQE8G6Y
         v+Mef6AayTjWn08fK/BBIjAUKiUgKQnQdNK9Dj4ezXNY91ejDu5DiZ35qEwkieQSU9Jp
         pZTlEmeNDCszdAjaa7t4czgmGskC3qSfp3dzhVA88B3nwg9AUY0URZODfq0RGSrkIlHX
         8wa/kriGKUH+k790afLUsVknkqQl9XWd4/Hrg3vIcDYHcInWEUlIbIZK4/PfIin1f5Yv
         AHIA==
X-Gm-Message-State: AOAM533GThkPrPEmJztc7lcrFEpcOmzpxB2OUxW9WkJUKwYThIo7v7Hi
        0BpBr6nTlVp7mHgM6Ar25z0DRQ==
X-Google-Smtp-Source: ABdhPJzTIAUTRV7I9gy5A9nst7i3RiaUgfMrDYjnhTijXz/ml+x+l4xw0vWtQoFXXt8VY7Ab29d1/g==
X-Received: by 2002:a92:9510:: with SMTP id y16mr9645687ilh.26.1611177973512;
        Wed, 20 Jan 2021 13:26:13 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q196sm1335687iod.27.2021.01.20.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 2/4] dt-bindings: net: remove modem-remoteproc property
Date:   Wed, 20 Jan 2021 15:26:04 -0600
Message-Id: <20210120212606.12556-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120212606.12556-1-elder@linaro.org>
References: <20210120212606.12556-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver uses the remoteproc SSR notifier now, rather than the
temporary IPA notification system used initially.  As a result it no
longer needs a property identifying the modem subsystem DT node.

Use GIC_SPI rather than 0 in the example interrupt definition.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/net/qcom,ipa.yaml         | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 8a2d12644675b..8f86084bf12e9 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -113,13 +113,6 @@ properties:
       performing early IPA initialization, including loading and
       validating firwmare used by the GSI.
 
-  modem-remoteproc:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      This defines the phandle to the remoteproc node representing
-      the modem subsystem.  This is requied so the IPA driver can
-      receive and act on notifications of modem up/down events.
-
   memory-region:
     maxItems: 1
     description:
@@ -135,7 +128,6 @@ required:
   - interrupts
   - interconnects
   - qcom,smem-states
-  - modem-remoteproc
 
 oneOf:
   - required:
@@ -147,7 +139,7 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/irq.h>
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
         #include <dt-bindings/clock/qcom,rpmh.h>
         #include <dt-bindings/interconnect/qcom,sdm845.h>
 
@@ -168,7 +160,6 @@ examples:
                 compatible = "qcom,sdm845-ipa";
 
                 modem-init;
-                modem-remoteproc = <&mss_pil>;
 
                 iommus = <&apps_smmu 0x720 0x3>;
                 reg = <0x1e40000 0x7000>,
@@ -178,8 +169,8 @@ examples:
                             "ipa-shared",
                             "gsi";
 
-                interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
-                                      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+                interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+                                      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
                                       <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
                                       <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "ipa",
-- 
2.20.1

