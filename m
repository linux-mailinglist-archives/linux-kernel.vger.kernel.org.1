Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE442B9EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgKSX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKSX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79BC0613D4;
        Thu, 19 Nov 2020 15:56:18 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so10430446ejk.2;
        Thu, 19 Nov 2020 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axPceqsNXvofBBHvET8CaWskFnkcgmjJ2eiQqEUxQ1Q=;
        b=T4DX+bC3kdhN/r6jeFMpYQIiGRGHzjIEUXYLhODqaeaz6TtvadcfiP+jCrMloGPYFn
         2Po+CrOHpnEEaKYcbVIPUFDxwf1/frIJOY+geaUAAyDjUeOnW+Tz8amBQYmGM/5O20zo
         7RusTZM06vvBlxSqCWRe1PKKP1EUWexK7D8iGzvJnT0Kpccw4wJuyzn5yd9RCKBZzIjZ
         WkS0t1/T/tObjF6/hQ7Zq+hzGNMrlLSU9qZjAC+9uDPI9aWOCV+utj6WQfHwZwB2ID38
         SK4kMkLg6uZypLaOtAyiQF7NwIX85fxnB5/LVWStuETPHzu/7MybzqCK/TmtnrdKrEuD
         xyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axPceqsNXvofBBHvET8CaWskFnkcgmjJ2eiQqEUxQ1Q=;
        b=n6O675do9+8GdnsUs/kCEnHVzd9nhVhZs6SKg4YCmvrD/Me1KdqS1+9TnmHSZPqTyv
         6VfWDe7ZVvEld5mdp7cgh7qaqnvEkNvhUPu5lEh2P6hxS74IYChMq0hoPVHtOAFEG1AZ
         3BXnf94SXvFXl5H0ZjAKQzfI4TOtmkL4wKEJFGVYg5oA8Z77jPUZzCfJqapzV/xEvd+U
         Z9nnoDOzUZ0bbYXHzyf1wkvwgGqtUnd3nHzmSlK8a/pSq9NixGoMdizPmZwhr/5mBLHy
         okqJYv10ip8k7IB11rO1oVIKJgTRWygt/uPI56i7LRWmN8zuQtFl4Ma20VSRfiZ2ARTY
         bBNg==
X-Gm-Message-State: AOAM531Us1S9tG5rV+D1J73CQMMheIQNFGwqqrq+cgxF2qL0lS2esL+U
        spmtXh3OYIzxvClX4rFJIF0=
X-Google-Smtp-Source: ABdhPJz+4rzvy/R4zsW7o6UOneAzixZgUPiQVkuEB9WkgQcvGV2o5UZN+3RDP4TeokqwsKMEfPcFAw==
X-Received: by 2002:a17:906:4ed7:: with SMTP id i23mr21425534ejv.172.1605830177669;
        Thu, 19 Nov 2020 15:56:17 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:17 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/18] arm: dts: owl-s500: Set CMU clocks for UARTs
Date:   Fri, 20 Nov 2020 01:55:56 +0200
Message-Id: <1bd42cf44e5aaef1bb7e97e4e344444ddbfbb091.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set Clock Management Unit clocks for the UART nodes of Actions Semi
S500 SoCs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5d5ad9db549b..ac3d04c75dd5 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -131,6 +131,7 @@ uart0: serial@b0120000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0120000 0x2000>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART0>;
 			status = "disabled";
 		};
 
@@ -138,6 +139,7 @@ uart1: serial@b0122000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0122000 0x2000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART1>;
 			status = "disabled";
 		};
 
@@ -145,6 +147,7 @@ uart2: serial@b0124000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0124000 0x2000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART2>;
 			status = "disabled";
 		};
 
@@ -152,6 +155,7 @@ uart3: serial@b0126000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0126000 0x2000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART3>;
 			status = "disabled";
 		};
 
@@ -159,6 +163,7 @@ uart4: serial@b0128000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0128000 0x2000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART4>;
 			status = "disabled";
 		};
 
@@ -166,6 +171,7 @@ uart5: serial@b012a000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012a000 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART5>;
 			status = "disabled";
 		};
 
@@ -173,6 +179,7 @@ uart6: serial@b012c000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012c000 0x2000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART6>;
 			status = "disabled";
 		};
 
-- 
2.29.2

