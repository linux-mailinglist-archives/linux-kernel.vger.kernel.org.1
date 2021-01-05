Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078B62EAAE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbhAEM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbhAEM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB7C061387
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w1so1152854pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShXu7/U7Beq0uWc9RaEN3HI3oScB32KORyGyOVEnVV0=;
        b=RHu4kMxc6AzHLy/zzx6vh7UJIyQtFXBt+A/Fxyq0b9PxSCboILqTeuUu0Xe4MZznd4
         drYlYhMgyPx9TKMEw1GUVh918DvWAc+dc6eLesDwoTH/kr87QUk7XPVqmdVUO6WecZnN
         vHvozS08ewOEliZ4Q+XMSYHqCeuNLlN+wBpq8hMq30yJKguNFEPevlJhMWOZGSeIVMpl
         p47BwbUFLItbfZ7WS4fh5QeQ+FXySoR0wdLSn8xmINB5Jo6SkubX7T7NVk0H+EitaSxt
         vxfKMfV2P2//uSVRn7/CTzZtP6JYAyTGQOXwCoPxr/bXEnKIsZb3Xu2ZCuzcG43gLwOE
         PH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShXu7/U7Beq0uWc9RaEN3HI3oScB32KORyGyOVEnVV0=;
        b=mBnmDfG2cO4ORmK0tjnDSJLni7qP3RengaYLvZ/Ko0XjbZjdH3SQfHbmqUQBkiUox1
         /simFXEFQOfAPZXyuBVmOY1EXoeNgtVRvac3DwxS6LGPKRkwH1GgOHz734LfUplg1r7+
         levmJZasXX6WaZWei5lLIf5aiYQaDS/cGRsGf+jAmTTYp8yOS+P8Xhul66vznJJVMfEF
         wBvJojXhEcWiuP9tpyi2xuvux0F+3rFqoWvTFe6by2zs081asRZJov8sGqB8Hn+AMyl+
         Vim4DOGN/ONKrhuJUyoN//USS+yXJkMY9OsqNc82oXYnzjyDzHxgzkmUpPqlDj1PJmWT
         p+kA==
X-Gm-Message-State: AOAM533yuKSPbkd7HQ9Cx5e+3cNyAhFsr7o3/8E5ZTkefnSh7x3yGNJ6
        JcQgd+CwZ+w9sEM3IwfIR6ov
X-Google-Smtp-Source: ABdhPJyfzQ0WJsrQK/rFzYMTCG1Uhe7fsH1p3wH4H0HACtztkBqMci7IerPbXoTYEVmG0P5u2SwtkQ==
X-Received: by 2002:a17:902:b203:b029:dc:973:3ad0 with SMTP id t3-20020a170902b203b02900dc09733ad0mr76213782plr.44.1609849659228;
        Tue, 05 Jan 2021 04:27:39 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/18] ARM: dts: qcom: sdx55: Add spmi node
Date:   Tue,  5 Jan 2021 17:56:44 +0530
Message-Id: <20210105122649.13581-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds SPMI node to SDX55 dts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1a6947753972..f3864471ba4c 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -226,6 +226,25 @@ pdc: interrupt-controller@b210000 {
 			interrupt-controller;
 		};
 
+		spmi_bus: qcom,spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0c440000 0x0000d00>,
+			      <0x0c600000 0x2000000>,
+			      <0x0e600000 0x0100000>,
+			      <0x0e700000 0x00a0000>,
+			      <0x0c40a000 0x0000700>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,sdx55-pinctrl";
 			reg = <0xf100000 0x300000>;
-- 
2.25.1

