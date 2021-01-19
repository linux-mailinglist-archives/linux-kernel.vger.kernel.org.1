Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE55B2FBBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391656AbhASPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbhASPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:53:21 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352DC0613C1;
        Tue, 19 Jan 2021 07:52:41 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f11so22452469ljm.8;
        Tue, 19 Jan 2021 07:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJc26kqK3lGiggOL8r2k0b8rqu0j1HSR3SxkGPEs1EY=;
        b=KYeJOrYr4NiWht8sbmC/Lsf0oX1RjPVSxie4XQt3heuBHRyENk1dc26UYOgG7BiLv4
         Gkf7GCfhHbXwi3tVVJ1cpN+9puCxX6QQExS/U/vVHjAJKrvSar98RXEWJRsoS9mv2Yd1
         TBLzKmbj3VeOywQqBR9K4VXLGXTyfw/f58ucV59glj13oonZez0cKb1Lme19AcRBNp5I
         2A7SI+JV3wA0hmaDitV6gTrRr1k0ediqvRDAndoefSWJmI5/jsLwpw5HnxFqgnzNw0Pk
         Ahj8v17c42Ccw0FjxSy/I9pxiQIle8K1jsEu26B6q7XFK2CPo4IxC3EkNaedc1OI/veU
         6M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJc26kqK3lGiggOL8r2k0b8rqu0j1HSR3SxkGPEs1EY=;
        b=L6Nccxf1Sqs8qPI6DV6J5i3mt2S2VHQuBOXIGtXU1e7M5TsC5Sk3964q/QvdKQ1wUn
         BIwR7XI3pP2Gyx3cKEN+2qqPoDmVog1CIKbWHUFnrRRTgtjGYdmysghfSO3TvgHI341y
         kAqrnYSsWYAZ0lF+p9rfovQ/wGEDeLPmueR6V0hW94QopvqQZVGfIv6A1Nyqz2DtiXdF
         goG77hqX9UVIyYveupXeQPuYufZiOLBpGC3gehd6ps52ANnbIG8a4s999gHpMfv7lL6j
         V0Bfz2EgSsOQtfmHNzf0L4pn5UoymU9GGa/nyXKcB3aiJ0W28Js2dUuPx8RrdlOnTE48
         cflA==
X-Gm-Message-State: AOAM531z5SUtbR8XhkVIJS63lkZRmS82rVpPK+NF9MauxcAuF201pRzj
        tiRBaDIjnby7W7OW78CxuXOHrDXGR8N38A==
X-Google-Smtp-Source: ABdhPJzIAOAwZS7Lprc/tcLmL4dMSTFDAD+TRc74Ry67mioOpAxj0Y4Dc8RTokKqX9mSCTlfNdJ94w==
X-Received: by 2002:a2e:3317:: with SMTP id d23mr403130ljc.199.1611071559679;
        Tue, 19 Jan 2021 07:52:39 -0800 (PST)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id t196sm2309286lff.195.2021.01.19.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:52:39 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: fsl-ls1012a-frdm: add spi-uart device
Date:   Tue, 19 Jan 2021 16:51:06 +0100
Message-Id: <20210119155106.1833610-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119155106.1833610-1-paweldembicki@gmail.com>
References: <20210119155106.1833610-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spi-uart controller  to LS1012A-FRDM board dts.
Device is equipped in SC16IS740 from NXP.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
Changes in v2:
- reordered property list
- change clock name to "clock-sc16is7xx"

 .../boot/dts/freescale/fsl-ls1012a-frdm.dts   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index 67702667ed8a..2517528f684f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "fsl-ls1012a.dtsi"
 
 / {
@@ -57,6 +58,26 @@ simple-audio-card,codec {
 	};
 };
 
+&dspi {
+	bus-num = <0>;
+	status = "okay";
+
+	serial@0 {
+		compatible = "nxp,sc16is740";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+		clocks = <&sc16is7xx_clk>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+
+		sc16is7xx_clk: clock-sc16is7xx {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
-- 
2.25.1

