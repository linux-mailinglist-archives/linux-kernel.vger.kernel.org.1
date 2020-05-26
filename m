Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED611D8A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgERVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgERVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:49:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3165C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:49:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f83so12101006qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEJGey6/k+OCef6v3YjhHQLAmR02XJvq10/E/t+8+J8=;
        b=te7Db9QKy+oMGYwWc0ZE8dhloSzTPm0L0vEClSIMuRdsOHuYiIt1rrGk6zZ4yv+MAd
         3X3cKcvJiYGm90R0/E3PUXjIyTAguDzXBibrSVYHgDN8tJQ3VaFT8wTokdlCE2fMhogW
         pe2maBoDXGcBjROp592R6oTdzMXc8OoYGCk4nm2hQKEMB/b1l41OwDaI91lvh0ENL3uL
         lIBLcGSrB5TAUbyJo88tib/ujn39P3vOT8fHYvHgobpPorz8HbPxFFdltCyPqHhHKmEM
         kh6TX8Dm0NplIiAMqoQBULMVWNsxZ863BUDdtAbe6+O/eUhcZmlVBFgnUeu8xeTfYhR2
         Ke7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEJGey6/k+OCef6v3YjhHQLAmR02XJvq10/E/t+8+J8=;
        b=EZNaRmAc0Y/jYcKVF01KrIe3K1Pl6W2KsIJ8ucUkGzfxzSQ5DKUHZkBuLMR7ePBtp1
         MJzYLBiFHqvEaMC8DNx7qQZuAUOZhFZOyok/4j8ni1zxHnf9I5uyGdA02cNSJHsfxiyb
         to7ZxZLNStCfBhEgU6Jm0X4mWL3IrXILF9EwqIV997eoHZ1bTm84HVECO4OcZmen+doW
         cwrJkeSnZbx5z973zkUQH2qaOVT9ckPOEdwyWNoXHwsE1zm3gIJBoVs49gxx0F+A4GPJ
         wFVMaO6NLLp9ccJl3SbbIpRhfUlLo6J0X1PsV5DnuvP90fQJZyMKjTVuQUooziuooBv9
         6FBw==
X-Gm-Message-State: AOAM530p4+doL9MiwqtM2BCdL/oIAeWUlDEP4e3PZLYakGZHqwiD3gZB
        ZpZUn/IeaGBdGk+HmquJk1l1FA==
X-Google-Smtp-Source: ABdhPJw8kB3CDlOkwgFJthOf3NhKgyWY80Nsf1LKhHEUaiGAyRRCKloZ+j9XqNWgCmnxjml4YwgBfQ==
X-Received: by 2002:a37:acc:: with SMTP id 195mr17757770qkk.419.1589838583127;
        Mon, 18 May 2020 14:49:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a16sm8947707qko.92.2020.05.18.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:49:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sc7180: add IPA information
Date:   Mon, 18 May 2020 16:49:39 -0500
Message-Id: <20200518214939.9730-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPA-related nodes and definitions to "sc7180.dtsi".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f1280e00b064..9a3686ce73ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -461,6 +461,17 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	psci {
@@ -1007,6 +1018,46 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ipa: ipa@1e40000 {
+			compatible = "qcom,sc7180-ipa";
+
+			iommus = <&apps_smmu 0x440 0x3>;
+			reg = <0 0x1e40000 0 0x7000>,
+			      <0 0x1e47000 0 0x2000>,
+			      <0 0x1e04000 0 0x2c000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
+					      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
+				        <&aggre2_noc MASTER_IPA &system_noc SLAVE_IMEM>,
+					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
+			interconnect-names = "memory",
+					     "imem",
+					     "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			modem-remoteproc = <&remoteproc_mpss>;
+
+			status = "disabled";
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0 0x01f40000 0 0x40000>;
-- 
2.20.1

