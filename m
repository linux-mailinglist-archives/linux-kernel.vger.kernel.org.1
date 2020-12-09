Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8C2D414E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgLILpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgLILpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:45:32 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:44:51 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cm17so1209797edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZ7wYcWUmWH+uVrdi5m11ZubeY2Wy0/H7RjJZGg6xE4=;
        b=aqX9kip9J67BsY4pqUSEZXQ/TMIQwaOOP0xcefZgGlThWPS+VU2sNeN/oEbCEBTZ2u
         6FYJ01oNYSo2AkF28wg60tISmWxKpcue92Fu8mM6H1IGfK6JLvYhO8quWwWQKaNkbmmd
         /KTJvFBabmHv8hSXWU0zUOQxUcJDrBrUHfs4GC+3yc+K8WqpmGxPZYAlz6lzGX4AC+qq
         0NZgu5NPxUKcBP6d6gu8L584maZrmI+4NK5v2KTvQ2ACTr49cRzWHFrIc+rDsxYtErJi
         g/HXOjMqRtZPb4gnt3V3bSLJEV+1aSXGkDE0ofPfIavp338fZD3OZME6nNg6dJEb8urB
         pckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZ7wYcWUmWH+uVrdi5m11ZubeY2Wy0/H7RjJZGg6xE4=;
        b=C8c8KBYv1hQ7Y8ROn7DgNTcg2vL6+iI3Hqb+2y2FeV7SFyBkFoF2ZjSUVtU5ME7o/r
         +uMChsna9fjje/oOs51D68XAYFZzuFS/TVdLQPHAJ6K9lYSlO9mpdPaQdk1ZvYSFXpCP
         IkGOp4WZp5/sblpl2V6jwJ39MdmgaJnosQU05Y8YQ2YqEWL/MSlJAYOlipBAaj+xnByO
         npJW1A3ua0Pic0SCo2e6SZY3Apo5hqw28h8fh/VqkQNwfaAGR/3XhtPq/y/vOFGC99bS
         2i2V+9lj8h0JFom0nBg0tWmp0d7MO8ZqyQJLReWBA56znDa0uS/dK2r+J4XQ2sipFteh
         dQGA==
X-Gm-Message-State: AOAM531G89dfYHggqSzqKYgBJVAxZRzRjkPbFYxI+/X/K/c7EZgthFf5
        YsDKVXe/x3zURWPDD6c/yZ+3OQ==
X-Google-Smtp-Source: ABdhPJxNqsA7hfko0K/oKynB9g7B5UaxABjUkJLiTKKQ1Ka5HzerQx5TREnQtWCg7kQ3RyD6ytVHTQ==
X-Received: by 2002:a50:8b61:: with SMTP id l88mr1629668edl.250.1607514290713;
        Wed, 09 Dec 2020 03:44:50 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c25sm1260327ejx.39.2020.12.09.03.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:44:50 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] =?UTF-8?q?=F0=9F=93=A4=20arm64:=20dts:=20mediatek:?= =?UTF-8?q?=20mt8516:=20add=20support=20for=20APDMA?=
Date:   Wed,  9 Dec 2020 12:44:40 +0100
Message-Id: <20201209114440.62950-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209114440.62950-1-fparent@baylibre.com>
References: <20201209114440.62950-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support the APDMA IP on MT8516. APDMA is a DMA controller
for UARTs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

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

