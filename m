Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD82EAADC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbhAEM3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbhAEM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:29:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D8C0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so18280357pfm.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cts2vGZ7rrrSCXfEGOMmkzEVqPBhvajN3PzO1Zo1Cp8=;
        b=A/xhvNWQghdZ1v4PRVIws+W+VCAoVlmPb91g7nE856rTTVBk+DFsEbuo4DcRau8oM4
         a7oLHdOCsNCObQ2lipGXaeLP/skC1PSPxXifXTgWRcmDoQeICGve9jHgasfqpJugDrbY
         tyfoPNfDC0yzW5vONsqHlz3x762+pVhCAhPzErkFHWIjrzMn1q3kHyHCg2HpPdt1gNtB
         C33NzAEAI9QBA+pg1ZATo9/bPk6mAxhMZOO+DsQnmS7IEH8FfCXwqoeDPn3tJWE8rGO8
         8p9A6zFR/J+YTur4LobVmzlyRw/D35GleVHABr38EmdyRWhMRgX05g9ZjJerE3r8usO8
         JzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cts2vGZ7rrrSCXfEGOMmkzEVqPBhvajN3PzO1Zo1Cp8=;
        b=YCtr9RcQi2khXrnK0PKgvymfDj4UC6bcw5gsBS4IiMbXd1aoFqMWfd4qwg4oev/FKa
         f7TYSi5ETZFsz2DcOrRICC/kTeFavHCmbKjEUXeI75AektcQZEQ/DIZGRWlhaRzYMgzK
         SiZIQgwdJeymUbu1Il5rOJbrm1k7T+111iknMIOWIwDDNCH23wUSX+DxBajAkatXDo0O
         2vaL+fGB3MTo9Kehkn4tPgFfC5vfblbKPApIyyPxyHLPAuprc95frVscyp05ddhXQUHv
         k/yRPJCx7vR5njkl3Z0rmNeVyr4CUQ3ajzLpB7jgnSa9WlvHYoV0hGy04hr8mWaY51ry
         k1bg==
X-Gm-Message-State: AOAM5309kDQWulhPmf9Wn/HUmo7bO3BnU7zfNI5rTdM75YP3et7g+3cC
        MjijAum+tHjywLUAEPKDKrP+
X-Google-Smtp-Source: ABdhPJyq13duIjIAHcEcRnDTXrWoD8tKCbUKSZJLqoOJADjjFVXosRghSeoOQA3a4o9/ylBOPKVY9A==
X-Received: by 2002:a63:1707:: with SMTP id x7mr42296314pgl.266.1609849640231;
        Tue, 05 Jan 2021 04:27:20 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 07/18] ARM: dts: qcom: sdx55: Add support for TCSR Mutex
Date:   Tue,  5 Jan 2021 17:56:38 +0530
Message-Id: <20210105122649.13581-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR Mutex node to support Qualcomm Hardware Mutex block on SDX55
platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 927f43a7414c..e48ec7a1971b 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -166,6 +166,17 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		tcsr_mutex_block: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x1f40000 0x20000>;
+		};
+
+		tcsr_mutex: hwlock {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_block 0 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

