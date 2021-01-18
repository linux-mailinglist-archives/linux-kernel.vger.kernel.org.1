Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC32F990D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbhARFMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbhARFLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:11:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FFC06179E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be12so7997977plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TWfVrulFNjPq0+eVRHAHEYkcTTWPCyteYKVSR9fpvE=;
        b=FwQd1dQ4UbJoQQmyF80j5kbsGRMQs/Tl7r3CabDhQmgc1tksFomt/9p1ap9x2m4g35
         eKNWXxxLlXUZNs6FKy6npp55tqahDf5I+OceAm4xGHwanFf47G76hJbeqUcJTzGvPhJB
         qEJXm0/PmXt18M9ug28NcilAOydaootmEIMT/oLcxbxaw3xExf4PzBKzQGWrQf20CoZk
         88P7bmRbp+IdTSQ/s4+WragPJ+BbNXXiD6bmROICHXU/1wIrPGL258U3KOTGDJd+/UAw
         i6OhgcznZdQW0CdpVnlGBoY+Tm7RBAsz5bx4PYtbg3ubPMIC/RDTxiiU4B0v+jkL8Yup
         Rrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TWfVrulFNjPq0+eVRHAHEYkcTTWPCyteYKVSR9fpvE=;
        b=rAIqlrHFzXN9bWupIhQSTlmRLDGNWust01MGWmI3e+LcN39Gu7RS8dTZ5gGup5bf41
         iUC/F7lrG1OU6RijnAN+G83+d3uP9aR26dVJbyao2dWpTR7pNfnp+ZdM8tsJBeFgKbER
         ytZEytyTcC5zhXLE95HuxAYfNp4oSEZs+4WUAznl3RG985hrA6l9smb7HYjXBb5JGclR
         qSBkOMPsrNBEJw+NKfeTma+I3s0paAa4/jx7HQ3oBYLjyEmIaBvxJculbycxYlKuaPqB
         ZiqTTvB+oYDG5Jtbq2jHWpLQ0IE0XZLKDWpyPSUDeGiTOBuemv5fEQP2SE3tFLZhWvKD
         O2Eg==
X-Gm-Message-State: AOAM531wxEthAcveWyNKVZKaWRSN6fDSIDx8kt3q7bLFXj5G6fkKzQwN
        Uyzw3yg6LNS8M39EYtt6tn6gbNL7oEO6
X-Google-Smtp-Source: ABdhPJw2LsEyCS4A/SY5Ouw1aNL4Pql1CpiE4uSpvf48A+FHywYDY9U+uWdTmPLkjUbiREju5JWqMQ==
X-Received: by 2002:a17:902:9304:b029:da:fa20:b86a with SMTP id bc4-20020a1709029304b02900dafa20b86amr25180829plb.36.1610946636197;
        Sun, 17 Jan 2021 21:10:36 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id j3sm14703571pjs.50.2021.01.17.21.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:10:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] arm64: dts: qcom: Add missing "-thermal" suffix for thermal zones
Date:   Mon, 18 Jan 2021 10:40:05 +0530
Message-Id: <20210118051005.55958-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
References: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal devicetree binding requires the "-thermal" suffix for all
thermal zones. Hence, add the missing suffix for PMIC based thermal
zones.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index a53eccf2b695..f5874223082e 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -11,7 +11,7 @@
 
 / {
 	thermal-zones {
-		pm8150 {
+		pm8150-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index e112e8876db6..ba85b2151ee9 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	thermal-zones {
-		pm8150b {
+		pm8150b-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 62139538b7d9..0ab9c364e7f1 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	thermal-zones {
-		pm8150l {
+		pm8150l-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 5ffdf37d8e31..91fff1f209e0 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	thermal-zones {
-		pm8994 {
+		pm8994-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 67283d60e2ac..6f5bb6b37ec2 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -9,7 +9,7 @@
 
 / {
 	thermal-zones {
-		pm8998 {
+		pm8998-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index ff4005186895..172be177fc8f 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	thermal-zones {
-		pms405 {
+		pms405-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-- 
2.25.1

