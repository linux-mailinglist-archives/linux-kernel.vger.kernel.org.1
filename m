Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9137B2EAADE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbhAEM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbhAEM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:29:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC5C0617BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so1614682pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuH2EEAxcppvUqPq2YEsaD2UoBQy97IRscYtDXxjJcU=;
        b=TNyQLCK8Elp35PEuLuD1Z8apl/ubhOnEu8uHWNDzxEbCaMtOGKXgy57mHnUqMcbDdR
         u0JcO4WAjJQvFLlsPYa1p8eTM7fQfpmgnewb/M4V6VLY688yPn3kK6A3Y+wlwKPW7u/e
         7o66ULfD5OHOKypEkAIQHihSgtDzJj+zi6cGbAq4Xq6xYOlPxOKCw+LNXFHvpiL3WbZK
         w3CUX8zG4CxxdaNsE3iGVYA6cuNveeoCkeQR1CnZ2fFYIfdiMiRKtIuC6NuKJfh9HfAA
         73bDd7cOuvNao2Zz0RtfzsxY61HwmuQxryW1B/NsMkeAE/e90pKgvjXw5O5FRpoEAoJ+
         QTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuH2EEAxcppvUqPq2YEsaD2UoBQy97IRscYtDXxjJcU=;
        b=Mai4+B9KZT81o0dg8m2KDn5W62vPCxwj4O5f8o/mYFO+julZgm+HK3Z9UspPO5ChZ3
         HVKPvIvTSz4q2JDS/QRQlGqmElY6x/YtLH8xOE6wvxRlXQk7eiFeNhV/j0re6atkhy8H
         eB2QTSJy0LW99ay0faN3AzPZy5A05mcBfH76z3KoHZ4Stfi1ndtOOeCAjJU/pR40A2ph
         NcDyFDTqj6OmrAvN583L/0dwAgGcJ9qPIXCGhDTd7CXgSlVDTHUUtuUXu3BZhY8pgGMq
         pSEd+61+TLCotZA4ry9sCmIzmUfegNlV2V3t+84zpUO6Zc3ICl6CRT16PEHEgAd19Dq5
         7AuQ==
X-Gm-Message-State: AOAM5302U8t0OPOvM9zSSFDHvPb/KFOwkDJdYT+k4ChzlMn8111SQniT
        TqhI/HL4t8MQ0ntRMerLJRR4
X-Google-Smtp-Source: ABdhPJxAw58MCZh4WFV88F+codV95ZX/slxvTq/ruzR+xGXYbDdQFd8f8OgSQP1tFXME4O57sk5IWg==
X-Received: by 2002:a17:902:7292:b029:dc:ac9:25b5 with SMTP id d18-20020a1709027292b02900dc0ac925b5mr77669939pll.2.1609849646792;
        Tue, 05 Jan 2021 04:27:26 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/18] ARM: dts: qcom: sdx55: Add QPIC BAM support
Date:   Tue,  5 Jan 2021 17:56:40 +0530
Message-Id: <20210105122649.13581-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic_bam node to support QPIC BAM DMA controller on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 622a63b0058f..1b9b990ad0a2 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -166,6 +166,18 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma@1b04000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x01b04000 0x1c000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rpmhcc RPMH_QPIC_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			status = "disabled";
+		};
+
 		tcsr_mutex_block: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
-- 
2.25.1

