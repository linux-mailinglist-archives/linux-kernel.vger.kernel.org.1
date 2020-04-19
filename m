Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA91AFAE9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDSNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDSNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B9C061A0C;
        Sun, 19 Apr 2020 06:50:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so8667865wrm.13;
        Sun, 19 Apr 2020 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUA++TEaLcF7xVYj2JPvsFYTdSQV3W9a05Rr324UlUQ=;
        b=SCeb+46yipxDv9/COJNIXXpa+me9KDQFXu00J1jjuKCGGpCVt1m97bcM7RaiJ8N++8
         Y+zQNPzqx/yNW5Acurrihk+8H0Sc73dcl/A+GjYpicbG26xu32HtLccq1HlSvsaH27JR
         jMME7DgK5vip9DRXcp/nEzNrZI60Uylg/5IMKT8vcraiLscku5UiMia8NUqAp0GeTulI
         /91iigbZF2EfhTZPBw/zD8wk5OUUkCddz4tRhNvZXi9gaWHCRTK5oA6j0jLrBsSGZDo6
         0f/T6ITi54DGdezprlXKW2us6r5P/Fxr0CGpH/IFJchMxAbZw+IRVK2rSK4tyFn0psz/
         TDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUA++TEaLcF7xVYj2JPvsFYTdSQV3W9a05Rr324UlUQ=;
        b=VNBcXhVmCYYMiTpB5smN7Q17B280bLWG4GcmoL6nULfpPj63mnkesQXg75zh16eQSJ
         Yr+CyI8Y5V59vbH4AUSq63Yaa0u8eb4RZwhpSU0lcZ/fCCusSsp5vZ5zzPrKXhJ3NoSK
         0ACMU7hXTkBD4x7bgXlVy2EmBRkLmTU22t17Ri7fQFjjIlxOixvNNVtDTdIHhclVnG2k
         X54I4Jo9qzu7/ioEXj7ATXZNE1Vb1f/RzhjFjyCXmHtVH9DIWK9rma1wlktaK6nRwVe+
         ig2eFOBrDq9+KU2kBQLHs7fX8vMVmTHvVUAAuBMjgAT1sShk3gYkSGDhCz5KRj9hHCyi
         N17g==
X-Gm-Message-State: AGi0PuaR/evZKDLMSNUDJ1iMbfK7+gVWUO6O4ZwZhf22QVkkWosA5zKB
        SzF24aiuXwnaffiHN81Ml+E=
X-Google-Smtp-Source: APiQypKADQ9qdgOD90LPt+LaY4fb76W1CUcU3g33XUbM9Z+8ph5ypgbAag07BSBplDly1t8bR8ST9A==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr13130557wrs.4.1587304219433;
        Sun, 19 Apr 2020 06:50:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 5/7] arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
Date:   Sun, 19 Apr 2020 15:50:09 +0200
Message-Id: <20200419135011.18010-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for Tanix TX6.

Also add the fixed regulator that provided vdd-cpu-gpu required for
CPU opp tables.

This voltage has been found using a voltmeter and could be wrong.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 83e6cb0e59ce..be81330db14f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -37,6 +38,17 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	reg_vdd_cpu_gpu: vdd-cpu-gpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu-gpu";
+		regulator-min-microvolt = <1135000>;
+		regulator-max-microvolt = <1135000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu_gpu>;
 };
 
 &de {
@@ -56,6 +68,7 @@
 };
 
 &gpu {
+	mali-supply = <&reg_vdd_cpu_gpu>;
 	status = "okay";
 };
 
-- 
2.20.1

