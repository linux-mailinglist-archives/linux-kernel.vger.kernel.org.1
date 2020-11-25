Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC92C497A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgKYVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgKYVDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:03:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5898FC0613D4;
        Wed, 25 Nov 2020 13:03:48 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n129so3512436iod.5;
        Wed, 25 Nov 2020 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcTsX4ej/UkZ63xJWlrhRCi5ZjNKdHYN+db6xsLhcQw=;
        b=jC3hTa5TCI5Myo/dYUCtrDYKKXKpGRAlMguaJb7ch8vOupDDf54sftnKMlQ5OnG9mw
         XaMd12FUzcxCKQAsl7dS5r9DP32mX4BpxXe+3+Y4hHrgKVxAX8bXUn9roXO93vS65dMV
         EIFlSVU6ynwG4s2Oja8QCDTnMpg1FidhKc21fFuzrLjtB6Qq9ONgXxvnCupnq3wQhcR0
         iBNPA/T4efpcbXGEMwUXfCbIN/J+R46BzhxlgCL3rMGT7qBPwgqQ0GbsFGngd0rGSNYD
         S+QxlSG7LmHCUkBtEbUFnozOv7+FedlRvZD25v3SNMib3fcF7jJQUi1xZP//EbrLN+1O
         t9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcTsX4ej/UkZ63xJWlrhRCi5ZjNKdHYN+db6xsLhcQw=;
        b=gxis1KEEpT/tzlZ0Ny0s9lOdjrmitzwu8RLkA83G01IHJYHHH7zQMG48H0/W7hVypo
         CIqOXpcjxKbLitMsubxL9BSqu8VMTRJhVddCMozN2UQtpcbjcGZKegTGS/F+PHO3CBqe
         dQ5Hr3iy3IWSHFLVqH2jNZEYXfn2UUwMDVd2o/0XcqvX8zmOgZMPrnOjVJjtnRkawRJM
         7LP4oLQnfhuTEqP5wiDb+/+cpEMNnW+2ivoJkI09FRFL6t2RJXY038lz+hTkuYUYl0yF
         6HIyaLwyxgBF7zV7Zjl/RjxMf6l03S/tThJbs6R3BPtPi6PgmlMbh6l1NZQiH1OQd/w4
         GphA==
X-Gm-Message-State: AOAM531Q2AQN95aWT8gM1Wuy/32g/QrdUTH3Lkfrk1q8rTLhbClcNN1e
        PGo1cGix8kTcSZ6hv8wMaCI=
X-Google-Smtp-Source: ABdhPJw4nPeeTG98OXe4vSBFKc+oHqPAYGlXA6woZ/pYsZnuvEFJWTQsp4LQy0CnOpl378+bzcVduA==
X-Received: by 2002:a05:6638:1ef:: with SMTP id t15mr103123jaq.28.1606338227537;
        Wed, 25 Nov 2020 13:03:47 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8da2:e979:8d1:eddb])
        by smtp.gmail.com with ESMTPSA id x23sm1564979ioh.28.2020.11.25.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 13:03:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mm-beacon-som:  Fix PMIC clock error
Date:   Wed, 25 Nov 2020 15:03:39 -0600
Message-Id: <20201125210339.1071419-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125210339.1071419-1-aford173@gmail.com>
References: <20201125210339.1071419-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC throws an errors because the clock isn't assigned to it.
Fix this by assigning the clocks info.

Fixes:  acb01032e11a ("arm64: defconfig: Enable clock driver for ROHM BD718x7 PMIC")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 9bdefbba9e90..d897913537ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -111,6 +111,10 @@ pmic@4b {
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
+		#clock-cells = <0>;
+		clocks = <&osc_32k 0>;
+		clock-output-names = "clk-32k-out";
+
 		regulators {
 			buck1_reg: BUCK1 {
 				regulator-name = "buck1";
-- 
2.25.1

