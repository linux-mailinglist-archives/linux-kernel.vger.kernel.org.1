Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0B2BB28D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgKTSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgKTSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:24:29 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBEC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:24:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so8633839pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30Bgpe4tRZbHCL1xlPM9iOd0AtYEUn6hOn8Ryly2PPA=;
        b=M98xqGzPeoUCxhHCksDZ+aqukGT+z9t2J672BwZUETcjYvDyLQb6sUrruRUI533fmf
         gNbla1W5c/VWSorPRrSd5hutpiBrZTzfzeF0SNuZARQXTLOOS6wf9T/t+i0maHyt8HTW
         jG5Z/3FylRgAf65nM2A3X5MG2Sr3SmCPR7CJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30Bgpe4tRZbHCL1xlPM9iOd0AtYEUn6hOn8Ryly2PPA=;
        b=SFZoKfqbHseYO+8ZMapv8s+9qTTySFMbV9giI/VYiqyrSJShFxdVNq1VvoxgsThVXm
         lPaTDfXKvMrvDK7/0bFUZUGZW70W3XT05JQ99MVhJyhgxnTRQTHDZHfh5keNdYdTd1zn
         BKDKktKtRiWcwIudjbyS4gKQltGOKW0WEIm4OIdArkgPn/B3rnE5+AgFJd9vmyzwjWGY
         BxgV8YUEi3JfPPr/PLf5U2q8MMz9iE6Gvst22U2gVDxXWfRj7gmNP92+INC9hT9cXxN3
         Xi+cAApC1domWozXRr219uvB4pUW6BKUyMFSFLCDZR2oqniz4V77yYMCTkIhDP5rm2Et
         fVxg==
X-Gm-Message-State: AOAM5321ML+Wbl+/3BbFaBQYAWTqH56EbiouumYx4dztjvoqCbYvxLaO
        AeIi6DoEzCkWXe7HtoHODjzjXg==
X-Google-Smtp-Source: ABdhPJy+qo4UdHWB8uDJPIvHzv9KiiwxNQimizWemMRpe7dMo/W3Iay3js2pxsTDC2SYgZTTx142ug==
X-Received: by 2002:a17:90a:4593:: with SMTP id v19mr11934492pjg.217.1605896668009;
        Fri, 20 Nov 2020 10:24:28 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id gd4sm4706497pjb.39.2020.11.20.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:24:27 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3] arm64: dts: qcom: sc7180: Add prox sensor to LTE sku Lazor boards
Date:   Fri, 20 Nov 2020 10:24:26 -0800
Message-Id: <20201120182426.541884-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a proximity sensor on Lazor devices, but only for LTE SKUs.
Enable it only on the Lazor LTE SKUs and also configure it properly so
it works.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2 (https://lore.kernel.org/r/20201120074508.3236616-1-swboyd@chromium.org):
 * Also disabled ap_sar_sensor_i2c node in trogdor.dtsi file

Changes from v1 (https://lore.kernel.org/r/20201118045454.2503325-1-swboyd@chromium.org):                                                                                                         
 * Fixed startup-sensor property to be 0 instead of 1                                                                                                                                             
 * Fixed proxraw-strength to be 8 instead of 2   

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi       | 7 ++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 -
 4 files changed, 22 insertions(+), 2 deletions(-)

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
index 180ef9e04306..89e5cd29ec09 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -30,7 +30,12 @@ panel_in_edp: endpoint {
 };
 
 &ap_sar_sensor {
-	status = "okay";
+	semtech,cs0-ground;
+	semtech,combined-sensors = <3>;
+	semtech,resolution = "fine";
+	semtech,startup-sensor = <0>;
+	semtech,proxraw-strength = <8>;
+	semtech,avg-pos-strength = <64>;
 };
 
 ap_ts_pen_1v8: &i2c4 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 781e61ad75a6..d48a75afdafb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -654,7 +654,6 @@ sn65dsi86_out: endpoint {
 };
 
 ap_sar_sensor_i2c: &i2c5 {
-	status = "okay";
 	clock-frequency = <400000>;
 
 	ap_sar_sensor: proximity@28 {

base-commit: ead9f7d7ea9e20843e29e688b53859cea20044ee
-- 
https://chromeos.dev

