Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0177A2CC48B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgLBSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgLBSIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:08:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533CC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:07:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a3so10772258wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6nXFxwui6LlgkzThdMNjZ7jNWTIQtA3MqnNk7x+FbA=;
        b=eCfisf3scDZboHsfmTrU9hQL3m3FB9sjSJHws8ZskY7oNjwUnzr3djiDKnorRanFOj
         BOxWeh648P014c1o2sHr6O62S1FMuHlj983nPwDpp15vb7mKHF2B0jg0A81VkaZLp0Yt
         jypoZZzyeyzSVD9PJZbE8sEsYVu3WCLoVIkAPu+C68/yqYwIQ/EyVYXyXetzrsWFfpRU
         fj9Z58i1tFUcg+cVlWWzR+H7Lt9DfdA8Lwkyw/YUMF5Yvjt/z9Oldd3GEDECo0ZsKCBG
         5QOuLrmJzf4xAZjCv/pzGJEwrCbPMkS3SURQG7xVOztgiil4fHpUOJFyWkwdyvO0luYt
         Jv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6nXFxwui6LlgkzThdMNjZ7jNWTIQtA3MqnNk7x+FbA=;
        b=oWMHiYDZtiB14vXK3dVEtKyaVyeRKXMfSw7niyVQqySclxbiltXgqLPzdPxewW2iVu
         s90bovAeHBxxQm0T8fmtYQc3sn1qNjwk9Fuw4bB2Ah2leCw5XjN8EpFlbxObBgRrVx/G
         Y4cUK+gD1gaSBlttO2meK+I+0p4T/LufQEjKY7hcaEHTwtevYN1i7U0r5YxiLI8v4pR6
         swPClq8bDL5DVzQxRe47Z0rBLc/NhYrqiW6+38eraMqo4U9oJTpEpZbjhKMMsXa+ueUJ
         YRaaP6mGBMT5hK6I3POd9T3DXQ6CsvvLOeXM3rRJUBBDotRhoxiWvZuhfyVXe3zK8la8
         svGw==
X-Gm-Message-State: AOAM533b8rAQXgODe8xgqxq16bQWbiQdIYP8BmXU8eTEaLPj/zsWKvxS
        ZgglsIhx9nhgHQf16ELtV5ElAg==
X-Google-Smtp-Source: ABdhPJxExSgM6GM/aAxAthga7OMPmTb2ZJL3oUkFTfcdhhckmEtj62dmQ1Dsh1lJcgvC5hBSPZ9nLw==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr4319430wma.93.1606932473145;
        Wed, 02 Dec 2020 10:07:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a18sm3004404wrr.20.2020.12.02.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:07:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/6] arm64: dts: qcom: sm8250: add apr and its services
Date:   Wed,  2 Dec 2020 18:07:36 +0000
Message-Id: <20201202180741.16386-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201202180741.16386-1-srinivas.kandagatla@linaro.org>
References: <20201202180741.16386-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apr node and its associated services required for audio on RB5.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 65acd1f381eb..d44120a6eadb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -11,7 +11,9 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -2620,6 +2622,60 @@
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					apr-service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: apr-service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: cc {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: apr-service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1801 0x0>;
+						};
+					};
+
+					q6adm: apr-service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
-- 
2.21.0

