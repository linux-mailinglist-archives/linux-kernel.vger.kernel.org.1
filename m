Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FC2EA803
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbhAEJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbhAEJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF03C061384
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so1392090pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19OfSQMbRh29ftmIa/VWNRiukHisCdmG2Buwzd97YAE=;
        b=O+PH6SlZwuvmXX3jL/UyjVMjSKvjd0yXhovCZ1T0rqTplwNISWRjCxXk6cBCFGv8au
         +JUHyN8HDbiTNP1sjiMlqsBa89WtwZllgJGswGvT5mX3F6NPATQulDB/jhWfmrED1aG+
         /4dSpSq7LBbbt2hmritFUvBBqiz92/wVL38tRzjwqF615nlvnHv62EGQm/LIzeXnLvkQ
         ciX+JIVNWeCDikmv2NmQI+bocFvkDfXzwkxtFxlofkxrj394g4E076WD/4vW5Od8NAJ9
         DLdyuD5AQ0WSLCglWK8CJTr3/5Gw6k4lMg/Ja/AoD4yvAHy1zyIC1GPurcnjaJfwo4uM
         W/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19OfSQMbRh29ftmIa/VWNRiukHisCdmG2Buwzd97YAE=;
        b=Qtrbh5D8wGvxXNqyi4FWEKW1n9OVElVI74miy2dtJZzbGiNYrZ+1s60Pe0GCI5xPel
         9hEulomJssyP4pWXGdtZHVdpGHsDbL6/JR9gGj/oLb2aLBK9uqClmmpxTRNmZabJq57K
         +3D6EqtiS8pbkE9Q5IvRhm26kAxh9hWMKogk4h9b5MTsiO8wLsjZxEZ9hMGpRl7hLK5c
         QtJ4MAgohiaXcvQw6xja4MPB5W+91NHg4w+aHkob15CX/Xnr/prPGGPwSsnjJtKQ1weR
         /6cedYi7XPWPAn3/oThCUUXYkd/xKl9jAY6sDSH4bFajeYcJR5ovdnw1RooOpPSKY2en
         oWRg==
X-Gm-Message-State: AOAM530coUGkGNp1mnV3XxsR2n1mtPCqP1BBxkoayU3erlEA5uZVXaNp
        6euOZAgMRWhpke+AMVjlrE86
X-Google-Smtp-Source: ABdhPJxfdUYO3so5k29tsoDglfwZRdeMPCicAJKiBqzMD7q1yt++I+LwqN9DdLntxUvb73hZvnieJQ==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr3320665pjz.73.1609840055620;
        Tue, 05 Jan 2021 01:47:35 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/18] ARM: dts: qcom: sdx55: Add rpmpd node
Date:   Tue,  5 Jan 2021 15:16:34 +0530
Message-Id: <20210105094636.10301-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
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
index f3864471ba4c..6f53acc882dc 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,gcc-sdx55.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -371,6 +372,56 @@ rpmhcc: clock-controller {
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

