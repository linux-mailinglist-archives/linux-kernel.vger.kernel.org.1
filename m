Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDF1CA044
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 03:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEHBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 21:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133AC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:46:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so3513249pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g21VM0N/xeIa/BHhtzwrufGFeXAe+t8tpDwjYGOH/p4=;
        b=rgetU6OpAMU4D1kkUKoI+J0pdPOpRA+4I02nwC0ZKFmz2pAXs3HVpNB+cB0o0V6Y5L
         W9Lw+p9mZueptmpC3Wo+pKScnSNvsDmzqUG/B4EmIqu5P1wAs9VnyX4ghEhjmMHCO7U8
         q/L0cgAR6S+qEMyzSa7uvyyvNz3CxRxQqsx2nKz71RXv9J3oEh3wFGrpWEsyfD+hhpNG
         D2BWRyWos3AiKBo/5eZwaysxRCJ/8c8X4QAapIWbMpM+jHRiURiw26YlLqmr4wbuDT5r
         tWyNuMGMhfYCu/XcHQtVWT0dW0YwGZwp5OM80nkNhajmM/Nsls0yeAeQq/ST1LtjfaQ3
         blQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g21VM0N/xeIa/BHhtzwrufGFeXAe+t8tpDwjYGOH/p4=;
        b=KJVS7CtBUivHaL35zjOqP5Licxmu+zz/iM0Xw3JCgnl18oqmvonA15P9KV8KoKx9VA
         ylb/IRC5VufD3UWGDZ3ZAWdTWI9EEfEUqvMhTIPTOoDUsP3CnNCcbzXDJt3yW+y0E67n
         R6VVndyrzMY7HwgE/Vd4JUfHMDwwGlQj5uWb3+kvOD8+oktEcVoc2bGMbXMToS7d1Tj3
         12LaQ9xayO40gTYEe5OX1rCfJzSe20vSONHRTBB/cbLe+ljMqRqFdk9bYmuivgyUUKsp
         ZY4qyXQB6n8EKkFPwe/VqdMUn6+iBbM0sdvRSQ9IEeQ66DwNDHbULfbpMWS7UlUwfZc7
         fJPg==
X-Gm-Message-State: AGi0PuZk5t/D76rA8O09RkX352yWodIyLEFNj53ymvxSTqbxwuDBj4l2
        kkZBnAtvwKwG9YVduCMORRQ+5gg783A=
X-Google-Smtp-Source: APiQypI7IDVKxcFmHkJ4Xm0Fi0OGTuWgWHi+XPxKF9hO8yv4yELTdrT+trWL0uEpQEME++1N51EJtQ==
X-Received: by 2002:a17:90a:414e:: with SMTP id m14mr3414310pjg.227.1588902401207;
        Thu, 07 May 2020 18:46:41 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id f74sm9270816pje.3.2020.05.07.18.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 18:46:40 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board
Date:   Fri,  8 May 2020 09:46:27 +0800
Message-Id: <1588902388-4596-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
References: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the stmpe811 touch screen on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Hi, Philippe Schenker, Alexandre Torgue

compare to [patch v1 3/4], this patch remove id, blocks, irq-trigger from
stmpe811 dts, as they not used by driver anymore.

thanks.

dillon,

 arch/arm/boot/dts/stm32f429-disco.dts | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..fad1ec1 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -127,3 +129,48 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	stmpe811@41 {
+		compatible = "st,stmpe811";
+		reg = <0x41>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpioa>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			/* 8 sample average control */
+			st,ave-ctrl = <3>;
+			/* 7 length fractional part in z */
+			st,fraction-z = <7>;
+			/*
+			 * 50 mA typical 80 mA max touchscreen drivers
+			 * current limit value
+			 */
+			st,i-drive = <1>;
+			/* 1 ms panel driver settling time */
+			st,settling = <3>;
+			/* 5 ms touch detect interrupt delay */
+			st,touch-det-delay = <5>;
+		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
+	};
+};
-- 
2.7.4

