Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAB28E389
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbgJNPqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:46:55 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:12538 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgJNPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:46:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602690414; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GdAJsxlfjQDS2Suiw8hdgs3pLDF9j25++frwrCPkCvg=; b=OPKhV8g2XPbh33hS5fWcLYIPLmvon34ACE4sTxRZcY8WVwzrF3mfI6b30R4jWByN+2bGx4Pl
 r8vE6+BO4ukbPU8zDQrh59ElHfiV4UH4ImhOoL6e2NL5Au6naHzGaUFvl0j54JNK71lx8Wyo
 OWrgg0jxOoFGJ8up+5mo2H6JKoQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f871d630764f13b002c8c39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 15:46:43
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9225C433FF; Wed, 14 Oct 2020 15:46:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03AF0C433C9;
        Wed, 14 Oct 2020 15:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03AF0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org, sricharan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Kathiravan T <kathirav@codeaurora.org>
Subject: [PATCH] arm64: dts: ipq6018: update the reserved-memory node
Date:   Wed, 14 Oct 2020 21:16:17 +0530
Message-Id: <1602690377-21304-1-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory region reserved for the TZ is changed long back. Let's
update the same to align with the corret region. Its size also
increased to 4MB from 2MB.

Along with that, bump the Q6 region size to 85MB.

Fixes: 1e8277854b49 ("arm64: dts: Add ipq6018 SoC and CP01 board support")
Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 1aa8d8579463..ee7acddcbdfa 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -98,8 +98,8 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		tz: tz@48500000 {
-			reg = <0x0 0x48500000 0x0 0x00200000>;
+		tz: memory@4a600000 {
+			reg = <0x0 0x4a600000 0x0 0x00400000>;
 			no-map;
 		};
 
@@ -109,7 +109,7 @@ smem_region: memory@4aa00000 {
 		};
 
 		q6_region: memory@4ab00000 {
-			reg = <0x0 0x4ab00000 0x0 0x02800000>;
+			reg = <0x0 0x4ab00000 0x0 0x05500000>;
 			no-map;
 		};
 	};

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

