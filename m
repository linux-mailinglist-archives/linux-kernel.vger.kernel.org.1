Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82B277E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgIYDbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD30C0613CE;
        Thu, 24 Sep 2020 20:31:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so1831850pfn.9;
        Thu, 24 Sep 2020 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSaz4MqTuDEutLU7r90eZgbkIoIloYKwHEIwGniaOUE=;
        b=p4dZ3wY1+3U3OADTK1eiCunGeGuC5M2Pir6SNXQUNAwmVnHIRbBmjvJJEcwj/MQ7zy
         9yfZ1OAHRJPu2zTfoW1MVGlpu9wV/6mEbuiymQM7eU5xAtOyRg/041cN681X6K6BXDw1
         cM2AIhfec15vro6ioL4wXVdO4+vTgtcOSEQN345dlMM4MCW6IgLk9wEVARhctWwZ5nBG
         3JPhd2KdDDN2ULIsMk1YnUCMWjhD4YYCk9uIhcJ9MKUFerny/dykDVTlw7brFSb6Jh1z
         AZCpgT0gx6CfAMQJ1cpY+qIczcLm0Ci/NYD2kQghj9p9+GoBeuCgM7bkEx5FeHs5//MZ
         N4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSaz4MqTuDEutLU7r90eZgbkIoIloYKwHEIwGniaOUE=;
        b=tOQutafQ3pWlGgbq/ioPc480d/rhq9uQTg/82RVlLHu9YhYYmzpbsbUpmdWqQrJpF7
         kcTJ7SrU2WmzRmB7JZmL8m1QFNrge/8i/y1V1Zzs0PjPL8Eo9fPfFUNS6bNK9Yscp1e1
         v57jO8/34iMof+nhplni2KYBqquN6NeT/yiR1Q5ofBBWkEJSMo9KaEAQgO70XP9/NEFx
         /9PKDeK8HyAv0F912J4uwDjow4IFLQHapXbwX1EI3SZRTwdpiygNOhRY8Ou9/wuth7qz
         qEPhps53Vs62gaIykz60AkzwyPcT7BAQ0Dm/UX/18BE2Zr4dg1U2Mg78g3QuQZvesG0i
         sj0g==
X-Gm-Message-State: AOAM533VXxk7BDMLHDmdecsesOQYH8gcktwRP1WseVagGVoyDq731WBd
        nm62umVmUeVv+2OcglfmXyE=
X-Google-Smtp-Source: ABdhPJwJChJg2OIZ6d58uvAiZLE9AJhn+xzsgErQmtOoAbRD31/UxYPWPv0Zi6On0/C11xoRU2sgSg==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr1769624pgk.137.1601004661436;
        Thu, 24 Sep 2020 20:31:01 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:00 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 3/8] arm64: dts: meson: update leds node on Khadas VIM3/VIM3L board meson-khadas-vim3
Date:   Fri, 25 Sep 2020 11:30:12 +0800
Message-Id: <20200925033017.1790973-4-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add aliases names led_white and led_red for white and red leds

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 73783692e30..7e137399257 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -12,6 +12,8 @@ / {
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		led_red = &led_red;
+		led_white = &led_white;
 	};
 
 	chosen {
@@ -39,13 +41,13 @@ button-function {
 	leds {
 		compatible = "gpio-leds";
 
-		led-white {
+		led_white: led-white {
 			label = "vim3:white:sys";
 			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		led-red {
+		led_red: led-red {
 			label = "vim3:red";
 			gpios = <&gpio_expander 5 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.25.1

