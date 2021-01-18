Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DD2F9903
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbhARFLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbhARFLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:11:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7EC0613ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id md11so8707566pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIOurttyqDWMRZTk0KvtZ6egeQZ8d/AjuWKlkLPQdLY=;
        b=nxcJ06gHz+s+l4F5b6KRUULDkdvR9nFrEmEBfOtHH90Rn0WAJUvZd4737DwfjHxeq4
         jQxia7m0Xbr+1TuNCgGsMANgHySvH6ZCev8d1DgUSJtfpl4/zx0wVmVRFN6jvWjiJn6S
         vjm/PncbRqQEL1j576bFsSPXuwvLMSAfYUUSfRdxqeJAxGLvNd3TDVmsrjHgtaUp2XvI
         6f9xhk2EaRH58wjvbhKQh9Ue9Mhgc7LpiC/p239jlWO3JzHj038ClZVz5JRpOphdoDb7
         AHsI8PSDmgEYqo7Q7dAt0Nr8eVCZo6ruqjq0d3ngn0zFxv/tYfrsMURXMLU5RSWqCW29
         3j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIOurttyqDWMRZTk0KvtZ6egeQZ8d/AjuWKlkLPQdLY=;
        b=mCGd04/mbKV+1vxpzdQYdKmWKgYCoa/ksBnk3QpDApwEvIsM7i4Bm1dXwbY3O3QZ+D
         2Y8CflWaqAi+DpADHEpVyRNeBdpP3SbzUF7xID78gFwl9JhxgxLKUaNkMSKqjJoqpDZu
         5o8/BJwb0no9HRFAXQJn6ZLGFkXjZ4y4LXBY0C3m1nzUcdIm+pyOkgQPbL1JyJor4Dqg
         HQ6DetQ3ct56zccKAjwrPejFX4wH+IrtttFOGUxmlLLj1U/Y8hXzJNfNJQIXtgEv0Asx
         OYW31jk1lZ4vsb9NBf4WEvxjJRVVO1tZfDPEBxrR1SVkvzcdIA9vPiMehrH7jlfTVoqE
         NKtg==
X-Gm-Message-State: AOAM533bm4/48RCiw9QTiwDtB9RyxXNt91gQIEFVeAsWAEo87fMDzkW6
        HBtd2X260+81WL47Krqu9fN9
X-Google-Smtp-Source: ABdhPJzrq2g+KN7dVIaJNNbxEWlVuzGCWtXPxaTOgrhJMdfuk8aAYwKojOnefzyVWH+pQ/x05O4cJA==
X-Received: by 2002:a17:90a:ee8f:: with SMTP id i15mr23955008pjz.82.1610946622280;
        Sun, 17 Jan 2021 21:10:22 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id j3sm14703571pjs.50.2021.01.17.21.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:10:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/7] ARM: dts: qcom: sdx55-mtp: Enable USB3 and PHY support
Date:   Mon, 18 Jan 2021 10:40:01 +0530
Message-Id: <20210118051005.55958-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
References: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for USB3 controller, QMP PHY and HS PHY on SDX55 MTP.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 29 ++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 96b6a295f813..7fec5e7a2724 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -111,7 +111,7 @@ vreg_s4e_1p904: smps4 {
 			regulator-max-microvolt = <1960000>;
 		};
 
-		ldo1 {
+		vreg_l1e_bb_1p2: ldo1 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
@@ -129,13 +129,13 @@ ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
 		};
 
-		ldo4 {
+		vreg_l4e_bb_0p875: ldo4 {
 			regulator-min-microvolt = <872000>;
 			regulator-max-microvolt = <872000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
 		};
 
-		ldo5 {
+		vreg_l5e_bb_1p7: ldo5 {
 			regulator-min-microvolt = <1704000>;
 			regulator-max-microvolt = <1900000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
@@ -165,7 +165,7 @@ ldo9 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
 		};
 
-		ldo10 {
+		vreg_l10e_3p1: ldo10 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
@@ -228,3 +228,24 @@ nand@0 {
 		nand-bus-width = <8>;
 	};
 };
+
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
+	vdda33-supply = <&vreg_l10e_3p1>;
+	vdda18-supply = <&vreg_l5e_bb_1p7>;
+};
+
+&usb_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l4e_bb_0p875>;
+	vdda-pll-supply = <&vreg_l1e_bb_1p2>;
+};
-- 
2.25.1

