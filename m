Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF6427EBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgI3PKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbgI3PKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:10:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F57C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:10:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so1401221pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=NQhqVoP9cYIyfFnw9k09wKwqLsbH49x5IC5GDEwAcLjUdNRR5756qj3mo/pPvivvQH
         vfRNzsT/mBdWhClDg9f2SpHLf8rMFt7wAukhnTkVI8s4Yp64//zU6YGtYPYfvEyqcUIi
         xuKmtwsa+ResLjY8eIw1nDRlE2dcjlKS4AdlITloMbDOk8Rorp/YGef7ZGgPF8HGKUzI
         XqmRCYYLurQw1cRznFu46U+alB5k2ksrYHoOxFyeEwTN/Uc1SYiWYxSQk2KynBdpZ0ic
         GWi0Qxojhv7K4CPOWd9zsDB2COYYvRedcUKPzqFW58aTEJE+VxZByi4fH2FuRQBvl1Cs
         amzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=LOmi8EqHXHsXL0rMT60VlTQiZwCj2QtR1NfHL3PPByG+M0/wXM2w2eCyEUJJmf1+kE
         UglMro2lr9TAcQp+UqtUXvXKu68jYV5g7YYrR8iktIEwKtbPgJZOvT9BWxiQt6PjrUKo
         0DaFqjjKrsQx+p0IHu+IDCjnc+kGNkPbMBdcWq7ITYShLuEhF8KNfFzL4+NMJkX8EVgf
         Gw+zRdg5IY2oVhJ/5wf5wOB8myOmxuhWHfyT1vag4HaHJtrTb3k930IEj/pxZ39wpWTJ
         LjED/fW0BwslhY2r29T/q2U6emDpN72hDLH6qSIjsTjbrJwDdvQxvn1u4xRQpBqyGw5M
         Qpqw==
X-Gm-Message-State: AOAM5328Wz5rO+n5JDYCzh/ZfzsV21OoQVtJrSphC9jN7nyLiX1I3Ppl
        sRBF7hCpiZlwR0UbOFdXLL0w
X-Google-Smtp-Source: ABdhPJzegAeNh1UuBH5lx+IzV3+Ju3y/UsDqn2Ael4VDVLar6LayVqgnrqp0IibpCLM4n5JjRkyePg==
X-Received: by 2002:a65:68c4:: with SMTP id k4mr2425222pgt.18.1601478611770;
        Wed, 30 Sep 2020 08:10:11 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6004:2356:f1f4:5bc8:894a:8c50])
        by smtp.gmail.com with ESMTPSA id o6sm2456444pjp.33.2020.09.30.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:10:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Wed, 30 Sep 2020 20:39:23 +0530
Message-Id: <20200930150925.31921-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..3b55310390a0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -13,6 +13,7 @@
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8250" for sm8250
 
 - reg:
 	Usage: required
@@ -27,6 +28,7 @@
 			- "dbi"	   DesignWare PCIe registers
 			- "elbi"   External local bus interface registers
 			- "config" PCIe configuration space
+			- "atu"    ATU address space (optional)
 
 - device_type:
 	Usage: required
@@ -131,7 +133,7 @@
 			- "slave_bus"	AXI Slave clock
 
 -clock-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -206,7 +208,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.17.1

