Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B02BB3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgKTSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgKTSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:38:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E7C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:38:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so8677019pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvxKdxs6M4JT+TjyiGRTBOjLUZOj8C65zt6mx45CTYU=;
        b=Tu3dkzCC53/KWbIL5K4tQTuhIa6w7VUb7TSqXbPv/lQ/5VZjWZPmP4ne35gz6nvYDm
         SVHg+L5wAD2jHTUA1wxYJn0xK9J0Gf3R1pzdomx5HCu+yiW0L8URaN6aCzZVv2pgP3XH
         9+iaak5QbWWTkGwiGy6wXhbUFUUd7ehd4eq0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvxKdxs6M4JT+TjyiGRTBOjLUZOj8C65zt6mx45CTYU=;
        b=S2qwbfe+FvAxByhFBwPyFtRKPcHT55Kv7C96Nn1TbpFsCnYcbubRDpMq0SnMxQL1FY
         zTGJ35Y7m7PhSmOtj1igEmeH3Q798Yg2eGbHZN8RRusVn8kvsWXPK5S4y1sotMWuBsI1
         t3yNlPOhe8fpR5Z+YexDHp2WoVDkJmyKRyqB6z6bDWPzARl0S+IwI01SX2vtfer2Tx8W
         UArqSb/N2az4Dk1v6L2VLlmgy9jLbifAfMeB7e7Hgx9sGiPG6d/02776Aiv3P7IG/ZdL
         D9CJ8KH96epLHGV07TknoM+4fS4cpLDbAnruyxBFtNfBYSwWmSS5YbcyRYU9mXDbWDTZ
         qDRQ==
X-Gm-Message-State: AOAM532LTz0wrMDXx0yolwZOx2nwLUbzxsNoVjYGDsr/dZK4olMqq9Nr
        tLBAXt9xRFiv0TIWhTqUsCGUDg==
X-Google-Smtp-Source: ABdhPJzzy12OIQ7XoGGH2+bU7dhA3J6Umwu1uVvc5icgZsY4dju4gjMNVxLJ3UqeyG+SzPis49AmFA==
X-Received: by 2002:aa7:9dda:0:b029:18e:c925:ff0a with SMTP id g26-20020aa79dda0000b029018ec925ff0amr15736481pfq.43.1605897507071;
        Fri, 20 Nov 2020 10:38:27 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id h7sm4343376pgi.90.2020.11.20.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:38:26 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4] arm64: dts: qcom: sc7180: Add prox sensor to LTE sku Lazor boards
Date:   Fri, 20 Nov 2020 10:38:25 -0800
Message-Id: <20201120183825.547310-1-swboyd@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v3 (https://lore.kernel.org/r/20201120182426.541884-1-swboyd@chromium.org):
 * Remove disabled ap_sar_sensor_i2c node in trogdor-r1.dts file

Changes from v2 (https://lore.kernel.org/r/20201120074508.3236616-1-swboyd@chromium.org):
 * Also disabled ap_sar_sensor_i2c node in trogdor.dtsi file

Changes from v1 (https://lore.kernel.org/r/20201118045454.2503325-1-swboyd@chromium.org):
 * Fixed startup-sensor property to be 0 instead of 1
 * Fixed proxraw-strength to be 8 instead of 2

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi       | 7 ++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts           | 5 -----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 -
 5 files changed, 22 insertions(+), 7 deletions(-)

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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 0a281c24841c..59d67fb0efe8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -34,11 +34,6 @@ panel_in_edp: endpoint {
 	};
 };
 
-&ap_sar_sensor_i2c {
-	/* Not hooked up */
-	status = "disabled";
-};
-
 ap_ts_pen_1v8: &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
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

