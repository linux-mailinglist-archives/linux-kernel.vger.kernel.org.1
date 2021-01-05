Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4762EAADF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbhAEM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbhAEM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DAAC06138A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:49 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c22so21143619pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19OfSQMbRh29ftmIa/VWNRiukHisCdmG2Buwzd97YAE=;
        b=sQ5HZs5WJzEblH00IWUr2IsN1ixg6IZWdd7Z214fVXKyocGF7sCGIISNcyOVSkpR82
         lYiUdyb1ghZKyIY1g3ny+n1+Dsj3B0sRMezDYGIWCR0FnoWS9SOrGMaCioQb2SS+MOhy
         fPrdZbed8RtwIdSfiVz2aUDtDUIr8DKIRC6TP8KAu+7yF9mzZ62ndeM3PTT2YBPaj6NL
         M6lEX+J1NVUSsZiVDSTwX6saOMBMfUVrvTp9fcotR/u0CQ44Vy9lc7PkhkNhRq+ZgmMV
         EgTnSA9oIIWNizTUIXNcxVtFvPAWekDG1krm/5aK1q+uEbbvHczA0g/IozsZwhSF543A
         eG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19OfSQMbRh29ftmIa/VWNRiukHisCdmG2Buwzd97YAE=;
        b=SqnpV8x5LtZZBSKDwkesXlbv5Ui/bFakFeyk7hQoKGcxHZOkffGtCd6He7hKQMUlPf
         yAmk2MCndxd3s7gLdi1K/6jA8I3aj7XG8qigmsjaAyRwlA0qpY0DrVD/yyhL/LdNQwdN
         Ve5cMb1kDmRlkQtx5ciNoMd2yWmIUn+vr/5c6pIygyvM4PsL5mZ6w5Ov8E9F8Vaj73CX
         SHZvdRJrhPy4mmzpg1dG7W+1ILRLndXfBNd2UnWwU6L7E4f/gvVxZU2TfV4hcq2qAm8x
         WOwzj3uB7ISfFJtfxgD/YzjP9SiV0AD3Db71ggZ6MyvwbBMLJy7Jw+Yw+F/uR5rFs48H
         jWeQ==
X-Gm-Message-State: AOAM53398LK5bTcUXng+nf2UldLTAQauryVAw8FEvX6eqqN1fugo7GEL
        +vpAlkQnJE93c3LOTXjUdTF5
X-Google-Smtp-Source: ABdhPJxQnHY9aBaHKLzriQ1v1OGmHYI0VTuRYhT+UxdJfB8bCtf8b7IoyrNTB9/bPIi5JlCXR9PB6Q==
X-Received: by 2002:a05:6a00:134d:b029:1ad:b17:dbc4 with SMTP id k13-20020a056a00134db02901ad0b17dbc4mr62591909pfu.53.1609849668975;
        Tue, 05 Jan 2021 04:27:48 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 16/18] ARM: dts: qcom: sdx55: Add rpmpd node
Date:   Tue,  5 Jan 2021 17:56:47 +0530
Message-Id: <20210105122649.13581-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
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

