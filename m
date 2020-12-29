Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F772E743A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgL2VTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2VS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB50C06179A;
        Tue, 29 Dec 2020 13:17:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so19657204ejf.11;
        Tue, 29 Dec 2020 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvOX0k5iXfRH66LCPp+9U12OfrKgIlzEio0gN5o9ipk=;
        b=uWMjNMhc9iXa8seo0HQEO6oY0fnlitHL1kYaLEDZ0rj8ryxOKuZxl9j8mspeToxzZX
         +T76+F7xxowx5s+LL6ySS00GiTUcI91ugTPU/VjCnmV642Va7waak2ubJUr9qkToGfxL
         ZvAxaDLg1dHITlhhT66k3on7TYqtk1NKsjJtF1o4X5sJJfZV/zX6KkZS9UVjF8aaeWoB
         5f7qi/9fBEej8zO8e1timWDRDa/tPVJU1hLt5MPi2w09HvToofz59cPTQ9z8kzkDlVtG
         OCjBGUJHDDB6L/T3fMgXLFRKZaNUSluDpWriFMwGNkrnwQiTLqfq07dCen6yGZvh71jM
         Gd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvOX0k5iXfRH66LCPp+9U12OfrKgIlzEio0gN5o9ipk=;
        b=q3um0D9NBoFW+CEioWbmieYU9DJf9d8AoQ5o6mYUmIA+TXrbvEDUF+BUmTCt7tghLH
         Kd9o1b5v/68N8kYEO29GHeTJiO/j4jE5ZLIawO5nh3pxAD8d77qvo6OzBYMwhU0dseA7
         qOLBTx8TgWicNGZTIKqlaY2B4bv7oVOlyXwl9mvQQtxFEhN6+23fr1Dfjt3N7fmzFYkI
         CvXhU07eV9nVGI/vcwTLSOzI3VFoTsyf3nk59uR922GuX0E/c40KlH1psjNNUq4mNoXv
         9Q+yCSh/PlyC0PZ2EcwY2+NiRiU2YzPezKR7ip+PKQ5VnaE20xrxPAve1ZiqbCzhpsNd
         wD9w==
X-Gm-Message-State: AOAM533XwwsZ7eSFxNQLKNRR8AnhlNliyKU9kUF2WA4MOANn7KPng02a
        u+W5VkE++rj5LVQw/kUz/Ts=
X-Google-Smtp-Source: ABdhPJxS5kLnnBAkaN4WYUktOluy9QJkUZqw7nsScTCyiYCHk3TCP1j+0sjUk8OYXYi5+3yHSQIsvA==
X-Received: by 2002:a17:906:7e0b:: with SMTP id e11mr46130932ejr.533.1609276662158;
        Tue, 29 Dec 2020 13:17:42 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:41 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] arm: dts: owl-s500: Add pinctrl & GPIO support
Date:   Tue, 29 Dec 2020 23:17:22 +0200
Message-Id: <a9e9d67a430cc900508dc86831962b282e5edd1e.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 449e9807c4ec..b16172615db0 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/actions,s500-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 #include <dt-bindings/reset/actions,s500-reset.h>
@@ -208,6 +209,25 @@ sps: power-controller@b01b0100 {
 			#power-domain-cells = <1>;
 		};
 
+		pinctrl: pinctrl@b01b0000 {
+			compatible = "actions,s500-pinctrl";
+			reg = <0xb01b0000 0x40>, /* GPIO */
+			      <0xb01b0040 0x10>, /* Multiplexing Control */
+			      <0xb01b0060 0x18>, /* PAD Control */
+			      <0xb01b0080 0xc>;  /* PAD Drive Capacity */
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 132>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* GPIOA */
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* GPIOB */
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* GPIOC */
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>, /* GPIOD */
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>; /* GPIOE */
+		};
+
 		dma: dma-controller@b0260000 {
 			compatible = "actions,s500-dma";
 			reg = <0xb0260000 0xd00>;
-- 
2.30.0

