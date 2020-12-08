Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5936C2D2A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgLHMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgLHMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:15:07 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2DC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 04:14:21 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so12028636pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9A4Sk5yzGnBoQXxaXJoojpAXbsWlJ4ueKRiORr8CZ8=;
        b=aU8AQYyD9RlPyxeHX6sgagW//rSkG7w1RQCw673Z1Tll3iiS2a2GLSf5h/966ARWwK
         lphXxY8mh5nUNB5m0sXrPINeGZHWzrkSSqIma0f6l4hOd5WrutDCb+FgXUvyzg94fl/Q
         o9+Qy0iUY5lbddogvn6ASwtVVwzCADyX3lZUKfdHQQr2NqpDJHFOfg3ssBLKUvwq4/MA
         sTBJeSEZ2coF9SOa1tCwFBaPMHadib/sS4Kym+Ctru+ZLzdTHlFIzIJrj70UWkWZor7Q
         Qp4fm4yzKw9g5yoRAFAJ3CdCRzov0lgDyC4ytc5C1B/7EGAFPNTh2t7fy9XS+l0rx8xt
         byLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9A4Sk5yzGnBoQXxaXJoojpAXbsWlJ4ueKRiORr8CZ8=;
        b=dBHRdVCopXkgnYX8CFdnAU1ylOq8UmbZC/ph3HRR5ZA56WHh5M/tQ3Z2nbh47/pBCE
         B232qN+Xr7E4X+f+jGWtE9Sb5TKLercK+5cCuYrUa95r21Lp29CZSWPJNa/uP9HhS+x7
         2uda1L7FrdiqcbOi+otW6W6RJqdhcAXX/DskWVyBjZuEfoMiJAV5ShOtF9XTLQ6VasP2
         H3kPTNyOSyo/RjIyIOmSmzGgiAzgcxIf4yz7F4s2f+9fpGrb6W39SXjC54fTI4i60Q4N
         RTqkCf5OkkUzwDkLRBJfA0L6coC8IYDe+QACBa/h6b09+nVlS16QLiEV2eocrq6F4NzH
         8hHA==
X-Gm-Message-State: AOAM530e1yNpbFQCVv+HvtN4Q3vKTP5HjFZc30wTUPpGpZiv85+twe35
        CNJWbKw7OJW11HRgGhe0S8OQ
X-Google-Smtp-Source: ABdhPJzfEn8S2FLIVfChKZcdxVrn/YiQ8yFchnbdWGpGFxo88xa206tKhhjsVfkXH/fr2sHJPtdj3g==
X-Received: by 2002:a63:40e:: with SMTP id 14mr15489937pge.420.1607429661277;
        Tue, 08 Dec 2020 04:14:21 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm3489889pjn.7.2020.12.08.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:14:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Tue,  8 Dec 2020 17:44:00 +0530
Message-Id: <20201208121402.178011-2-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208121402.178011-1-mani@kernel.org>
References: <20201208121402.178011-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
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
2.25.1

