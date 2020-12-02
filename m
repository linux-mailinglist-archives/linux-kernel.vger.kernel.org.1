Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D612CBF15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgLBOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388935AbgLBOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:08:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C7C08C5F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw4so4430384ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvj9L8sor8CyXho3VJNOStq16ikUZFmX+/hnEaB78Fg=;
        b=tUDiuwnMlvYXKyUbget5sHaWpVGEzFIXOzFPVrC+hhScmTZNlbAai4lW/9WjcVkvwB
         w0G9qh1avdlNUvL5iybcp0i+2w5mLc/JCoXtlajxBTHcU2BkHmghM15EyNIA55D5pK2O
         j9y+k9KfW263WQTtmk9AohfK8DCOZzoliZoNH7+sZdKvvv86QbxJfp9wGE046KWq1rE/
         HtzMpEMuAcfRVbK2Upbh69BwYk8c6CANVX9Ft/hpL8r6zcAPM3x9+miDeUVBFhaMRmYw
         NX7FLJWCQSawY49+1lYCPOuS2XQzIssvF6sSmyB4ZY3PejfmudT8SNV8vZGh7SAo8W2t
         1/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zvj9L8sor8CyXho3VJNOStq16ikUZFmX+/hnEaB78Fg=;
        b=U/s6edPec/RdvqYEg0xLN889PnbTePtE+QUnE4EdNC7lAr0FzsNtaYd2OFFaGGKXCJ
         WQUZOzZV9cN9d7QbYjhbdlPeayHwy09J+V4RBAQIP9VIk4JRh9wC756UJaTBWl0JuQZs
         gBrkfsBp8QqD7TxzN0Szb6Yj1MeNc+8Usqlq8Okh90uoQb1ZgElZLxHiudFLlEAuQyFu
         aKyb1BWu0QRWsHwCdPc/ES5xqSdEKpGbc2oy7mm3ft+m68eU/Nr5bPSMHT0YkzXKVEj4
         wGbRj/GHwtqhKHu5os1osjHyL5mWgXhpU61qCF4UnTwmTguPOpVwaBojP2OwCR6iP5zn
         4wTQ==
X-Gm-Message-State: AOAM533g8lSbKIZER9EZgRQJTRrrzxImt3FDBDz4j4Rs2bniLynt0w6w
        3uOl0HmWwKaCpuX3wgzUJuqBF2/7uihIfDrO
X-Google-Smtp-Source: ABdhPJzwbTfV0676rWepFUWvNAYHfb0uHZGjPN2u6o84yNTOfdjUmdy1K5CDwdPouZvZvQ8AORZlPA==
X-Received: by 2002:a17:906:81ca:: with SMTP id e10mr2385845ejx.449.1606917995393;
        Wed, 02 Dec 2020 06:06:35 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v8sm32493edt.3.2020.12.02.06.06.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:34 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/12] arm64: dts: zynqmp: Add missing lpd watchdog node
Date:   Wed,  2 Dec 2020 15:06:09 +0100
Message-Id: <645e5dc57a57bca766bf2a7967ac19ca43b68df2.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP SoC has FPD (Full Power Domain) and LPD (Low Power Domain)
watchdogs. There are cases where also LPD WDT should be used by Arm cores
that's why list it with disabled status.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 6a577e1383c1..3ca7e4ee51b5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -223,3 +223,7 @@ &usb1 {
 &watchdog0 {
 	clocks = <&zynqmp_clk WDT>;
 };
+
+&lpd_watchdog {
+	clocks = <&zynqmp_clk LPD_WDT>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 4312d4594dba..704696811116 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -808,5 +808,14 @@ watchdog0: watchdog@fd4d0000 {
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		lpd_watchdog: watchdog@ff150000 {
+			compatible = "cdns,wdt-r1p2";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 52 1>;
+			reg = <0x0 0xff150000 0x0 0x1000>;
+			timeout-sec = <10>;
+		};
 	};
 };
-- 
2.29.2

