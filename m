Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66A2B7580
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKREy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKREy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:54:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0772C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:54:56 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d17so334454plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moO2QhNnqIGWOkMHd95f/PelXhTS60oiUOB6MIxsOtY=;
        b=KJgiM8UwlUWQO8p9WhLRYJs69GRYY7ASWc7B+IKX2wDbM/9TGHQ2DMAK2lMze3on5t
         VLc1ukbdFUes3cGxqq1273FEdH7V2rrO/p+mhtgOa24whGVgIIbSBWFkZ5j4lmPC/Z0v
         jrndjRGxl1zmKY74hYID/A9wMDZ6ppnbCiQk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=moO2QhNnqIGWOkMHd95f/PelXhTS60oiUOB6MIxsOtY=;
        b=hEumh+ULhlTJEubth5s/muAIWFWuI/eXwAtMBTbhR0jMl53uKfIbcM6I6n4w1Nivub
         ryVQG9SjaYz2r8hTAJXZRoGUe4UYQbhXXZMEE58lNC1WtMxSPMnvmBGVSnajJbXhPPzp
         EFun9aMKeXWDpNgD2CkY6/PrMt3Tl/wU/FI6+oP6+YZ69PjorJsQFuI8kGMQTuhSB+Xe
         NtPRhJrveyQDR6MwSx1Mmylf3amw7zVcc2vgPmrTRyuheVjKMIB6bLInrHqobtZYXV8S
         tIreVr8tKJt5VnYiwgQQrR9JKtE3S7UDV8dWRTxZxH1/eyZymVVj7V71M95HxUvEc1vR
         ZFHQ==
X-Gm-Message-State: AOAM5332gfV89R0QTQCLplCnbYUpanzc7WQMzw2lgeh7NRsg6rBmYfHi
        qjgaph68qS/bvmDAKGehOz9Uyw==
X-Google-Smtp-Source: ABdhPJyWsv8OrsRh/Xsuzi+ygcgvXgaBBy4c00ZRCo1S3sE7OOLuluGTBnUcbOZ77IlCgpDNJgIUYg==
X-Received: by 2002:a17:90a:8543:: with SMTP id a3mr2408228pjw.13.1605675296251;
        Tue, 17 Nov 2020 20:54:56 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id mt2sm834690pjb.7.2020.11.17.20.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:54:55 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Add prox sensor to LTE SKU Lazor boards
Date:   Tue, 17 Nov 2020 20:54:54 -0800
Message-Id: <20201118045454.2503325-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a proximity sensor on Lazor devices, but only for LTE SKUs.
Enable it only on the LTE SKUs and also configure it properly so it
works.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi       | 7 ++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
index 5a67e5baafec..e16ba7b01f25 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
@@ -13,6 +13,14 @@ / {
 	compatible = "google,lazor-rev1-sku0", "google,lazor-rev2-sku0", "qcom,sc7180";
 };
 
+&ap_sar_sensor {
+	status = "okay";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
 &keyboard_backlight {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index 43836fc4d403..0881f8dd02c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -13,6 +13,14 @@ / {
 	compatible = "google,lazor-sku0", "qcom,sc7180";
 };
 
+&ap_sar_sensor {
+	status = "okay";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
 &keyboard_backlight {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 180ef9e04306..89de69b60609 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -30,7 +30,12 @@ panel_in_edp: endpoint {
 };
 
 &ap_sar_sensor {
-	status = "okay";
+	semtech,cs0-ground;
+	semtech,combined-sensors = <3>;
+	semtech,resolution = "fine";
+	semtech,startup-sensor = <1>;
+	semtech,proxraw-strength = <2>;
+	semtech,avg-pos-strength = <64>;
 };
 
 ap_ts_pen_1v8: &i2c4 {

base-commit: ead9f7d7ea9e20843e29e688b53859cea20044ee
-- 
Sent by a computer, using git, on the internet

