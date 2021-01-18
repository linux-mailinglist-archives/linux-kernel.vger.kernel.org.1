Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020C2FA618
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406734AbhARQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:26:51 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:41021 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406672AbhARQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:25:51 -0500
Received: from localhost.localdomain (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 119DE1FC8F;
        Mon, 18 Jan 2021 17:25:07 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: dts: qcom: msm8994-kitakami: Add uSD card support
Date:   Mon, 18 Jan 2021 17:24:27 +0100
Message-Id: <20210118162432.107275-7-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118162432.107275-1-konrad.dybcio@somainline.org>
References: <20210118162432.107275-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign regulators and enable regulator-set-load on
VMMC so as to provide sufficient power.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index 33af174b78ab..26b54f360fc3 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -355,6 +355,8 @@ pm8994_l21: l21 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 			regulator-always-on;
+			regulator-allow-set-load;
+			regulator-system-load = <800000>;
 		};
 
 		pm8994_l22: l22 {
@@ -461,6 +463,14 @@ &sdhc1 {
 	 */
 };
 
+&sdhc2 {
+	status = "okay";
+
+	cd-gpios = <&tlmm 100 0>;
+	vmmc-supply = <&pm8994_l21>;
+	vqmmc-supply = <&pm8994_l13>;
+};
+
 &tlmm {
 	ts_int_active: ts-int-active {
 		pins = "gpio42";
-- 
2.29.2

