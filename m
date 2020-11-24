Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942212C1E16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgKXGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:21:38 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17373 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgKXGVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:21:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606198897; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WjHmjt0stjiGryWOi4xegHxsZG0q/vN8TYzk3Fgapx0=; b=wPe0nZuwdQ/7zTKagxfAwH2uujcKwoMVttF7mPlFGU8nJ8kBMiTkdHQm+mFYXmCvJVSXwF2Z
 lDkuS6wPL3EtI3ckHspr3q+yx7mZTaEL+HqBhCfwtUfu5+5MVU6WBkLgIfgjx5SShI0FeBh+
 7/gLa0LsG0otIqas5J++HIAAP1w=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fbca66f7f0cfa6a16554ea9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 06:21:35
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CEF9C433ED; Tue, 24 Nov 2020 06:21:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4576C43461;
        Tue, 24 Nov 2020 06:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4576C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, dianders@chromium.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        mka@chromium.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7180: Add DDR/L3 votes for the pro variant
Date:   Tue, 24 Nov 2020 11:51:16 +0530
Message-Id: <1606198876-3515-2-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606198876-3515-1-git-send-email-sibis@codeaurora.org>
References: <1606198876-3515-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DDR/L3 bandwidth votes for the pro variant of SC7180 SoC, as it support
frequencies upto 2.5 GHz.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 625e922c273d..05bc10a4c84d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -527,6 +527,11 @@
 			opp-hz = /bits/ 64 <2400000000>;
 			opp-peak-kBps = <8532000 23347200>;
 		};
+
+		cpu6_opp16: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			opp-peak-kBps = <8532000 23347200>;
+		};
 	};
 
 	memory@80000000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

