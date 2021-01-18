Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC52FA620
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392860AbhARQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:27:58 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:59981 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406710AbhARQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:25:58 -0500
Received: from localhost.localdomain (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id D3AC11FC5C;
        Mon, 18 Jan 2021 17:25:00 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] arm64: dts: qcom: msm8992/4: Rename vreg_vph_pwr to vph_pwr
Date:   Mon, 18 Jan 2021 17:24:24 +0100
Message-Id: <20210118162432.107275-4-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118162432.107275-1-konrad.dybcio@somainline.org>
References: <20210118162432.107275-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the fixed regulator to follow the common naming scheme

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 5 ++---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 0c422af47917..7c2770f60b07 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -725,10 +725,9 @@ timer {
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	vreg_vph_pwr: vreg-vph-pwr {
+	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
-		status = "okay";
-		regulator-name = "vph-pwr";
+		regulator-name = "vph_pwr";
 
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 6e083a2f690b..f7e6423db8d4 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -790,9 +790,9 @@ timer {
 			     <GIC_PPI 1 0xff08>;
 	};
 
-	vreg_vph_pwr: vreg-vph-pwr {
+	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vph-pwr";
+		regulator-name = "vph_pwr";
 
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
-- 
2.29.2

