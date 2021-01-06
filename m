Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE62EBE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAFM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhAFMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F488C061375
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 11so1666659pfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/y9bF5GzcDDQpJx8ZDFZlvAK9IBnJLaK6UoovPsBu8=;
        b=FxwUgmT2jVBayjun7NTSZIUgDVLWZB87G8ajAbYBzB6pU/Mmu1tiTgd2YoY0FmDPzQ
         wzqjWlnTz51Vk6LGcMJjKMRBxtHJeBIQUQrt0i9THgyQom56CNt6oDFSYzXVh1MU5kMh
         sZBdW0TJ0ThYD958yhGUJ+wy9wKiVXqfeQtuwzWPcPBaE8ApeqYabDrPJ5Xng/JgZbGm
         JE+69ElvHwKs4Xi2wL6+nLLVnsP9PP31r5PpPcg3DQ9ex+k7D/sK4ICoWCt/Cx8cf42P
         CShZV4r1PhhLGjGbvBytXTG/kljP0+U5aU3i8we9t+HdeOZfJcQnjGs7wPDfC2obaiGu
         m47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/y9bF5GzcDDQpJx8ZDFZlvAK9IBnJLaK6UoovPsBu8=;
        b=nHUwuPZ05OYd9jHr1GTKp/0NHnxEaKPrEY4oriB4NGSsLWP9yFuvrGm1o3312mm37r
         0iUyCa5iIZKPKnUKoi8rKgG0MreKm60yHmLIdM4c1JWwnL8a1zWKX026+RP6niss4zFh
         lwPe+eq0l2+nhAvNLvxdPSXfd7LPLkxqTp8EAfbDC8iBNN3R/o2nZiBaJqhvQde1jxGV
         bGFY7xnVKFxKsQohw0GlgfPGgG7XfYbL5EJ4scdrnm0QMi9uA/XMk6Qa5pOOSXTiJnoc
         mD1koGoGuc93B68nzCr8Obq8Wm0zv2px8sq4RKvvYxudMWKS0lT37gsCCv9zr1DBlXtC
         Cknw==
X-Gm-Message-State: AOAM530/JYAFgVzI80hB4ZCFbLV4Fd4EHSP8z1Avhq8+YhefXPZo2kZE
        /1iSPOWo0l2zTzmy0KxHPyJr2nw2xV2I
X-Google-Smtp-Source: ABdhPJxNFgNJyFphnArhqm83EmzK7ydarRPAGF8G5ciPngf3lDjRDKjQ+xGK8LUPQGWKH0nt4nh/+Q==
X-Received: by 2002:a65:458e:: with SMTP id o14mr4381657pgq.444.1609937685042;
        Wed, 06 Jan 2021 04:54:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 16/18] ARM: dts: qcom: sdx55: Add rpmpd node
Date:   Wed,  6 Jan 2021 18:23:20 +0530
Message-Id: <20210106125322.61840-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds rpmpd node and opps for this node to the SDX55 dts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 9911e672b4d2..6ec7cf1a2367 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,gcc-sdx55.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -351,6 +352,56 @@ rpmhcc: clock-controller {
 				clock-names = "xo";
 				clocks = <&xo_board>;
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sdx55-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.25.1

