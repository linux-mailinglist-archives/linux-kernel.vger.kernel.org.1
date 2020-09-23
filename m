Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FA27555D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIWKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIWKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:12:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31698C0613D1;
        Wed, 23 Sep 2020 03:12:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so14740306pfa.10;
        Wed, 23 Sep 2020 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4R3q/B+RQaycGXbN2yEBl4AP6ihJrpnfs7s1c4skU4=;
        b=Omwv3/T9mFFs+Z+A0wCDkeskPHeUulCMNTiGjvs60Fx6/JnkKQyNIuFnt/w0U4VnGg
         I6d3yxPA7igVMEocF0v2OtO8/+TYXWBRxBJcd+LpvadcFU3xsqPioJNLgSr3IJWW8nlH
         enzNOJ/EYX1jMUgLyxopzJ8ZMlU/uPqsNNKDRdYQi0NoblqKPT92YL3WksAdT8RgotPs
         NR2gx4Bi8JtkoS9a50HX9EoWvGqEi9xU/HFwZo2QaEX3tRxjqZ1KJsXr7x01IAHF+beF
         47QvjPCe/0ja62Kq+8PABnWvYAty3AQVGr+6bOZWQR622V5xAReFi1gKCJXksDHgVQV0
         p9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4R3q/B+RQaycGXbN2yEBl4AP6ihJrpnfs7s1c4skU4=;
        b=tDqJdvkByqW0uucTpgIHspkAWV8bu6tEQA4W7uzdekN0B37rQt8bRwE0WX0JzClFWn
         cge0+R4f9q718KdLM2DPF8IkJtb63kM9+A/RsFFbZpHvePBVDT8AllMeXsTcucZ1ERL5
         tqyrZL/Ck4Ce+9EhdNYcGX4TFiFzofiHKcuT44IfC62uAa3KekBDGbMH2kJNtQZ1opb2
         gVDisWehISzD8fwdlILeZcqBKE6B7NpJCH+7vnH5sg09X3N5Ql0rAs8Pl2ZRnWnoYe9k
         lIXziN6CSs7xnPJ0P5mlFM+/VRoGlzOvuC2HJrc0lKNChkKvtYyno/Y2rFw4dttZoqaz
         X1fQ==
X-Gm-Message-State: AOAM531KCYqos8CxNw33FG1/xO/7lT3gZfKpvAbk2VjuHFuxYX/4q1SJ
        RQ4ttfXfRZKbHDG0ORuAZ/A=
X-Google-Smtp-Source: ABdhPJxP6IsEP6ZjR5to8LmkjKbLHx3a82Lgqljyxm2Xr5oEkrWTFbPXzDz3QsQ7RvLUPvsKi4CcZg==
X-Received: by 2002:a05:6a00:f:b029:13e:d13d:a089 with SMTP id h15-20020a056a00000fb029013ed13da089mr8163884pfk.32.1600855962782;
        Wed, 23 Sep 2020 03:12:42 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id i1sm17678549pfk.21.2020.09.23.03.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:12:42 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        art@khadas.com, jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick@khadas.com
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3399-khadas-edge add missed ir-receiver and ir_rx pinctl nodes
Date:   Wed, 23 Sep 2020 18:12:25 +0800
Message-Id: <20200923101225.1513392-3-email2tema@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923101225.1513392-1-email2tema@gmail.com>
References: <20200923101225.1513392-1-email2tema@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Lapkin <art@khadas.com>

add missed ir receivier to Khadas Edge board
Khadas Edge uses gpio-ir-receiver on RK_PB6 gpio
---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 42ebbd6fa46..389ae43d869 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -109,6 +109,14 @@ vsys_5v0: vsys-5v0 {
 		vin-supply = <&vsys>;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_rx>;
+		linux,rc-map-name = "rc-khadas";
+	};
+
 	adc-keys {
 		compatible = "adc-keys";
 		io-channels = <&saradc 1>;
@@ -682,6 +690,14 @@ &sdmmc {
 	status = "okay";
 };
 
+&pinctrl {
+    ir {
+	ir_rx: ir-rx {
+	    rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+	};
+    };
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
-- 
2.25.1

