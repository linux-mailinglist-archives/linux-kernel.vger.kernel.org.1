Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473021ADF65
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgDQOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:06:40 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61937 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731151AbgDQOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:06:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587132398; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MkGLn7lkOqxZllVszXuo1Fr40qbxDQiMjGnb44dbThE=; b=cmNbeq/foxSvo0/6sNr/Tvst6lDf/vielu3qTkazfjat64vLTAlT9JSeVjMXma7MBWmFCsV1
 fU9xhZViJEJDXod4OjkdDg9LAVJkZgGh13ScsE4LgZQT2KdXgvRDvNLfmiIByraBReDma2VB
 VaZUmbVpNodzafWCtxR/ZoMK4Ac=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99b7ed.7f951a888f48-smtp-out-n03;
 Fri, 17 Apr 2020 14:06:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BB77C6473A; Fri, 17 Apr 2020 14:06:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C63BCC38567;
        Fri, 17 Apr 2020 14:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C63BCC38567
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 17/17] arm64: dts: sc7180: Add qspi opps and power-domains
Date:   Fri, 17 Apr 2020 19:34:39 +0530
Message-Id: <1587132279-27659-18-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587132279-27659-1-git-send-email-rnayak@codeaurora.org>
References: <1587132279-27659-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domain supporting performance state and the corresponding
OPP tables for the qspi device on sc7180

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b87f3eb..c340a63 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1421,6 +1421,25 @@
 			#power-domain-cells = <1>;
 		};
 
+		qspi_opp_table: qspi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-150000000 {
+				opp-hz = /bits/ 64 <150000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
 		qspi: spi@88dc000 {
 			compatible = "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x600>;
@@ -1430,6 +1449,8 @@
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
+			power-domains = <&rpmhpd SC7180_CX>;
+			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";
 		};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
