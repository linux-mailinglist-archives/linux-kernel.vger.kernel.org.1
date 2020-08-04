Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5823B66A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgHDIIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 04:08:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:46048 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgHDIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:08:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596528524; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wzkE1gcsoctw3hiDqTWdfJ/SEs/ShA6LmWUp5yuAKJA=; b=liZhsIwJOaT4RNwUIGiTG1N7S8HqwIXvJH7mZX5IbP2mK1XjqTaUvBYgRzy9fwogS3mYoNyo
 OitKdcJJP7pPsQekEyZGPTGoSoekn0O0KeTlf6RyASLUuVrqxJ6b7Fcl3tQNWupTcfdcCfHl
 4EPFTeOppZJoTgrNjdQGrq+eAj0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f29178c9fdcd87189b5ad48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 08:08:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7536C4344B; Tue,  4 Aug 2020 08:08:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCCDFC433CB;
        Tue,  4 Aug 2020 08:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCCDFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v5 07/12] dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node
Date:   Tue,  4 Aug 2020 13:37:28 +0530
Message-Id: <1596528453-11437-8-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596528453-11437-1-git-send-email-rohitkr@codeaurora.org>
References: <1596528453-11437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings to support "qcom,lpass-cpu-sc7180" node.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 55 +++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index 32c2cdb..c07202c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -4,7 +4,8 @@ This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
 
 Required properties:
 
-- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu"
+- compatible		: "qcom,lpass-cpu" or "qcom,apq8016-lpass-cpu" or
+			  "qcom,sc7180-lpass-cpu"
 - clocks		: Must contain an entry for each entry in clock-names.
 - clock-names		: A list which must include the following entries:
 				* "ahbix-clk"
@@ -18,6 +19,13 @@ Required properties:
 				* "mi2s-bit-clk3"
 				* "pcnoc-mport-clk"
 				* "pcnoc-sway-clk"
+			: required clocks for "qcom,lpass-cpu-sc7180"
+				* "audio-core"
+				* "mclk0"
+				* "mi2s-bit-clk0"
+				* "mi2s-bit-clk1"
+				* "pcnoc-sway-clk"
+				* "pcnoc-mport-clk"
 
 - interrupts		: Must contain an entry for each entry in
 			  interrupt-names.
@@ -53,7 +61,8 @@ Required properties for each DAI (represented by a subnode):
 Note that adding a subnode changes the default to "no lines configured",
 so both playback and capture lines should be configured when a subnode is added.
 
-Example:
+Examples:
+1)
 
 lpass@28100000 {
 	compatible = "qcom,lpass-cpu";
@@ -77,3 +86,45 @@ lpass@28100000 {
 		qcom,playback-sd-lines = <0 1>;
 	};
 };
+
+2)
+
+#include <dt-bindings/sound/sc7180-lpass.h>
+
+lpass_cpu: lpass {
+	compatible = "qcom,sc7180-lpass-cpu";
+
+	reg = <0 0x62F00000 0 0x29000>;
+
+	iommus = <&apps_smmu 0x1020 0>;
+
+	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
+	clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_CORE_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
+		<&lpasscorecc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
+	clock-names = "pcnoc-sway-clk", "audio-core",
+			"mclk0", "pcnoc-mport-clk",
+			"mi2s-bit-clk0", "mi2s-bit-clk1";
+	interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "lpass-irq-lpaif";
+
+
+	#sound-dai-cells = <1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mi2s-primary@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	mi2s-secondary@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+};
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

