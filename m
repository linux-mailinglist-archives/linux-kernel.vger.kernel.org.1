Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6B2CA740
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391870AbgLAPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390571AbgLAPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:38:42 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4281C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:37:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so6087346wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIHgb8fdd+Pz02Bd0nEwBeV7zsJRfiJajUBhZJqVTbc=;
        b=hJ2xUF+iuAw0FHIflFts7a3mYNfAl/QwZOV2gFcw+ZUNMyeLrhFSmRtRQ5axv9lwOz
         KSYpS7NKx/7txNZYj/t1itXvprHH+dg4/3dzDKMFz4bEgALCsrPYN/KjEADn04z+sDOo
         wKDQFJZw8qz07eJbqQry3/449zialwZsnQJVqkg5B4mG3vK9acfHOaJB52K+6ehN1uER
         0RkF2dNBSvjJmlQeVqTpCGbdmxOOMu/JyYVMPclnxF6KTdHLNkCEK98Uax+/qmfJgrFa
         q0IG2iYSkp6ZKKPApS8ZcyySMZFrZhGte45NpHwaZsBM7LOGyHPtve1NuPejLwkgpbLh
         Z22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIHgb8fdd+Pz02Bd0nEwBeV7zsJRfiJajUBhZJqVTbc=;
        b=uPmDbOCLWNGzzRVBL8g5F3mPmoC43k9Md2qrQ30IeRfbh+6RdlhK9IUJQEbEAhHJTY
         yy1L5CFwYw3VIwCFNzbrr/TFl31f34BxpYhXijC+8m2Si31jqB47i1k6IusJ8vsKsVxP
         XfI3be+cdpWYezQ+Cv81voO55RdtT9ngrPRRJzzUgrklBSTDVJ590XItHsCJN6QqpSma
         HoScnSCnp15cerSTq1Qc7jelGJhZybUq488R5pyOadU9dF/6IToxhgvbBb44mWbuqu5D
         lcgRKN+LSDxGRFHB1sgitmNx2JV1dCZO0zUKXHGBqBgiOYRU7LlmZpNVnDVo2Cg7j1td
         O7Lg==
X-Gm-Message-State: AOAM531rMtKXz5/6mJ460CsJZC+GO4sFiaEuMqaOwql9l9TWDc0n4ozs
        sYp1WQeKZHlRrJ9+Cz3jCVvHqA==
X-Google-Smtp-Source: ABdhPJw7MCl9H8yU9lww2ZCsGtRpMhv+3Gv0zkH0pAiNK0tBttU7q1bJbHd3vj2J2A5jjcEIiQZ9QA==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr3235175wmf.59.1606837037869;
        Tue, 01 Dec 2020 07:37:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y7sm302171wmb.37.2020.12.01.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:37:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: sm8250: add audio clock controllers
Date:   Tue,  1 Dec 2020 15:37:02 +0000
Message-Id: <20201201153706.13450-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
References: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audiocc and aoncc clock controller nodes required for audio on RB5.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 3b4e98b13d36..ec5b53b8f656 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8250.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8250.h>
+#include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
+#include <dt-bindings/clock/qcom,sm8250-lpass-aoncc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -2585,6 +2587,26 @@
 					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		audiocc: clock-controller@3300000 {
+			compatible = "qcom,sm8250-lpass-audiocc";
+			reg = <0 0x03300000 0 0x30000>;
+			#clock-cells = <1>;
+			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio", "bus";
+		};
+
+		aoncc: clock-controller@3380000 {
+			compatible = "qcom,sm8250-lpass-aoncc";
+			reg = <0 0x03380000 0 0x40000>;
+			#clock-cells = <1>;
+			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio", "bus";
+		};
+
 		adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8250-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
-- 
2.21.0

