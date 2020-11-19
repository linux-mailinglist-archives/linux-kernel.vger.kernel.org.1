Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A912B96F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKSPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgKSPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:43 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2958C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:52:42 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id u4so5746706qkk.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncm4tg3t1i7YF0Acj05l9+ZFtRqok/Gt9GCUMfnO+SI=;
        b=Dwn1JI3IGVVrz9y1hJnMh9HlIiQF+/UE4yWOgcnTq+QHQ0LRgSEKDOa17UhFgxvw5W
         sfrnXKLoLKvWfb3hD8atziUk3EsE1xbMU/Paxw0f04Jrx9FaVGupvJVC8PtlLpAz9mTT
         YZNyEHaqD1c1sHi+lAHPsqQjYNB2C7hVqGlHXZ346pyCia0Td+Bn9V2H9gMwvS3F3cE+
         /sXSXGVVWvDmDNU98wXz3r+hkVy1GpHWJZfSnFhTybRekpDX3GQiha9tvuFs2S1EoNH5
         NtNal34ErNuxWUva/p0UbDHeDlh7hwO4BxyWAjjyqCuHOohH8T6OZelQaslPySs52tMO
         kVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncm4tg3t1i7YF0Acj05l9+ZFtRqok/Gt9GCUMfnO+SI=;
        b=Qx+4Rfi/n4olU6dv3BjHQiTK4upCQbH4DE4IcOSIqMcYoL/jeISHIMaq8rJimYnxwU
         aNuOEimZS4TZMhVsJdFyWmFZqtpFZyPrseOE8ZcF3Zv0y+hJS1lQDde+trUp+r0eCtyM
         8Xc3gNpEX9od+TwFAeWEhxtYwC/7s4X0Cr1JQUMlhad3s/XPFOiLm6p4pm5E4hShAi6W
         XplY1/ovJcVNuR+LOH+IRGOECxdwTFcw6EY1bS9C+USp3qfdkzlp1hD1YUXm6PAdsd+f
         qCabZfDaaYn5dExWMvIedl96MKh7Pknq1RY7k9EKqiQzGSFG2SfiFVTOsDoiRErwnZTX
         +NlA==
X-Gm-Message-State: AOAM531vJK0gs/VUxQ7IeLZW+2+WdtOlMw+k+FNbDvHkKVEF55n1j/m+
        xQCNIAKOFx3CCp6yyNpe0VB8hw==
X-Google-Smtp-Source: ABdhPJzBzlC9keR57VmYhsWPTNkQgkbnigWXOFO/CWaItdZnYLjbu3+faOf09WY8SRnpqH5zJU98Ww==
X-Received: by 2002:a05:620a:d41:: with SMTP id o1mr11295674qkl.338.1605801161839;
        Thu, 19 Nov 2020 07:52:41 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g70sm127290qke.8.2020.11.19.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:41 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [Patch v2 5/6] dts: qcom: sdm845: Add dt entries to support crypto engine.
Date:   Thu, 19 Nov 2020 10:52:32 -0500
Message-Id: <20201119155233.3974286-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119155233.3974286-1-thara.gopinath@linaro.org>
References: <20201119155233.3974286-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
"sdm845.dtsi".

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 40e8c11f23ab..b5b2ea97681f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2138,6 +2138,36 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 			};
 		};
 
+		cryptobam: dma@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rpmhcc RPMH_CE_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely = <1>;
+			iommus = <&apps_smmu 0x704 0x1>,
+				 <&apps_smmu 0x706 0x1>,
+				 <&apps_smmu 0x714 0x1>,
+				 <&apps_smmu 0x716 0x1>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,crypto-v5.4";
+			reg = <0 0x01dfa000 0 0x6000>;
+			clocks = <&gcc GCC_CE1_AHB_CLK>,
+				 <&gcc GCC_CE1_AHB_CLK>,
+				 <&rpmhcc RPMH_CE_CLK>;
+			clock-names = "iface", "bus", "core";
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x704 0x1>,
+				 <&apps_smmu 0x706 0x1>,
+				 <&apps_smmu 0x714 0x1>,
+				 <&apps_smmu 0x716 0x1>;
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sdm845-ipa";
 
-- 
2.25.1

