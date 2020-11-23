Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1278F2C0E10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKWOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:43:55 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6FC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:43:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so17101539qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2SiZKMvHQFkM1/qhp0SkwrM9G5ksb+yQHB/8dCBmpo=;
        b=K3Nt5+xJqLYboBaIUf6v7DHhvVskipIayCOt49/MD+Mej2rG2figrRBy0nUE9m+RP+
         ibyGmjBhRWHQ78ZIyIWkda0X0PwJE5xqXi2/kw/Sd2ZG9x1c3AhI3VDEs2CazCs1I67E
         UF1mRdWEHh2Fsa6X3UJfn18WRE7e93HV8MkNuUQJGblLHn7LUG7uWspoHammVZqbQ0do
         FqZjvcm87K4umacN7xxh+4gMpGY9FnF2hXuUJz1qgW1Q84dPCJTEheO1y4ZPjXws2jLu
         U2JCZUDVRWguDoyEXW4CgFZke40lv4IrYavN4SYqdCsaeEgtQWYbVTMAx1ixHxZJHyb4
         h5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2SiZKMvHQFkM1/qhp0SkwrM9G5ksb+yQHB/8dCBmpo=;
        b=Ak5Rn58DejMLDsaUuNa1xDbSZyRnAcpx6f6RD1HwD6zWdItXm+FW0HrmSBAMc2Lhvm
         HfuJyswIrxHMWslq7qoduBUYh+fXj5Cmvn850LMApMyDBvGeugh11BuRGDrG0ecMBnoC
         0SMFARyXFlQFDy+gWTdMRMsS76z7AziboFZ25ERECo4ClCxH72YuCpme6Kh/cJMVBN9v
         4lQXPLkwvm0ifOLwh1qm862ZGw8LwDp2LYEjakik1zDw6bb1cMmzrTIpsjQSC8Hv6ijA
         ltASvt5r3ZKCEzKEjqPpeHtLpZm0VczABrIqUzWHn8sQT9iinUzpyGkIIgcg7MxC3Uex
         my8w==
X-Gm-Message-State: AOAM530I7HY5QI3VWYSzq3HaAjJGk7V1cyn42uv0ufmhjXwjKV0ZMHZm
        qbt0AF4Ib9bep3aPn3O8ms8arw==
X-Google-Smtp-Source: ABdhPJziBlrkYgWxvRMWQZ5/O7T1FA7qXlbFM3WUYpNWrir2+EF/lFHiHTQOTbF21xBML/4YyEcMNA==
X-Received: by 2002:a37:b046:: with SMTP id z67mr3777392qke.354.1606142632725;
        Mon, 23 Nov 2020 06:43:52 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id 9sm9901381qkm.81.2020.11.23.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:43:52 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: fix indentation error in sm8250 cpu nodes
Date:   Mon, 23 Nov 2020 09:40:16 -0500
Message-Id: <20201123144016.19596-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs instead of 6 spaces.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 34 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 468ba1d18751..e43a362f5e59 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -93,10 +93,10 @@ CPU0: cpu@0 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
-				      compatible = "cache";
+					compatible = "cache";
 				};
 			};
 		};
@@ -110,8 +110,8 @@ CPU1: cpu@100 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 
@@ -124,8 +124,8 @@ CPU2: cpu@200 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 
@@ -138,8 +138,8 @@ CPU3: cpu@300 {
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 
@@ -152,8 +152,8 @@ CPU4: cpu@400 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 
@@ -166,8 +166,8 @@ CPU5: cpu@500 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 
 		};
@@ -181,8 +181,8 @@ CPU6: cpu@600 {
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 
@@ -195,8 +195,8 @@ CPU7: cpu@700 {
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
-			      compatible = "cache";
-			      next-level-cache = <&L3_0>;
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
 			};
 		};
 	};
-- 
2.26.1

