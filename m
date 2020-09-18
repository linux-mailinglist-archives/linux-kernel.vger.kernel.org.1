Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712EA27004F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgIRO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:57:13 -0400
Received: from m42-11.mailgun.net ([69.72.42.11]:24414 "EHLO
        m42-11.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIRO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:57:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600441032; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=t+7g+pEV5SjJC4AvV+pwWDH02tzEERCBUCn9AGMC6Pw=; b=jVakiOSu+asY00O6Y9sqO4IGd9/LaRQOzbr1SjedHqZhuRYbQwocQCMJ8Lv9g0Myfpb4nTx9
 1L0UGx8jgg06Oyy5pWaeC/KURm916ifcziEWEmyYZYyrSx0XQgDAQkSG4V7z39HQIhAwQOto
 jHafmB2j719eEkTxFG9wpH8qpeA=
X-Mailgun-Sending-Ip: 69.72.42.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f64cac60566e2dcd77cf8f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 14:57:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C024C433CB; Fri, 18 Sep 2020 14:57:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9E1BC433CB;
        Fri, 18 Sep 2020 14:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9E1BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for HDMI
Date:   Fri, 18 Sep 2020 20:26:47 +0530
Message-Id: <1600441007-2427-3-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600441007-2427-1-git-send-email-srivasam@codeaurora.org>
References: <1600441007-2427-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Add dai link in sc7180-trogdor.dtsi for supporting audio over DP

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 5724982..adbbb2d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -230,6 +230,7 @@
 			"Headphone Jack", "HPOR";
 
 		audio-jack = <&alc5682>;
+		hdmi-jack = <&msm_dp>;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -257,6 +258,17 @@
 				sound-dai = <&max98357a>;
 			};
 		};
+		dai-link@2 {
+			link-name = "MultiMedia2";
+			reg = <2>;
+			cpu {
+				sound-dai = <&lpass_cpu 2>;
+			};
+
+			codec {
+				sound-dai = <&msm_dp>;
+			};
+		};
 	};
 };
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

