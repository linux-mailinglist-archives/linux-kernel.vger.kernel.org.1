Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA12EAACA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbhAEM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbhAEM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A7C0617BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q4so16280918plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKU2p5aR/XepehIlp9fHVnluEudBDhLBR2ItYfLDnIA=;
        b=QyjNAFDT17rOjldZ5jNIIxBQkpsJ/aIFtmaGrTx6N8u+utONVWy3WjoBqy4e7GzqKq
         i5iiRIC/0l4L+r+tfG+3kWOotfuj8BnUPFsFOQkJSV/RYhjI6IrRrqRtMVufEyyWlChl
         gkY4SfVZ16khTniyyFcBMP/VYsPWhX9ozhODkhvddfds+eHnZ9EgA2eFYHjRLEu7tRwz
         B3na4kwm2DcqBQgL5VsSUQvDMMmwHtw0IXjthfD3X05mXrl9xYNQkgfLDAE0CkcU3ch+
         CnA+jt/uU0Z3VdyHiOJDZsp4jU7UYkQewSqf7WUHkq/CyqDZqOu6n92dPl4/k+si0DJP
         W80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKU2p5aR/XepehIlp9fHVnluEudBDhLBR2ItYfLDnIA=;
        b=YwejzG/3O0J4y7KqRZGaAnSHGJKykiVfDFCEe+LnXGgMCzMDaUJtlaVvZdTc4i4H03
         sfV8iqE3m3ytUTTkXLF3dazfhYuY5KUgFeuDxyaU8U6FFtmA9SABirtybmvRY1N5MoxE
         VZ+yFfXSD95dx8IjBWtM8F5duidMtMUwD6Qa/GUIF1VLd7DB2Wrw/jaGO7ipjgZxo/Jj
         giceiVYM5rfNRK6jecj//fDUPFHpAW08CjPrTmIMInBLliAFB0PFywm53UWH7GUkL3iW
         nA6Xg0UIVvo8fl1rwQs34pYCjPuLFk7AMtLS+rxFxRT5+CCFlMikLiPSpn/moa2Araek
         533A==
X-Gm-Message-State: AOAM530UFn37CkF5XjDNMNG3vg3lowNsR3Oak3VzSvIIlyzKyK4vCPOO
        SXgM1+0gMSjYalxzPFHtoL+7
X-Google-Smtp-Source: ABdhPJz9d9LPihcIuIhAkRbhC+pcKnsprYg0A9RQQgN6KXpgxWUq6Rq91/NPPGatCVt3T1rmYURZ4Q==
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id a4-20020a1709027d84b02900dbfeae425emr76429983plm.43.1609849649592;
        Tue, 05 Jan 2021 04:27:29 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/18] ARM: dts: qcom: sdx55: Add QPIC NAND support
Date:   Tue,  5 Jan 2021 17:56:41 +0530
Message-Id: <20210105122649.13581-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic_nand node to support QPIC NAND controller on SDX55 platform.
Since there is no "aon" clock in SDX55, a dummy clock is provided.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1b9b990ad0a2..1a6947753972 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -41,6 +41,12 @@ pll_test_clk: pll-test-clk {
 			#clock-cells = <0>;
 			clock-frequency = <400000000>;
 		};
+
+		nand_clk_dummy: nand-clk-dummy {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
 	};
 
 	cpus {
@@ -178,6 +184,22 @@ qpic_bam: dma@1b04000 {
 			status = "disabled";
 		};
 
+		qpic_nand: nand@1b30000 {
+			compatible = "qcom,sdx55-nand";
+			reg = <0x01b30000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&rpmhcc RPMH_QPIC_CLK>,
+				 <&nand_clk_dummy>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+		};
+
 		tcsr_mutex_block: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
-- 
2.25.1

