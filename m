Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9E2F16F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbhAKN7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbhAKN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:59:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EEC061786;
        Mon, 11 Jan 2021 05:58:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t16so16559408wra.3;
        Mon, 11 Jan 2021 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y+oG+xNm9xP+x0Bd2rZ9vn+P0+PwuwT6nvWBSD6Nz98=;
        b=ej1ljIbtahWMaGXTQNV9pI+UlDz+JM+ZZrdSUlnKqTdv7A15XmfHu75mqT/bnbCBxm
         mv3MSo78U0qjwGkbEqyVzv11PXj+p5h4fN6MCY0649LWbj8b0rjKf4lM+uWj5gJQPJPr
         6UsaWjAUNa5iz+yByAoCG3T8JKVu+C78QnGrjV2y/cjFx1AomkF9b/+P2g1DWbwlSbvR
         LgLl7EuO5nXnhzL+bO/CAvFEUBz4yJ8ucl3q7r6+NrHiHsGfJxlXKhuVryc71Z1qY9Oh
         9tftHFp4sgdIzf3ePzxShqkcoJsQgautCst1j1EZaidgxOWhQNUhye9y4uhFVewf97dQ
         dckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y+oG+xNm9xP+x0Bd2rZ9vn+P0+PwuwT6nvWBSD6Nz98=;
        b=Tu/U0Hz9H3vfU32Xalzu9Vr4cembt7Zi/u2ug0Nejkkb8ifVBik21P/Gz2UN4ptjGE
         d61FINxIES2a6icNIJgsJrkYtrtNt/dPlcRuQb/OPfmd6E8w9uTeSPOLg0aRQ17nqxOf
         noculMkU5osdQj8oVYexU1XOgFtL1bWpOUTbEJ6enrSUEIGt/yqc/X/IRU38EkUFwNkt
         vLI+9+5o2QaqYvdmmT9ZsmnDqGFYhIckUu5XqzznyNCttM0MiSAHYkSMxKBnGyfkUdaP
         LsmItqKqC+GOcE3GNF9TCvWpZLtfxUar3zc82CIDpQpVgCQf0aFW+xeubyjZQZU98dm+
         CALw==
X-Gm-Message-State: AOAM532igy/mpMFNPVZV5nXd/HSn4gBJL0OIZ+n2m7tVc0uULOEjlrPO
        wVPY+eBDQxhYt8eR5+6sAP0=
X-Google-Smtp-Source: ABdhPJw4USDQqdK6oVUdyEsVMIb9mDKFEOAu1DET+S/0kX+94PlJZ/YAMZjwVEuDbBRCLbuiUUZR3A==
X-Received: by 2002:a5d:43ce:: with SMTP id v14mr16366742wrr.342.1610373516733;
        Mon, 11 Jan 2021 05:58:36 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u66sm22543950wmg.30.2021.01.11.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:58:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add i2c3/rtc nodes and rtc aliases to ODROID-N2 dtsi
Date:   Mon, 11 Jan 2021 13:58:31 +0000
Message-Id: <20210111135831.2218-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the onboard pcf8563 rtc hardware on ODROID N2/N2+ boards via the
common dtsi. Also add aliases to ensure vrtc does not claim /dev/rtc0.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 39a09661c5f6..b78be3e6974d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -13,6 +13,8 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
 	};
 
 	dioo2133: audio-amplifier-0 {
@@ -478,6 +480,18 @@
 	linux,rc-map-name = "rc-odroid";
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+};
+
 &pwm_ab {
 	pinctrl-0 = <&pwm_a_e_pins>;
 	pinctrl-names = "default";
-- 
2.17.1

