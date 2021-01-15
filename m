Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC52F7677
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbhAOKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:17:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA41C061793;
        Fri, 15 Jan 2021 02:17:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so5718631lfr.7;
        Fri, 15 Jan 2021 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fgRlLkwxsmY7BYgCFdgyzj4S+bI1O7GBJW53PDVtEY=;
        b=TlHMbmMslon+O19Brt5TtQkGwyv26qSkm5vsYY3VFo14F75GVw4EmaAeENHxrHcD4h
         RLAcNjncj2Q6i02f1xU17AbdqJmAi2fI/fcFx0QcvgZLAIy7uvMwQghEwSlh11gpNHgF
         C1KXvLq07euYLF8Npqg+/yROO5dwwzg2CqccIsKE8uSYKmLWudo375H9o+MLRa8JJMMN
         FdIPJQYwXDHWBpbC4OkaorOuy04fHm2RdsUp/pq9OqYXvuXBsfNrdGSuICLTt2i7OjQN
         bT+6U6CEalaqFJQk4xQbEoHX3aK7ydSueWNtD1zpE7zA18nraJzgdudjnjGSgBAiN0JJ
         uRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fgRlLkwxsmY7BYgCFdgyzj4S+bI1O7GBJW53PDVtEY=;
        b=Kp9bfUgNUhmtIYhcfeScpaYGsIO/EiLScZN9s2K38a34cHTdztJ2SUSdQ976vRwtxq
         pERJCxQhWfbk5hFB4GQrpUKgz4vCfueAoKBdqNAB7+0sdPCAKQ7gy9Xy4IpzOczIhbkq
         FbiPeJmvnsAEpzqhx4g+IrrS9YAtqwCBhOgDY2OSUe8xCqshKBvdL6ukANy8qIMe71Kq
         5wTffxJiH79t4Jzw+QhSARCpZfKvy5LyYdpotNQRF2eaKSe1nd2W731hpoOqRIzYCw/r
         23BQln1Nc1IoUUm1jGEW9NemZJl7PiY6xgxTkJ/oKSexEqZCLOZs/iMjoPUw4HH8GqG+
         eoYw==
X-Gm-Message-State: AOAM532NNvPHj8de0YgycpRh+ikG9945UNMR4QdWm0F47wrJxNAZQIkn
        i87obGONLrThT/7Lzwv8w6U=
X-Google-Smtp-Source: ABdhPJxTQRfxiWTZ+haizQueztCjKL3UrnWo2+rFVHOeIaOwvfZEDEhqrtFMnDb7ffHtlO+uVHzqsg==
X-Received: by 2002:a19:600d:: with SMTP id u13mr5242339lfb.312.1610705820854;
        Fri, 15 Jan 2021 02:17:00 -0800 (PST)
Received: from endpoint.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g26sm758033ljn.90.2021.01.15.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 02:17:00 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: fsl-ls1012a-frdm: add spi-uart device
Date:   Fri, 15 Jan 2021 11:16:13 +0100
Message-Id: <20210115101613.1490837-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115101613.1490837-1-paweldembicki@gmail.com>
References: <20210115101613.1490837-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spi-uart controller  to LS1012A-FRDM board dts.
Device is equipped in SC16IS740 from NXP.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 .../boot/dts/freescale/fsl-ls1012a-frdm.dts   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index 67702667ed8a..9473d16336a2 100644
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
+	status = "okay";
+	bus-num = <0>;
+
+	serial@0 {
+		reg = <0>;
+		compatible = "nxp,sc16is740";
+		spi-max-frequency = <4000000>;
+		clocks = <&sc16is7xx_clk>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+
+		sc16is7xx_clk: sc16is7xx_clk {
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

