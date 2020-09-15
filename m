Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AAA269FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIOHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgIOHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:24:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A27C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:24:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f1so874177plo.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+BrNXRxv8fGST2O/AL4jHM4ZP3mKD824W/Sr7p4Ymk=;
        b=F9na49fUZEvPUjtIioDeLh/fLkeokofNAIVa92pJv8M4U2GBo9NkQM9n1ytkKPwGzi
         n+TipsGODY/oYhSJXn6gEPMTkYVQrmcSzb0K6MzAyXpBrFWL5PUduS9uTKL4qLhkC/jk
         OmpgMo8f/QhGw8OURR+u5C+s/GyPQvhoOpaNPcGIQRU7Aa0drafj6OSxeyzDFC+v8zHc
         Iwja8TeP5dM7B6pLzwp6xPuABXWUUMEmaPZ84z9WhCSvVZX2hZQ/yt7U8t5MgUxbfXqs
         Mr2S+fm1RdbpVID2aaXf1sMiM3pD4gcDVXYB+6tRN/o7KnJjAl6YtbiOhDKao7iyobB/
         dxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+BrNXRxv8fGST2O/AL4jHM4ZP3mKD824W/Sr7p4Ymk=;
        b=WEfiVD5xCtMcafu3jPdc2aD1+7E3gU2haJMZRVn1C9Qt5Ks9cqRa041hU+SrAvWcUk
         AkxBX5ohyOJi3ReSRMhOM3iiXqTXQWjZb9Zt519/z6PMYgD5tLfRE0nnxQyspMFV1HX+
         UwNTLY+BMB70pow6hNN+a3hKAdW6yihhnnT7lbUjw8stmWisexQcuGUgWKkxbYDjB4vF
         5YG8bzpF20R2y4zuu1s/y8bprLfxTp7oe5OVuYpIp5Q3af/IK9d94H8OCUd0rgrb/C/N
         Z7i8FRA140FVycplhB8dqNXLqLUo1YmRpuFNNR0z88vS7PKTYo58jk0u+Nf6Cnmws/LA
         6yqw==
X-Gm-Message-State: AOAM532p9u/1FTCpIiBM0f2lFJ99CaIwAmK+vgPqe7/YDApJFouMXbC8
        uWEmlPNX/0K9T2eAEuyjvfHchXVlpR8yIaA=
X-Google-Smtp-Source: ABdhPJwogN5gW1S+CQKFPlA09s/TLUgaqlXK1CWyATAmwJH5fRmPj8m7nhWH/2p7pUiSs0FKRU7dAg==
X-Received: by 2002:a17:90b:1741:: with SMTP id jf1mr2890833pjb.164.1600154684566;
        Tue, 15 Sep 2020 00:24:44 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m24sm10701501pgn.44.2020.09.15.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:24:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/5] arm64: dts: qcom: sm8250: Add cpufreq hw node
Date:   Tue, 15 Sep 2020 12:54:20 +0530
Message-Id: <20200915072423.18437-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915072423.18437-1-manivannan.sadhasivam@linaro.org>
References: <20200915072423.18437-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add cpufreq HW device node to scale 4-Silver/3-Gold/1-Gold+ cores
on SM8250 SoCs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amitk@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e7d139e1a6ce..7eb0eda37b26 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -87,6 +87,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -102,6 +103,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -114,6 +116,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -126,6 +129,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -138,6 +142,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -150,6 +155,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -163,6 +169,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -175,6 +182,7 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -2076,6 +2084,20 @@
 				};
 			};
 		};
+
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,sm8250-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0 0x18591000 0 0x1000>,
+			      <0 0x18592000 0 0x1000>,
+			      <0 0x18593000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1",
+				    "freq-domain2";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.17.1

