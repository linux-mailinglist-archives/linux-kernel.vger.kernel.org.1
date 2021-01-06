Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99272EBE0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhAFM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAFMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948DC061365
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i7so2166798pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knoP4Y7GeyRz5anuMPnotwfe10J/VqLnOfm6LoV3mIA=;
        b=XwqpYsLL4hAvWYZEpPuRRv6F9kUuVA6OfqqZpAzyzon5/2WGTOazrJU+mScptdbNTn
         PsxgJus9+iJT3+uLOwcI/BZvIonId7vRb2ZDLU1KVdFRelVLZeJa607SBH85TKcdfhqC
         U8qEe4mPiqK99NOq2cb6FnqUu99sDv596/ENKAcItc7s081/JgQWvshOuEqr4qPI5B2M
         0YnuLO74PckbJJU+SGttv+Y3bygmBTOKWNNQYucVogan3buWZaAOTNE7XgI26Rmxhwdt
         VJdr5UNChe08l/3dKm3aVr+Cx0f4XQvtFBrX1zHhYjhbq756hoWgE0GOQVc+AlV2LqY4
         cucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knoP4Y7GeyRz5anuMPnotwfe10J/VqLnOfm6LoV3mIA=;
        b=MgGvLpXmBvXs798VRhKpTLlCDBQdBmSrvP8qa+3F9aGEu3lyhF7MkhTQWCumjt3jS7
         GzSF2Ao9p4FRZZ+1KlyqStvxr0KKU7O8NUth1kFQoz8OE3KkfoxSQumWucbHBbYEGMTJ
         DUuktZGHKLuyl0s/bPUgLm/tGkJMpgbS6MWw5Fv/i3Mc2K73+dIV6OjorNURNHkvNSas
         oRIKWHwskrTcX/hKXqsn5q3WiKesu+QPxZHOHiFfW6774OKAa9ucWhDMPhHeidyL2g5/
         0DwhTZhb4mp04vZSY5IihbVljBt06oZm+/wWWrPY6clkWPcw3mWx23jpejp0cjONddLB
         fnqg==
X-Gm-Message-State: AOAM531feHc0jCw8DHCgwWxbvQ5XEFjQqoZ5CVbUAHMMv2xK/stIXKde
        o5hcA9DxjzgI9mzWNzCvfEga5hmPzSk+
X-Google-Smtp-Source: ABdhPJyQ7HzSBtPXPB0/nk92ZSvw5eepA7MjSHF4RXuNuBnrsN2JR4bHELlvnH59NpvYCN1sS/hfMA==
X-Received: by 2002:a62:37c7:0:b029:1aa:22ea:537d with SMTP id e190-20020a6237c70000b02901aa22ea537dmr3702694pfa.56.1609937648898;
        Wed, 06 Jan 2021 04:54:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/18] ARM: dts: qcom: sdx55: Add support for TCSR Mutex
Date:   Wed,  6 Jan 2021 18:23:11 +0530
Message-Id: <20210106125322.61840-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR Mutex node to support Qualcomm Hardware Mutex block on SDX55
platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index d78e1123b422..b752b150a5e7 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -139,6 +139,12 @@ blsp1_uart3: serial@831000 {
 			status = "disabled";
 		};
 
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01f40000 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
 		sdhc_1: sdhci@8804000 {
 			compatible = "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
-- 
2.25.1

