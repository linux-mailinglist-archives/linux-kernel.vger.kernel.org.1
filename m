Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5882EBE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbhAFMz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbhAFMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DCC06136D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so1515851plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82XTBN0WJT5Ms5npJDtW/1oxbbnnwYJ+KY+KF1anN/Q=;
        b=gh0WboCNGEIVTNphlkjYhDOkfdHpmGI4r7OcV46WrbRzUHupq3Z+libFifMKtmUB1U
         vRMWrUzNIl6VVh4kkjHenBHjrXVP4d9klLpAJc+JYbo/0ih/u9Az1CJC/1Ldn8xNpSAe
         /fDZEgXIxjSM6cg4yORC8Fc+kQK9dvzWFfEe9rUSlPnYNdkDkB0OsEsJKmC3nbBgqzzu
         XBBijhEuTXl81hAEC/UYsrBfZRQfNON6WVhUmE1pi1XnPRMkNajvzefpeEVuB4JHoLey
         BlNqWaIPfKUD8rhGWT5dWCScaKHWLhedoBKuaYG3heCyHga+Di+X5wNalmlV2a0CnehH
         MNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82XTBN0WJT5Ms5npJDtW/1oxbbnnwYJ+KY+KF1anN/Q=;
        b=Sdt6A3l0Q0gjHXQT9sFSS9C0Q/XxdoQg0qNWfDFRuc3aii8gKf8aXc//Hzy5OreOMP
         l2p19+01v0NUsbWBjv1B+gght2z1l+Kz3CbLQHKxiWgtn602oJM1pmS8nNtvvZxmouq5
         j5vcfhZGpvn17HIYT32yarTRjq3OnkPOXQvpaHovhuQwLIm5TvCDfSP1glhSVPDJhDgv
         G/0467QP0Ot96IfuV151wIeho0pCQ9f27W7Lzz+avniNPw+FrNnd6/IvI+36vHxoUUX4
         UYWjDCc23wIShce1LJcCRVtfzSJ+sOvdHJMDuR0Y/skFtOpkXoH4reakWi2WmQxvgXuS
         tmkA==
X-Gm-Message-State: AOAM5319E7Fnbq8XK1sNS052BcO9yzIlkyyet/hmlzwOJ1YlkVn+tqHM
        2nIoqDUpR5WzmLdUQQz2Qg4/
X-Google-Smtp-Source: ABdhPJyQwzPK0jBzcy37EqJxA7HsdInDazR46boyXsulnxWyxtnlfiR43jOE5WshNHlmMWxY/VQ9tA==
X-Received: by 2002:a17:90a:300c:: with SMTP id g12mr4244899pjb.4.1609937660489;
        Wed, 06 Jan 2021 04:54:20 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/18] ARM: dts: qcom: sdx55: Add QPIC NAND support
Date:   Wed,  6 Jan 2021 18:23:14 +0530
Message-Id: <20210106125322.61840-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
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
index fde3a9da68e7..ebcde361c3f3 100644
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
@@ -151,6 +157,22 @@ qpic_bam: dma-controller@1b04000 {
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
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x40000>;
-- 
2.25.1

