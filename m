Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B486A287F56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgJIAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:00:10 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:20440 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgJIAAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:00:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602201608; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=svOoRqtJ5cLu3s1vASk0kRY90uC+P608o+2VET2Fo2I=; b=gyCOQm3AGsEqUA4QSATktEaImIV+HGYHLn3ZdccyFLpn/i1fpHrtgYu3Abx/CfsFWKGL/BOs
 uUMZ1tN/vP9vj19/1Stg/zCyql80A/4pH/Hwy2IqUqLm/lf3sVOzcmIN8yldrbhPbE/P/bf7
 3ehsW5ioRoQH4shcYBNRtVp9ZGM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f7fa7f2d6d00c7a9e28c5ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 23:59:45
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B77F5C43452; Thu,  8 Oct 2020 23:59:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9131DC43443;
        Thu,  8 Oct 2020 23:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9131DC43443
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     sboyd@kernel.org, heikki.krogerus@linux.intel.com,
        agross@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, sergei.shtylyov@gmail.com,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v10 4/4] arm64: boot: dts: qcom: pm8150b: Add DTS node for PMIC VBUS booster
Date:   Thu,  8 Oct 2020 16:59:34 -0700
Message-Id: <20201008235934.8931-5-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008235934.8931-1-wcheng@codeaurora.org>
References: <20201008235934.8931-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required DTS node for the USB VBUS output regulator, which is
available on PM8150B.  This will provide the VBUS source to connected
peripherals.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm8150b.dtsi   | 6 ++++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 2bf385f5a55a..49ea597cc0c5 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -53,6 +53,12 @@ power-on@800 {
 			status = "disabled";
 		};
 
+		pm8150b_vbus: regulator@1100 {
+			compatible = "qcom,pm8150b-vbus-reg";
+			status = "disabled";
+			reg = <0x1100>;
+		};
+
 		pm8150b_typec: usb-typec@1500 {
 			compatible = "qcom,pm8150b-usb-typec";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 6c6325c3af59..ba3b5b802954 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -409,6 +409,10 @@ &ufs_mem_phy {
 	vdda-pll-max-microamp = <19000>;
 };
 
+&pm8150b_vbus {
+	status = "okay";
+};
+
 &usb_1_hsphy {
 	status = "okay";
 	vdda-pll-supply = <&vdd_usb_hs_core>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

