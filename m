Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355262B9ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKSX41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgKSX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFF8C0613CF;
        Thu, 19 Nov 2020 15:56:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq7so7699622edb.4;
        Thu, 19 Nov 2020 15:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssSUxfXpviyBasi+2gQACiWpfjH7atruIlm2d1gHuxs=;
        b=Vb0VrsGxGTclypeI58rRqEMAjDhRQ6vGk5W8SUFe+R94yJ3VbEawzH0YIopJuExgyG
         1mJKbn2/Au86GGBW9wVp44MlK4+9cduRJl8IvvLxWgzkccY+Lx6uA6dHIBPH01zHvt++
         tsjhKB4b3rp7Q73LqijXfkV/g+JCgIBXOC7oym5q5rJqsjTA8GGrJlsNzmUV/2QyiP3F
         dq+laUmqdKN/EcWuyOLBd1tKV2+X/WN49pZIYPV+3OfG3TgMXcWKA/l98Qdv2RC5P0Ij
         J7I9oHlO7hrW4M70lVr6nSSZP0BxtAS7xcmLLOOIhuBFcWkTqqSpEK65X4qrUq/5d92l
         u+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssSUxfXpviyBasi+2gQACiWpfjH7atruIlm2d1gHuxs=;
        b=bEoBmRonxHZRNdX/1OHvyGjNMNDhAqilyFaNIzaI6LjcaWEyGwnelLx6xq6awjcwgb
         fxIyEQu6k7JsXg1D7FmXw6lhGEHOVV4pMZg1VnDq3joJ2baZEqKICMzaDmUhqLkOBXui
         +Fockun4E6hfjvRIxkkOP8REp6IsfJw0wwwdz/cIYKPnLpg+whe4FPy4dtyCiWf77K1E
         zkvlayoOxAUVCxTN3QmounHCCOB1YpytyEuRGZZTiDGX6RomnE4QectT5bqH/lCmsuye
         eg1R7G1flAEakuSTG0JI6Rf4GV+yIGasfIvzejL4mN2cNOtWqQyWB1ykThi68nsVTBcT
         xKnQ==
X-Gm-Message-State: AOAM530yBmJPvD4FKIVgzoA45Q8EX1Z6UAA54a7OWLN+1ypQxVSsstAu
        CFp3dWgwLuGeqQ1Y4FbhxyON2a475YOAGA==
X-Google-Smtp-Source: ABdhPJxVFL7KWWgv+jUlPv8Qdgq4IrclE0pFGhPdv0JsFwFQsQpf6FToC9/wc2p5oey3vncKB3yr6Q==
X-Received: by 2002:a50:9b1c:: with SMTP id o28mr5105054edi.355.1605830184644;
        Thu, 19 Nov 2020 15:56:24 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:24 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/18] arm: dts: owl-s500: Add pinctrl & GPIO support
Date:   Fri, 20 Nov 2020 01:56:01 +0200
Message-Id: <d63b1486c93b4ccc1fca9b837b150acb67c6d402.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.29.2

