Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30DB2C1C97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgKXENm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKXENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:13:41 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:13:41 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id y18so3009969qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt8cy62Sf+1LUo2jKUqU0KxiS+qrKJvOn13RlpIH/MQ=;
        b=wu48yA9TTPD76JwDzPncANkDH1fK+/BHkitmGHbazn3yE7LrmD+JFRxIJHrRUWxEIq
         EhFyZjaENTKgLC89lqGDuVmO6yfzsw6Qn0F0sE0I0J5meb29w5yeAZJCojzeA7JIs2Yo
         7DU3UmFX2SaChbrN9jzSD7vPSPI0J1HME/zhzHHsKv6PWL6aUAi/oNHg2KcUJU9NYqOz
         2Nf+z3Gi2f84yMbENijAe3r+PyqUBVV2WrxV4a++e0m+25reBu6RkfeKFD02mzNIaR7Z
         gcZoqG1KatNkEyipkuKoljWf4TQuK4c26bf6vOth2LvXCp9lvvt1rWEjtoPm8J/1+USW
         lNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt8cy62Sf+1LUo2jKUqU0KxiS+qrKJvOn13RlpIH/MQ=;
        b=c5CeARannzhbgVo9e2HfdG7FITTl9SOBTjvhWKf3GrEnssfnpsR2l2dy6S0m099Enn
         boXvtE4IluTUCfgnsYnq45tUR25Tvqi0ss4e8yiL/YzNgGR+voS3n0PA+5vvmO1PaAah
         AafiHYDPXx54IXpU/aXN9DOZnzflHxomtYaJpFma3LLceRkm5S1NZmHz0L8hcA7bdllv
         j5Br5pzAgKNLXvMfaWBFJh0I9fpmVGT1Qk08Z1hGGhiJ1QPha4UXvAev5E2ihtNd/JnP
         e7tNMsLsRuxluB1LoNq3g9ysXB76ulNKf66wsId1yB8s50hhCEQ/fh5vTwkOtQF1Gl45
         cgPA==
X-Gm-Message-State: AOAM5333As+/CiiPopWaALC/sYwulQsZItYW+vssEEXUP7afIrIa3RHC
        dM5bNW2mDBtn3DoJteEIpHzdAGg04lLTyaGF
X-Google-Smtp-Source: ABdhPJz7ZNezBZGA9buuHdIjN+4aarJihl6kEXxbuZw+b8D54bKloFI81/adeHUq4f7fVUpTCEXTSQ==
X-Received: by 2002:a37:6805:: with SMTP id d5mr2986582qkc.66.1606191220466;
        Mon, 23 Nov 2020 20:13:40 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id o8sm11841553qtm.9.2020.11.23.20.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:13:39 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sort sm8150 usb_2 node
Date:   Mon, 23 Nov 2020 23:10:03 -0500
Message-Id: <20201124041003.3600-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an error introduced resolving conflicts with camnoc_virt node.

Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index bcfb06f5bebe..743228ba148f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -976,13 +976,6 @@ usb_1_dwc3: dwc3@a600000 {
 			};
 		};
 
-		camnoc_virt: interconnect@ac00000 {
-			compatible = "qcom,sm8150-camnoc-virt";
-			reg = <0 0x0ac00000 0 0x1000>;
-			#interconnect-cells = <1>;
-			qcom,bcm-voters = <&apps_bcm_voter>;
-		};
-
 		usb_2: usb@a8f8800 {
 			compatible = "qcom,sm8150-dwc3", "qcom,dwc3";
 			reg = <0 0x0a8f8800 0 0x400>;
@@ -1028,6 +1021,13 @@ usb_2_dwc3: dwc3@a800000 {
 			};
 		};
 
+		camnoc_virt: interconnect@ac00000 {
+			compatible = "qcom,sm8150-camnoc-virt";
+			reg = <0 0x0ac00000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sm8150-aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x100000>;
-- 
2.26.1

