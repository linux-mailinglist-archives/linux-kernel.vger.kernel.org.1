Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD962DFF73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgLUSOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D5C061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id x22so10710575wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CNSVuVCy6pDq2pHryyGIphjcVCtjSNpbEXQSGcq8K8=;
        b=ro6PZ8miBiXxczKWKMmWYIo1Te0lOA0LqkzB2dAYSaCiQeyoPlCU8opDLWmnVdr7ZO
         lVXbJx7ca9QgLyYzr7D6Pb+8xuzdYMtjMtSSRUtpBfyw1TngSeUOCwLvcsgNNcDFVeCm
         nUpWIuCT0Yf/jhvEF8nIU1U9FQZprnhw+iqfxSDop3ibXGNUQzXhMNLQXSSAWqxF+7OF
         nNxe2knkUAJSqFpt4zXk2r6ddQwTBXnrH0LV+G4HwLLMF4poun6d3j32vbjFqrh/vXmR
         aoqr6MvUOA8Ndbgk7uB4UDsICxSQyVQdMSJDgPq4HyUHIiIw4e0Bj7NencTpgPjUQlg8
         YrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CNSVuVCy6pDq2pHryyGIphjcVCtjSNpbEXQSGcq8K8=;
        b=kVGK7yHVSyKNwZxbRVejASALz93nya5yza+co7xoD783AM5DGrM+v8TSX0k6iyex+B
         Mu/Oe1Mw9i4a+g4RW/71jBFv5dLo+u8YZfXYOQnm1QaxwJvRMwkpGf0Lw1kabk96/MaG
         rYVRsuOoxPgywDD9Qi9su9/85AKhZLC77uXrwCTRbYOlAeKn17lKTPJXEN44dLLoPkJZ
         3Cp6uyVIGEGc2/OjlocJj47FbK8tZaFTrrPOwhS7b/VX7aYVR21bnH9NsZ/+IrI2f0WQ
         muqBNZEutJBrHNrxvf82VyOhaPrLBUax1pHM1pHGItXYwepGabSqlzDHBskwn+YPBvY6
         H2bA==
X-Gm-Message-State: AOAM532+RV5fzxohqXCzdhZiZbvPtMtdbfWDeWacjlmrleajCT/7cmou
        BGttiqs9tAr9LFucD24fz78=
X-Google-Smtp-Source: ABdhPJyi00a0kPHjXm/9YZxrLDUId8sVOiXhBlq9M5WMxU2WTU0Z+Zr5rkidENtHt8xrOrirc2HfzA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr18174342wmi.36.1608574419608;
        Mon, 21 Dec 2020 10:13:39 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/5] ARM: dts: meson: add the ADC thermal sensor to meson.dtsi
Date:   Mon, 21 Dec 2020 19:13:03 +0100
Message-Id: <20201221181306.904272-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC temperature can be retrieved from ADC channel 8 on all 32-bit
SoCs (Meson6, Meson8, Meson8b and Meson8m2). Add a "generic-adc-thermal"
instance to meson.dtsi so the thermal sensor is available for all SoCs.
If the temperature sensor calibration data is missing for a board then
the "generic-adc-thermal" will not probe and not register a thermal
sensor.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 5f074f7aa1a2..e0ca5f08d07d 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -298,6 +298,13 @@ efuse: nvmem@0 {
 		};
 	};
 
+	thermal_sensor: thermal-sensor {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&saradc 8>;
+		io-channel-names = "sensor-channel";
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.29.2

