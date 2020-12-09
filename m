Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30B02D4156
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgLILsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbgLILsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:48:24 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C49C06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:47:43 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so1662557ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9woAOYYUTApfHEXuDyQxlO3UMapZTcSjzqhS/D3AjbE=;
        b=H1MYjEBUHXsEmRB5zK3lrIfUDCESZ/yUle4xUxQpR2/3Uefg9+OmJZPu5Y1tGst44h
         KASM+xB37usilH2dPzK/Gm9MsuKZ7Q0Q6PjWN9BRw2ywD2+HeGPYB3Zj3WfMntMDT2e4
         ticNha5B96fMZ2qOr5ZFZTzsRgkDApr8sHUbOiObz1/EVXaxMbSlAIyynriuzC1HyWdq
         VCBgmAqaxgVcI8DZa35fhFk2sRPGLBb0RDVDiZ3ickoHiWmCHxaj4lA97aIebFkf9exZ
         bHkZu8z7JjMJLwXegEfxCS4VaQ5G6WPDxDhwxCacSHSopwfz5HPljMlgyTvTsJIWmufP
         XcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9woAOYYUTApfHEXuDyQxlO3UMapZTcSjzqhS/D3AjbE=;
        b=FZ6ZmD61T2HuU79lXDmwiqijxetrvGXg6SCSFjMGD08/T2xvtuleYBFyKgW1tE+KZe
         vWStXL6oNrUFRH/jxQ96zIo2T0Fh5R/hzOlHY0z2TRfJvghUmduR7Z7WN7r0v1hB8iMM
         blV8p/6SO6Hy3R5qqKoH/6dKEun7g8Dbe8j+deh+HWWL4eKuykHOrGU+0hf7ef/pfuUZ
         81+6skjnQ1J2T/UB47zNsB/1KW6nWRUHXkhWeWTiY888dl9G+7+eGrNSzTmFiMwrHeK3
         smlPQPLvnRG7GWr3ETSOwgz6IpEt1OXiSiS0mYxhmpPNgwT+PL2vXaKN01TxSq0dy95t
         CZgg==
X-Gm-Message-State: AOAM533+dQYyV/7MRE9Po9jYEKbfCQns2i0J4UokiK64SjFEX5rnCuKQ
        9+CgXmDG2JtauMUorCFnaAkXtg==
X-Google-Smtp-Source: ABdhPJwpP09moR3fOdYGPHtxzsHg0Xp80bWTYrzjqN1vN7fhPy8dIyqyuRU2qzTh7XSFbgSRvI0QDw==
X-Received: by 2002:a17:906:391b:: with SMTP id f27mr1665544eje.195.1607514462330;
        Wed, 09 Dec 2020 03:47:42 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k23sm1244877ejs.100.2020.12.09.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:47:41 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8516: add support for APDMA
Date:   Wed,  9 Dec 2020 12:47:36 +0100
Message-Id: <20201209114736.70625-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209114736.70625-1-fparent@baylibre.com>
References: <20201209114736.70625-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support the APDMA IP on MT8516. APDMA is a DMA controller
for UARTs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V3: remove unicode symbol that slips into patch summary
V2: Add missing dma-names properties on uart nodes

 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index e6e4d9d60094..b80e95574bef 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -276,6 +276,27 @@ gic: interrupt-controller@10310000 {
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		apdma: dma-controller@11000480 {
+			compatible = "mediatek,mt8516-uart-dma",
+				     "mediatek,mt6577-uart-dma";
+			reg = <0 0x11000480 0 0x80>,
+			      <0 0x11000500 0 0x80>,
+			      <0 0x11000580 0 0x80>,
+			      <0 0x11000600 0 0x80>,
+			      <0 0x11000980 0 0x80>,
+			      <0 0x11000a00 0 0x80>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_LOW>;
+			dma-requests = <6>;
+			clocks = <&topckgen CLK_TOP_APDMA>;
+			clock-names = "apdma";
+			#dma-cells = <1>;
+		};
+
 		uart0: serial@11005000 {
 			compatible = "mediatek,mt8516-uart",
 				     "mediatek,mt6577-uart";
@@ -284,6 +305,9 @@ uart0: serial@11005000 {
 			clocks = <&topckgen CLK_TOP_UART0_SEL>,
 				 <&topckgen CLK_TOP_UART0>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 0
+				&apdma 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -295,6 +319,9 @@ uart1: serial@11006000 {
 			clocks = <&topckgen CLK_TOP_UART1_SEL>,
 				 <&topckgen CLK_TOP_UART1>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 2
+				&apdma 3>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -306,6 +333,9 @@ uart2: serial@11007000 {
 			clocks = <&topckgen CLK_TOP_UART2_SEL>,
 				 <&topckgen CLK_TOP_UART2>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 4
+				&apdma 5>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.29.2

