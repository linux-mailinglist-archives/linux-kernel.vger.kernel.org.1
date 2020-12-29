Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC912E7439
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgL2VS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgL2VS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA2C06179F;
        Tue, 29 Dec 2020 13:17:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u19so13755900edx.2;
        Tue, 29 Dec 2020 13:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbMzqYqJfll387/VWz2zvatjdA7pONXKy99fSV96+KA=;
        b=TLwOfHE/h5zpLtNdrx/zJcuZMJR2HMXwk0a1T8lD+wuzHWO5vko9JaSDyh5XzPYNCj
         JBM2NfOSv8MR0eGGic/h1PwpQbQ7PiGiUtiu1dMf616Ac0TJIKbA8Mnta4PbZOihQMS9
         1dxHiCz6yvOfpxD4J6YjpkvjCX9tc7IF4sVbmlaOfLJGG0IvLDhyRT+QaR+7n1DsOqqU
         B23NFXgWl8znwxZGaXSUKA6OvfPBAhH/HchQ1tEcbuBYSItXE8AboB4eRz8zQ0KAF5ne
         ANj2OPB5JrxgSyX/RQT0l549jyBXt3ubN4JrBP0IvdUoeMZi/XapP2Ci0lrTuyKKd5Mr
         sw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbMzqYqJfll387/VWz2zvatjdA7pONXKy99fSV96+KA=;
        b=scLYFGpEOYQpRtJcWfPOT69YOZ8gADJbRlasJtDi/v6hEn051GLCFTEMR8t/bRaPxa
         SQc0P87RemRsZKathJEtGmOEcX/EB1JvMnDhIylhOdaP7BNpXKrkPbQJoWyVzB65gpLe
         lRIHsGpHhcv6p1ygt+nB1q4EKdxQOF+dz8MMl//R2TKJw16DvfNhH0KMqODHs8JSXM8M
         tkjMpEXSqeR2bwmPdzhAw6KgCZzYkLxG0AgdmFrljcB3Pu+l3WfLNoIUYMzKzacKGCSG
         JAqDjESkhs3+g2tcM57iRDmT5+aX02VzmhdqTBvavBvzJz2EhU3JhsgaC+JixPSc6Pxp
         vDrg==
X-Gm-Message-State: AOAM533yJ09MzCQtSeX/1+O9PwYYJ4/gY84iczmiSmlAkhJK5fQuKwUY
        kLoOAXN3jk3LF9CLFWxyDaU=
X-Google-Smtp-Source: ABdhPJzOniW44Ek6NNqOM6bkESm+TV/RvWDXT3+LSVhVM0Ou111tFIW7HFGKnueKh2rn26Ml3OiTRA==
X-Received: by 2002:aa7:d916:: with SMTP id a22mr47576831edr.122.1609276666144;
        Tue, 29 Dec 2020 13:17:46 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:45 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] arm: dts: owl-s500: Add SIRQ controller
Date:   Tue, 29 Dec 2020 23:17:25 +0200
Message-Id: <b900425518af75a2ba60d0923c52d261e0aeff98.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SIRQ controller node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 55f8b8c2e149..cd635f222d26 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -233,6 +233,16 @@ i2c3: i2c@b017c000 {
 			status = "disabled";
 		};
 
+		sirq: interrupt-controller@b01b0200 {
+			compatible = "actions,s500-sirq";
+			reg = <0xb01b0200 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.30.0

