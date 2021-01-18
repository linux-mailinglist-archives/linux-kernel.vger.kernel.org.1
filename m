Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525D2FA603
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406575AbhARQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406577AbhARQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:20:36 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D7C061575;
        Mon, 18 Jan 2021 08:19:56 -0800 (PST)
Received: from localhost.localdomain (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 11A951F524;
        Mon, 18 Jan 2021 17:19:54 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8992/4: Add RPM Power Domains
Date:   Mon, 18 Jan 2021 17:19:42 +0100
Message-Id: <20210118161943.105733-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118161943.105733-1-konrad.dybcio@somainline.org>
References: <20210118161943.105733-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 30 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 30 +++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 7c2770f60b07..b2046497dcaa 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8994.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -713,6 +714,35 @@ rpmcc: rpmcc {
 					compatible = "qcom,rpmcc-msm8992";
 					#clock-cells = <1>;
 				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8994-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+						rpmpd_opp_super_turbo: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 7ff1dfaddd79..e694aaad3c99 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8994.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -235,6 +236,35 @@ rpmcc: rpmcc {
 					compatible = "qcom,rpmcc-msm8994";
 					#clock-cells = <1>;
 				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8994-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+						rpmpd_opp_super_turbo: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
 			};
 		};
 	};
-- 
2.29.2

