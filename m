Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E5221C24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 07:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgGPFqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 01:46:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52328 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgGPFqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:46:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594878393; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=6/gh6ivbd09D7l8l4mc9ZClJc+uYvsmImgyKmqe70mY=; b=h1vHbvL/mgKH9UfzxWAPyn7huMzSrRSD/VGXGmq9jqBBcb6tIg+nTR+gRr3aYGz6g/Rnjre/
 O+BsHtLRlr8FDncuaB7J8QsXfYVitLz765S39PzhIWattYhUma5DlVQp6uzKL+u+gqGE0Ym5
 zCFPkyDgKdpxjXdWO3+vhLKtS8I=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-east-1.postgun.com with SMTP id
 5f0fe98ec7a053446a793474 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 05:45:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BEAAC433C6; Thu, 16 Jul 2020 05:45:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36AD9C4339C;
        Thu, 16 Jul 2020 05:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36AD9C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     stanimir.varbanov@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 4/4] arm64: dts: sc7180: Add OPP tables and power-domains for venus
Date:   Thu, 16 Jul 2020 11:12:19 +0530
Message-Id: <1594878139-3402-5-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594878139-3402-1-git-send-email-rnayak@codeaurora.org>
References: <1594878139-3402-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP tables in order to be able to vote on the performance state
of a power-domain

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 126e2fc..c560ad2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2664,8 +2664,10 @@
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc VENUS_GDSC>,
-					<&videocc VCODEC0_GDSC>;
-			power-domain-names = "venus", "vcodec0";
+					<&videocc VCODEC0_GDSC>,
+					<&rpmhpd SC7180_CX>;
+			power-domain-names = "venus", "vcodec0", "opp-pd";
+			operating-points-v2 = <&venus_opp_table>;
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
 				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
 				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
@@ -2686,6 +2688,35 @@
 			video-encoder {
 				compatible = "venus-encoder";
 			};
+
+			venus_opp_table: venus-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-270000000 {
+					opp-hz = /bits/ 64 <270000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-340000000 {
+					opp-hz = /bits/ 64 <340000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-434000000 {
+					opp-hz = /bits/ 64 <434000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					required-opps = <&rpmhpd_opp_turbo>;
+				};
+			};
 		};
 
 		videocc: clock-controller@ab00000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

